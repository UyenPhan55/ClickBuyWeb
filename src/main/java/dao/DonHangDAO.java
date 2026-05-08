package dao;

import java.math.BigDecimal;
import java.sql.*;
import java.util.*;
import model.DonHang;
import model.SanPhamTrongDon;

public class DonHangDAO {
    public int placeOrder(int idNguoiDung, String diaChi, String sdtNguoiNhan, Integer idVoucher, String diaChiIp) throws SQLException {
        if (diaChi == null || diaChi.trim().isEmpty()) throw new SQLException("Địa chỉ nhận hàng không được rỗng");
        if (sdtNguoiNhan == null || sdtNguoiNhan.trim().isEmpty()) throw new SQLException("Số điện thoại nhận hàng không được rỗng");

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int idGioHang = new GioHangDAO().getOrCreateCartId(conn, idNguoiDung);
                List<CartRow> cartRows = getCartRowsForUpdate(conn, idGioHang);
                if (cartRows.isEmpty()) throw new SQLException("Giỏ hàng đang trống");

                BigDecimal tamTinh = BigDecimal.ZERO;
                for (CartRow row : cartRows) {
                    if (row.soLuong > row.soLuongTon) {
                        throw new SQLException("Sản phẩm " + row.idBienThe + " không đủ tồn kho");
                    }
                    tamTinh = tamTinh.add(row.giaBienThe.multiply(BigDecimal.valueOf(row.soLuong)));
                }

                Integer validVoucher = validateVoucher(conn, idVoucher, tamTinh);

                int idDonHang;
                String insertOrder = "INSERT INTO don_hang(id_nguoi_dung, trang_thai, dia_chi, sdt_nguoi_nhan, id_voucher) VALUES (?, 'CHO_XAC_NHAN', ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, idNguoiDung);
                    ps.setString(2, diaChi.trim());
                    ps.setString(3, sdtNguoiNhan.trim());
                    if (validVoucher == null) ps.setNull(4, Types.INTEGER); else ps.setInt(4, validVoucher);
                    ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) throw new SQLException("Không tạo được đơn hàng");
                        idDonHang = keys.getInt(1);
                    }
                }

                String insertItem = "INSERT INTO san_pham_trong_don(id_don_hang, id_bien_the, so_luong, don_gia) VALUES (?, ?, ?, ?)";
                String updateStock = "UPDATE bien_the_san_pham SET so_luong_ton = so_luong_ton - ? WHERE id_bien_the = ? AND so_luong_ton >= ?";
                try (PreparedStatement psItem = conn.prepareStatement(insertItem); PreparedStatement psStock = conn.prepareStatement(updateStock)) {
                    for (CartRow row : cartRows) {
                        psItem.setInt(1, idDonHang);
                        psItem.setInt(2, row.idBienThe);
                        psItem.setInt(3, row.soLuong);
                        psItem.setBigDecimal(4, row.giaBienThe);
                        psItem.addBatch();

                        psStock.setInt(1, row.soLuong);
                        psStock.setInt(2, row.idBienThe);
                        psStock.setInt(3, row.soLuong);
                        psStock.addBatch();
                    }
                    psItem.executeBatch();
                    int[] stockRows = psStock.executeBatch();
                    for (int r : stockRows) {
                        if (r <= 0) throw new SQLException("Không cập nhật được tồn kho");
                    }
                }

                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM san_pham_trong_gio WHERE id_gio_hang = ?")) {
                    ps.setInt(1, idGioHang);
                    ps.executeUpdate();
                }

                new ThongBaoDAO().insertThongBao(conn, idNguoiDung, "Đặt hàng thành công", "Đơn hàng #" + idDonHang + " đã được tạo và đang chờ xác nhận.", "DON_HANG");
                new LichSuHoatDongDAO().insertLog(conn, idNguoiDung, "Đặt hàng", "don_hang", idDonHang, diaChiIp);

                conn.commit();
                return idDonHang;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public List<DonHang> getOrdersByUser(int idNguoiDung) throws SQLException {
        String sql = baseOrderSql() + " WHERE dh.id_nguoi_dung = ? GROUP BY dh.id_don_hang ORDER BY dh.ngay_dat DESC";
        List<DonHang> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapOrder(rs));
            }
        }
        return list;
    }

    public List<DonHang> getAllOrders() throws SQLException {
        String sql = baseOrderSql() + " GROUP BY dh.id_don_hang ORDER BY dh.ngay_dat DESC";
        List<DonHang> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapOrder(rs));
        }
        return list;
    }

    public DonHang getOrderById(int idDonHang) throws SQLException {
        String sql = baseOrderSql() + " WHERE dh.id_don_hang = ? GROUP BY dh.id_don_hang";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDonHang);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }
        }
        return null;
    }

    public DonHang getOrderByIdAndUser(int idDonHang, int idNguoiDung) throws SQLException {
        String sql = baseOrderSql() + " WHERE dh.id_don_hang = ? AND dh.id_nguoi_dung = ? GROUP BY dh.id_don_hang";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDonHang);
            ps.setInt(2, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }
        }
        return null;
    }

    public List<SanPhamTrongDon> getOrderItems(int idDonHang) throws SQLException {
        String sql = "SELECT ctd.*, sp.ten_san_pham, sp.url_anh, bt.ten_bien_the " +
                     "FROM san_pham_trong_don ctd " +
                     "JOIN bien_the_san_pham bt ON ctd.id_bien_the = bt.id_bien_the " +
                     "JOIN san_pham sp ON bt.id_san_pham = sp.id_san_pham " +
                     "WHERE ctd.id_don_hang = ?";
        List<SanPhamTrongDon> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDonHang);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPhamTrongDon item = new SanPhamTrongDon();
                    item.setIdDonHang(rs.getInt("id_don_hang"));
                    item.setIdBienThe(rs.getInt("id_bien_the"));
                    item.setSoLuong(rs.getInt("so_luong"));
                    item.setDonGia(rs.getBigDecimal("don_gia"));
                    item.setTenSanPham(rs.getString("ten_san_pham"));
                    item.setUrlAnh(rs.getString("url_anh"));
                    item.setTenBienThe(rs.getString("ten_bien_the"));
                    list.add(item);
                }
            }
        }
        return list;
    }

    public boolean updateStatus(int idDonHang, String trangThaiMoi, int idNguoiThucHien, String diaChiIp) throws SQLException {
        String sql = "UPDATE don_hang SET trang_thai = ? WHERE id_don_hang = ?";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int idChuDon = getOrderOwner(conn, idDonHang);
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, trangThaiMoi);
                    ps.setInt(2, idDonHang);
                    if (ps.executeUpdate() <= 0) throw new SQLException("Không cập nhật được trạng thái đơn hàng");
                }
                new ThongBaoDAO().insertThongBao(conn, idChuDon, "Cập nhật đơn hàng", "Đơn hàng #" + idDonHang + " đã chuyển sang trạng thái " + trangThaiMoi + ".", "DON_HANG");
                new LichSuHoatDongDAO().insertLog(conn, idNguoiThucHien, "Cập nhật trạng thái đơn hàng: " + trangThaiMoi, "don_hang", idDonHang, diaChiIp);
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public boolean cancelOrderByUser(int idDonHang, int idNguoiDung, String diaChiIp) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                String oldStatus;
                try (PreparedStatement ps = conn.prepareStatement("SELECT trang_thai FROM don_hang WHERE id_don_hang = ? AND id_nguoi_dung = ? FOR UPDATE")) {
                    ps.setInt(1, idDonHang);
                    ps.setInt(2, idNguoiDung);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) throw new SQLException("Không tìm thấy đơn hàng");
                        oldStatus = rs.getString("trang_thai");
                    }
                }
                if (!"CHO_XAC_NHAN".equals(oldStatus)) {
                    throw new SQLException("Chỉ có thể hủy đơn khi đang chờ xác nhận");
                }

                List<SanPhamTrongDon> items = getOrderItemsByConnection(conn, idDonHang);
                try (PreparedStatement ps = conn.prepareStatement("UPDATE bien_the_san_pham SET so_luong_ton = so_luong_ton + ? WHERE id_bien_the = ?")) {
                    for (SanPhamTrongDon item : items) {
                        ps.setInt(1, item.getSoLuong());
                        ps.setInt(2, item.getIdBienThe());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }

                try (PreparedStatement ps = conn.prepareStatement("UPDATE don_hang SET trang_thai = 'DA_HUY' WHERE id_don_hang = ?")) {
                    ps.setInt(1, idDonHang);
                    ps.executeUpdate();
                }
                new LichSuHoatDongDAO().insertLog(conn, idNguoiDung, "Hủy đơn hàng", "don_hang", idDonHang, diaChiIp);
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    private String baseOrderSql() {
        return "SELECT dh.*, nd.ten_day_du, nd.email, " +
               "COALESCE(SUM(ct.so_luong * ct.don_gia), 0) AS tam_tinh, " +
               "CASE " +
               " WHEN mg.id_voucher IS NULL THEN 0 " +
               " WHEN mg.loai_giam = 'TIEN_MAT' THEN LEAST(mg.gia_tri_giam, COALESCE(SUM(ct.so_luong * ct.don_gia),0)) " +
               " WHEN mg.loai_giam = 'PHAN_TRAM' THEN LEAST(COALESCE(SUM(ct.so_luong * ct.don_gia),0) * mg.gia_tri_giam / 100, COALESCE(mg.giam_toi_da, COALESCE(SUM(ct.so_luong * ct.don_gia),0))) " +
               " ELSE 0 END AS giam_gia " +
               "FROM don_hang dh " +
               "JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung " +
               "LEFT JOIN san_pham_trong_don ct ON dh.id_don_hang = ct.id_don_hang " +
               "LEFT JOIN ma_giam_gia mg ON dh.id_voucher = mg.id_voucher";
    }

    private DonHang mapOrder(ResultSet rs) throws SQLException {
        DonHang dh = new DonHang();
        dh.setIdDonHang(rs.getInt("id_don_hang"));
        dh.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        dh.setNgayDat(rs.getTimestamp("ngay_dat"));
        dh.setTrangThai(rs.getString("trang_thai"));
        dh.setDiaChi(rs.getString("dia_chi"));
        dh.setSdtNguoiNhan(rs.getString("sdt_nguoi_nhan"));
        int voucher = rs.getInt("id_voucher");
        dh.setIdVoucher(rs.wasNull() ? null : voucher);
        dh.setTenNguoiDung(rs.getString("ten_day_du"));
        dh.setEmail(rs.getString("email"));
        BigDecimal tamTinh = rs.getBigDecimal("tam_tinh");
        BigDecimal giamGia = rs.getBigDecimal("giam_gia");
        if (tamTinh == null) tamTinh = BigDecimal.ZERO;
        if (giamGia == null) giamGia = BigDecimal.ZERO;
        dh.setTamTinh(tamTinh);
        dh.setGiamGia(giamGia);
        dh.setTongThanhToan(tamTinh.subtract(giamGia).max(BigDecimal.ZERO));
        return dh;
    }

    private List<CartRow> getCartRowsForUpdate(Connection conn, int idGioHang) throws SQLException {
        String sql = "SELECT ct.id_bien_the, ct.so_luong, bt.gia_bien_the, bt.so_luong_ton " +
                     "FROM san_pham_trong_gio ct JOIN bien_the_san_pham bt ON ct.id_bien_the = bt.id_bien_the " +
                     "WHERE ct.id_gio_hang = ? FOR UPDATE";
        List<CartRow> rows = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idGioHang);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartRow r = new CartRow();
                    r.idBienThe = rs.getInt("id_bien_the");
                    r.soLuong = rs.getInt("so_luong");
                    r.giaBienThe = rs.getBigDecimal("gia_bien_the");
                    r.soLuongTon = rs.getInt("so_luong_ton");
                    rows.add(r);
                }
            }
        }
        return rows;
    }

    private Integer validateVoucher(Connection conn, Integer idVoucher, BigDecimal tamTinh) throws SQLException {
        if (idVoucher == null) return null;
        String sql = "SELECT mg.*, (SELECT COUNT(*) FROM don_hang dh WHERE dh.id_voucher = mg.id_voucher AND dh.trang_thai <> 'DA_HUY') AS da_dung " +
                     "FROM ma_giam_gia mg WHERE mg.id_voucher = ? AND mg.trang_thai = 1 AND NOW() BETWEEN mg.ngay_bat_dau AND mg.ngay_het_han";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idVoucher);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) throw new SQLException("Mã giảm giá không hợp lệ hoặc đã hết hạn");
                if (tamTinh.compareTo(rs.getBigDecimal("don_toi_thieu")) < 0) throw new SQLException("Đơn hàng chưa đạt giá trị tối thiểu của mã giảm giá");
                if (rs.getInt("da_dung") >= rs.getInt("so_luong_gioi_han")) throw new SQLException("Mã giảm giá đã hết lượt sử dụng");
                return idVoucher;
            }
        }
    }

    private int getOrderOwner(Connection conn, int idDonHang) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT id_nguoi_dung FROM don_hang WHERE id_don_hang = ?")) {
            ps.setInt(1, idDonHang);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("id_nguoi_dung");
            }
        }
        throw new SQLException("Không tìm thấy đơn hàng");
    }

    private List<SanPhamTrongDon> getOrderItemsByConnection(Connection conn, int idDonHang) throws SQLException {
        List<SanPhamTrongDon> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM san_pham_trong_don WHERE id_don_hang = ?")) {
            ps.setInt(1, idDonHang);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPhamTrongDon item = new SanPhamTrongDon();
                    item.setIdDonHang(rs.getInt("id_don_hang"));
                    item.setIdBienThe(rs.getInt("id_bien_the"));
                    item.setSoLuong(rs.getInt("so_luong"));
                    item.setDonGia(rs.getBigDecimal("don_gia"));
                    list.add(item);
                }
            }
        }
        return list;
    }

    private static class CartRow {
        int idBienThe;
        int soLuong;
        BigDecimal giaBienThe;
        int soLuongTon;
    }
}

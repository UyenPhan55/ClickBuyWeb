<<<<<<< HEAD
package model;

import java.util.Date;

public class SanPham {
    private int id;
    private String tenSanPham; // VD: iPhone 15 Pro Max
    private String hangSanXuat; // VD: Apple, Samsung
    private String moTa;
    private String anhDaiDien;
    private boolean trangThai; // True: Đang bán, False: Ngừng kinh doanh
    private Date ngayTao;

    public SanPham() {}

    public SanPham(int id, String tenSanPham, String hangSanXuat, String moTa, String anhDaiDien, boolean trangThai, Date ngayTao) {
        this.id = id;
        this.tenSanPham = tenSanPham;
        this.hangSanXuat = hangSanXuat;
        this.moTa = moTa;
        this.anhDaiDien = anhDaiDien;
        this.trangThai = trangThai;
        this.ngayTao = ngayTao;
    }

    // Ấn Alt + Insert -> Getter and Setter để tạo tự động nhé
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }
    public String getHangSanXuat() { return hangSanXuat; }
    public void setHangSanXuat(String hangSanXuat) { this.hangSanXuat = hangSanXuat; }
    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
    public String getAnhDaiDien() { return anhDaiDien; }
    public void setAnhDaiDien(String anhDaiDien) { this.anhDaiDien = anhDaiDien; }
    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }
    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }
=======
package model;

public class SanPham {
    private int idSanPham;
    private String tenSanPham;
    private double giaGoc;
    private String hinhAnh;
    private String moTa;
    private int idDanhMuc;

    // 1. Hàm khởi tạo rỗng (Bắt buộc phải có)
    public SanPham() {
    }

    // 2. Hàm khởi tạo đầy đủ tham số (Để DAO nhét dữ liệu vào)
    public SanPham(int idSanPham, String tenSanPham, double giaGoc, String hinhAnh, String moTa, int idDanhMuc) {
        this.idSanPham = idSanPham;
        this.tenSanPham = tenSanPham;
        this.giaGoc = giaGoc;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
        this.idDanhMuc = idDanhMuc;
    }

    // 3. Các hàm Getter và Setter (Để lấy và sửa dữ liệu)
    public int getIdSanPham() {
        return idSanPham;
    }

    public void setIdSanPham(int idSanPham) {
        this.idSanPham = idSanPham;
    }

    public String getTenSanPham() {
        return tenSanPham;
    }

    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
    }

    public double getGiaGoc() {
        return giaGoc;
    }

    public void setGiaGoc(double giaGoc) {
        this.giaGoc = giaGoc;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public int getIdDanhMuc() {
        return idDanhMuc;
    }

    public void setIdDanhMuc(int idDanhMuc) {
        this.idDanhMuc = idDanhMuc;
    }
>>>>>>> 66e75cedbca2796cc48db838e4062f55d94b85ec
}
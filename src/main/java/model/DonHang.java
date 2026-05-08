package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class DonHang {
    private int idDonHang;
    private int idNguoiDung;
    private Timestamp ngayDat;
    private String trangThai;
    private String diaChi;
    private String sdtNguoiNhan;
    private Integer idVoucher;

    // Thuộc tính hiển thị thêm khi JOIN / tính toán
    private String tenNguoiDung;
    private String email;
    private BigDecimal tamTinh = BigDecimal.ZERO;
    private BigDecimal giamGia = BigDecimal.ZERO;
    private BigDecimal tongThanhToan = BigDecimal.ZERO;

    public DonHang() {}

    public int getIdDonHang() { return idDonHang; }
    public void setIdDonHang(int idDonHang) { this.idDonHang = idDonHang; }
    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }
    public Timestamp getNgayDat() { return ngayDat; }
    public void setNgayDat(Timestamp ngayDat) { this.ngayDat = ngayDat; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }
    public String getSdtNguoiNhan() { return sdtNguoiNhan; }
    public void setSdtNguoiNhan(String sdtNguoiNhan) { this.sdtNguoiNhan = sdtNguoiNhan; }
    public Integer getIdVoucher() { return idVoucher; }
    public void setIdVoucher(Integer idVoucher) { this.idVoucher = idVoucher; }
    public String getTenNguoiDung() { return tenNguoiDung; }
    public void setTenNguoiDung(String tenNguoiDung) { this.tenNguoiDung = tenNguoiDung; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public BigDecimal getTamTinh() { return tamTinh; }
    public void setTamTinh(BigDecimal tamTinh) { this.tamTinh = tamTinh; }
    public BigDecimal getGiamGia() { return giamGia; }
    public void setGiamGia(BigDecimal giamGia) { this.giamGia = giamGia; }
    public BigDecimal getTongThanhToan() { return tongThanhToan; }
    public void setTongThanhToan(BigDecimal tongThanhToan) { this.tongThanhToan = tongThanhToan; }
}

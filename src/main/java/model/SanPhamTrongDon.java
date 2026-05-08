package model;

import java.math.BigDecimal;

public class SanPhamTrongDon {
    private int idDonHang;
    private int idBienThe;
    private int soLuong;
    private BigDecimal donGia;

    // Thuộc tính hiển thị thêm khi JOIN
    private String tenSanPham;
    private String tenBienThe;
    private String urlAnh;

    public SanPhamTrongDon() {}

    public BigDecimal getThanhTien() {
        if (donGia == null) return BigDecimal.ZERO;
        return donGia.multiply(BigDecimal.valueOf(soLuong));
    }

    public int getIdDonHang() { return idDonHang; }
    public void setIdDonHang(int idDonHang) { this.idDonHang = idDonHang; }
    public int getIdBienThe() { return idBienThe; }
    public void setIdBienThe(int idBienThe) { this.idBienThe = idBienThe; }
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { this.donGia = donGia; }
    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }
    public String getTenBienThe() { return tenBienThe; }
    public void setTenBienThe(String tenBienThe) { this.tenBienThe = tenBienThe; }
    public String getUrlAnh() { return urlAnh; }
    public void setUrlAnh(String urlAnh) { this.urlAnh = urlAnh; }
}

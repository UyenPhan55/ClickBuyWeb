package model;

import java.math.BigDecimal;

public class SanPhamTrongGio {
    private int idGioHang;
    private int idBienThe;
    private int soLuong;

    // Thuộc tính hiển thị thêm khi JOIN
    private String tenSanPham;
    private String tenBienThe;
    private String urlAnh;
    private BigDecimal giaBienThe;
    private int soLuongTon;

    public SanPhamTrongGio() {}

    public SanPhamTrongGio(int idGioHang, int idBienThe, int soLuong) {
        this.idGioHang = idGioHang;
        this.idBienThe = idBienThe;
        this.soLuong = soLuong;
    }

    public BigDecimal getThanhTien() {
        if (giaBienThe == null) return BigDecimal.ZERO;
        return giaBienThe.multiply(BigDecimal.valueOf(soLuong));
    }

    public int getIdGioHang() { return idGioHang; }
    public void setIdGioHang(int idGioHang) { this.idGioHang = idGioHang; }
    public int getIdBienThe() { return idBienThe; }
    public void setIdBienThe(int idBienThe) { this.idBienThe = idBienThe; }
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }
    public String getTenBienThe() { return tenBienThe; }
    public void setTenBienThe(String tenBienThe) { this.tenBienThe = tenBienThe; }
    public String getUrlAnh() { return urlAnh; }
    public void setUrlAnh(String urlAnh) { this.urlAnh = urlAnh; }
    public BigDecimal getGiaBienThe() { return giaBienThe; }
    public void setGiaBienThe(BigDecimal giaBienThe) { this.giaBienThe = giaBienThe; }
    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }
}

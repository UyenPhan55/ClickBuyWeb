package model;

import java.math.BigDecimal; // Thêm import này

public class BienTheSanPham {
    private int idBienThe;
    private int idSanPham;
    private String tenBienThe;
    private BigDecimal giaBienThe; // Đã sửa từ double sang BigDecimal
    private int soLuongTon;

    public BienTheSanPham() {
    }

    public BienTheSanPham(int idBienThe, int idSanPham, String tenBienThe, BigDecimal giaBienThe, int soLuongTon) {
        this.idBienThe = idBienThe;
        this.idSanPham = idSanPham;
        this.tenBienThe = tenBienThe;
        this.giaBienThe = giaBienThe;
        this.soLuongTon = soLuongTon;
    }

    public int getIdBienThe() { return idBienThe; }
    public void setIdBienThe(int idBienThe) { this.idBienThe = idBienThe; }

    public int getIdSanPham() { return idSanPham; }
    public void setIdSanPham(int idSanPham) { this.idSanPham = idSanPham; }

    public String getTenBienThe() { return tenBienThe; }
    public void setTenBienThe(String tenBienThe) { this.tenBienThe = tenBienThe; }

    public BigDecimal getGiaBienThe() { return giaBienThe; }
    public void setGiaBienThe(BigDecimal giaBienThe) { this.giaBienThe = giaBienThe; }

    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }
}
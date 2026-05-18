package model;

public class SanPham {
    private int idSanPham;
    private String tenSanPham;
    private String moTa;
    private String urlAnh;
    private String nhaSanXuat;
    private double giaCoBan;
    private int trangThai;
    private int idBienThe;

    public SanPham() {
    }

    public SanPham(int idSanPham, String tenSanPham, String moTa, String urlAnh, String nhaSanXuat, double giaCoBan, int trangThai) {
        this.idSanPham = idSanPham;
        this.tenSanPham = tenSanPham;
        this.moTa = moTa;
        this.urlAnh = urlAnh;
        this.nhaSanXuat = nhaSanXuat;
        this.giaCoBan = giaCoBan;
        this.trangThai = trangThai;
    }

    // --- GETTER & SETTER ---
    public int getIdBienThe() {return idBienThe;}
    public void setIdBienThe(int idBienThe) {this.idBienThe = idBienThe;}
    
    public int getIdSanPham() { return idSanPham; }
    public void setIdSanPham(int idSanPham) { this.idSanPham = idSanPham; }

    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getUrlAnh() { return urlAnh; }
    public void setUrlAnh(String urlAnh) { this.urlAnh = urlAnh; }

    public String getNhaSanXuat() { return nhaSanXuat; }
    public void setNhaSanXuat(String nhaSanXuat) { this.nhaSanXuat = nhaSanXuat; }

    public double getGiaCoBan() { return giaCoBan; }
    public void setGiaCoBan(double giaCoBan) { this.giaCoBan = giaCoBan; }

    public int getTrangThai() { return trangThai; }
    public void setTrangThai(int trangThai) { this.trangThai = trangThai; }

    
}

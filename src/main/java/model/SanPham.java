package model;

public class SanPham {
    private int idSanPham;
    private String tenSanPham;
    private String moTa;
    private String urlAnh;
    private String nhaSanXuat;
    private double giaCoBan;
    private int trangThai; 
    private int soLuongTon; // 1. Mới thêm: Số lượng tồn kho

    public SanPham() {
    }

    // 2. Cập nhật Constructor để nhận thêm soLuongTon
    public SanPham(int idSanPham, String tenSanPham, String moTa, String urlAnh, String nhaSanXuat, double giaCoBan, int trangThai, int soLuongTon) {
        this.idSanPham = idSanPham;
        this.tenSanPham = tenSanPham;
        this.moTa = moTa;
        this.urlAnh = urlAnh;
        this.nhaSanXuat = nhaSanXuat;
        this.giaCoBan = giaCoBan;
        this.trangThai = trangThai;
        this.soLuongTon = soLuongTon;
    }

    // --- GETTER & SETTER ---
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

    // 3. Getter và Setter cho soLuongTon
    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }
}
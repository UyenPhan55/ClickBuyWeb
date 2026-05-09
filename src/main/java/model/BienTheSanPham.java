package model;

public class BienTheSanPham {
    private int id;
    private int sanPhamId; 
    private String mauSac; 
    private String dungLuong; 
    private double giaBan; 
    private int soLuongTon;

    public BienTheSanPham() {}

    public BienTheSanPham(int id, int sanPhamId, String mauSac, String dungLuong, double giaBan, int soLuongTon) {
        this.id = id;
        this.sanPhamId = sanPhamId;
        this.mauSac = mauSac;
        this.dungLuong = dungLuong;
        this.giaBan = giaBan;
        this.soLuongTon = soLuongTon;
    }

    // Các hàm Getter và Setter (Dùng Alt + Insert để tạo nếu chưa có nhé)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getSanPhamId() { return sanPhamId; }
    public void setSanPhamId(int sanPhamId) { this.sanPhamId = sanPhamId; }
    public String getMauSac() { return mauSac; }
    public void setMauSac(String mauSac) { this.mauSac = mauSac; }
    public String getDungLuong() { return dungLuong; }
    public void setDungLuong(String dungLuong) { this.dungLuong = dungLuong; }
    public double getGiaBan() { return giaBan; }
    public void setGiaBan(double giaBan) { this.giaBan = giaBan; }
    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }
}
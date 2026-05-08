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
}
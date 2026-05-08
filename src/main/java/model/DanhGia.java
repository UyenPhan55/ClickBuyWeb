package model;

import java.sql.Timestamp;

public class DanhGia {
    private int idDanhGia;
    private int idDonHang;
    private int idBienThe;
    private int soSao;
    private String noiDung;
    private String traLoi;
    private Timestamp ngayDanhGia;
    private int trangThai;

    // Hiển thị thêm
    private String tenSanPham;
    private String tenBienThe;
    private String tenNguoiDung;

    public DanhGia() {}

    public int getIdDanhGia() { return idDanhGia; }
    public void setIdDanhGia(int idDanhGia) { this.idDanhGia = idDanhGia; }
    public int getIdDonHang() { return idDonHang; }
    public void setIdDonHang(int idDonHang) { this.idDonHang = idDonHang; }
    public int getIdBienThe() { return idBienThe; }
    public void setIdBienThe(int idBienThe) { this.idBienThe = idBienThe; }
    public int getSoSao() { return soSao; }
    public void setSoSao(int soSao) { this.soSao = soSao; }
    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }
    public String getTraLoi() { return traLoi; }
    public void setTraLoi(String traLoi) { this.traLoi = traLoi; }
    public Timestamp getNgayDanhGia() { return ngayDanhGia; }
    public void setNgayDanhGia(Timestamp ngayDanhGia) { this.ngayDanhGia = ngayDanhGia; }
    public int getTrangThai() { return trangThai; }
    public void setTrangThai(int trangThai) { this.trangThai = trangThai; }
    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }
    public String getTenBienThe() { return tenBienThe; }
    public void setTenBienThe(String tenBienThe) { this.tenBienThe = tenBienThe; }
    public String getTenNguoiDung() { return tenNguoiDung; }
    public void setTenNguoiDung(String tenNguoiDung) { this.tenNguoiDung = tenNguoiDung; }
}

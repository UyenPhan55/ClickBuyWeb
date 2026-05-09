package model;

import java.sql.Timestamp;

public class KhieuNai {
    private int idKhieuNai;
    private int idDonHang;
    private String noiDung;
    private String phanHoi;
    private String trangThai;
    private Timestamp ngayGui;
    private int yeuCauTraHang;

    // Hiển thị thêm
    private int idNguoiDung;
    private String tenNguoiDung;
    private String email;

    public KhieuNai() {}

    public int getIdKhieuNai() { return idKhieuNai; }
    public void setIdKhieuNai(int idKhieuNai) { this.idKhieuNai = idKhieuNai; }
    public int getIdDonHang() { return idDonHang; }
    public void setIdDonHang(int idDonHang) { this.idDonHang = idDonHang; }
    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }
    public String getPhanHoi() { return phanHoi; }
    public void setPhanHoi(String phanHoi) { this.phanHoi = phanHoi; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
    public Timestamp getNgayGui() { return ngayGui; }
    public void setNgayGui(Timestamp ngayGui) { this.ngayGui = ngayGui; }
    public int getYeuCauTraHang() { return yeuCauTraHang; }
    public void setYeuCauTraHang(int yeuCauTraHang) { this.yeuCauTraHang = yeuCauTraHang; }
    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }
    public String getTenNguoiDung() { return tenNguoiDung; }
    public void setTenNguoiDung(String tenNguoiDung) { this.tenNguoiDung = tenNguoiDung; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}

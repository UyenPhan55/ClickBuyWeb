package model;

import java.sql.Date;

public class BaoHanh {
    private int idBaoHanh;
    private int idDonHang;
    private int idBienThe;
    private Integer idNhanVien;
    private String maBaoHanhCode;
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private String trangThai;
    private String ghiChu;

    // Hiển thị thêm
    private String tenSanPham;
    private String tenBienThe;
    private String tenNhanVien;
    private int idNguoiDung;
    private String tenNguoiDung;

    public BaoHanh() {}

    public int getIdBaoHanh() { return idBaoHanh; }
    public void setIdBaoHanh(int idBaoHanh) { this.idBaoHanh = idBaoHanh; }
    public int getIdDonHang() { return idDonHang; }
    public void setIdDonHang(int idDonHang) { this.idDonHang = idDonHang; }
    public int getIdBienThe() { return idBienThe; }
    public void setIdBienThe(int idBienThe) { this.idBienThe = idBienThe; }
    public Integer getIdNhanVien() { return idNhanVien; }
    public void setIdNhanVien(Integer idNhanVien) { this.idNhanVien = idNhanVien; }
    public String getMaBaoHanhCode() { return maBaoHanhCode; }
    public void setMaBaoHanhCode(String maBaoHanhCode) { this.maBaoHanhCode = maBaoHanhCode; }
    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }
    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
    public String getGhiChu() { return ghiChu; }
    public void setGhiChu(String ghiChu) { this.ghiChu = ghiChu; }
    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }
    public String getTenBienThe() { return tenBienThe; }
    public void setTenBienThe(String tenBienThe) { this.tenBienThe = tenBienThe; }
    public String getTenNhanVien() { return tenNhanVien; }
    public void setTenNhanVien(String tenNhanVien) { this.tenNhanVien = tenNhanVien; }
    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }
    public String getTenNguoiDung() { return tenNguoiDung; }
    public void setTenNguoiDung(String tenNguoiDung) { this.tenNguoiDung = tenNguoiDung; }
}

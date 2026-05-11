package model;

import java.sql.Timestamp;

public class MaGiamGia {
    private int idVoucher;
    private String maCode;
    private String loaiGiam; 
    private double giaTriGiam;
    private double donToiThieu;
    private double giamToiDa;
    private int soLuongGioiHan;
    private Timestamp ngayBatDau;
    private Timestamp ngayHetHan;
    private int trangThai;

    public MaGiamGia() {
    }

    // Đây chính là cái Constructor mà DAO đang "đòi" nè
    public MaGiamGia(int idVoucher, String maCode, String loaiGiam, double giaTriGiam, double donToiThieu, double giamToiDa, int soLuongGioiHan, Timestamp ngayBatDau, Timestamp ngayHetHan, int trangThai) {
        this.idVoucher = idVoucher;
        this.maCode = maCode;
        this.loaiGiam = loaiGiam;
        this.giaTriGiam = giaTriGiam;
        this.donToiThieu = donToiThieu;
        this.giamToiDa = giamToiDa;
        this.soLuongGioiHan = soLuongGioiHan;
        this.ngayBatDau = ngayBatDau;
        this.ngayHetHan = ngayHetHan;
        this.trangThai = trangThai;
    }

    // --- GETTER VÀ SETTER ---
    public int getIdVoucher() { return idVoucher; }
    public void setIdVoucher(int idVoucher) { this.idVoucher = idVoucher; }

    public String getMaCode() { return maCode; }
    public void setMaCode(String maCode) { this.maCode = maCode; }

    public String getLoaiGiam() { return loaiGiam; }
    public void setLoaiGiam(String loaiGiam) { this.loaiGiam = loaiGiam; }

    public double getGiaTriGiam() { return giaTriGiam; }
    public void setGiaTriGiam(double giaTriGiam) { this.giaTriGiam = giaTriGiam; }

    public double getDonToiThieu() { return donToiThieu; }
    public void setDonToiThieu(double donToiThieu) { this.donToiThieu = donToiThieu; }

    public double getGiamToiDa() { return giamToiDa; }
    public void setGiamToiDa(double giamToiDa) { this.giamToiDa = giamToiDa; }

    public int getSoLuongGioiHan() { return soLuongGioiHan; }
    public void setSoLuongGioiHan(int soLuongGioiHan) { this.soLuongGioiHan = soLuongGioiHan; }

    public Timestamp getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Timestamp ngayBatDau) { this.ngayBatDau = ngayBatDau; }

    public Timestamp getNgayHetHan() { return ngayHetHan; }
    public void setNgayHetHan(Timestamp ngayHetHan) { this.ngayHetHan = ngayHetHan; }

    public int getTrangThai() { return trangThai; }
    public void setTrangThai(int trangThai) { this.trangThai = trangThai; }
}
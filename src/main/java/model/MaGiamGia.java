package model;

import java.util.Date;

public class MaGiamGia {
    private int id;
    private String maCode; 
    private double giaTriGiam; 
    private String loaiGiam; 
    private double donToiThieu; 
    private int soLuongDaDung;
    private int soLuongToiDa;
    private Date ngayBatDau;
    private Date ngayKetThuc;

    public MaGiamGia() {}

    // Bắt buộc phải có các hàm này thì file DAO mới không bị lỗi đỏ
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMaCode() { return maCode; }
    public void setMaCode(String maCode) { this.maCode = maCode; }

    public double getGiaTriGiam() { return giaTriGiam; }
    public void setGiaTriGiam(double giaTriGiam) { this.giaTriGiam = giaTriGiam; }

    public String getLoaiGiam() { return loaiGiam; }
    public void setLoaiGiam(String loaiGiam) { this.loaiGiam = loaiGiam; }

    public double getDonToiThieu() { return donToiThieu; }
    public void setDonToiThieu(double donToiThieu) { this.donToiThieu = donToiThieu; }

    public int getSoLuongDaDung() { return soLuongDaDung; }
    public void setSoLuongDaDung(int soLuongDaDung) { this.soLuongDaDung = soLuongDaDung; }

    public int getSoLuongToiDa() { return soLuongToiDa; }
    public void setSoLuongToiDa(int soLuongToiDa) { this.soLuongToiDa = soLuongToiDa; }

    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }

    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }
}
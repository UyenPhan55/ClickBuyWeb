package model;

import java.sql.Timestamp;

public class GioHang {
    private int idGioHang;
    private int idNguoiDung;
    private Timestamp ngayTao;

    public GioHang() {}

    public GioHang(int idGioHang, int idNguoiDung, Timestamp ngayTao) {
        this.idGioHang = idGioHang;
        this.idNguoiDung = idNguoiDung;
        this.ngayTao = ngayTao;
    }

    public int getIdGioHang() { return idGioHang; }
    public void setIdGioHang(int idGioHang) { this.idGioHang = idGioHang; }
    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }
    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }
}

package model;

import java.sql.Timestamp;

public class LichSuHoatDong {
    private int idLog;
    private int idNguoiDung;
    private String hanhDong;
    private String bangTacDong;
    private int idDoiTuong;
    private Timestamp thoiGian;
    private String diaChiIp;

    // Hiển thị thêm
    private String tenNguoiDung;
    private String email;

    public LichSuHoatDong() {}

    public int getIdLog() { return idLog; }
    public void setIdLog(int idLog) { this.idLog = idLog; }
    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }
    public String getHanhDong() { return hanhDong; }
    public void setHanhDong(String hanhDong) { this.hanhDong = hanhDong; }
    public String getBangTacDong() { return bangTacDong; }
    public void setBangTacDong(String bangTacDong) { this.bangTacDong = bangTacDong; }
    public int getIdDoiTuong() { return idDoiTuong; }
    public void setIdDoiTuong(int idDoiTuong) { this.idDoiTuong = idDoiTuong; }
    public Timestamp getThoiGian() { return thoiGian; }
    public void setThoiGian(Timestamp thoiGian) { this.thoiGian = thoiGian; }
    public String getDiaChiIp() { return diaChiIp; }
    public void setDiaChiIp(String diaChiIp) { this.diaChiIp = diaChiIp; }
    public String getTenNguoiDung() { return tenNguoiDung; }
    public void setTenNguoiDung(String tenNguoiDung) { this.tenNguoiDung = tenNguoiDung; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}

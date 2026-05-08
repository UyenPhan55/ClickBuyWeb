package model;

import java.sql.Timestamp;

public class ThongBao {
    private int idThongBao;
    private int idNguoiDung;
    private String tieuDe;
    private String noiDung;
    private String loaiThongBao;
    private int daDoc;
    private Timestamp ngayTao;

    public ThongBao() {}

    public int getIdThongBao() { return idThongBao; }
    public void setIdThongBao(int idThongBao) { this.idThongBao = idThongBao; }
    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }
    public String getTieuDe() { return tieuDe; }
    public void setTieuDe(String tieuDe) { this.tieuDe = tieuDe; }
    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }
    public String getLoaiThongBao() { return loaiThongBao; }
    public void setLoaiThongBao(String loaiThongBao) { this.loaiThongBao = loaiThongBao; }
    public int getDaDoc() { return daDoc; }
    public void setDaDoc(int daDoc) { this.daDoc = daDoc; }
    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }
}

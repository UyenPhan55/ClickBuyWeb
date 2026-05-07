package model;

public class NguoiDung {

    private int idNguoiDung;
    private String tenDayDu;
    private String email;
    private String matKhau;
    private String sdt;
    private String diaChi;
    private int idVaiTro;   // 1=ADMIN, 2=NHAN_VIEN, 3=KHACH_HANG
    private int trangThai;  // 1=hoạt động, 0=bị khóa

    public NguoiDung() {}

    public int    getIdNguoiDung()              { return idNguoiDung; }
    public String getTenDayDu()                 { return tenDayDu; }
    public String getEmail()                    { return email; }
    public String getMatKhau()                  { return matKhau; }
    public String getSdt()                      { return sdt; }
    public String getDiaChi()                   { return diaChi; }
    public int    getIdVaiTro()                 { return idVaiTro; }
    public int    getTrangThai()                { return trangThai; }

    public void setIdNguoiDung(int v)           { this.idNguoiDung = v; }
    public void setTenDayDu(String v)           { this.tenDayDu = v; }
    public void setEmail(String v)              { this.email = v; }
    public void setMatKhau(String v)            { this.matKhau = v; }
    public void setSdt(String v)                { this.sdt = v; }
    public void setDiaChi(String v)             { this.diaChi = v; }
    public void setIdVaiTro(int v)              { this.idVaiTro = v; }
    public void setTrangThai(int v)             { this.trangThai = v; }
}
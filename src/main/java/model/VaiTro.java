package model;

public class VaiTro {

    private int    idVaiTro;
    private String tenVaiTro;

    public VaiTro() {}

    public VaiTro(int idVaiTro, String tenVaiTro) {
        this.idVaiTro  = idVaiTro;
        this.tenVaiTro = tenVaiTro;
    }

    public int    getIdVaiTro()           { return idVaiTro; }
    public String getTenVaiTro()          { return tenVaiTro; }
    public void   setIdVaiTro(int v)      { this.idVaiTro = v; }
    public void   setTenVaiTro(String v)  { this.tenVaiTro = v; }
}
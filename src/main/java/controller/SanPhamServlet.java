package dao;



import java.sql.Connection;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.util.ArrayList;

import java.util.List;

import model.SanPham;



public class SanPhamDAO {

    public List<SanPham> getAllSanPham() {

        List<SanPham> list = new ArrayList<>();

        String sql = "SELECT * FROM san_pham";

        

        try (Connection conn = DBConnection.getConnection(); 

             PreparedStatement ps = conn.prepareStatement(sql);

             ResultSet rs = ps.executeQuery()) {

            

            while (rs.next()) {

                list.add(new SanPham(

                    rs.getInt("id_san_pham"),

                    rs.getString("ten_san_pham"),

                    rs.getDouble("gia_goc"),

                    rs.getString("hinh_anh"),

                    rs.getString("mo_ta"),

                    rs.getInt("id_danh_muc")

                ));

            }

        } catch (Exception e) {

            System.out.println("Lỗi lấy danh sách SP: " + e.getMessage());

        }

        return list;

    }

    

    // Test nhanh xem DB có chạy không (Chạy bằng Shift + F6)

    public static void main(String[] args) {

        SanPhamDAO dao = new SanPhamDAO();

        List<SanPham> list = dao.getAllSanPham();

        for (SanPham sp : list) {

            System.out.println(sp.getTenSanPham() + " - " + sp.getGiaGoc());

        }

    }

}

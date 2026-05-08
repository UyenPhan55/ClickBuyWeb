package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection1 {
    // Thay "root" và "123456" bằng username và password MySQL của máy bạn
    private static final String URL = "jdbc:mysql://localhost:3306/ban_dien_thoai?useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASS = "123456"; 

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
package util;

import java.security.MessageDigest;
import java.util.Base64;

public class PasswordUtil {

    // Mã hóa mật khẩu bằng SHA-256
    public static String hash(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(password.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(bytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // So sánh mật khẩu nhập vào với hash trong DB
    // Tương thích với data mẫu chưa hash (chuỗi ngắn hơn 20 ký tự)
    public static boolean check(String rawPassword, String storedHash) {
        if (rawPassword == null || storedHash == null) return false;
        if (storedHash.length() < 20) {
            // Data mẫu chưa hash — so sánh thẳng
            return rawPassword.equals(storedHash);
        }
        return hash(rawPassword).equals(storedHash);
    }
}
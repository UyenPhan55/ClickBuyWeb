package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

public class UploadUtil {
    
    public static String uploadFile(HttpServletRequest request, Part part, String folderName) {
        try {
            // Lấy tên file gốc
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            if (fileName == null || fileName.trim().isEmpty()) {
                return null;
            }
            
            // Đường dẫn lưu ảnh (lưu trong thư mục uploads của project)
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + folderName;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            // Lưu file
            String filePath = uploadPath + File.separator + fileName;
            part.write(filePath);
            
            return folderName + "/" + fileName; // Trả về đường dẫn tương đối để lưu vào Database
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
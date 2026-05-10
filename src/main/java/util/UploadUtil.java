package util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

public class UploadUtil {
    public static String saveFile(Part filePart, String folderPath) {
        try {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (fileName == null || fileName.isEmpty()) return null;
            
            File uploadDir = new File(folderPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            filePart.write(folderPath + File.separator + fileName);
            return fileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
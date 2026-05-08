package util;

import dao.LichSuHoatDongDAO;
import jakarta.servlet.http.HttpServletRequest;

public class LogUtil {
    public static void ghiLog(HttpServletRequest request, String hanhDong, String bangTacDong, int idDoiTuong) {
        try {
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);
            if (idNguoiDung == null) return;
            String ip = request.getRemoteAddr();
            new LichSuHoatDongDAO().insertLog(idNguoiDung, hanhDong, bangTacDong, idDoiTuong, ip);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

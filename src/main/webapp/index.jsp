<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Điều hướng người dùng về trang chủ chính thức trong thư mục user
    response.sendRedirect(request.getContextPath() + "/TrangChuServlet");
%>

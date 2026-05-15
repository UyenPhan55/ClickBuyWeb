<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Khai báo thư viện JSTL hệ Jakarta --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <%-- Dùng EL để lấy contextPath là cách an toàn nhất trong Jakarta --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        main {
            flex: 1;
        }
    </style>
</head>
<body>
   
</body>
</html>

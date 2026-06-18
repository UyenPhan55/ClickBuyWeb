<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ${not empty pageTitle ? pageTitle : 'Trang quản trị'}
        - CLICKBUY Admin
    </title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>

<body>

<div class="layout-wrapper">

    <jsp:include page="/common/sidebar-admin.jsp"/>

    <main class="main-content">

        <jsp:include page="/common/topnav-admin.jsp"/>
                <%--để trang header là khung của cấu trúc HTML--%>

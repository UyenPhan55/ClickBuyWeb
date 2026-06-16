<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="status" value="error"/>
<c:set var="title" value="Đã xảy ra lỗi"/>
<c:set var="message" value="${not empty error ? error : 'Không thể xử lý yêu cầu. Vui lòng thử lại.'}"/>
<jsp:include page="/common/message.jsp"/>

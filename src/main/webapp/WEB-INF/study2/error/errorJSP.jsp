<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/errorMSG/errorMessage.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>errorJSP.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	name 파라미터 값 : <%=request.getParameter("name").toUpperCase() %>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
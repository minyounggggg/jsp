<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>eerror.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>error페이지 연습</h2>
	<hr/>
	<div><a href="ErrorJSP.st" class="btn btn-success">JSP error발생</a></div>
	<div><a href="Error404.st" class="btn btn-success">404 error발생</a></div>
	<div><a href="Error500.st" class="btn btn-success">500 error발생</a></div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
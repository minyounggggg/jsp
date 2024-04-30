<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%@ include file = "/include/certification.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t1_FilterRes.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>이곳은 t1_FilterRes.jsp 입니두</h2>
	<div>
		메세지 : ${msg}
	</div>
	<hr/>
	<div><a href="${ctp}/study/0430_web_xml/filter/t1_Filter.jsp" class="btn btn-success">돌아가기</a></div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
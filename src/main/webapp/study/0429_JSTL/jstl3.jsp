<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%@ include file = "/include/certification.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>jstl3_vo.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>JSTL 반복문 응용연습</h2>
	<div class="text-right">
		<button type="button" onclick="javascript:location.href='jstl.jsp';" class="btn btn-success btn-sm">JSTL core라이브러리</button>
		<button type="button" onclick="javascript:location.href='jstl2.jsp';" class="btn btn-warning btn-sm">JSTL 반복문</button>
		<button type="button" onclick="javascript:location.href='jstl3.jsp';" class="btn btn-primary btn-sm">JSTL 반복문응용</button>
		<button type="button" onclick="javascript:location.href='jstl4_function.jsp';" class="btn btn-info btn-sm">JSTL 함수</button>
		<button type="button" onclick="javascript:location.href='jstl5_format.jsp';" class="btn btn-secondary btn-sm">JSTL formatting</button>
	</div>
	<hr/>
	<h2>회원 자료 출력하기</h2>
	<form name="myform" method="post" action="${ctp}/j0429/Jstl3Ok">
		<input type="submit" value="회원리스트" class="btn btn-success"/>
	</form>
</div>
<hr/>

<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
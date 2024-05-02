<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%@ include file = "/include/certification.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>loginMain.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center">회원메인방</h2>
	<hr/>
	<table class="table table-hover">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>아이디</th>
			<th>성명</th>
			<th>나이</th>
			<th>성별</th>
			<th>주소</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.mid}</td>
				<td>${vo.name}</td>
				<td>${vo.age}</td>
				<td>${vo.gender}</td>
				<td>${vo.address}</td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
	<hr/>
	<p>
		<a href="${ctp}/database/Search" class="btn btn-warning">개별조회</a>
	</p>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
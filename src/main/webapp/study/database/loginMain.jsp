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
    <script>
    	'use strict';
    	
    	function nameSearch() {
			let name = document.getElementById("name").value;
			if(name.trim() == ""){
				alert("검색할 성명을 입력하세요.");
				document.getElementById("name").focus();
			}
			else{
				location.href = "${ctp}/database/LoginSearch?name="+name;
			}
		}
    	
    	function loginList() {
			location.href = "${ctp}/study/database/LoginList";
		}
    </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center">회원메인방</h2>
	<hr/>
	<div>
		<input type="button" value="전체조회" onclick="loginList()" class="btn btn-success btn-sm mb-2"/>
	</div>
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
				<td><a href="${ctp}/study/database/LoginView?idx=${vo.idx}">${vo.name}</a></td>
				<td>${vo.age}</td>
				<td>${vo.gender}</td>
				<td>${vo.address}</td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
	<hr/>
	<div class="input-group">
		<div class="input-group-prepend"><span class="input-group-text">성 명</span></div>
		<input type="text" name="name" id="name" class="form-control"/>
		<button type="button" onclick="nameSearch()" class="input-group-append btn btn-warning">개별조회</button>
	</div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>complaintList</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	'use strict';
    	
    	function complaintCheck(part, partIdx, complaint) {
			$.ajax({
				url : "ComplaintCheck.ad",
				type : "post",
				data : {
					part : part,
					partIdx : partIdx,
					complaint : complaint
				},
				success : function() {
					location.reload();
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2 class="text-center">신고리트스</h2>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>분류</th>
			<th>글제목</th>
			<th>글쓰닝</th>
			<th>신고자</th>
			<th>신고내역</th>
			<th>신고날짜</th>
			<th>표시여부</th>
		</tr>
		<c:set var="complaintCnt" value="${complaintCnt}"></c:set>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${complaintCnt}</td>
				<td>${vo.part}</td>
				<td>${vo.title}</td>
				<td>${vo.nickName}</td>
				<td>${vo.cpMid}</td>
				<td>${vo.cpContent}</td>
				<td>${vo.cpDate}</td>
				<td>
					<a href="javascript:complaintCheck('${vo.part}','${vo.partIdx}','${vo.complaint}')" class="badge badge-warning">${vo.complaint == 'NO' ? '표시중' : '<font color=white>감춰짐</font>'}</a><br/>
					<a href="javascript:complaintDelete(${vo.idx})" class="badge badge-danger">삭제</a>
				</td>
				<c:set var="complaintCnt" value="${complaintCnt -1}"></c:set>
			</tr>
		</c:forEach>
		<tr><td colspan="8" class="m-0 p-0"></td></tr>
	</table>
</div>
<p><br/></p>
</body>
</html>
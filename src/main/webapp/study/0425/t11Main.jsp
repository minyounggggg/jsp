<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mid = request.getParameter("mid") == null ? "관리자" : request.getParameter("mid");
	String msgFlag = request.getParameter("msgFlag");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t11Main.jsp</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    	'use strict';
    	
    	if('<%= msgFlag%>' == 'ok'){
    		alert("<%=mid%>님 방문 환영");
    	}
    	
    	function logoutCheck() {
			let ans = confirm("로그아웃 하겠습닊따?");
			if(ans){
				alert('<%=mid%>님 로그아운 완료');
				location.href = '<%=request.getContextPath()%>/study/0425/t11_Login.jsp';
			}
		}
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원 전용방</h2>
	<hr/>
	<div><a href="t10_member.jsp" class="btn btn-info"></a>회원정보보기</div>
	<p>
		<%=mid %>회원님 로그인중입니다.
	</p>
	<hr/>
	<p>
		<a href="javascript:logoutCheck()" class="btn btn-warning">로그아웃</a>
	</p>
</div>
<p><br/></p>
</body>
</html>
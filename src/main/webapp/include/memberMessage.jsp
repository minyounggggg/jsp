<%@page import="member.MemberChatVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("utf-8");
	MemberDAO dao = new MemberDAO();
	ArrayList<MemberChatVO> vos = dao.getMemberMessage();
	pageContext.setAttribute("vos", vos);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberMessage.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	'use strict';
    	
    	setTimeout("location.reload()", 1000*5);
    	
    	$(document).ready(function () {
			document.body.scrollIntoView(false);  //스크롤바를 강제로 바디태그의 끝으로
		});
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<c:if test="${sNickName == vo.nickName}"><font color="blue">${vo.nickName} : ${vo.chat}</font></c:if>
		<c:if test="${sNickName != vo.nickName}">${vo.nickName} : ${vo.chat}</c:if>
		<br/>
	</c:forEach>
</div>
<p><br/></p>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%-- <%@ include file = "/include/certification.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberMain.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원 전용방</h2>
	<hr/>
	<font color="#ccc">("실시간 채팅방(DB)"이 들어올 예정입니다.)</font>
	<hr/>
	<div>
		<p>현재 <font color="blue"><b>${sNickName}(<font color="red">${strLevel}</font>)</b></font>님이 로그인 상태 입니다.</p>
		<p>총 방문횟수 : <b>${mVo.visitCnt}</b>회</p>
		<p>오늘 방문횟수 : <b>${mVo.todayCnt}</b>회</p>
		<p>총 보유 포인트 : <b>${mVo.point}</b>점</p>
	</div>
	<hr/>
	<div>
		<h5>활동내역</h5>
		<p>방명록에 올린 글 수 : <b>${guestCnt}</b>건</p>
		<p>게시판에 올린 글 수 : __건</p>
		<p>자료실에 올린 글 수 : __건</p>
	</div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
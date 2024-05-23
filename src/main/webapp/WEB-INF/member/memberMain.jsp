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
    <script>
    	'use strict';
    	
    	// 채팅내용 DB에 저장
    	function chatInput() {
			let chat = $("#chat").val();
			if(chat.trim() != "") {
				$.ajax({
					url : "MemberChatInput.mem",
					type : "post",
					data : {chat : chat},
					error : function () {
						alert("전송오류");
					}
				});
			}
		}
    	
    	// 채딩 대화입력후 엔터키를 누르면 자동으로 DB에 저장시키기 chatInput함수호출
    	$(function() {
			$("#chat").on("keydown", function(e) {
				if(e.keyCode == 13) chatInput();
			});
		});
    	
    </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원 전용방</h2>
	<hr/>
	<!-- 실시간 채팅방 -->
	<div style="width:460px">
		<form name="chatForm">
			<label for="chat"><b>실시간 대화방</b></label>
			<iframe src="${ctp}/include/memberMessage.jsp" width="100%" height="200px" class="border"></iframe>
			<div class="input-group mt-1">
				<input type="text" name="chat" id="chat" class="form-control" placeholder="대화내용을 입력하세요" autofocus/>
				<div class="input-group-append">
					<input type="button" value="글등록" onclick="chatInput()" class="btn btn-primary"/> 
				</div>
			</div>
		</form>
	</div>
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
	<hr/>
	<p><img src="${ctp}/images/member/${mVo.photo}" width="200px"/></p>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
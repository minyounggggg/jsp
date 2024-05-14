<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BoardContent.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <style>
    	th{
    		text-align: center;
    		background-color: #eee;
    	}
    </style>
    <script>
    	'use strict';
    	
    	function boardDelete() {
			let ans = confirm("현재 게시글을 삭제하겠습니까?");
			if(ans) location.href="BoardDelete.bo?idx=${vo.idx}";
		}
    	
    	// 하트 수 증가 (중복허용)
    	function goodCheck() {
			$.ajax({
				url : "BoardGoodCheck.bo",
				type : "post",
				data : {idx:${vo.idx}},
				success : function (res) {
					if(res != "0") location.reload();
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    	// 하트 수 증가 (중복불허)
    	function goodCheck2() {
			$.ajax({
				url : "BoardGoodCheck2.bo",
				type : "post",
				data : {idx:${vo.idx}},
				success : function (res) {
					if(res != "0") location.reload();
					else alert("이미 좋아요 버튼을 눌렀습니다.");
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    	// 좋아요(따봉) 수 증가 (중복허용)
    	function goodCheckPlus() {
			$.ajax({
				url : "BoardGoodCheckPlusMinus.bo",
				type : "post",
				data : {
					idx : ${vo.idx},
					goodCnt : +1
				},
				success : function (res) {
					location.reload();
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    	// 좋아요(따봉) 수 감소 (중복허용)
    	function goodCheckMinus() {
			$.ajax({
				url : "BoardGoodCheckPlusMinus.bo",
				type : "post",
				data : {
					idx : ${vo.idx},
					goodCnt : -1
				},
				success : function (res) {
					location.reload();
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center mb-4">글 내용 보기</h2>
	<table class="table table-bordered">
		<tr>
			<th>글쓴이</th>
			<td>${vo.nickName}</td>
			<th>글쓴 날짜</th>
			<td>${fn:substring(vo.wDate, 0, 16)}</td>
		</tr>
		<tr>
			<th>글조회수</th>
			<td>${vo.readNum}</td>
			<th>접속IP</th>
			<td>${vo.hostIp}</td>
		</tr>
		<tr>
			<th>글제목</th>
			<td colspan="3">
				${vo.title} (<a href="javascript:goodCheck()">❤</a> : ${vo.good}) / 
				<a href="javascript:goodCheckPlus()"> 👍 </a>
				<a href="javascript:goodCheckMinus()"> 👎 </a> / 
				(<a href="javascript:goodCheck2()"><font color="blue">♥</font></a> : ${vo.good})
			</td>
		</tr>
		<tr>
			<th>글내용</th>
			<td colspan="3" style="height:200px">${fn:replace(vo.content, newLine, "<br/>")}</td>
		</tr>
		<tr>
			<td colspan="4" class="text-right">
				<input type="button" value="돌아가기" onclick="location.href='BoardList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-success"/>
				<c:if test="${sNickName == vo.nickName || sLevel == 0}"> <!-- 닉네임이 같은지 확인해서 내가 쓴글만 삭제, 수정할 수 있게 -->
					<input type="button" value="수정" onclick="location.href='BoardUpdate.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/>
					<input type="button" value="삭제" onclick="boardDelete()" class="btn btn-danger"/>
				</c:if>
			</td>
		</tr>
	</table>
	<hr/>
	<!-- 이전글 다음글 출력하기 -->
	<table class="table table-borderless">
		<tr>
			<td>
				<c:if test="${!empty nextVo.title}"> <!-- 다음글이 없으면 나오지 않게 처리 -->
					<a href="BoardContent.bo?idx=${nextVo.idx}">▲ 다음글 : ${nextVo.title}</a><br/>
				</c:if>
				<c:if test="${!empty preVo.title}">  <!-- 이전글이 없으면 나오지 않게 처리 -->
					<a href="BoardContent.bo?idx=${preVo.idx}">▼ 이전글 : ${preVo.title}</a><br/>
				</c:if>
			</td>
		</tr>
	</table>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
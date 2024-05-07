<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
	String msg = request.getParameter("msg")==null? "공백" : request.getParameter("msg");
	pageContext.setAttribute("msg", msg);
%>
<html>
<script>
	'use strict';
	/* 
	function calc(flag) {
		if(flag == 'hap') myform.action = "hap.do3";
		else if(flag == 'cha') myform.action = "cha.do3";
		else if(flag == 'gop') myform.action = "gop.do3";
		else if(flag == 'mok') myform.action = "mok.do3";
		
		myform.submit();
	}
	 */
	 
	 function selectCheck() {
		let selectKey = document.getElementById("selectKey").value;
	}
	  
	 function fCheck() {
		location.href = "/WEB-INF/study2/mapping/${selectKey}";
	}
</script>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>test5.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>이곳은 test5.jsp(/WEB-INF/study2/mapping)</h2>
	<hr/>
	<%-- 
	<div>전송메세지 : ${msg}</div>
	<hr/>
	 --%>
	 <!-- 
		  t5Input.jsp
		  콤보박스로 회원가입, 수정, 삭제, 검색, 전체리스트 선택
		  선택하면 텍스트 박스로 오토포커스되어 처리버튼 누르면 처리되었다는 메세지 띄우기 ("아이디"님이 수정되었습니다./"아이디"님이 삭제되었습니다.)
	  -->
	<div>
		<a href="t5Input.do5" class="btn btn-success mr-3">회원가입</a>
		<a href="t5Update.do5" class="btn btn-primary mr-3">회원수정</a>
		<a href="t5Delete.do5" class="btn btn-info mr-3">회원삭제</a>
		<a href="t5Search.do5" class="btn btn-danger mr-3">회원검색</a>
		<a href="t5List.do5" class="btn btn-warning mr-3">회원리스트</a>
	</div>
	<hr/>
	<div>
		<select name="selectKey" id="selectKey" onchange="selectCheck()">
			<option>선택하기</option>
			<option value="t5Input.jsp" <c:if test="${selectKey == 't5Input.jsp'}">selected</c:if> >회원가입</option>
			<option value="t5Update" <c:if test="${selectKey == 'update'}">selected</c:if> >회원수정</option>
			<option value="t5Delete" <c:if test="${selectKey == 'delete'}">selected</c:if> >회원삭제</option>
			<option value="t5Search" <c:if test="${selectKey == 'search'}">selected</c:if> >회원검색</option>
			<option value="t5List" <c:if test="${selectKey == 'list'}">selected</c:if> >회원리스트</option>
		</select>
		<input type="text" name="mid" id="mid" />
		<input type="button" value="처리하기" onclick="fCheck()" class="btn btn-success" />
	</div>
	<hr/>
	<!-- 
	<div>
		<a href="javascript:calc('hap')" class="btn btn-success mr-3">합</a>
		<a href="javascript:calc('cha')" class="btn btn-primary mr-3">차</a>
		<a href="javascript:calc('gop')" class="btn btn-info mr-3">곱</a>
		<a href="javascript:calc('mok')" class="btn btn-info mr-3">몫</a>
	</div>	
	 -->
	<hr/>
	<%-- 
	<div>
		<form name="myform" method="post" action="${ctp}/mapping/test4.do4">
			<div>
				<input type="number" name="su1" value="${su1}" class="form-control mb-2"/>
				<input type="number" name="su2" value="${su2}" class="form-control mb-2"/>
			</div>
			<div><input type="submit" value="전송하기" class="btn btn-success"/></div>
		</form>
	</div>
	<div>
		<div>두수의 합 : ${hap}</div>
		<div>두수의 차 : ${cha}</div>
		<div>두수의 곱 : ${gop}</div>
		<div>두수의 몫 : ${mok}</div>
	</div>
	 --%>
	<!-- <div><input type="submit" value="전송하기" class="btn btn-success" /></div> -->
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
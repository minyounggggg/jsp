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
	
	function fCheck(flag){
		if(flag ==1){
			myform.submit();
		}
		else if(flag == 2){
			location.href = "${ctp}/mapping/test";
		}
		else if(flag == 4){
			myform.action = "${ctp}/mapping/testRes2";
			myform.submit();
		}
	}
</script>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>test.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>이곳은 test1.jsp(/WEB-INF/study2/mapping)</h2>
	<hr/>
	<div>
		<input type="button" value="두수의 합/차" onclick="fCheck(1)" class="btn btn-success mr-3"/>
		<input type="button" value="돌아가기" onclick="fCheck(2)" class="btn btn-primary mr-3"/>
		<input type="button" value="전송" onclick="fCheck(3)" class="btn btn-info mr-3"/>
		<input type="button" value="전송Res" onclick="fCheck(4)" class="btn btn-info mr-3"/>
	</div>	
	<hr/>
	<div>전송메세지 : ${msg}</div>
	<hr/>
	<div>
		<form name="myform" method="post" action="${ctp}/mapping/test1Ok">
			<input type="number" name="su1" value="${su1}" class="form-control mb-2"/>
			<input type="number" name="su2" value="${su2}" class="form-control mb-2"/>
		</form>
	</div>
	<div>
		<div>두수의 합 : ${hap}</div>
		<div>두수의 차 : ${cha}</div>
	</div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
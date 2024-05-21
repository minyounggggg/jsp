<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>fileUpload.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>파일 업로드 연습 (싱글/멀티파일)</h2>
	<hr/>
	<h4>COS라이브러리를 이용한 파일 업로드</h4>
	<div>(http://www.servlets.com/cos/)</div>
	<hr/>
	<div class="row text-center">
		<div class="col"><a href="FileUpload1.st" class="btn btn-success">업로드연습1</a></div>
		<div class="col"><a href="FileUpload2.st" class="btn btn-primary">업로드연습2</a></div>
		<div class="col"><a href="FileUpload3.st" class="btn btn-info">업로드연습3</a></div>
		<div class="col"><a href="FileUpload4.st" class="btn btn-warning">업로드연습4</a></div>
	</div>
	<hr/>
	<div><a href="FileDownLoad.st" class="btn btn-secondary form-control">다운로드로 이동하기</a></div>
	<h4 class="mt-5">자바 서블릿의 Part객체를 이용한 파일 업로드</h4>
	<div>(javax.servlets.http.Part)</div>
	<hr/>
	<div class="row text-center">
		<div class="col"><a href="FileUpload5.st" class="btn btn-success">업로드연습5</a></div>
		<div class="col"><a href="FileUpload6.st" class="btn btn-primary">업로드연습6</a></div>
	</div>
	<hr/>
	<div><a href="FileDownLoad.st" class="btn btn-secondary form-control">다운로드로 이동하기</a></div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
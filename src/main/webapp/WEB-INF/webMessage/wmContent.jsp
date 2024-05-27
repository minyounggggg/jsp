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
	<title>wmContent.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br/></p>
<div class="container">
	<table class="table table-bordered">
		<tr>
			<th>보내는 사람</th>
			<td>${vo.sendId}</td>
		</tr>
		<tr>
			<th>받는 사람</th>
			<td>${vo.receiveId}</td>
		</tr>
		<tr>
			<th>메세지 제목</th>
			<td>${vo.title}</td>
		</tr>
		<tr>
			<th>메세지 내용</th>
			<td>${fn:replace(vo.content, newLine, "<br/>")}</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center">
				<input type="button" value="답장하기" onclick="location.href='WebMessage.wm?mSw=0&receiveId=${vo.sendId}';" class="btn btn-success"/>
				<input type="button" value="휴지통으로" onclick="location.href='WmDeleteCheck.wm?idx=${vo.idx}&mSw=${param.mFlag}';" class="btn btn-success"/>
				<input type="button" value="돌아가기" onclick="location.href='WebMessage.wm?mSw=1&mFlag=11';" class="btn btn-success"/>
			</td>
		</tr>
	</table>
</div>
<p><br/></p>
</body>
</html>
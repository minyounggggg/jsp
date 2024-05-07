<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
	String msg = request.getParameter("msg")==null? "공백" : request.getParameter("msg");
	pageContext.setAttribute("msg", msg);
%>
<!DOCTYPE html>
<html>
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
	<h2>이곳은 test2.jsp(/WEB-INF/study2/mapping)</h2>
	<hr/>
	<div>전송메세지 : ${msg}</div>
	<hr/>
	<div>
		<form name="myform" method="post" action="testOk.jsp">
		<!-- <input type="number" name="su1" value="10" class="form-control mb-2"/>
			<input type="number" name="su2" value="20" class="form-control mb-2"/> -->
		</form>
	</div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
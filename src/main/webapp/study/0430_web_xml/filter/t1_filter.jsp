<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%@ include file = "/include/certification.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t1_filter.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	function fCheck(flag){
			if(flag == 'OK') myform.action = "${ctp}/j0430/T01Ok1";
			else myform.action ="";
			myform.submit();
		}
    	function fCheck(flag){
			if(flag == 'NO') myform.action = "${ctp}/j0430/T01Ok2";
			else myform.action ="";
			myform.submit();
		}
    </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>Filter 한글처리 연습</h2>
	<form name="myform" method="post">
		<div><input type="text" name="content" value="간단한 소개힙니다." class="form-control mb-3" autofoucs/></div>
		<div><textarea row="5" name="introduce" class="form-control mb-3" autofoucs/>자기소개입니다.</textarea></div>
		<div><input type="button" value="전송1" onclick="fCheck('OK')" class="btn btn-success form-control mb-3"/></div>
		<div><input type="button" value="전송2" onclick="fCheck('NO')" class="btn btn-primary form-control mb-3"/></div>
	</form>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
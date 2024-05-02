<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%-- <%@ include file = "/include/certification.jsp" %> --%>
<!DOCTYPE html>
<html>
<script>
	'use stricr';
	
	function certificationCheck() {                             //함수명과 변수명이 같으면 안된다.
		let certification = myform.certification.value;
		if(certification == "") || certification.length !=4 {
			alert("인증코드를 확인하시오 (4자리)");
			return false;
		}
		else {
			location.href="${ctp}/j0430/T02_Certification?admin=admin&u="+certification;
		}
	}
</script>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t2_Certification.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>이곳은 인증코드 발급창입니다.</h2>
	<form name="myform">
		<div><input type="text" name="Certification" value="1234" class="form-control mb-2"/></div>
		<div><input type="button" value="인증코드발급" onclick="certificationCheck()" class="btn btn-success form-control"/></div>
	</form>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
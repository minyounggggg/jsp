<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberJoin.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  
  <script>
    'use strict';
    
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
    <h2>개별 회원 정보</h2>
    <br/>
    <div>아이디 : ${vo.mid}</div>
    <div>닉네임 : ${vo.nickName}</div>
    <div>성명 : ${vo.name}</div>
    <div>Email address: ${vo.email}</div>
    <div>성별 : ${vo.gender}</div>
    <div>생일 : ${vo.birthday}</div>
    <div>전화번호 : ${vo.tel}</div>
    <div>주소 : ${vo.address}</div>
    <div>Homepage address : ${vo.homePage}</div>
    <div>직업 : ${vo.job}</div>
    <div>취미 : ${vo.hobby}</div>
    <div>자기소개 : ${vo.content}</div>
    <div>정보공개 : ${vo.userInfor}</div>
    <div>회원 사진 :<br/><img src="${ctp}/images/member/${vo.photo}" style="width:200px"/></div>
    <hr/>
    <div>
    	<a href="javascript:history.back();" class="btn btn-secondary">돌아가기</a>
    </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
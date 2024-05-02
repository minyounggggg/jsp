<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	/* 
	request.setCharacterEncoding("utf-8");
	String mid = request.getParameter("mid");
	String name = request.getParameter("name");
	
	pageContext.setAttribute("mid", mid);
	pageContext.setAttribute("name", name);
	 */
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<script>
	'use strict';
	
	function deleteCheck() {
		let ans = confirm("회원 탈퇴 하시겠습니까?");
		if(ans){
			location.href = "${ctp}/database/LoginDelete?mid=${vo.mid}";
		}
	}
</script>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>view.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="${ctp}/database/UpdateOk">
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2"><font size="5">회원 상세정보</font></td>
      </tr>
      <tr>
        <th>아이디</th>
<%--         <td><input type="text" name="mid" value="${vo.mid}" placeholder="아이디를 입력하세요" autofocus readonly class="form-control"/></td> --%> <!-- readonly수정안댐 -->
        <td class="text-left">${vo.mid}</td>  <!-- 위랑 똑같음 -->
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" value="${vo.pwd}" required class="form-control"/></td>
      </tr>
      <tr>
        <th>성명</th>
        <td><input type="text" name="name" value="${vo.name}" required class="form-control"/></td>
      </tr>
      <tr>
        <th>나이</th>
        <td><input type="number" name="age" value="${vo.age}" class="form-control"/></td>
      </tr>
      <tr>
        <th>성별</th>
        <td>
        	<input type="radio" name="gender" value="남자" <c:if test="${vo.gender=='남자'}">checked</c:if> />남자 &nbsp;
        	<input type="radio" name="gender" value="여자" <c:if test="${vo.gender=='여자'}">checked</c:if> />여자
        </td>
      </tr>
      <tr>
        <th>주소</th>
        <td><input type="text" name="address" value="${vo.address}" class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
        <div class="row">
        	<div class="col text-left">
	          <input type="submit" value="수정" class="btn btn-success mr-2"/>
	          <c:if test="${sMid == vo.mid}">
		          <input type="reset" value="탈퇴" onclick="deleteCheck()" class="btn btn-danger mr-2"/>
	          </c:if>
	          <c:if test="${sMid != vo.mid}">
	          	<input type="reset" value="삭제" onclick="deleteCheck()" class="btn btn-warning mr-2"/>
	          </c:if>
        	</div>
        	<div class="col text-right">
	          <input type="button" value="돌아가기" onclick="location.href='${ctp}/study/database/LoginList';" class="btn btn-primary mr-4"/>
	          <!-- <input type="button" value="돌아가기" onclick="history.back()" class="btn btn-primary mr-4"/> -->  <!-- 일케쓰면 안댐 (히스토리백은 전 작업으로 가는거니까) -->
	        </div>
	    </div>
        </td>
      </tr>
    </table>
    <input type="hidden" name="idx" value="${vo.idx}"/>  <!-- 안보이게해야하니까 히든으로 감취서 넘기기 -->
  </form>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>wmList.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	'use strict';
    	
    	setTimeout("location.reload()", 1000*10);
    	
    	function msgDel(idx) {
			let ans = confirm("선택하신 메세지를 삭제하시겠습니까?");
			if(!ans) return false;
			
			let query = {
					idx : idx,
					mFlag : 13
			}
			
			$.ajax({
				url : "WmDeleteOne.wm",
				type : "post",
				date : query,
				success : function (res) {
					if(res != "0"){
						alert("메세지가 삭제되었습니다.")
						location.reload();
					}
					else alert("메세지삭제실패");
				},
				error : function () {
					alert("전송오류");
				}
			});
		}
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>제목</th>
      <th>
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸사람</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은사람</c:if>
      </th>
      <th>
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸날짜</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은날짜</c:if>
      </th>
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <tr>
          <td>${vo.idx}</td>
          <td class="text-left">
          	<c:if test="${mSw!=4}"><a href="WebMessage.wm?mSw=6&idx=${vo.idx}&mFlag=${mFlag}">${vo.title}</a></c:if>
          	<c:if test="${mSw==4}">${vo.title}</c:if>
          	<c:if test="${vo.receiveSw=='n'}"><img src="${ctp}/images/new.gif"/></c:if>
          	<c:if test="${mSw==3}">
          	  <a href="javascript:msgDel(${vo.idx})" class="badge badge-danger">삭제</a>
          	</c:if>
          </td>
          <td>
	          <c:if test="${mSw==1 || mSw==2 || mSw==5}">${vo.sendId}</c:if>
	        	<c:if test="${mSw==3 || mSw==4}">${vo.receiveId}</c:if>
          </td>
          <td>
            <c:if test="${vo.hour_diff < 24}">${fn:substring(vo.receiveDate,11,19)}</c:if>
            <c:if test="${vo.hour_diff >= 24}">${fn:substring(vo.receiveDate,0,16)}</c:if>
          </td>
        </tr>
      </c:forEach>
      <tr><td colspan="4" class="m-0 p-0"></td></tr>
      <th></th>
    </tr>
  </table>
</div>
<p><br/></p>
</body>
</html>
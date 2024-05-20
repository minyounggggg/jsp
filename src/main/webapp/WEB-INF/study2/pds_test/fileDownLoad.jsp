<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>fileDownLoad.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	'use strict';
    	
    	function fileDelete(fileName) {
			$.ajax({
				url : "FileDelete.st",
				type : "post",
				data : {fileName : fileName},
				success : function (res) {
					if(res != 0){
						alert("삭제완료");
						location.reload();
					}
					else alert("삭제실패");
				},
				error : function () {
					alert("전송오류");
				}
			});
		}
    </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>저장된 파일 정보</h2>
	<hr/>
	<c:forEach var="file" items="${files}" varStatus="st">
								<!-- 파일명에 링크걸어서 다운로드 받게하기 -->
		${st.count}. <a href="${ctp}/images/pds_test/${file}" download="${file}">${file}</a>
		<input type="button" value="삭제" onclick="fileDelete('${file}')" class="btn btn-danger btn-sm mb-2"/>
		<br/>
		<c:set var="fNameArr" value="${fn:split(file,'.')}" />
		<c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr)-1])}" />
		<font color="blue">
			<c:if test="${extName == 'zip'}">압축파일</c:if>
			<c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트 파일</c:if>
			<c:if test="${extName == 'xls' || extName == 'xlsx'}">엑셀 파일</c:if>
		</font>
		<c:if test="${extName == 'jpg' || extName == 'png' || extName == 'gif'}">
			<img src="${ctp}/images/pds_test/${file}" width="150px"/>
		</c:if>
		<br/><br/>
	</c:forEach>
	<hr/>
	<p>
		<input type="button" value="돌아가기" onclick="location.href='FileUpload4.st';" class="btn btn-success"/>
	</p>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
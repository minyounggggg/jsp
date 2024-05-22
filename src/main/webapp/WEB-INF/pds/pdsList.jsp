<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>pdsList.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	'use strict';
    	
    	function partCheck() {
			let part = $("#part").val();
			location.href = "PdsList.pds?pag=${pag}&pageSize=${pageSize}&part="+part;
		}
    	
    	// 다운로드수 증가시키기
    	function downNumCheck(idx) {
				$.ajax({
				url : "PdsDownNumCheck.pds",
				type : "post",
				data : {idx : idx},
				success : function () {
					location.reload();
				},
				error : function () {
					alert("전성오류!");
				}
			});
			
		}
    	
    	// 자료내용 삭제(자료 + Data)
    	function PdsDeleteCheck(idx, fSName) {
			let ans = confirm("선택하신 자료를 삭제하겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : "PdsDeleteCheck.pds",
				type : "post",
				data : {
					idx : idx,
					fSName : fSName
				},
				success : function (res) {
					if(res != 0){
						alert("자료가 삭제되었습니다.");
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
	<h2 class="text-center">자료실 리스트(${part})</h2>
	<br/>
	<table class="table table-borderless m-0 p-0">
		<tr>
			<td>
				<form name="partForm">
					<select name="part" id="part" onchange="partCheck()">
						<option ${part == "전체" ? "selected" : ""}>전체</option>
						<option ${part == "학습" ? "selected" : ""}>학습</option>
						<option ${part == "여행" ? "selected" : ""}>여행</option>
						<option ${part == "음식" ? "selected" : ""}>음식</option>
						<option ${part == "기타" ? "selected" : ""}>기타</option>
					</select> 
				</form>
			</td>
			<td class="text-right">
				<a href="PdsInput.pds?part=${part}" class="btn btn-success">자료올리기</a>
			</td>
		</tr>
	</table>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>자료제목</th>
			<th>올린이</th>
			<th>올린날짜</th>
			<th>분류</th>
			<th>파일명(크기)</th>
			<th>다운수</th>
			<th>비고</th>
		</tr>
		<c:set var="curScrStarNO" value="${curScrStarNO}"/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${curScrStarNO}</td>
				<td>
					<a href="PdsContent.pds?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&part=${part}">${vo.title}</a>
					<c:if test="${vo.hour_diff < 24}"><img src="${ctp}/images/new.gif"/></c:if>
				</td>
				<td>${vo.nickName}</td>
				<td>
					${vo.fDate}
					${vo.date_diff == 0 ? fn:substring(vo.fDate,11,19) : fn:substring(vo.fDate,0,10)}
				</td>
				<td>${vo.part}</td>
				<td>
					<c:set var="fNames" value="${fn:split(vo.fName, '/')}"/>
					<c:set var="fSNames" value="${fn:split(vo.fSName, '/')}"/>
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctp}/images/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
					</c:forEach>
					(<fmt:formatNumber value="${vo.fSize/1024}" pattern="#,##0"/>KByte)
				</td>
				<td>${vo.downNum}</td>
				<td>
					<c:if test="${vo.mid == sMid || sLevel == 0}">
						<a href="javascript:PdsDeleteCheck('${vo.idx}', '${vo.fSName}')" class="badge badge-danger">삭제</a><br/>
					</c:if>
					<a href="PdsTotalDown.pds?idx=${vo.idx}" class="badge badge-primary">전체파일다운로드</a>
				</td>
			</tr>
		<c:set var="curScrStarNO" value="${curScrStarNO -1}"/>
		</c:forEach>
		<tr><td colspan="8" class="m-0 p-0"></td></tr>
	</table>
	<!-- 블록페이지 시작! -->
	<div class="text-center">
		<ul class="pagination justify-content-center">
		<c:if test="${pag > 1 }"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/PdsList.pds?pag=1&pageSize=${pageSize}">첫 페이지</a></li></c:if>
		<c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/PdsList.pds?pag=${(curBlock-1) * blockSize + 1}&pageSize=${pageSize}">이전블록</a></li></c:if>
		<c:forEach var="i" begin="${(curBlock * blockSize)+1}" end="${(curBlock * blockSize) + blockSize}" varStatus="st">
			<!-- 현재있는 페이지 수만 굵게 표시한다. -->
			<c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link" href="${ctp}/PdsList.pds?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if> 
			<!-- 현재있는 페이지가 아닌 숫자는 일반 표시, 두껍게 하지 않는다. -->
			<c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/PdsList.pds?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
		</c:forEach>
		<c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/PdsList.pds?pag=${(curBlock+1) * (blockSize+1)}&pageSize=${pageSize}">다음블록</a></li></c:if>
		<c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/PdsList.pds?pag=${totPage}&pageSize=${pageSize}">마지막 페이지</a></li></c:if>
		</ul>
	</div>
	<!-- 블록페이지 끝! -->
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
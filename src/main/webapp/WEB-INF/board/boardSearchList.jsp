<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>boardSearchList.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	'use strict';
    	
    	function pageSizeCheck() {
    		let pageSize = $("#pageSize").val();
			location.href = "BoardSearchList.bo?search=${search}&searchString=${searchString}&pageSize="+pageSize;
		}
    	
    	function modalCheck(idx, hostIp, mid, nickName) {
      		$("#myModal #modalIdx").text(idx);
      		$("#myModal #modalHostIp").text(hostIp);
      		$("#myModal #modalMid").text(mid);
      		$("#myModal #modalNickName").text(nickName);
    	}
    </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<table class="table table-borderless m-0 p-0">
		<tr>
			<td colspan="2">
				<h2 class="text-center">게시판 조건별 검색 리스트</h2>
				(<font color="blue">${searchTitle}</font>(으)로 <font color="blue">${searchString}</font>(을)를 검색한 결과 <font color="red">${searchCount}</font>건의 게시글이 검색되었습니다.)
			</td>
		</tr>
		<tr>
			<td><c:if test="${sLevel != 1}"><a href="BoardInput.bo" class="btn btn-success btn-sm">글쓰기</a></c:if></td>
			<td class="text-right">
				<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
					<option ${pageSize==5 ? "selected" : ""}>5</option>
					<option ${pageSize==10 ? "selected" : ""}>10</option>
					<option ${pageSize==15 ? "selected" : ""}>15</option>
					<option ${pageSize==20 ? "selected" : ""}>20</option>
					<option ${pageSize==30 ? "selected" : ""}>30</option>
				</select>
			</td>
		</tr>
	</table>
	<hr/>
	<table class="table table-hover m-0 p-0">
		<tr class="table-dark text-dark text-center">
			<th>글번호</th>
			<th>글제목</th>
			<th>글쓴이</th>
			<th>글쓴날짜</th>
			<th>조회수(좋아요)</th>
		</tr>
		<c:set var="curScrStarNO" value="${curScrStarNO}"></c:set> <!-- 글번호 삭제 되도 바르게 표시 처리 -->
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${vo.openSw == 'OK' || sLevel == 0 || sNickName == vo.nickName}">
			    <c:if test="${vo.complaint == 'NO' || sLevel == 0 || sNickName == vo.nickName}">
					<tr>
						<td class="text-center">${curScrStarNO}</td>
						<td>
							<a href="BoardContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}">${vo.title}</a>
							<c:if test="${vo.hour_diff < 24}"><img src="${ctp}/images/new.gif"/></c:if>
						</td>
						<td class="text-center">
							${vo.nickName}
							<!-- 닉네임(글쓴이) 출력되는 곳 옆에 관리자만 보이게 모달박스 버튼 표시하기 -->
							<c:if test="${sLevel == 0}">
								<a href="#" onclick="modalCheck('${vo.idx}','${vo.hostIp}','${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#myModal" class="badge badge-success">모달출력</a>
							</c:if>
						</td>
						<!-- 1일(24시간) 이내는 시간만표시(10:43), 이후는 날짜와 시간을 표시 : 2024-05-14 10:43:52 -->
						<%-- <td><c:if test="${vo.date_diff == 0}">${fn:substring(vo.wDate,11,16)}</c:if></td> --%>
						<%-- <td class="text-center">${vo.hour_diff < 24 ? fn:substring(vo.wDate, 11, 19) : fn:substring(vo.wDate, 0, 10)}</td> --%>
						<td>${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}</td>
						<td class="text-center">${vo.readNum}(${vo.good})</td>
					</tr>
				</c:if>
			</c:if>
			<c:set var="curScrStarNO" value="${curScrStarNO -1}"></c:set> <!-- 글번호 삭제 되도 바르게 표시 처리 -->
		</c:forEach>
		<tr><td colspan="5" class="m-0 p-0"></td></tr>
	</table>
	<br/>
		<!-- 블록페이지 시작 -->
	<div class="text-center">
		<ul class="pagination justify-content-center">
		<c:if test="${pag > 1 }"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/BoardSearchList.bo?search=${search}&searchString=${searchString}&pag=1&pageSize=${pageSize}">첫 페이지</a></li></c:if>
		<c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/BoardSearchList.bo?search=${search}&searchString=${searchString}&pag=${(curBlock-1) * blockSize + 1}&pageSize=${pageSize}">이전블록</a></li></c:if>
		<c:forEach var="i" begin="${(curBlock * blockSize)+1}" end="${(curBlock * blockSize) + blockSize}" varStatus="st">
			<!-- 현재있는 페이지 수만 굵게 표시한다. -->
			<c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link" href="${ctp}/BoardSearchList.bo?search=${search}&searchString=${searchString}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if> 
			<!-- 현재있는 페이지가 아닌 숫자는 일반 표시, 두껍게 하지 않는다. -->
			<c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/BoardSearchList.bo?search=${search}&searchString=${searchString}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
		</c:forEach>
		<c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/BoardSearchList.bo?search=${search}&searchString=${searchString}&pag=${(curBlock+1) * (blockSize+1)}&pageSize=${pageSize}">다음블록</a></li></c:if>
		<c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/BoardSearchList.bo?search=${search}&searchString=${searchString}&pag=${totPage}&pageSize=${pageSize}">마지막 페이지</a></li></c:if>
		</ul>
	</div>
	<!-- 블록페이지 끝 -->
	<br/>
	<!-- 검색기 시작 -->
	<!-- 
	<div class="container text-center">
		<form name="searchForm" method="post" action="BoardSearch.bo">
			<b>검색 : </b>
			<select name="search" id="search">
				<option value="title">글제목</option>			
				<option value="nickName">글쓴이</option>			
				<option value="content">글내용</option>			
			</select>
			<input type="text" name="searchString" id="searchString" required/>
			<input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
		</form>
	</div>
	 -->
	<!-- 검색기 끝 -->
	<input type="button" value="돌아가기" onclick="location.href='BoardList.bo';" class="btn btn-warning"/>
</div>
<p><br/></p>

 <!-- 모달에 회원정보 출력하기 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          고유번호 : <span id="modalIdx"></span><br/>
          아이디 : <span id="modalMid"></span><br/>
          호스트IP : <span id="modalHostIp"></span><br/>
          닉네임 : <span id="modalNickName"></span><br/>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
        
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
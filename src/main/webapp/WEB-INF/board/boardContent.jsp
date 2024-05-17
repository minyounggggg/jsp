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
	<title>boardContent.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <style>
    	th{
    		text-align: center;
    		background-color: #eee;
    	}
    </style>
    <script>
    	'use strict';
    	
    	function boardDelete() {
			let ans = confirm("현재 게시글을 삭제하겠습니까?");
			if(ans) location.href="BoardDelete.bo?idx=${vo.idx}";
		}
    	
    	// 하트 수 증가 (중복허용)
    	function goodCheck() {
			$.ajax({
				url : "BoardGoodCheck.bo",
				type : "post",
				data : {idx:${vo.idx}},
				success : function (res) {
					if(res != "0") location.reload();
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    	// 하트 수 증가 (중복불허)
    	function goodCheck2() {
			$.ajax({
				url : "BoardGoodCheck2.bo",
				type : "post",
				data : {idx:${vo.idx}},
				success : function (res) {
					if(res != "0") location.reload();
					else alert("이미 좋아요 버튼을 눌렀습니다.");
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    	// 좋아요(따봉) 수 증가 (중복허용)
    	function goodCheckPlus() {
			$.ajax({
				url : "BoardGoodCheckPlusMinus.bo",
				type : "post",
				data : {
					idx : ${vo.idx},
					goodCnt : +1
				},
				success : function (res) {
					location.reload();
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    	// 좋아요(따봉) 수 감소 (중복허용)
    	function goodCheckMinus() {
			$.ajax({
				url : "BoardGoodCheckPlusMinus.bo",
				type : "post",
				data : {
					idx : ${vo.idx},
					goodCnt : -1
				},
				success : function (res) {
					location.reload();
				},
				error : function () {
					alert("전송오류")
				}
			});
		}
    	
    	//신고사유 기타 클릭시 텍스트 박스 표시
    	function etcShow() {
			$("#complaintTxt").show();
		}
    	
    	// 신고화면 선택 후 신고사항 전송하기
    	function complaintCheck() {
			if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
				alert("신고항목을 선택해주세요");
				return false;
			}
    		if ($("input[type=radio]:checked").val() == '기타' && $("#complaintTxt").val() == ""){
    			alert("기타사유를 입력해주세요");
    			return false;
    		}
    		let cpContent = modalForm.complaint.value;
    		if(cpContent == '기타') cpContent += "/" + $("#complaintTxt").val();
    		
    		//alert("신고내용 : " + cpContent);
    		
	    	let query = {
	    			part : 'board',
	    			partIdx : ${vo.idx},
	    			cpMid : '${sMid}',
	    			cpContent : cpContent
	    	}
	    	
	    	$.ajax({
	    		url : "BoardComplaintInput.ad",
	    		type : "post",
	    		data : query,
	    		success : function (res) {
					if(res != "0"){
						alert("신고되었습니다.");
						location.reload();
					}
					else alert("신고실패");
				},
	    	error : function () {
				alert("전송오류");
			}
	    	});
    	}
    	
		// 댓글달기
		function replyCheck() {
			let content = $("#content").val();
			if(content.trim() == ""){
				alert("댓글을 입력하세요");
				return false;
			}
			let query = {
					boardIdx : ${vo.idx},
					mid : '${sMid}',
					nickName : '${sNickName}',
					hostIp : '${pageContext.request.remoteAddr}',
					content : content
			}

			$.ajax({
				url : "BoardReplyInput.bo",
				type : "post",
				data : query,
				success : function (res) {
					if(res != "0"){
						alert("댓글이 입력되었습니다.");
						location.reload();
					}
					else alert("댓글입력 실패");
				},
				error : function () {
					alert("전송오류");
				}
			});
		}
		
		// 댓글삭제하기
		function replyDelete(idx) {
			let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : "BoardReplyDelete.bo",
				type : "post",
				data : {idx:idx},
				success : function (res) {
					if(res != "0"){
						alert("댓글이 삭제되었습니다.");
						location.reload();
					}
					else alert("삭제실패");
				},
				error : function() {
					alert("전송오류");
				}
				
			});
		}
		
		// 수정할 댓글 모달창에 불러오기
		function replyContent(idx,content) {
			$("#myModal2 #modalContent").text(content);
			$("#myModal2 #idx").val(idx);
		}
		
		//댓글 수정하기 버튼처리
		function replyContentUpdate() {
			let idx = $("#idx").val();
			let replyContentUpdateTxt = $("#modalContent").val();
			if(replyContentUpdateTxt.trim() == ""){
				alert("수정사항을 입력해주세요");
				return false;
			}
			
			let query = {
					idx : idx,
					replyContentUpdateTxt : replyContentUpdateTxt
			}
			$.ajax({
				url : "BoardReplyUpdate.bo",
				type : "post",
				data : query,
				success : function (res) {
					if(res != "0"){
						alert("수정이 완료되었습니다.");
						location.reload();
					}
					else alert("수정실패");
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
	<h2 class="text-center mb-4">글 내용 보기</h2>
	<table class="table table-bordered">
		<tr>
			<th>글쓴이</th>
			<td>${vo.nickName}</td>
			<th>글쓴 날짜</th>
			<td>${fn:substring(vo.wDate, 0, 16)}</td>
		</tr>
		<tr>
			<th>글조회수</th>
			<td>${vo.readNum}</td>
			<th>접속IP</th>
			<td>${vo.hostIp}</td>
		</tr>
		<tr>
			<th>글제목</th>
			<td colspan="3">
				${vo.title} (<a href="javascript:goodCheck()">❤</a> : ${vo.good}) / 
				<a href="javascript:goodCheckPlus()"> 👍 </a>
				<a href="javascript:goodCheckMinus()"> 👎 </a> / 
				(<a href="javascript:goodCheck2()"><font color="blue">♥</font></a> : ${vo.good})
			</td>
		</tr>
		<tr>
			<th>글내용</th>
			<td colspan="3" style="height:200px">${fn:replace(vo.content, newLine, "<br/>")}</td>
		</tr>
		<tr>
			<td colspan="4">
		        <div class="row">
			        <div class="col">
			        	<c:if test="${empty flag}"><input type="button" value="돌아가기" onclick="location.href='BoardList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning" /></c:if>
			        	<c:if test="${!empty flag}"><input type="button" value="돌아가기" onclick="location.href='BoardSearchList.bo?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-warning" /></c:if>
			        </div>
			        <c:if test="${sNickName == vo.nickName || sLevel == 0}">
				        <div class="col text-right">
					        <input type="button" value="수정" onclick="location.href='BoardUpdate.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" />
					        <input type="button" value="삭제" onclick="boardDelete()" class="btn btn-danger text-right" />
				        </div>
			        </c:if>
			        <c:if test="${sNickName != vo.nickName}">
				        <div class="col text-right">
				        	<c:if test="${report == 'OK'}"><font color="red">신고중입니다.</font></c:if>
					        <c:if test="${report != 'OK'}"><input type="button" value="신고하기" data-toggle="modal" data-target="#myModal" class="btn btn-danger text-right" /></c:if>
				        </div>
			        </c:if>
		        </div>
	      	</td>
		</tr>
	</table>
	<hr/>
	<!-- 이전글 다음글 출력하기 -->
	<table class="table table-borderless">
		<tr>
			<td>
				<c:if test="${!empty nextVo.title}"> <!-- 다음글이 없으면 나오지 않게 처리 -->
					<a href="BoardContent.bo?idx=${nextVo.idx}">▲ 다음글 : ${nextVo.title}</a><br/>
				</c:if>
				<c:if test="${!empty preVo.title}">  <!-- 이전글이 없으면 나오지 않게 처리 -->
					<a href="BoardContent.bo?idx=${preVo.idx}">▼ 이전글 : ${preVo.title}</a><br/>
				</c:if>
			</td>
		</tr>
	</table>
</div>
<p><br/></p>

<!-- 댓글처리 (리스트/입력) -->
<div class="container">
	<!-- 댓글 리스트 보여주기 -->
	<table class="table table-hover text-center">
		<tr>
			<th>작성자</th>
			<th>댓글내용</th>
			<th>댓글일자</th>
			<th>접속IP</th>
		</tr>
		<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
			<tr>
				<td>${replyVo.nickName}
					<c:if test="${sMid == replyVo.mid || sLevel == 0}">
						<a href="#" onclick="replyContent('${replyVo.idx}','${replyVo.content}')" data-toggle="modal" data-target="#myModal2" class="badge badge-success"  title="댓글수정">수정</a>
						<a href="javascript:replyDelete(${replyVo.idx})" class="badge badge-danger" title="댓글삭제">삭제</a>
					</c:if>
				</td>
				<td class="text-left">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
				<td>${fn:substring(replyVo.wDate, 0, 10)}</td>
				<td>${replyVo.hostIp}</td>
			</tr>
		</c:forEach>
		<tr><td colspan="4" class="m-0 p-0"></td></tr>
	</table>
	
	<!-- 댓글 입력창 -->
	<form name="replyForm">
		<table class="table table-center">
			<tr>
				<td style="width:85%" class="text-left">
					글내용 : 
					<textarea rows="4" name="content" id="content" class="form-control"></textarea>
				</td>
				<td style="width:15%">
					<br/>
					<p>작성자 : ${sNickName}</p>
					<p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- 댓글처리 -->

<!-- 신고하기 폼 모달창 -->
<div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">현재 게시글을 신고합니다.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
       	  <b>신고사유 선택</b>
       	  <hr/>
          <form name="modalForm">
          	<div><input type="radio" name="complaint" id="complaint1" value="광고, 홍보, 영리목적"/>광고, 홍보, 영리목적</div>
          	<div><input type="radio" name="complaint" id="complaint2" value="욕설, 비방, 차별, 혐오"/>욕설, 비방, 차별, 혐오</div>
          	<div><input type="radio" name="complaint" id="complaint3" value="불법정보"/>불법정보</div>
          	<div><input type="radio" name="complaint" id="complaint4" value="음란, 청소년유해물"/>음란, 청소년유해물</div>
          	<div><input type="radio" name="complaint" id="complaint5" value="개인정보노출, 유포, 거래"/>개인정보노출, 유포, 거래</div>
          	<div><input type="radio" name="complaint" id="complaint6" value="도배, 스팸"/>도배, 스팸</div>
          	<div><input type="radio" name="complaint" id="complaint7" value="기타" onclick="etcShow()"/>기타</div>
          	<div id="etc"><textarea row="2" id="complaintTxt" class="form-control" style="display:none"></textarea></div>
          	<hr/>
          	<input type="button" value="확인" onclick="complaintCheck()" class="btn btn-success form-control"/>
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
</div>
<!-- 신고하기 폼 모달창 -->

<!-- 댓글수정 모달창 -->
  <div class="modal fade" id="myModal2">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">댓글 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          글내용 : <textarea rows="4" id="modalContent" class="form-control"></textarea>
          <hr/>
          <input type="button" value="수정하기" onclick="replyContentUpdate()" class="btn btn-success form-control"/>
          <input type="hidden" name="idx" id="idx"/>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
<!-- 댓글수정 모달창 -->

<%@ include file = "/include/footer.jsp" %>
</body>
</html>
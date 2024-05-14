<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberList.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <script>
    	'use strict';
    	
    	$(function() {
			$("#userDisplay").hide();
			
			$("#userInfor").on("click", function() {
				if($("#userInfor").is(":checked")) {
					$("#totalList").hide();
					$("#userDisplay").show();
				}
				else {
					$("#totalList").show();
					$("#userDisplay").hide();
				}
			});
		});
    	
    	// 각 레벨별 회원 보기
    	function levelItemCheck() {
			let level = $("#levelItem").val();
			location.href = "MemberList.ad?level="+level;
		}
    	
    	// 회원별 각각의 등ㅇ급 변경처리(ajax처리)
    	function levelChange(e) {
			let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
			if(!ans){
				location.reload();
				return false;
			}
			// 밑에서 level값이랑 idx값이 (level/idx)이렇게 넘어왔으니까 "/"로 구분해서 items에 담고
			// query변수에 다시 배열로 따로 따로 받아온다. 0번째는 level값, 1번째는 idx값
			let items = e.value.split("/");
			let query = {
					level : items[0],
					idx : items[1],
					userDel : items[2]
			}
			$.ajax({
				url : "MemberLevelChange.ad",
				type : "get",
				data : query,
				success : function (res) {
					if(res != "0"){
						alert("등급 수정 완료");
						location.reload();
					}
					else alert("등급 수정 실패");
				},
				error : function() {
					alert("전송오류!!");
				}
			});
		}
    	// 30일 경과회원 삭제처리
    	function memberDeleteOk(idx) {
			let ans = confirm("선택하신 회원을 영구 삭제 하시겠습니까?");
			if (ans){
				$.ajax({
					url : "MemberDeleteOk.ad",
					type : "post",
					data : {idx : idx},
					success : function (res) {
						if(res != "0"){
							alert("삭제 완료되었습니다.");
							location.reload();
						}
						else alert("삭제실패!!");
					},
					error : function() {
						alert("전송오류");
					}
				});
			}
		}
    	
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="row">
		<div class="col text-left"><input type="checkbox" name="userInfor" id="userInfor" onclick="userCheck()"/>비공개회원보기/가리기</div>
		<div class="col text-right">
			<select name="levelItem" id="levelItem" onchange="levelItemCheck()">
				<option value="999" ${level > 4 ? "selected" : ""}>전체보기</option>
				<option value="1" ${level == 1 ? "selected" : ""}>준회원</option>
				<option value="2" ${level == 2 ? "selected" : ""}>정회원</option>
				<option value="3" ${level == 3 ? "selected" : ""}>우수회원</option>
				<option value="99" ${level == 99 ? "selected" : ""}>탈퇴신청회원</option>
				<option value="0" ${level == 0 ? "selected" : ""}>관리자</option>
			</select>
		</div>
	</div>
	<!-- 리스트앞에 체크박스 넣어서 전체선택, 선택, 반전선택, 전체취소 등 만들기-->
	<div id="totalList"> 
		<h3 class="text-center mb-4">전체 회원 리스트</h3>
		<div class="mb-2">
			<input type="checkbox" name="selectA" id="selectA" onclick="selectAll()"/> 전체 선택/해제 &nbsp;&nbsp;
			<input type="checkbox" name="selectR" id="selectR" onclick="selectRe()"/> 반전선택
		</div>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>성명</th>
				<th>생일</th>
				<th>성별</th>
				<th>최종방문일</th>
				<th>오늘방문횟수</th>
				<th>활동여부</th>
				<th>현재레벨</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
				<c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청" /></c:if>
				<c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중" /></c:if>
				<tr>
					<td><input type="checkbox" name="ckBox1" id="ckBox1" onclick="selectChange()"/>${vo.idx}</td>
					<td><a href="MemberSearch.mem?mid=${vo.mid}">${vo.mid}</a></td>
					<td>${vo.nickName}</td>
					<td>${vo.name}</td>
					<td>${fn:substring(vo.birthday,0,10)}</td>
					<td>${vo.gender}</td>
					<td>${fn:substring(vo.lastDate,0,10)}</td>
					<td>${vo.todayCnt}</td>
					<td>
						<!-- 탈퇴신청을 한 사람중 30일이 지난 사람만 30일 경과 문구 보이기 -->
						<c:if test="${vo.userDel == 'OK'}">
							<font color="red"><b>${active}</b></font>
							<c:if test="${vo.deleteDiff >= 30}"><br/>
								(<a href="javascript:memberDeleteOk(${vo.idx})">30일경과</a>)
							</c:if>
						</c:if>
						<c:if test="${vo.userDel != 'OK'}">${active}</c:if>
					</td>
					<td>
					<form name="levelForm">
						<select name="level" onchange="levelChange(this)">	
							<option value="1/${vo.idx}/NO" ${vo.level == 1 ? "selected" : ""}>준회원</option>
							<option value="2/${vo.idx}/NO" ${vo.level == 2 ? "selected" : ""}>정회원</option>
							<option value="3/${vo.idx}/NO" ${vo.level == 3 ? "selected" : ""}>우수회원</option>
							<option value="0/${vo.idx}/NO" ${vo.level == 0 ? "selected" : ""}>관리자</option>
							<option value="99/${vo.idx}/OK" ${vo.level == 99 ? "selected" : ""}>탈퇴신청회원</option>
						</select>	
					</form>
					</td>
				</tr>
				</c:if>
			</c:forEach>
			<tr><td colspan="10" class="m-0 p-0"></td></tr>
		</table>
	</div>
	<div id="userDisplay">
		<c:if test="${sLevel == 0}"> <!-- 이렇게 안해주면 페이지 소스보기를 눌렀을때 비공개 회원이 다 뜬다. -->
			<hr/>
			<h3 class="text-center">비공개 회원 리스트</h3>
			<table class="table table-hover text-center">
				<tr class="table-dark text-dark">
					<th>번호</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>성명</th>
					<th>생일</th>
					<th>성별</th>
					<th>최종방문일</th>
					<th>오늘방문횟수</th>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<c:if test="${vo.userInfor == '비공개'}">
					<tr>
						<td>${vo.idx}</td>
						<td>${vo.mid}</td>
						<td>${vo.nickName}</td>
						<td>${vo.name}</td>
						<td>${fn:substring(vo.birthday,0,10)}</td>
						<td>${vo.gender}</td>
						<td>${fn:substring(vo.lastDate,0,10)}</td>
						<td>${vo.todayCnt}</td>
					</tr>
					</c:if>
				</c:forEach>
				<tr><td colspan="8" class="m-0 p-0"></td></tr>
			</table>
		</c:if>
	</div>
</div>
<p><br/></p>
</body>
</html>
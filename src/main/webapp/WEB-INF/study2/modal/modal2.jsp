<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>modal2.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  
  	function fCheck2(name) {
  		//let name = myform.name.value;
  		$("#myModal2 #modalName2").text(name);
  	}
  	
  	function modalCheck2() {
  		let mid = myform.mid.value;
  		location.href = "Modal2.st?mid="+mid;
  	}
  	
  	function fCheck3() {
  		$("#myModal3 #modalName3").text('${mVo.name}');
  	}
  	
  	function fCheck4(name, mid, nickName) {
  		$("#myModal4 #modalName").text(name);
  		$("#myModal4 #modalMid").text(mid);
  		$("#myModal4 #modalNickName").text(nickName);
	}
  	
  	function nameCheck() {
  		
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>Modal 연습2</h2>
  <hr/>
  <p>
    <input type="button" value="폼내용출력1" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" />
    <a href="#" onclick="fCheck2('홍길동')" class="btn btn-secondary" data-toggle="modal" data-target="#myModal2">폼내용출력2</a>
    <a href="#" onclick="fCheck3()" class="btn btn-info" data-toggle="modal" data-target="#myModal3">폼내용출력3</a>
    <a href="#" onclick="fCheck4('${mVo.name}','${mVo.mid}','${mVo.nickName}')" class="btn btn-warning" data-toggle="modal" data-target="#myModal4">폼내용출력4</a>
  </p>
  <hr/>
  <div>
    <form name="myform">
      <div class="input-group">
        <div class="input-group">아이디</div>
        <div class="input-group-prepend"><input type="text" name="mid" value="hkd1234" class="form-control"/></div>
        <div class="input-group-prepend"><input type="button" value="아이디검색" onclick="modalCheck2()" class="btn btn-success"/></div>
      </div>
    </form>
  </div>
</div>
<p><br/></p>

  <!-- The Modal -->
  <div class="modal fade" id="myModal1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          Modal body..
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="myModal2">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          성명2 : <span id="modalName2"></span>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="myModal3">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          성명3 : <span id="modalName3"></span>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="myModal4">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <form name="midModalForm">
          <!-- 
          	아이디 : 
          	<input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" class="form-control mb-2" required/>
          	<input type="button" value="성명확인" onclick="nameCheck()" class="btn btn-success form-control mb-2"/>
          	 -->
          	 아이디 : <span id="modalMid"></span><br/>
          	 성명 : <span id="modalName"></span><br/>
          	 닉네임 : <span id="modalNickName"></span><br/>
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>

<jsp:include page="/include/footer.jsp" />
</body>
</html>
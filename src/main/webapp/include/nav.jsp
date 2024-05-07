<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
	String mid_ = (String) session.getAttribute("sMid")==null ? "" : (String) session.getAttribute("sMid");
%>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <%-- <a class="navbar-brand" href="<%=request.getContextPath()%>/">HOME</a> --%>
  <a class="navbar-brand" href="http://192.168.50.53:9090/javaclass/Main">HOME</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="${ctp}/GuestList">GUEST</a>
      </li>
      <% if(!mid_.equals("")){ %>
      
      <li class="nav-item">
        <a class="nav-link" href="#">BOARD</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">PDS</a>
      </li>    
      <li class="nav-item">
      	<div class="dropdown">
			<button type="button" class="btn btn-secondary dropdown-toggle mr-3" data-toggle="dropdown">STUDY_01</button>
				<div class="dropdown-menu">
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0426/t01.jsp">서버환경</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0426/t02.jsp">성적 계산</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t01_cookies.jsp">쿠키 연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t2_Session.jsp">세션 연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t3_Application.jsp">어플리케이션 연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t4_StorageTest.jsp">저장소 연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/homwork/ex1_Login.jsp">아이디저장 연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0429_JSTL/el1.jsp">EL 연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0429_JSTL/jstl.jsp">JSTL 연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/filter/t1_filter.jsp">Filter 한글 연습</a>
			      <%-- <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/filter/t2_Certification.jsp">인증코드발행(관리자)</a> --%>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/init/t03_init.jsp">초기값확인</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/lifeCycle/lifeCycle2.jsp">서블릿 생명주기</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/database/LoginList">데이터베이스 연습</a>
			    </div>
		</div>
      </li>
      <li class="nav-item">
      	<div class="dropdown">
			<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">STUDY_02</button>
			<div class="dropdown-menu">
			     <a class="dropdown-item" href="<%=request.getContextPath()%>/study/password/passCheck.jsp">비밀번호암호화</a>
			     <a class="dropdown-item" href="${ctp}/mapping/test">디렉토리mapping연습</a>
			     <a class="dropdown-item" href="${ctp}/mapping/test2.do">확장자mapping연습</a>  <!-- .do를 씀으로써 확장자 -->
			     <a class="dropdown-item" href="${ctp}/mapping/test3.do3">확장자mapping연습3</a>
			     <a class="dropdown-item" href="${ctp}/mapping/test4.do4">확장자mapping연습4</a>
			     <a class="dropdown-item" href="${ctp}/mapping/test5.do5">확장자mapping연습5(숙제)</a>
			</div>
		</div>
      </li>
      <%} %>
      <li class="nav-item">
      <% if(!mid_.equals("")){ %>
        <a class="nav-link" href="${pageContext.request.contextPath}/database/Logout">Logout</a>
        <%} else { %>
        <a class="nav-link" href="<%=request.getContextPath()%>/study/database/login.jsp">Login</a>
        <%} %>
      </li>     
    </ul>
  </div>  
</nav>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <%-- <a class="navbar-brand" href="<%=request.getContextPath()%>/">HOME</a> --%>
  <a class="navbar-brand" href="http://192.168.50.53:9090/javaclass">HOME</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#">GUEST</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">BOARD</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">PDS</a>
      </li>    
      <li class="nav-item">
      	<div class="dropdown">
			<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">STUDY_01</button>
				<div class="dropdown-menu">
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0426/t01.jsp">서버환경</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0426/t02.jsp">성적 계산</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t01_cookies.jsp">쿠키 연습</a>
			    </div>
		</div>
      </li>    
    </ul>
  </div>  
</nav>
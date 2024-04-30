<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/include/certification.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>el1.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>EL(Expression Language)</h2>
	<p>저장소(서버 저장소:ServletContext컨테이너)에 기록되어있는 자료에 대한 처리를 담당</p>
	<hr/>
	<pre>
		용도 : 사용자가 '변수/값/수식/객체' 등을 전송받은 후에 저장, 또는 기타 처리하는 용도로 사용함.
		표기법 : $ {변수/값/객체}
		서버저장소 : Application / session / pageContext / Request
	</pre>
	<hr/>
	<%
		String atom = "Seoul";
		String name = "홍길동";
		int su1 = 100, su2 = 200;
		String su3 = "100", su4 = "400";
	%>
	<h4>스크립틀릿을 이용한 출력</h4>
	<div>
		atom = <%=atom %><br/>
		name = <%=name %><br/>
		su1 = <%=su1 %><br/>
		su2 = <%=su2 %><br/>
		su3 + su4 = <%=(su3 + su4) %>
		<%-- su3 * su4 = <%=(su3 * su4) %> --%>
	</div>
	<hr/>
	<div>
		<h4>EL을 이용한 출력</h4>
		<%
			request.setAttribute("atom", atom);
			pageContext.setAttribute("name", name);
			pageContext.setAttribute("su1", su1);
			pageContext.setAttribute("su2", su2);
			pageContext.setAttribute("su3", su3);
			pageContext.setAttribute("su4", su4);
		%>
			atom = ${atom}<br/>
			name = ${name}<br/>
			su1 = ${su1}<br/>
			su2 = ${su2}<br/>
			su3 + su4 = ${(su3 + su4)}<br/>
			su3 * su4 = ${(su3 * su4)}<br/>
	</div>
	<hr/>
	<h4>파라메터를 통해서 넘어온 값의 처리(QueryString형식)</h4>
	<div>Form태그의 get/post 방식의 전송이나, url을 통한 값의 전송(주소?변수1=값1&변수2=값2...) 되는 값의 처리</div>
	<div>주소창에 현재주소 뒤에 '?mbc=200&kbs=50' 을 입력 후 아래내용 확인하시오<br/>
		mbc = ${param.mbc}<br/>
		kbs = ${param.kbs}<br/>
		mbc - kbs = ${param.mbc - param.kbs}<br/>
	</div>
	<hr/>
	<div>
		<form name="myform" method="post" action="${pageContext.request.contextPath}/j0429/ElTest">
			<h2 class="text-center mb-5">form 자료 전송연습</h2>
			<div>성명 :
				<input type="text" name="name" value="홍길동" class="form-control mb-3"/>
			</div>
			<div>취미 :
				<input type="checkbox" name="hobby" value="등산" checked/> 등산
				<input type="checkbox" name="hobby" value="낚시" /> 낚시
				<input type="checkbox" name="hobby" value="바둑" /> 바둑
				<input type="checkbox" name="hobby" value="수영" /> 수영
				<input type="checkbox" name="hobby" value="바이크" /> 바이크
				<input type="checkbox" name="hobby" value="승마" /> 승마
			</div>
			<div>
				<input type="submit" value="전송" class="btn btn-success form-control mt-3"/>
			</div>
		</form>
	</div>
<%
	name = request.getParameter("name") ==null ? "" : request.getParameter("name");
	if(!name.equals("")){
%>
	<p>성명 : ${name}</p>
	<p>취미 : ${hobby}</p>
<%	} %>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
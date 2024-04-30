<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "/include/certification.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>jstl.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>JSTL(Java Standard Tag Library)</h2>
	<div class="text-right">
		<button type="button" onclick="javascript:location.href='jstl.jsp';" class="btn btn-success btn-sm">JSTL core라이브러리</button>
		<button type="button" onclick="javascript:location.href='jstl2.jsp';" class="btn btn-warning btn-sm">JSTL 반복문</button>
		<button type="button" onclick="javascript:location.href='jstl3.jsp';" class="btn btn-primary btn-sm">JSTL 반복문응용</button>
		<button type="button" onclick="javascript:location.href='jstl4_function.jsp';" class="btn btn-info btn-sm">JSTL 함수</button>
		<button type="button" onclick="javascript:location.href='jstl5_format.jsp';" class="btn btn-secondary btn-sm">JSTL formatting</button>
	</div>
	<table class="table table-bordered mt-4">
		<tr>
			<th>라이브러리</th>
			<th>주소(url)</th>
			<th>접두어</th>
			<th>기본문법</th>
		</tr>
		<tr>
			<td>Core</td>
			<td>http://java.sun.com/jsp/jstl/core</td>
			<td>c</td>
			<td>< c : 태그명..../ ></td>
		</tr>
		<tr>
			<td>Formatting</td>
			<td>http://java.sun.com/jsp/jstl/fmt</td>
			<td>fmt</td>
			<td>< fmt : 태그명..../ ></td>
		</tr>
		<tr>
			<td>Function</td>
			<td>http://java.sun.com/jsp/jstl/function</td>
			<td>fn</td>
			<td>$ { fn : 태그명..../ }</td>
		</tr>
		<tr>
			<td>SQL</td>
			<td>http://java.sun.com/jsp/jstl/sql</td>
			<td>sql</td>
			<td>< sql : 태그명..../ ></td>
		</tr>
	</table>
	<hr/>
	<div>
		앞의 라이브러리를 사용할 경우에는 반드시 상단에 jsp지시자중 'taglib'를 이용하여 먼저 선언 후 사용해야 한다.
	</div>
	<hr/>
	<h2>Core 라이브러리 사용 예</h2>
	<pre>
		<h4>용도 : 변수제어(선언/값(일반,객체)할당/출력/제거), 제어문(조건문, 반복문)</h4>
		변수 선언 : < c : set var="변수명" value="값" />
		변수 출력 : < c : out value="값/변수/수식" />
		변수 제거 : < c : remove var="변수명" />
	</pre>
	<hr/>
	su1 변수를 선언 후 초기값으로 100을 할당? <c:set var="su1" value="100"></c:set><br/>
	값을 출력? <c:out value="200"></c:out><br/>
	su1 변수 값을 출력1? <c:out value="${su1}"/><br/> <!-- EL표기법으로 적어주기 -->
	su1 변수 값을 출력2? ${su1}<br/> <!-- 위랑 같음 -->
	수식을 출력 1? <c:out value="${100 + 200}"/><br/> 
	수식을 출력 2? <c:out value="${'100' + 200}"/><br/> 
	수식을 출력 3? <c:out value="${'100' + '200'}"/><br/> 
	<%String name = "홍길동"; %>
	값을 출력 1? <%=name %><br/>
	값을 출력 2? <c:out value='<%=name %>'/><br/>
	값을 출력 3? <c:out value='${name}'/> : 저장소에 저장하지 않은 변수는 값이 출력되지 않는다.<br/>
	<% pageContext.setAttribute("name", name); %>
	값을 출력 4? <c:out value='${name}'/> == ${name}<br/>
	su1 변수 값을 출력 1? ${su1}<br/>
	su1 변수를 제거? <c:remove var="su1"/><br/>
	su1 변수 값을 출력 2? ${su1}<br/>
	su1 변수에 name 변수값을 저장? <c:set var="su1" value="${name}"></c:set><br/>
	su1 변수값을 출력 3? ${su1}<br/>
	<hr/>
	<h4>JSTL 제어문(조건문(if), 반복문(foreach)) : 주의점 : 조건식의 내용은 EL표기법으로 처리한다.</h4>
	<p>사용법 : < c : if test="$ {조건식}" > 조건식에 따른 처리할 내용 < / c : if > </p>
	<p>단점1 : EL조건문에는 else가 없다.</p>
	<p>단점2 : jstl의 숫자비교는 문자형식으로 비교한다.</p>
	<p>사용 예 1 : (su1=300, su2=400)</p>
	<c:set var="su3" value="300" />
	<c:set var="su4" value="400" />
	<div>su3 : ${su3} / su4 : ${su4}</div>
	<div>1. su3 == su4 : <c:if test="${su3 == su4}">su3와 su4는 같다.</c:if></div>
	<div>2. su3 != su4 : <c:if test="${su3 != su4}">su3와 su4는 같지않다.</c:if></div>
	<div>3. su3 > su4 : <c:if test="${su3 > su4}">su3가 su4보다 크다.</c:if></div>
	<div>4. su3 < su4 : <c:if test="${su3 < su4}">su3가 su4보다 작다.</c:if></div>
	<div>5. su3 <= su4 : <c:if test="${su3 <= su4}">su3가 su4보다 작거나 같다..</c:if></div>
	<div>6. su3 >= su4 : <c:if test="${su3 >= su4}">su3가 su4보다 크거나 같다.</c:if></div>
	<br/>
	
	<p>사용 예 2 : (su3=100, su4=40)</p>
	<c:set var="su3" value="100" />
	<c:set var="su4" value="4" />
	<div>su3 : ${su3} / su4 : ${su4}</div>
	<div>11. su3 == su4 : <c:if test="${su3 == su4}">su3와 su4는 같다.</c:if></div>
	<div>12. su3 != su4 : <c:if test="${su3 != su4}">su3와 su4는 같지않다.</c:if></div>
	<div>13. su3 > su4 : <c:if test="${su3 > su4}">su3가 su4보다 크다.</c:if></div>
	<div>14. su3 < su4 : <c:if test="${su3 < su4}">su3가 su4보다 작다.</c:if></div>
	<div>113. su3 > su4 : <c:if test="${su3+0 > su4+0}">113 su3가 su4보다 크다.</c:if></div> <!-- 숫자를 문자로 비교되기 때문에 +0을 붙여서 숫자로 비교한다. -->
	<div>114. su3 < su4 : <c:if test="${su3+0 < su4+0}">114 su3가 su4보다 작다.</c:if></div>
	<div>1113. su3 gt su4 : <c:if test="${su3+0 gt su4+0}">113 su3가 su4보다 크다.</c:if></div> 
	<div>1114. su3 lt su4 : <c:if test="${su3+0 lt su4+0}">114 su3가 su4보다 작다.</c:if></div>
	<div>1115. su3 gt su4 : <c:if test="${su3+0 ge su4+0}">113 su3가 su4보다 크거나 같다.</c:if></div> 
	<div>1116. su3 lt su4 : <c:if test="${su3+0 le su4+0}">114 su3가 su4보다 작거나 같다.</c:if></div>
	<br/>
	
	<div>예제 : URL에 jumsu를 쿼리스트링 방식으로 입력 후 구하시오</div>
	<div>
		<c:set var="jum" value="${param.jumsu}"></c:set>
		<c:if test="${jum+0 >= 60}"><c:set var="grade" value="D"></c:set></c:if>
		<c:if test="${jum+0 >= 70}"><c:set var="grade" value="C"></c:set></c:if>
		<c:if test="${jum+0 >= 80}"><c:set var="grade" value="B"></c:set></c:if>
		<c:if test="${jum+0 >= 90}"><c:set var="grade" value="A"></c:set></c:if>
		<c:if test="${jum+0 < 60}"><c:set var="grade" value="F"></c:set></c:if>
		입력받은 점수 : ${jum}의 학점은 ${grade} 입니다.
	</div>
	<br/>
	
	<h4>다중조건 비교 : choose ~ when</h4>
	<pre>
		사용법 :
		< c : choose >
			< c : when test="조건식1">수행할 내용1< / c : when >
			< c : when test="조건식2">수행할 내용2< / c : when >
			< c : when test="조건식3">수행할 내용3< / c : when >
			< c : when test="조건식4">수행할 내용4< / c : when >
			~~~~~~~~
			< c : otherwise > 기타 수행할 내용 < / : otherwise >
		< / c : choose >
	</pre>
	<div>학점은?
		<c:choose>
			<c:when test="${jum >= 90}">A</c:when>
			<c:when test="${jum >= 80}">B</c:when>
			<c:when test="${jum >= 70}">C</c:when>
			<c:when test="${jum >= 60}">D</c:when>
			<c:otherwise>F</c:otherwise>
		</c:choose>
	</div>
	<br/>
	
	<div>예제2 : URL에 사번코드(code)를 쿼리스트링 방식으로 입력 후 직급명을 구하시오 </div>
	<div>(B:부장, K:과장, D:대리, S:사원) 변수명 : 직급코드:kCode, 직급명:kName</div>
	<div>
		<c:set var="kCode" value="${param.code}"></c:set>
		<c:choose>
			<c:when test="${kCode == 'B'}"><c:set var="kName" value="부장"/></c:when>
			<c:when test="${kCode == 'K'}"><c:set var="kName" value="과장"/></c:when>
			<c:when test="${kCode == 'D'}"><c:set var="kName" value="대리"/></c:when>
			<c:when test="${kCode == 'S'}"><c:set var="kName" value="사원"/></c:when>
			<c:otherwise><c:set var="kName" value="비사원"/></c:otherwise>
		</c:choose>
		직급코드 : ${kCode} / 직급 : ${kName}
	</div>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
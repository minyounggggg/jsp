<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />


<c:forEach var="vo" items="${vos}" varStatus="st">
	<div class="card">
		<div class="card-body">
			${curScrStarNO}.<img src="${ctp}/images/111.jpg" width="100px"/>
		</div>
		<div class="card-footer">
			<h3>${vo.title}</h3>
			<div><p>${vo.wDate}</p></div>
		</div>
	</div>
	<br/>
	<c:set var="curScrStarNO" value="${curScrStarNO - 1}"></c:set>
	<c:if test=${curScrStarNO}"><h4 class="text-center text-danger"><b>더이상 표시할 게시물이 없습니다.</b></h4></c:if>
</c:forEach>
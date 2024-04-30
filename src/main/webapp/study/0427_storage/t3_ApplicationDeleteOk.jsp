<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t2_SessionDeleteOk.jsp -->
<%
	String applicationSW = request.getParameter("applicationSW");
	application.removeAttribute(applicationSW);
%>

<script>
	alert('['+'<%=applicationSW%>' + "] 어플리케이션이 삭제 되었습니다.");
	location.href="t3_Application.jsp";
</script>
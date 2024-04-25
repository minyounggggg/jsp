<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    	'use strict';
    	
    	function imgView() {
			let img = myform.img.value;
			let str = '<img src="<%=request.getContextPath()%>/images/'+img+'.jpg" width="300px"/>';
			demo1.innerHTML = str;
		}
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>아래 콤보상자에서 그림 파일을 선택하면 선택된 그림을 화면에 출력하시오</h2>
	<hr/>
	<form name="myform" action="<%=request.getContextPath() %>/j0425/T08Ok">
		<div>그림선택
			<select name="img" onchange="imgView()">
				<option>111</option>
				<option>112</option>
				<option>113</option>
			</select>
		</div>
		<hr/>
		<div id="demo1"></div>
		<hr/>
		<div>그림선택
			<select name="img2" size="3" multiple>
				<option>111</option>
				<option>222</option>
				<option>333</option>
			</select>
			<p><input type="submit" value="사진출력" class="btn btn-info"/></p>
		</div>
		<hr/>
		<div id="demo2"></div>
		<hr/>
	</form>
</div>
<p><br/></p>
</body>
</html>
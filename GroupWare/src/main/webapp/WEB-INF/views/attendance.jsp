<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyAttendance</title>

<%@ include file="./layout/header.jsp"%>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10">
		${sessionScope.loginDto}
		</div>
	</div>
</main>
	
</body>
</html>

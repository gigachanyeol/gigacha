<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="./layout/header.jsp"%>
<style type="text/css">
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}
</style>
</head> 
<body>
<%@ include file="./layout/nav.jsp" %>
<%@ include file="./layout/sidebar.jsp" %>
	<div id="content">
		<h3 class="content_title">제목</h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>라이브러리</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td>sdasd</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>

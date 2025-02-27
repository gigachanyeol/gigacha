<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<h3 class="content_title">카테고리 목록</h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>이름</th>
					<th>약어</th>
					<th>생성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${categoryList}" var="cate">
					<tr>
						<td>${cate.category_name}</td>
						<td>${cate.category_yname}</td>
						<td>${cate.create_date}</td>
					</tr>
				</c:forEach>				
			</tbody>
		</table>
	</div>

</body>
</html>

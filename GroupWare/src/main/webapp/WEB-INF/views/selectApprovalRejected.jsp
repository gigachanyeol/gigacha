<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려문서함</title>

<%@ include file="./layout/header.jsp"%>
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10 mt-3">
			<h3 class="content_title">반려문서함</h3>
			<table class="table table-hover">
				<tr>
					<th>문서번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>상태</th>
					<th>결재자</th>
					<th>반려사유</th>
				</tr>
				<c:forEach items="${approvalList}" var="dto">
					<tr>
						<td><a href="./approvalDetail.do?id=${dto.approval_id}">${dto.approval_id}</a>
						</td>
						<td>${dto.approval_content}</td>
						<td>${dto.approval_title}</td>
						<td>${dto.approval_status}</td>
						<td>${dto.create_date}</td>
						<td>${dto.approval_deadline }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</main>
</body>
</html>

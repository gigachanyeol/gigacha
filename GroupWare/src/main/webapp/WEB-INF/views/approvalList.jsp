<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재요청함/임시저장요청함</title>

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
		<h3 class="content_title">결재요청함</h3>
		<table class="table table-hover">
			<tr>
				<th>문서번호</th>
				<th>양식번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>상태</th>
				<th>작성일</th>
				<th>마감기한</th>
				<th>임시저장여부</th>
			</tr>
			<c:forEach items="${approvalList}" var="dto">
				<tr>
					<td>
						<a href="./approvalDetail.do?id=${dto.approval_id}">
							${dto.approval_id}
						</a>
					</td>
					<td>${dto.form_id}</td>
					<td>${dto.empno}</td>
					<td>${dto.approval_title}</td>
					<td>
						<c:if test='${dto.approval_status eq "ST01"}'>임시저장</c:if>
						<c:if test='${dto.approval_status eq "ST02"}'>결재대기</c:if>
						<c:if test='${dto.approval_status eq "ST03"}'>결재진행중</c:if>
						<c:if test='${dto.approval_status eq "ST04"}'>결재완료</c:if>
						<c:if test='${dto.approval_status eq "ST05"}'>반려</c:if>
					</td>
					<td>${dto.create_date}</td>
					<td>${dto.approval_deadline}</td>
					<td>${dto.temp_save_yn}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	
	
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재요청함/임시저장요청함</title>

<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<div class="row">
	<div id="content" class="col-lg-10">
		<h3 class="content_title">결재요청함</h3>
		<div id="wrapper" class="list">
            <table id="example" class="display nowrap dataTable dtr-inline collapsed">
                <thead>
                    <tr>
                        <th>문서번호</th>
                        <th>양식번호</th>
                        <th>작성자</th>
                        <th>제목</th>
                        <th>상태</th>
                        <th>작성일</th> 
                        <th>마감기한</th> 
                        <th>임시저장</th> 
                    </tr>
                </thead>
            </table>
        </div>
<!-- 		<table class="table table-hover"> -->
<!-- 			<tr> -->
<!-- 				<th>문서번호</th> -->
<!-- 				<th>양식번호</th> -->
<!-- 				<th>작성자</th> -->
<!-- 				<th>제목</th> -->
<!-- 				<th>상태</th> -->
<!-- 				<th>작성일</th> -->
<!-- 				<th>마감기한</th> -->
<!-- 				<th>임시저장여부</th> -->
<!-- 			</tr> -->
<%-- 			<c:forEach items="${approvalList}" var="dto"> --%>
<!-- 				<tr> -->
<!-- 					<td> -->
<%-- 						<a href="./approvalDetail.do?id=${dto.approval_id}"> --%>
<%-- 							${dto.approval_id} --%>
<!-- 						</a> -->
<!-- 					</td> -->
<%-- 					<td>${dto.form_id}</td> --%>
<%-- 					<td>${dto.empno}</td> --%>
<%-- 					<td>${dto.approval_title}</td> --%>
<!-- 					<td> -->
<%-- 						<c:if test='${dto.approval_status eq "ST01"}'>임시저장</c:if> --%>
<%-- 						<c:if test='${dto.approval_status eq "ST02"}'>결재대기</c:if> --%>
<%-- 						<c:if test='${dto.approval_status eq "ST03"}'>결재진행중</c:if> --%>
<%-- 						<c:if test='${dto.approval_status eq "ST04"}'>결재완료</c:if> --%>
<%-- 						<c:if test='${dto.approval_status eq "ST05"}'>반려</c:if> --%>
<!-- 					</td> -->
<%-- 					<td>${dto.create_date}</td> --%>
<%-- 					<td>${dto.approval_deadline}</td> --%>
<%-- 					<td>${dto.temp_save_yn}</td> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</table> -->
	</div>
</div>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable({
	    	// 샘플 데이터
	        ajax: {
	            url: './approvalListTempAjax.do',
	            method:'get',
	            dataType: 'json',
	            dataSrc: function(json) {
	                console.log("서버 응답 데이터:", json); // JSON 데이터 확인
	                return json.data || json; // dataSrc가 없을 경우 전체 반환
	            }
	        },
	        columns: [
	            { data: 'approval_id' },
	            { data: 'form_id' },
	            { data: 'empno' },
	            { data: 'approval_title' },
	            { data: 'approval_status' },
	            { data: 'create_date' },
	            { data: 'approval_deadline' },
	            { data: 'temp_save_yn' }
	        ],
	        // 행 선택
	        lengthMenu: [10, 20, 30],
	        search: {
	            return: true
	        }
	    });
	});
	</script>
</body>
</html>

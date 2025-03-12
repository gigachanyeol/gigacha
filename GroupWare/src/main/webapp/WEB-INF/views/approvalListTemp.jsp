<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재요청함/임시저장요청함</title>

<%@ include file="./layout/header.jsp"%>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/> -->
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
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
		</div>
	</div>
</main>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable({
	    	// 샘플 데이터
	        ajax: {
	            url: './approvalListTemp.json',
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
	        },
	        rowCallback: function(row, data) {
	            $(row).find('td:first').on('click', function() {
	                window.location.href = './approvalDetail.do?id='+data.approval_id;
	            }).css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
	        }
	    });
	});
	</script>
</body>
</html>

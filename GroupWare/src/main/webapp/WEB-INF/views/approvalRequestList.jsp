<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재목록함</title>

<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/>
<style type="text/css">
.modal-content{
	width: 220mm;
/*     height: 307mm; */
}
</style>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10 mt-3">
			<h3 class="content_title">결재목록함</h3>
<!-- 			<table class="table table-hover"> -->
<!-- 				<tr> -->
<!-- 					<th>문서번호</th> -->
<!-- 					<th>작성자</th> -->
<!-- 					<th>제목</th> -->
<!-- 					<th>상태</th> -->
<!-- 					<th>작성일</th> -->
<!-- 					<th>마감기한</th> -->
<!-- 					<th></th> -->
<!-- 				</tr> -->
<%-- 				<c:forEach items="${approvalList}" var="dto"> --%>
<!-- 					<tr> -->
<!-- 						<td> -->
<%-- 							<a href="./approvalDetail.do?id=${dto.approval_id}">${dto.approval_id}</a> --%>
<!-- 						</td> -->
<%-- 						<td>${dto.empno}</td> --%>
<%-- 						<td>${dto.approval_title}</td> --%>
<!-- 						<td> -->
<%-- 							<c:if test='${dto.approval_status eq "ST01"}'>임시저장</c:if> --%>
<%-- 							<c:if test='${dto.approval_status eq "ST02"}'>결재대기</c:if> --%>
<%-- 							<c:if test='${dto.approval_status eq "ST03"}'>결재진행중</c:if> --%>
<%-- 							<c:if test='${dto.approval_status eq "ST04"}'>결재완료</c:if> --%>
<%-- 							<c:if test='${dto.approval_status eq "ST05"}'>반려</c:if> --%>
<!-- 						</td> -->
<%-- 						<td>${dto.create_date}</td> --%>
<%-- 						<td>${dto.approval_deadline}</td> --%>
<!-- 						<td> -->
<!-- 							<button class="btn btn-success" id="acceptBtn">승인</button> -->
<!-- 							<button class="btn btn-danger" id="rejectBtn" data-bs-toggle="modal" data-bs-target="#myModal">반려</button> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<%-- 				</c:forEach> --%>
<!-- 			</table> -->
			<table id="documentsTable"
				class="display nowrap dataTable dtr-inline collapsed"
				style="width: 100%;">
				<thead>
					<tr>
						<th>문서번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>상태</th>
						<th>작성일</th>
						<th>마감기한</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</main>
<!-- 모달 -->
	<div class="modal" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false">
	  <div class="modal-dialog modal-dialog-scrollabl">
	    <div class="modal-content">
	    	
	      <div class="modal-header">
  			<button class="btn btn-info" id="acceptBtn">승인</button>
	         <button type="button" class="btn btn-success" id="rejectBtn">반려</button>
	      	<button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button>
	      </div>
	      <div class="modal-body row">
	      	<div id="approvalLine" class="mt-3 col-4"></div>
	      	<div id="modal-content"></div>
	      </div>
	
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>

<!-- 	<!-- The Modal --> -->
<!-- <div class="modal" id="myModal"> -->
<!--   <div class="modal-dialog"> -->
<!--     <div class="modal-content"> -->

<!--       Modal Header -->
<!--       <div class="modal-header"> -->
<!--         <h4 class="modal-title">반려사유</h4> -->
<!--         <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<!--       </div> -->

<!--       Modal body -->
<!--       <div class="modal-body"> -->
<!--         <input type="text" name="reject_reason"> -->
<!--       </div> -->

<!--       Modal footer -->
<!--       <div class="modal-footer"> -->
      
<!--       	<button type="button" class="btn btn-success" id="rejectModalBtn">반려</button> -->
<!--         <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button> -->
<!--       </div> -->

<!--     </div> -->
<!--   </div> -->
<!-- </div> -->
</body>
<script type="text/javascript">
	$(document).ready(function(){
		var table = $('#documentsTable').DataTable({
			// 샘플 데이터
	        ajax: {
	            url: './approvalRequestList.json',
	            method:'get',
	            dataType: 'json',
	            dataSrc: function(json) {
	                console.log("서버 응답 데이터:", json); // JSON 데이터 확인
	                return json.data || json; // dataSrc가 없을 경우 전체 반환
	            }
	        },
	        columns: [
	            { data: 'approval_id' },
	            { data: 'empno' },
	            { data: 'approval_title' },
	            { data: 'approval_status' },
	            { data: 'create_date' },
	            { data: 'approval_deadline' }
	        ],
	        // 행 선택
	        lengthMenu: [10, 20, 30],
	        search: {
	            return: true
	        },
	        rowCallback: function(row, data) {
	            $(row).find('td:first').on('click', function() {
//	                 window.location.href = './approvalDetail.do?id='+data.approval_id;
					openModal(data.approval_id);
					console.log(data.approval_id);
	            })
	            .css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
	        }
	    });

		function openModal(approval_id){
			fetch("./approvalDetail.json?id="+approval_id)
			.then(resp => resp.json())
			.then(data => {
				console.log(data);
				 let html = "<div class='approval-item'>결<br>재</div>";
		            data.approvalLineDtos.forEach((emp, i) => {
		                console.log(emp.name, emp.approver_empno);
		                html += "<div class='approval-item'>";
		                html += "<div id='" + emp.approver_empno + "' class='text-center'></div>";
		                html += "</div>";
		            });

	            document.getElementById("approvalLine").innerHTML = html;
				$("#modal-content").html(data.approval_content);
				$("#acceptBtn").val(data.approval_id);
				$("#rejectBtn").val(data.approval_id);						
				$("#myModal").show();
			})
			.catch(err => console.log(err));
		}
		
		$(".modalBtn").on('click', function(){
			$("#myModal").hide();
			$("#acceptBtn").val('');
			$("#rejectBtn").val('');	
		});
		
		$("#acceptBtn").on('click', function (event) {
			console.log('클릭',$("#acceptBtn").val());
			let jsonData={};
			jsonData["approval_id"] = $("#acceptBtn").val();
			console.log(jsonData);
		
			fetch("./acceptApprovalLine.json",{
				method:"POST",
				headers:{
					"Content-Type":"application/json"
				},
				body:JSON.stringify(jsonData)
			})
			.then(resp => resp.json())
			.then(data => {
				if(data == true) {
					Swal.fire("결재승인").then(()=>{
						table.ajax.reload();
						$("#myModal").hide();
					});
				} else{
					Swal.fire("결재승인실패");
				}
			})
			.catch(err => console.log(err));
		});
		
		$("#rejectBtn").on('click', function (event) {
			console.log('클릭',$("#rejectBtn").val());
			let jsonData={};
			jsonData["approval_id"] = $("#rejectBtn").val();

			console.log(jsonData);
			
			Swal.fire({
				title: "반려사유를 입력하세요",
		        input: "text",
		        inputPlaceholder: "반려 사유를 입력하세요",
		        showCancelButton: true,
		        confirmButtonText: "확인",
		        cancelButtonText: "취소",
		        inputValidator: (value) => {
		            if (!value) {
		                return "반려 사유를 입력해야 합니다!";
		            }
		        } 
			}).then((result) => {
				console.log(result);
				jsonData["reject_reason"] = result.value;
				console.log(jsonData);
				fetch("./rejectApprovalLine.json",{
					method:"POST",
					headers:{
						'Content-Type':'application/json'
					},
					body:JSON.stringify(jsonData)
				})
				.then(resp => resp.json())
				.then(data => {
					if(data == true) {
						Swal.fire("반려성공").then(() => {
							table.ajax.reload();
							$("#myModal").hide();
						});
					} else{
						Swal.fire("반려실패");
					}
				})
				.catch(err => console.log(err));
			})
		});
	});
	

</script>
</html>


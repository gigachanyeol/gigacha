<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재목록함</title>

<%@ include file="./layout/header.jsp"%>
</head> 
<body>
<%-- <%@ include file="./layout/nav.jsp" %> --%>
<%@ include file="./layout/newNav.jsp" %>
<%-- <%@ include file="./layout/sidebar.jsp" %> --%>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10 mt-3">
			<h3 class="content_title">결재목록함</h3>
			<table class="table table-hover">
				<tr>
					<th>문서번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>상태</th>
					<th>작성일</th>
					<th>마감기한</th>
					<th></th>
				</tr>
				<c:forEach items="${approvalList}" var="dto">
					<tr>
						<td>
							<a href="./approvalDetail.do?id=${dto.approval_id}">${dto.approval_id}</a>
						</td>
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
						<td>
							<button class="btn btn-success" id="acceptBtn">승인</button>
							<button class="btn btn-danger" id="rejectBtn" data-bs-toggle="modal" data-bs-target="#myModal">반려</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</main>
	<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">반려사유</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <input type="text" name="reject_reason">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      
      	<button type="button" class="btn btn-success" id="rejectModalBtn">반려</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>
</body>
<script type="text/javascript">
	
	document.querySelector("#acceptBtn").addEventListener('click', (event) => {
		let tr = event.target.closest("tr");
		let approval_id = tr.children[0].children[0].textContent;
		console.log(approval_id);
		let jsonData={};
		jsonData["approval_id"] = approval_id;
		console.log(jsonData);
		fetch("./acceptApprovalLine.do",{
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
					tr.remove();
				})
				
			} else{
				Swal.fire("결재승인실패");
			}
		})
		.catch(err => console.log(err))
	});
	
	
	var reject_reason;
	document.querySelector("#rejectBtn").addEventListener('click', (event) => {
		console.log(reject_reason);
		let tr = event.target.closest("tr");
		let approval_id = tr.children[0].children[0].textContent;
		console.log(approval_id);
		let jsonData={};
		jsonData["approval_id"] = approval_id;
		jsonData["reject_reason"] = reject_reason;
		console.log(jsonData);
		
		if(typeof reject_reason != 'undefined') {
			console.log("dddd");
			fetch("./rejectApprovalLine.do",{
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
						let modalElement = document.getElementById('myModal');
		                let modalInstance = bootstrap.Modal.getInstance(modalElement);
		                modalInstance.hide(); 
					});
					tr.remove();
				} else{
					Swal.fire("반려실패");
				}
			})
			.catch(err => console.log(err));
		}
	});
	document.querySelector("#rejectModalBtn").addEventListener('click', () => {
		reject_reason = document.querySelector("input[name=reject_reason]").value;
		document.querySelector("#rejectBtn").click();
	});
</script>
</html>

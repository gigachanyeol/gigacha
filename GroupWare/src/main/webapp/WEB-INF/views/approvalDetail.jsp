<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재문서 상세</title>

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
		<h3 class="content_title">${approval.approval_id}</h3>
		<c:if test="${approval.empno eq loginDto.empno}"><button id="updateFormBtn">문서수정</button></c:if>
		<c:if test='${approval.empno eq loginDto.empno and approval.approval_status eq "ST02"}'><button id="recallBtn">문서회수</button></c:if>
		<c:if test='${approval.approval_status eq "ST01"}'>
			<button id="approvalBtn">결재 요청</button>	
		</c:if>
		
		<div>
			${approval.approval_content}
		</div>
	</div>
</body>
<script type="text/javascript">
	document.querySelector("#updateFormBtn").addEventListener('click', () => {
		location.href="./approvalUpdateForm.do?id=${approval.approval_id}";
	});
	
	document.querySelector("#recallBtn").addEventListener('click', () => {
		let approval_id = document.querySelector(".content_title").textContent;
		fetch("./approvalRecall.do",{
			method:"POST",
			headers:{
				"Content-Type":"application/json"
			},
			body:approval_id=approval_id
		})
		.then(resp => resp.json())
		.then(data => {
			if(data == true){
				Swal.fire("문서가 회수되었습니다.").then(()=>{
					location.href="./approvalList.do";
				})
			} else{
				Swal.fire("문서회수가 실패하였습니다.");
			}
		})
		.catch(err => console.log(err));
	});
	
	document.querySelector("#approvalBtn").addEventListener('click', ()=> {
		let approval_id = document.querySelector(".content_title").textContent;
		fetch("./approvalRequest.do",{
			method:"POST",
			headers:{
				"Content-Type":"application/json"
			},
			body:approval_id=approval_id
		})
		.then(resp => resp.json())
		.then(data => {
			if(data == true){
				Swal.fire("결재요청 되었습니다.").then(()=>{
					location.href="./approvalList.do";
				})
			} else{
				Swal.fire("결재요청이 실패했습니다.");
			}
		})
		.catch(err => console.log(err));
	});
</script>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식관리</title>

<%@ include file="./layout/header.jsp"%>
</head> 
<body>
	<%@ include file="./layout/newNav.jsp" %>
	<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<div class="pagetitle">
				<h1>문서양식관리</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
						<li class="breadcrumb-item ">전자결재</li>
						<li class="breadcrumb-item active">문서양식관리</li>
					</ol>
				</nav>
			</div>
			<c:if test="${loginDto.auth eq 'A' }">
				<button type="button" class="btn btn-primary" onclick="location.href='./managerFormCreate.do'">문서양식등록</button>
			</c:if>
			<div class="card">
	            <div class="card-body">
	              <table class="table">
	                <thead>
	                  <tr>
	                    <th scope="col">#</th>
	                    <th scope="col">양식아이디</th>
	                    <th scope="col">카테고리이름</th>
	                    <th scope="col">양식이름</th>
	                    <th scope="col">생성일</th>
	                  </tr>
	                </thead>
	                <tbody>
	                 <c:forEach items="${formList}" var="frm">
	                 	<c:choose>
	                 		<c:when test="${loginDto.auth eq 'A'}">
	                 		<tr>
			                    <td scope="col">#</td>
			                    <td scope="col">${frm.form_id}</td>
			                    <td scope="col">${frm.form_content}</td>
			                    <td scope="col"><a href="./managerFormDetail.do?id=${frm.form_id}">${frm.form_name}</a></td>
			                    <td scope="col">${frm.create_date}</td>
			                    <td>
									<div class="form-check form-switch">
				                      <input class="form-check-input" type="checkbox" value="${frm.form_id}" ${frm.use_yn eq 'Y' ?'checked':''}>
				                    </div>
								</td>
			                  </tr>
	                 		</c:when>
	                 		<c:otherwise>
	                 			<c:if test="${frm.use_yn eq 'Y'}">
		                 			<tr>
					                    <td scope="col">#</td>
					                    <td scope="col">${frm.form_id}</td>
					                    <td scope="col">${frm.form_content}</td>
					                    <td scope="col"><a href="./managerFormDetail.do?id=${frm.form_id}">${frm.form_name}</a></td>
					                    <td scope="col">${frm.create_date}</td>
					                  </tr>
	                 			</c:if>
	                 		</c:otherwise>
	                 	</c:choose>
		                 
	                 </c:forEach>
	                </tbody>
	              </table>
	            </div>
	         </div>
		</div>
	</div>
</main>
</body>
<script type="text/javascript">
		document.querySelectorAll(".form-check-input").forEach( async (checkbox) => {
			checkbox.addEventListener("change", async (event)=>{
				console.log("id ", event.target.value);
				console.log(event.target);
				let useYn = event.target.checked ? 'Y' : 'N';
				console.log(useYn)
				let data = await changeUseYn(useYn, event.target.value);
				console.log(data);
			})
		})
		async function changeUseYn(useYn, value){
			let response = await fetch("./managerFormDeleteAjax.do",{
				method:"post",
				headers:{
					'Content-Type':'application/json'
				},
				body:JSON.stringify({
					use_yn:useYn,
					id:value
				})
			})
			if(!response.ok){
				throw new Error(error);
			}
			return await response.json();
		}
	</script>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식수정</title>

<%@ include file="./layout/header.jsp"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@toast-ui/editor@3.2.2/dist/toastui-editor.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<style type="text/css">
	#content {
		margin-top:65px;
		margin-right: 30px;
		margin-left: 230px;
	}

	.content_title {
		margin-top: 10px;
		padding-bottom: 5px;
		border-bottom: 1px solid #ccc;
	}

	#viewer table {
		margin: 0 auto;
		width: 80%;
	}
	.toastui-editor-contents table {
		margin: 0 auto;
		width:80%;
	}
	.toastui-editor-contents table th{
	background-color:#fff;
		color:black;
	}
	.toastui-editor-contents th p {
	background-color:#fff;
		color:black;
	}
	
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
	<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
		
</head> 
<body>
<%@ include file="./layout/nav.jsp" %>
<%@ include file="./layout/sidebar.jsp" %>
	<div id="content">
		<h3 class="content_title">${form.form_name}</h3>
		<form>
			<label for="inputText" class="col-sm-2 col-form-label">양식이름</label>
			<div class="col-sm-10">
				<input type="hidden" class="form-control" name="form_id" value="${form.form_id}">
				<input type="text" class="form-control" name="form_name" value="${form.form_name}">
			</div>
			<div id="editor" class="toastui-editor-contents">${form.form_content}</div>
			<input type="hidden" value="" name="form_content">
			<button id="saveBtn" type="submit" class="btn btn-info">수정</button>
			<button type="button" class="btn btn-danger" onclick="history.back()">뒤로가기</button>
		</form>
	</div>
</body>
	<script src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>
	<script>
		window.onload = function () {
			editor.setData(document.querySelector('#editor').innerHTML);
			
			document.querySelector("#saveBtn").addEventListener('click',(event) => {
				event.preventDefault();
				let formData = new FormData(document.forms[0]);
				let jsonData = {};
				formData.forEach((value, key) => {
					jsonData[key] = value;
				});
				jsonData["form_content"] = editor.getData();
				console.log(jsonData);
				fetch("./approvalFormUpdate.do",{
					method:"POST",
					headers:{
						"Content-Type":"application/json"
					},
					body:JSON.stringify(jsonData)
				})
				.then(resp => resp.json())
				.then(data => {
					console.log(data);
					if(data == true) {
						Swal.fire("수정에 성공했습니다.").then(()=>{
							location.href="./approvalFormUpdate.do?id="+jsonData["form_id"];
						})
					} else {
						Swal.fire("수정에 실패했습니다.<br> 해당 양식으로 작성된 <br>글이 존재합니다.");
					}
				})
				.catch(err => console.log(err));
			})
		}
	</script>
</html>

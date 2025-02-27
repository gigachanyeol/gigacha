<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식상세</title>

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
</head> 
<body>
<%@ include file="./layout/nav.jsp" %>
<%@ include file="./layout/sidebar.jsp" %>
	<div id="content">
		<h3 class="content_title">${form.form_name}</h3>
		<div id="viewer" class="toastui-editor-contents">${form.form_content}</div>
	</div>

	
	
</body>
</html>

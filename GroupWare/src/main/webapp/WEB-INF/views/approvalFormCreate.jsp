<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식관리</title>

<%@ include file="./layout/header.jsp"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@toast-ui/editor@3.2.2/dist/toastui-editor.min.css">
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<style type="text/css">
#content {
	margin-top: 65px;
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
	width: 80%;
}

.toastui-editor-contents table th {
	background-color: #fff;
	color: black;
}

.toastui-editor-contents th p {
	background-color: #fff;
	color: black;
}
</style>
</head>
<body>
	<%@ include file="./layout/nav.jsp"%>
	<%@ include file="./layout/sidebar.jsp"%>
	<div id="content">
		필수값 : FORM_ID 자동생성 , CATEGORY_ID 트리 , FORM_NAME, FORM_CONTENT
		<h3 class="content_title">문서양식추가</h3>

		<div class="card">
			<div class="card-body">
				<h5 class="card-title">General Form Elements</h5>

				<!-- General Form Elements -->
				<form>
					<div class="row mb-3">
						<label for="inputText" class="col-sm-2 col-form-label">양식이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="form_name">
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">카테고리</label>
						<div class="col-sm-10">
							<input type="hidden" value="" name="category_id" readonly="readonly">
							<div class="form-control">
								<span id="category_id" ></span>
								<button class="btn" id="cateBtn">카테고리 선택</button>
							</div>						
							
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">양식</label>
						<div class="col-sm-10">
							<div id="editor"></div>
							<input type="hidden" name="form_content">
							<button id="editorViewBtn">에디터 뷰 DB에서 가져오기 버튼</button>
							<button id="editorSaveBtn">에디터 내용 저장</button>
							<div id="viewer" class="toastui-editor-contents"></div>
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">Submit Button</label>
						<div class="col-sm-10">
							<button type="submit" class="btn btn-primary">저장</button>
							<button type="reset" class="btn btn-light">리셋</button>
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>
	<script type="text/javascript">
	function categoryPick(category_id,category_name) {
		console.log("팝업에서 보낸 값", category_id, category_name);
		document.querySelector("input[name=category_id]").value = category_id;
		document.querySelector("#category_id").textContent = category_name;
	}
	window.onload = function() {
		
		document.querySelector("button[type=reset]").addEventListener('click',()=> {
			console.log("리셋클릭");
			editor.setHTML();
		}); 
		
		document.querySelector("#cateBtn").addEventListener('click',(event)=>{
			event.preventDefault();
			console.log("cateBtn클릭");
			window.open('./categoryPop.do',"popupWindow","width=400,height=600,top=150,left=300");
		});
		
		
		
		document.querySelector("button[type=submit]").addEventListener('click', (event) => {
			event.preventDefault();
			let editorHtml = editor.getHTML();
			console.log(editorHtml);
			let formData = new FormData(document.forms[0]);
			let jsonData = {};
			formData.forEach((value, key) => {
				jsonData[key] = value;
			});
			jsonData["form_content"] = editorHtml;
			console.log(jsonData);
			fetch('./approvalFormSave.do',{
	 			method:'POST',
	 			headers:{
	 				'Content-Type':'application/json'
	 			},
	 			body:JSON.stringify(jsonData)
	 		})
	 		.then(resp => resp.json())
	 		.then(data => console.log(data))
	 		.catch(err => console.log(err))
		});
		
		const editor = new toastui.Editor({
	         el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
	         height: '500px',
	         initialEditType: 'wysiwyg',
	         previewStyle:"vertical",
	         hideModeSwitch:"true",
	         
	     });
		
	     // 에디터 DB에서 불러오기
	     document.querySelector("#editorViewBtn").addEventListener('click',()=>{
	     	console.log("버튼클릭확인");
	     	
	     	document.querySelector("#editor").style.display = "none";
	     	fetch('./editorRead.do')
	     	.then(res => res.json())
	     	.then(data => {
	     		document.querySelector("#viewer").innerHTML = data.html;	
	     	})
	     	.catch(err => console.log(err));
	     });
	     
	  // --- 에디터 저장
	 	var editorSaveBtn = document.querySelector("#editorSaveBtn");
	 	editorSaveBtn.addEventListener('click',()=>{
	 		let editorHtml = editor.getHTML();
	 		
	 		fetch('./approvalFormSave.do',{
	 			method:'POST',
	 			headers:{
	 				'Content-Type':'application/json'
	 			},
	 			body:JSON.stringify({html:editorHtml})
	 		})
	 		.then(res => res.text())
	 		.then(data => console.log(data))
	 		.catch(err => console.log(err));
	 	});
	}
	 
	</script>
</body>
</html>

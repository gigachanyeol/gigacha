<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="./layout/header.jsp"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@toast-ui/editor@3.2.2/dist/toastui-editor.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<style type="text/css">
#approvalLine {
	
}

.approval-item {
	float: right;
	display: inline-block;
	width: 80px;
	height: 100px;
	background: yellow;
	border: 1px solid black;
	font-size: 0.8em;
	display: inline-block;
}

#form {
	clear: both;
}

#fileForm {
	height: 100px;
	border: 1px solid #ccc;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet"
	href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
</head>
<body>
	<%@ include file="./layout/newNav.jsp" %>
	<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content">
			<h3 class="content_title">기안문작성</h3>
			<div class="content_nav">
				<button id="formBtn">문서양식</button>
				<button id="lineBtn">결재선</button>
				<button id="saveBtn">문서수정</button>
				<button id="cancelBtn" onclick="javascirpt:history.back()">취소</button>
			</div>
			<div id="approvalLine"></div>
			<form action="">
				<table border="1">
					<tbody>
						<tr>
							<th>문서번호</th>
							<td>
								<input type="hidden" value="${approval.approval_id}" name="approval_id">
								${approval.approval_id}
							</td>
							<th>기안일자</th>
							<td>${approval.create_date}</td>
						</tr>
						<tr>
							<th>참조자</th>
							<td><span>참조자선택버튼</span></td>
							<th>마감기한</th>
							<td><input type="date" name="approval_deadline"></td>
						</tr>
						<tr>
							<th>긴급여부</th>
							<td>긴급 <input type="radio" name="urgency" value="Y">
								일반 <input type="radio" name="urgency" value="N" checked>
							</td>
							<th>서명/도장</th>
							<td>서명 <input type="radio" value="1" name="signature" checked>
								도장 <input type="radio" value="2" name="signature">
							</td>
						</tr>
						<tr>
							<th>문서제목</th>
							<td colspan="3"><input type="text" class="form-control"
								name="approval_title"></td>
						</tr>
	
					</tbody>
				</table>
				<input type="hidden" name="form_id">
				<div id="editor">${approval.approval_content}</div>
				<input class="btn" type="file" multiple id="formFile">
				<div id="fileForm">파일업로드목록</div>
			</form>
		</div>
	</div>
</main>
	<script
		src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>

	<script type="text/javascript">
		editor.setData(document.querySelector('#editor').innerHTML);
		// 양식 가져오기 
		document.querySelector("#formBtn").addEventListener('click', () => {
			window.open('./formTreeView.do',"popupWindow","width=400,height=600,top=150,left=300");
		});

		function form(form_id) {
			console.log("팝업에서 보낸값", form_id[0].id);
			fetch("./selectForm.do", {
				method:'post',
				headers:{
					'Content-Type':'text/plain'
				},
				body:form_id[0].id
			})
			.then(resp => resp.json())
			.then(data => {
				console.log(data);
				document.querySelector("input[name=form_id]").value = data.FORM_ID;
//	 			editor.setHTML(data.FORM_CONTENT);
				editor.setData(data.FORM_CONTENT);
			})
			.catch(err => console.log(err));
		}
		
		// -- 문서양식 에디터
//	 	const editor = new toastui.Editor({
//	             el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
//	             height: 'auto',
//	             initialEditType: 'wysiwyg',
//	             previewStyle:"vertical",
//	             hideModeSwitch:"true",
//	             toolbarItems: []
//	         });

		// -- 결재선
			var initApprovalLine;
			document.getElementById("lineBtn").addEventListener('click', () => {
				window.open('./tre.do',"popupWindow","width=400,height=600,top=150,left=300");
			});
			
			function line(approvalLine) {
				console.log("팝업에서 보낸값", approvalLine);
				initApprovalLine = approvalLine;
				console.log(initApprovalLine) // 결재선에 선택된 사원 아이디, 이름(직급) 들어있는 변수
				let html = "";
				html += "<div class='approval-item'>";
				html += "결<br>재";
				html += "</div>";
				approvalLine.forEach( (emp , i) => { 
						console.log(emp.name,emp.id);
						html += "<div class='approval-item'>";
//		 				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
						html += "<div id='"+emp.id+"' class='text-center'>"+emp.name.substr(0,emp.name.lastIndexOf("("))+"</div>";
						html += "</div>";
						console.log(html);
				});
				document.getElementById("approvalLine").innerHTML = html;
			}
			// 문서 작성
			document.querySelector("#saveBtn").addEventListener('click', () => {
				let formData = new FormData(document.forms[0]);
				let jsonData = {};
				formData.forEach((value, key) => {
					jsonData[key] = value;
				});
//	 			jsonData["approval_content"] = editor.getHTML();
				jsonData["approval_content"] = editor.getData();
// 				let d = initApprovalLine.map(item => ({approver_empno:item.id}));
			    
// 			    jsonData["approvalLineDtos"] = d; 
		
			    console.log(jsonData);
				fetch('./approvalUpdateForm.do',{
					method:'POST',
					headers:{
						'Content-Type':'application/json'
					},
					body:JSON.stringify(jsonData)
				})
				.then(resp => resp.json())
				.then(data => {
					if(data == true) {
						Swal.fire("작성성공").then(()=>{
							location.href="./approvalDetail.do?id=${approval.approval_id}"
						});
					} else{
						Swal.fire("작성실패");
					}
				})
				.catch(err => console.log(err))
			});
	</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<%@ include file="./layout/header.jsp"%>
<script
	src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<style type="text/css">


#fileForm{
   height: 100px;
   border: 1px solid #ccc;
}
.modal-content{
	width: 220mm;
/*     height: 307mm; */
}
#dateRange{
	display:none;
}
#formPickBtn , #linePickBtn, #organization, #documentForm{
	display:none;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editorStyle.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
</head>
<body>
	<%@ include file="./layout/newNav.jsp" %>
	<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h3 class="content_title">기안문작성</h3>
			<div class="content_nav">
				<button id="formBtn">문서양식</button>
				<button id="lineBtn">결재선</button>
				<button id="saveBtn">결재요청</button>
				<button id="tempBtn">임시저장</button>
				<button id="cancelBtn" onclick="javascirpt:history.back()">취소</button>
				<button id="getContent" data-bs-toggle="modal" data-bs-target="#myModal">컨텐츠만 얻기</button>
				<button type="button" class="btn" id="printBtn">Print</button>
			</div>
			<div class="row" id="contentHtml">
				<div id="approvalLine" class="mt-3"></div>
				<form class="mt-3">
					<table border="1" class="table">
						<tbody>
							<tr>
								<th>문서번호</th>
								<td>자동입력</td>
								<th>기안일자</th>
								<td>자동입력</td>
							</tr>
							
							<tr>
								<th>기안자</th>
								<td>
								${loginDto.name}
								</td>
								<th>부서</th>
								<td>${loginDto.deptno}</td>
							</tr>
							<tr>
								<th>참조자</th>
								<td><span>참조자선택버튼</span></td>
								<th>마감기한</th>
								<td>
									<input type="date" name="approval_deadline">
								</td>
							</tr>
							<tr>
								<th>긴급여부</th>
								<td>
									긴급 <input type="radio" name="urgency" value="Y">
									일반 <input type="radio" name="urgency" value="N" checked>
								</td>
								<th>서명/도장</th>
								<td>
									서명 <input type="radio" value="1" name="signature" checked>
									도장 <input type="radio" value="2" name="signature">
								</td>
							</tr>
							<tr id="dateRange">
								<th>시작날짜</th>
								<td>
									<input type="date" name="start_date">
								</td>
								<th>종료날짜</th>
								<td>
									<input type="date" name="end_date">
								</td>
							</tr>
							<tr>
								<th>문서제목</th>
								<td colspan="3">
									<input type="text" class="form-control" name="approval_title">
								</td>
							</tr>
							
						</tbody>
					</table>
					<input type="hidden" name="form_id">
					<div id="editor"></div>
					<div id="fileDiv">
						<input class="btn" type="file" multiple id="formFile">
						<div id="fileForm">
						파일업로드목록
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</main>
<div class="modal" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
    	
<!--       <div class="modal-header"> -->
<!--       	<button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button> -->
<!--       </div> -->
      <div class="modal-body">
      	<div id="documentForm">
      		<input type="text" id="searchInputDocumentTree" placeholder="검색">
	      	<div id="documentTree"></div>
	      	<h3>선택한 양식</h3>
	    	<div id="approvalForm"></div>
    	</div>
    	<div id="organization">
	    	<h2>조직도</h2>
			<input type="text" id="searchInputOrganizationTree" placeholder="검색">
			<div class="row">
			<div id="organizationTree" class="col-6"></div>
			<div id="saveLine" class="col-6"></div>
			<hr>
			<h5>결재순서</h5>
			<div id="approvalList"></div>
			</div>
		</div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-info" id="lineSaveBtn" onclick="saveApprovalLine()" data-bs-dismiss="modal">결재선 저장</button>
      	<button type="button" class="btn btn-success" id="formPickBtn" data-bs-dismiss="modal">선택</button>
      	<button type="button" class="btn btn-success" id="linePickBtn" data-bs-dismiss="modal">선택</button>
        <button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

	<script src="https://cdn.ckeditor.com/ckeditor5/44.2.1/ckeditor5.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/editor.js"></script>

	<script type="text/javascript">
	var approvalForm = [];
	
	$(".modalBtn").on('click',()=>{
		$("#linePickBtn").hide();
		$("#lineSaveBtn").hide();
	    $("#formPickBtn").hide();
	    $("#documentForm").hide();
		$("#organization").hide();
		$("#myModal").hide();
	})
	// -- 문서양식 트리 시작 ----------------------------
	$('#documentTree').jstree({
            'plugins': ["search"],
            "search": {
                "show_only_matches": true // 검색 결과만 표시
            },
            'core': {
                'data': function (node, cb) {
                    $.ajax({
                        url: "./formTree.json", // 데이터를 JSON 형태로 가져오는 API
                        type: "GET",
                        dataType: "json",
                        success: function (data) {
                            console.log(data);
                            cb(data);
                        }
                    });
                }
            }
        });
		
	 $('#documentTree').on("select_node.jstree", function (e, data) {
            let selectedNode = data.node;
            let formId = selectedNode.id;
            let formName = selectedNode.text;

            if (!formId.startsWith("CATE")) { // 카테고리가 아닌 경우만 추가
           	 addToApprovalForm(formId, formName);
            }
       });
	 $("#searchInputDocumentTree").keyup(function () {
	        let searchText = $(this).val();
	        $("#documentTree").jstree(true).search(searchText);
	    }); // search end
	 
	// 양식 가져오기 
	document.querySelector("#formBtn").addEventListener('click', () => {
		
// 		window.open('./formTreeView.do',"popupWindow","width=400,height=600,top=150,left=300");
		$("#documentForm").show();
		$("#formPickBtn").show();
		$("#myModal").show();
		
	});
	
	function addToApprovalForm(formId, formName) {
		console.log("aaaa")
        // 중복 방지
        if (approvalForm.some(form => form.id === formId)) {
        	Swal.fire("이미 추가된 문서입니다.");
            return;
        }

        // 최대 3개까지만 추가 가능
        if (approvalForm.length >= 1) {
            Swal.fire("1개의 양식만 선택 가능합니다.");
            return;
        }
		
        // 리스트에 추가
        approvalForm.push({ id: formId, name: formName });
        updateApprovalForm();
    }
	
	function updateApprovalForm() {
        $("#approvalForm").empty();
        let html = "";

        approvalForm.forEach((form, i) => {
            html += "<div>";
            html += "<span id='" + form.id + "'>" + (i + 1) + ". " + form.name + " (" + form.id + ")</span>";
            html += "<span class='remove-btn' onclick='removeFromApprovalForm(\"" + form.id + "\")'>✖</span>";
            html += "</div>";
        });

        $("#approvalForm").html(html);
    }
	
	// 선택한 문서 삭제
    function removeFromApprovalForm(formId) {
    	approvalForm = approvalForm.filter(form => form.id !== formId);
        updateApprovalForm();
    }
	
	$("#formPickBtn").on('click',()=>{
		console.log(approvalForm[0].id);
		fetch("./selectForm.json", {
			method:'post',
			headers:{
				'Content-Type':'text/plain'
			},
			body:approvalForm[0].id
		})
		.then(resp => resp.json())
		.then(data => {
			console.log(data);
			document.querySelector("input[name=form_id]").value = data.FORM_ID;
			if(data.FORM_ID.startsWith("BC")){
// 				document.querySelector("#dateRange").style.display = 'table-row';
				$("#dateRange").show()
			}
// 			editor.setHTML(data.FORM_CONTENT);
			editor.setData(data.FORM_CONTENT);
			$("#myModal").hide();
			$("#documentForm").hide();
			$("#formPickBtn").hide();
		})
		.catch(err => console.log(err));
	})
	
	// 문서양식 tree 끝 ---------------------------------------------------
	// 결재선 tree 시작 ---------------------------------------------------
	var approvalLine = [];

    $('#organizationTree').jstree({
    	'plugins' : ["search"],
    	"search":{
            "show_only_matches": true // 검색 결과만 표시
    	},
        'core': {
            'data': function (node, cb) {
                $.ajax({
                    url: "./tree.json",
                    type: "GET",
                    dataType: "json",
                    success: function (data) {
                    	console.log(data);
                        cb(data);
                    }
                });
            }
        }
    });
    
    $("#searchInputOrganizationTree").keyup(function () {
        let searchText = $(this).val();
        $("#organizationTree").jstree(true).search(searchText);
    }); // search end

    // 사원 선택 이벤트 (결재선 추가)
    $('#organizationTree').on("select_node.jstree", function (e, data) {
        let selectedNode = data.node;
        let empNo = selectedNode.id;
        let empName = selectedNode.text;
		
        if (!empNo.startsWith("D") && !empNo.startsWith("HQ")) { // 부서가 아닌 사원만 추가
            addToApprovalLine(empNo, empName);
        	return;
        }
    }); // organizationTree end
	
 // 결재선 추가 함수
    function addToApprovalLine(empNo, empName) {
        // 중복 방지
        if (approvalLine.some(emp => emp.id === empNo)) {
            alert("이미 추가된 사원입니다.");
            return;
        }
        // 3명 체크
        if(approvalLine.length == 3) {
        	alert("결재선은 3명까지 지정 가능합니다.");
        	return;
        }

        // 결재선 목록에 추가
        approvalLine.push({ id: empNo, name: empName});
        updateApprovalList();
    }

    // 결재선 리스트 업데이트
    function updateApprovalList() {
        $("#approvalList").empty();
		console.log(approvalLine);
		let html = "";
		approvalLine.forEach( (emp , i) => { 
				console.log(emp.name,emp.id);
				html += "<div>";
				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
				html += "<span class='remove-btn' onclick='removeFromApprovalLine(\""+emp.id+"\")'>✖</span>"
				html += "</div>";
				console.log(html);
		})
		$("#approvalList").html(html);
    }

    // 결재선에서 삭제
    function removeFromApprovalLine(empNo) {
        approvalLine = approvalLine.filter(emp => emp.id !== empNo);
        updateApprovalList();
    }

    // 결재선 저장 (JSON 변환)
    function saveApprovalLine() {
        if (approvalLine.length === 0) {
            alert("결재선을 선택하세요.");
            return;
        }
        Swal.fire({
			title: "이름을 입력하세요",
	        input: "text",
	        inputPlaceholder: "이름을 입력하세요",
	        showCancelButton: true,
	        confirmButtonText: "확인",
	        cancelButtonText: "취소",
	        inputValidator: (value) => {
	            if (!value) {
	                return "반려 사유를 입력해야 합니다!";
	            }
	        } 
		}).then(result => {
			console.log(result.value);
			if(typeof result.value == 'undefined'){
				return;
			}
			let d = approvalLine.map(item => ({approver_empno:item.id}));
	        let approvalJson = {};
	        approvalJson["line_name"] = result.value;
	        approvalJson["line_data"] = d;
	        console.log("결재선 저장:", approvalJson);
	        
			
	        fetch("./insertSaveLine.json",{
	        	method:"POST",
	        	headers:{
	        		'Content-Type':'application/json'
	        	},
	        	body:JSON.stringify(approvalJson)
	        })
	        .then(resp => resp.text())
	        .then(data => console.log(data))
	        .catch(err => console.log(err))
		})
    }
// 		var initApprovalLine;
		document.getElementById("lineBtn").addEventListener('click', () => {
// 			window.open('./tre.do',"popupWindow","width=400,height=600,top=150,left=300");
			fetch("./selectSaveLine.json")
			.then(resp => resp.json())
			.then(data => {
				$("#saveLine").text(data);
			})
			.catch(err => console.log(err))
			
			$("#linePickBtn").show();
			$("#organization").show();
			$("#myModal").show();
		});
		$("#linePickBtn").on('click',()=>{
			console.log("선택한 결재선", approvalLine);
			let html = "";
			html += "<div class='approval-item'>";
			html += "결<br>재";
			html += "</div>";
			approvalLine.forEach( (emp , i) => { 
					console.log(emp.name,emp.id);
					html += "<div class='approval-item'>";
//	 				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
					html += "<div id='"+emp.id+"' class='text-center'>"+emp.name.substr(0,emp.name.lastIndexOf("("))+"</div>";
					html += "</div>";
					console.log(html);
			});
			document.getElementById("approvalLine").innerHTML = html;
			$("#myModal").hide();
		})
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
//	 				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
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
// 			jsonData["approval_content"] = editor.getHTML();
			jsonData["approval_content"] = editor.getData();
			let d = approvalLine.map(item => ({approver_empno:item.id}));
		    
		    jsonData["approvalLineDtos"] = d; 
	
		    console.log(jsonData);
			fetch('./approvalDocumentSave.json',{
				method:'POST',
				headers:{
					'Content-Type':'application/json'
				},
				body:JSON.stringify(jsonData)
			})
			.then(resp => resp.json())
			.then(data => {
				if(data == true) {
					Swal.fire("작성성공");
				} else{
					Swal.fire("작성실패");
				}
			})
			.catch(err => console.log(err))
		});
		
		document.querySelector("#tempBtn").addEventListener('click', () => {
			let formData = new FormData(document.forms[0]);
			let jsonData = {};
			formData.forEach((value, key) => {
				jsonData[key] = value;
			});
// 			jsonData["approval_content"] = editor.getHTML();
			if(editor.getData() == '') {
				Swal.fire("문서양식을 선택해주세요");
				return;
			}
			jsonData["approval_content"] = editor.getData();
			
			if(typeof initApprovalLine != 'undefined'){
				let d = initApprovalLine.map(item => ({approver_empno:item.id}));
			    jsonData["approvalLineDtos"] = d; 
			}		
	
		    console.log(jsonData);
			fetch('./approvalDocumentSaveTemp.json',{
				method:'POST',
				headers:{
					'Content-Type':'application/json'
				},
				body:JSON.stringify(jsonData)
			})
			.then(resp => resp.json())
			.then(data => {
				if(data == true) {
					Swal.fire("작성성공");
				} else{
					Swal.fire("작성실패");
				}
			})
			.catch(err => console.log(err))
		})
	
		document.querySelector("#getContent").addEventListener('click',() => {
// 			let forms = document.querySelectorAll("input")
			document.querySelector(".ck-editor").style.display = 'none'
			document.querySelector("#fileDiv").style.display = 'none'
			let contentDiv = document.querySelector("#editor")
			contentDiv.style.display = 'block';
			contentDiv.innerHTML = editor.getData();
			let content = document.querySelector("#contentHtml");
			document.querySelector(".modal-body").innerHTML = content.innerHTML;
// 			let preview = window.open("","previewWindow","width=794,height=1123");
			
		});
		
		document.getElementById('myModal').addEventListener('hidden.bs.modal', function () {
		    console.log("모달이 닫혔습니다.");
		    document.querySelector(".ck-editor").style.display = 'block';
		    document.querySelector("#fileDiv").style.display = 'block';
		    document.querySelector("#editor").style.display = 'none';
		});
		document.querySelector("#printBtn").addEventListener("click",() => {
			printModalBody();
		})	
		function printModalBody() {
// 		    var printContents = document.querySelector(".modal-body").innerHTML;
// 		    var originalContents = document.body.innerHTML;

// 		    document.body.innerHTML = printContents; // 모달 내용만 body에 설정
		    window.print(); // 프린트 실행
// 		    document.body.innerHTML = originalContents; // 원래 내용 복원
		}
	</script>
</body>
</html>

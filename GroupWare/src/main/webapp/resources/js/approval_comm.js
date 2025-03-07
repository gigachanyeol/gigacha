
var approvalForm = [];

$(".modalBtn").on('click',()=>{
	$("#linePickBtn").hide();
	$("#lineSaveBtn").hide();
    $("#formPickBtn").hide();
    $("#documentForm").hide();
	$("#organization").hide();
	$(".ck-editor").show();
	$("#fileDiv").hide();
	$("#myModal").hide();
});

// -- 문서양식 트리 시작 ----------------------------

	
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
//		window.open('./formTreeView.do',"popupWindow","width=400,height=600,top=150,left=300");
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

async function selectForm(){
    try {
        const response = await fetch("./selectForm.json", {
            method:'post',
            headers:{
                'Content-Type':'text/plain'
            },
            body:approvalForm[0].id
        });
        if(!response.ok)  throw new Error('에러발생');
        return await response.json(); 
    } catch (error) {
     console.log(err);   
    }
}

async function selForm(){
    console.log(approvalForm[0].id);
    let data = await selectForm();
    
    document.querySelector("input[name=form_id]").value = data.FORM_ID;
		if(data.FORM_ID.startsWith("BC")){
//				document.querySelector("#dateRange").style.display = 'table-row';
			$("#dateRange").show();
		}
//			editor.setHTML(data.FORM_CONTENT);
		editor.setData(data.FORM_CONTENT);
		$("#myModal").hide();
		$("#documentForm").hide();
		$("#formPickBtn").hide();
}

$("#formPickBtn").on('click',()=>{
	selForm();
})

// 문서양식 tree 끝 ---------------------------------------------------
// 결재선 tree 시작 ---------------------------------------------------
var approvalLine = [];



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

	async function saveApprovalLine() {
	    if (approvalLine.length === 0) {
	        Swal.fire("결재선을 선택하세요.");
	        return;
	    }
	
	    try {
	        // 사용자 입력 받기
	        const { value: lineName } = await Swal.fire({
	            title: "이름을 입력하세요",
	            input: "text",
	            inputPlaceholder: "이름을 입력하세요",
	            showCancelButton: true,
	            confirmButtonText: "확인",
	            cancelButtonText: "취소",
	            inputValidator: (value) => !value ? "반려 사유를 입력해야 합니다!" : null
	        });
	
	        if (!lineName) return; // 입력이 없을 경우 종료
	
	        // 결재선 데이터 생성
	        const approvalJson = {
	            line_name: lineName,
	            line_data: approvalLine.map(item => ({ approver_empno: item.id }))
	        };
	
	        console.log("결재선 저장:", approvalJson);
	
	        // 서버에 저장 요청
	        const response = await fetch("./insertSaveLine.json", {
	            method: "POST",
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify(approvalJson)
	        });
	
	        const result = await response.text();
	        console.log(result);
	    } catch (error) {
	        console.error("결재선 저장 오류:", error);
	    }
	}

	document.getElementById("lineBtn").addEventListener('click', async () => {
		try {
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
				
			let data = await selectSaveLine();
			console.log("저장된 결재선 데이타 값 ",data);
			$("#saveLine").html(data);

			$("#linePickBtn").show();
			$("#organization").show();
			$("#myModal").show();
		} catch (e) {
			console.log("에러 발생");
		}
		
	
	});
	
	async function selectSaveLine(){
	    try {
	        let response = await fetch("./selectSaveLine.json");
	        if(!response.ok) throw new Error("에러발생");
	        return await response.json();
	    } catch (error) {
	        console.log(error);
	    }
	}
	
	$("#linePickBtn").on('click',()=>{
		console.log("선택한 결재선", approvalLine);
		let html = "";
		html += "<div class='approval-item'>";
		html += "결<br>재";
		html += "</div>";
		approvalLine.forEach( (emp , i) => { 
				console.log(emp.name,emp.id);
				html += "<div class='approval-item'>";
// 				html += "<span id='"+emp.id+"'>"+(i+1)+"."+emp.name+" ("+emp.id+")</span>";
				html += "<div id='"+emp.id+"' class='text-center'>"+emp.name.substr(0,emp.name.lastIndexOf("("))+"</div>";
				html += "</div>";
				console.log(html);
		});
		document.getElementById("approvalLine").innerHTML = html;
		$("#myModal").hide();
	})

	
    async function approvalDocumentSave(url ,jsonData) {
        try {
            let response = await fetch(url,{
                method:'POST',
                headers:{
                    'Content-Type':'application/json'
                },
                body:JSON.stringify(jsonData)
            });
            if(!response.ok) throw new Error ("저장실패");

            return await response.json();
        } catch (error) {
            
        }
    }
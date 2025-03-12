<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서관리</title>
<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

<style type="text/css">
* {
    box-sizing: border-box;
}
.card-body{
	flex: 1 1 auto;
    padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
    color: var(--bs-card-color);
}

.card-body pt-3{
	padding-top: 1rem ;
}

td {
    padding: 10px;
    border: 1px solid black;
}

.modal {
	display: none;
	top: 40%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 60%;
	height: 80%;
}

</style>

</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10">
			<h2 class="content_title">부서관리</h2>
		
      <div class="row">
        <div class="col-3">
          <div class="card">
            <div>
            	<div>
            		<h5 class="card-title">조직도</h5>
          			<button id="addDept">부서 추가</button>
            	</div>
            	<!-- 모달 -->
            	<div id="deptAddModal" class="modal">
            		<div class="modal-content">
            			<span class="close" onclick="closeModal()">&times;</span>
			            <h2>부서 추가</h2>
			            <div>
			            	<select id="deptType">
			            		<option>본부</option>
			            		<option>부서</option>
			            	</select>
			            		<div>
				            		<label for="deptName">부서 번호:</label>
					                <input type="text" id="deptName" name="deptName" required>
					            	<form id="departmentForm" onsubmit="submitForm(event)">
						                <label for="deptName">부서 이름:</label>
						                <input type="text" id="deptName" name="deptName" required>
						                <button type="button">중복검사</button>
					            	</form>
					            	<form id="departmentForm" onsubmit="submitForm(event)">
						                <label for="deptName">상위 부서:</label>
						                <input type="text" id="deptName" name="deptName" required>
						                <button type="button">선택하기</button>
					            	</form>
			            		</div>
			            </div>
			            <div>
			                <button type="submit">임시저장</button>
			                <button type="submit">등록</button>
			                <button type="button" class="close" onclick="closeModal()">닫기</button>
			            </div>
            		</div>
            	</div>
            	
				<input type="text" id="searchInput" placeholder="검색">
				<br>
				<div id="organizationTree"></div>
				<hr>
            </div>
          </div>
        </div>
        <div class="col-4">
          <div class="card">
            <div class="card-body pt-3">
              <div class="tab-content pt-2">
                <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
                  <h5 class="card-title">부서 정보</h5>
                  <div>
                  <!-- 
	                  <div>
						<h3>결재순서</h3>
						<div id="ll"></div>
						<button onclick="ok()">완료</button>
						<button onclick="saveApprovalLine()">결재선 저장</button>
					</div>
					 -->
                  	<table style="border: 1px solid black; max-width: 100%; width: 100%; text-align: center;"  >
                  		<tr>
                  			<td style="background-color: #E1E1E1">부서명</td>
                  			<td>부서명 test</td>
                  		</tr>
                  		<tr>
                  			<td style="background-color: #E1E1E1">부서코드</td>
                  			<td>부서코드 test</td>
                  		</tr>
                  		<tr>
                  			<td style="background-color: #E1E1E1">생성일</td>
                  			<td>생성일 test</td>
                  			<td style="background-color: #E1E1E1">최근 수정일</td>
                  			<td>수정일 test</td>
                  		</tr>
                  		<tr>
                  			<td style="background-color: #E1E1E1">최근 수정자</td>
                  			<td>수정자 test</td>
                 		</tr>
                  	</table>
                  </div>

                </div>
              </div>

            </div>
          </div>

        </div>
      </div>

        </div>
			
		</div>
</main>
	
</body>


<script>
     	var approvalLine = [];
        $(document).ready(function () {
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
            
            $("#searchInput").keyup(function () {
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
        });
        
     	// 결재선 추가 함수
        function addToApprovalLine(empNo, empName) {
            // 중복 방지
            if (approvalLine.some(emp => emp.id === empNo)) {
                alert("이미 추가된 사원입니다.");
                return;
            }
            // 1명 체크
            if(approvalLine.length == 10) {
            	alert("결재선은 10명까지 지정 가능합니다.");
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
			$("#ll").html(html);
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
            let approvalJson = JSON.stringify(approvalLine);
            console.log("결재선 저장:", approvalJson);
            alert("결재선이 저장되었습니다.");
           	
        }
        
        function ok() {
        	if (approvalLine.length === 0) {
                alert("결재선을 선택하세요.");
                return;
            }
        	console.log(approvalLine)
        	window.opener.line(approvalLine);
        	window.close();
        }
        
        function saveDept(){
        	deptType: document.getElementById("deptType").value,
            deptName: document.getElementById("deptName").value,
            parentDeptno: document.getElementById("parentDeptno").value
        }
        
       
    </script>
    
    <script type="text/javascript">
    // 모달 열기
    document.getElementById("addDept").onclick = function() {
        document.getElementById("deptAddModal").style.display = "block";
        console.log("모달");
    }
    
	 // 모달 닫기
    document.querySelectorAll(".close").forEach(function(button) {
        button.onclick = function() {
            document.getElementById("deptAddModal").style.display = "none";
        };
    });
    
    
    
    
    </script>



</html>

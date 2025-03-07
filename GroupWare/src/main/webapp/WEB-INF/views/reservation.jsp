<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>항상 보이는 Datepicker</title>
<%@ include file="./layout/header.jsp"%>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>


<style>
.btn-container { /* 추가: 부모 요소 클래스 */
	display: flex;
}

.btn_bg {
	align-items: center;
	justify-content: center;
	width: 100px;
	height: 40px;
	border-radius: 10px;
	text-align: center;
	cursor: pointer;
	box-sizing: border-box;
	margin: 10px 20px;
	line-height: 40px; /* 추가: 세로 가운데 정렬 */
}

.nocheck:hover {
	border: 1px solid red;
}

.nocheck {
	background-color: #E9F3FF;
	color: #2D8CFF;
}

.check {
	background-color: #2388FF;
	color: #E4FAFF;
}

/* 캘린더 스타일 조정 */
#datepicker {
	position: absolute;
	top: 60px;
}
</style>
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="container mt-5"></div>
		<!-- 항상 보이는 달력 -->
		<div id="content">

			<h3 class="content_title">예약하기</h3>
			<table>
				<thead>
					<tr>
						<th class="text-center">회의실명</th>
						<th class="text-center">예약상태</th>
						<td rowspan="5" style="position: relative;" width="270">
							<div style="position: relative;">
								<div id="datepicker"></div>
							</div>
						</td>
					</tr>
				</thead>
				<tbody>
					<%
					for (int j = 1; j <= 4; j++) {
					%>
					<tr>
						<td>회의실<%=j%>
						</td>
						<td class="text-center">
							<div class="btn-container">
								<div style="display: flex; flex-direction: column;">
									<span>08:00-10:00</span>
									<div class="btn_bg nocheck text-center" name="reserBtn"
										onclick="toggleCheck(this)">1</div>
								</div>
								<div style="display: flex; flex-direction: column;">
									<span>10:00-12:00</span>
									<div class="btn_bg nocheck text-center" name="reserBtn"
										onclick="toggleCheck(this)">2</div>
								</div>
								<div style="display: flex; flex-direction: column;">
									<span>13:00-15:00</span>
									<div class="btn_bg nocheck text-center" name="reserBtn"
										onclick="toggleCheck(this)">3</div>
								</div>
								<div style="display: flex; flex-direction: column;">
									<span>15:00-17:00</span>
									<div class="btn_bg nocheck text-center" name="reserBtn"
										onclick="toggleCheck(this)">4</div>
								</div>
							</div>

						</td>
						<!-- 						 <td> -->
						<!-- 						    <button type="button" name= "reserBtn" class="btn btn-warning">예약</button> -->
						<!-- 						</td> -->
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

		</div>
		<!-- 예약 모달 창 -->
		<!-- tabindex="-1": 키보드를 통해 모달을 닫을 수 없도록 -->
		<!-- Modal -->
		<div class="modal fade" id="reservationModal"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">회의실 예약</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="room_id">
						<div class="mb-3">
							<label for="reserver" class="form-label">예약자</label> <input
								type="text" class="form-control" id="reserver">
						</div>
						<div class="mb-3">
							<label for="capacity" class="form-label">예약인원수</label> <input
								type="number" class="form-control" id="capacity" min="1"
								max="15">
						</div>
						<div class="mb-3">
							<label for="member" class="form-label">참여자</label> <input
								type="number" class="form-control" id="member" min="1" max="15">
						</div>
						<div class="mb-3">
							<label for="purpose" class="form-label">회의 사유</label> <input
								type="text" class="form-control" id="purpose">
						</div>
						<div id="organization">
							<h2>조직도</h2>
							<input type="text" id="searchInput" placeholder="검색"> <br>
							<div id="organizationTree"></div>
							<hr>
							<h3>결재순서</h3>
							<div id="approvalList"></div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" id="reservationRoomForm"
							class="btn btn-primary">예약</button>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script>
	window.onload = function(){
    	var reservationModal;
    	
		$(document).ready(function() {
			$("#datepicker").datepicker({
				inline : true, // 항상 보이도록 설정
				dateFormat : "yy-mm-dd", // 날짜 형식 설정
				changeYear : true, // 연도 변경 가능
				changeMonth : true, // 월 변경 가능
				showOtherMonths : true, // 이전/다음 달 날짜도 표시
				selectOtherMonths : true, // 다른 달 날짜도 선택 가능
				onSelect : function(dateText) {
					alert("선택한 날짜: " + dateText);
				}
			});
		});

// 		function toggleCheck(element) {
// 			$(element).toggleClass("check nocheck");
// 		}
		
		//예약 버튼
		var reserBtn = document.getElementsByName("reserBtn");
    	console.log("예약버튼 갯수 :", reserBtn.length);
    	for(let i=0; i<reserBtn.length; i++){
    		reserBtn[i].onclick =function(){
//     			var parent = this.closest("tr");
//     			var room_id_p = parent.children[0].textContent;
//     			var room_name_p = parent.children[1].textContent;
//     			var capacity_p = parent.children[2].textContent;
//     			var created_at_p = parent.children[3].textContent;
//     			var updated_at_p = parent.children[4].textContent;
    			
    			var reserver = document.getElementById("reserver");
    			var capacity = document.getElementById("capacity");
    			var member = document.getElementById("member");
    			var purpose = document.getElementById("purpose");       			
    			
    			
//     			console.log("현재정보 : " , room_id_p , room_name_p, capacity_p, created_at_p, updated_at_p);
    			
//     			room_id.value = room_id_p;
//     			room_name.value = room_name_p;
//     			capacity.value = capacity_p;
    			
    			reservationModal = new bootstrap.Modal(document.getElementById("reservationModal"));
    			reservationModal.show();
    		}
    	}
	
		
		//예약 모달
		document.getElementById("reservationRoomForm").onclick = function(event) {
        	event.preventDefault();  // 폼 제출 이벤트 방지
        	
//         	console.log(event.target) //  modal button 

        	var reserver = document.getElementById("reserver").value;
        	var capacity = document.getElementById("capacity").value;
    		var member = document.getElementById("member").value;
    		var purpose = document.getElementById("purpose").value;

    		console.log("전송될 값 :", reserver,capacity, member, purpose);
    		
    		var reservationDto = {
    			reserver: reserver,
    			capacity: capacity,
    			member: member,
    			purpose : purpose
            };
    		
    		fetch("./insertroom.do", {
			    method: "POST",
			    headers: {
			        "Content-Type": "application/json"
			    },
			    body: JSON.stringify(reservationDto)
			})
			.then(response => {
			    if (!response.ok) {
			        throw new Error("서버 응답 오류: " + response.status);
			    }
			    return response.json(); // JSON 형식의 응답을 파싱
			})
			.then(data => {
// 			    console.log(data);

			    reservationModal.hide();
			    location.reload();  // 페이지 새로고침 또는 수정된 데이터 표시
			})
			.catch(error => {
			    console.error("예약 오류:", error);
			});

    	}

    }
	
	
	
	
	var approvalLine = [];

    $('#organizationTree').jstree({
    	'plugins' : ["search"],
    	"search":{
            "show_only_matches": true // 검색 결과만 표시
    	},
        'core': {
            'data': function (node, cb) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/approval/tree.json",
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

	</script>


</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 리스트</title>
<%@ include file="./layout/header.jsp"%>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
.switch {
	width: 50px;
	height: 25px;
	background-color: #ccc;
	border-radius: 25px;
	position: relative;
	cursor: pointer;
	transition: background-color 0.3s;
}

.switch .slider {
	width: 20px;
	height: 20px;
	background-color: white;
	border-radius: 50%;
	position: absolute;
	top: 50%;
	left: 3px;
	transform: translateY(-50%);
	transition: left 0.3s;
}

.switch.on {
	background-color: #4caf50;
}

.switch.on .slider {
	left: 27px;
}
</style>
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="row">
			<div id="content" class="mt-3">
				<h3 class="content_title">회의실 리스트</h3>
				<div class="card">
					<div class="card-body">
						<table class="table">
							<caption>
								<button type="button" class="btn btn-success"
									onclick="location.href='./roomform.do'">회의실 등록</button>
							</caption>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">회의실 이름</th>
									<th scope="col">수용인원</th>
									<th scope="col">등록일</th>
									<th scope="col">수정일</th>
									<th scope="col">사용여부</th>
									<th scope="col">수정</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${roomList}" var="room">
									<tr>
										<td scope="col">${room.room_id}</td>
										<td scope="col">${room.room_name}</td>
										<td scope="col">${room.capacity}</td>
										<td scope="col">${room.created_at}</td>
										<td scope="col">${room.updated_at}</td>
										<td scope="col">
											<div class="${room.use_yn eq 'Y' ? 'switch on':'switch'}">
												<div class="slider"></div>
											</div>
										</td>
										<td>
											<button type="button" name="modifyBtn"
												class="btn btn-warning">수정</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>
		<!-- 수정 모달 창 -->
		<!-- tabindex="-1": 키보드를 통해 모달을 닫을 수 없도록 -->
		<!-- Modal -->
		<div class="modal fade" id="updateModal" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">회의실 정보
							수정</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="room_id">
						<div class="mb-3">
							<label for="room_name" class="form-label">회의실 이름</label> <input
								type="text" class="form-control" id="room_name">
						</div>
						<div class="mb-3">
							<label for="capacity" class="form-label">수용인원</label> <input
								type="number" class="form-control" id="capacity" min="1"
								max="15">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" id="updateRoomForm" class="btn btn-primary">수정</button>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script>
             
        window.onload = function(){
        	var updateModal;

        	var switchBtn =  document.querySelectorAll(".switch")
        	console.log("스위치 버튼 갯수 : ", switchBtn.length)
        	for(let i=0; i < switchBtn.length; i++ ){
        		switchBtn[i].onclick=function(){
        			console.log(this.className)
        			this.classList.toggle("on");
        			
        			if (this.classList.contains("on")) {
					    console.log("스위치가 켜져 있습니다.");
					    //AJAX 작업으로 update use_yn 을 Y
					    $.ajax({
					        url: './update.do',
					        method: 'POST',
					        contentType: 'application/json',
					        data: JSON.stringify({
					            room_id: 'ROOM025', // 실제 회의실 ID
					            use_yn: 'Y'
					        }),
					        success: function(response) {
					        	console.log(response);
					            if(response) {
					                console.log("사용 상태 업데이트 성공");
					            } else {
					                console.error("업데이트 실패");
					            }
					        },
					        error: function(error) {
					            console.error('Error:', error);
					            //실패 시 원래 상태로 되돌리기
// 					            this.classList.toggle("on");
					        }
					    });
					} else {
					    console.log("스위치가 꺼져 있습니다.");
					  //AJAX 작업으로 update use_yn 을 N
					    $.ajax({
					        url: './update.do',
					        method: 'POST',
					        contentType: 'application/json',
					        data: JSON.stringify({
					        	room_id: 'ROOM025', // 실제 회의실 ID
					        	use_yn: 'N'
					        }),
					        success: function(response) {
					            if(response) {
					                console.log("사용 상태 업데이트 성공");
					            } else {
					                console.error("업데이트 실패");
					            }
					        },
					        error: function(error) {
					            console.error('Error:', error);
					        }
					    });
					}
        		};
        	} // switch 버튼 이벤트
        	
        	var modifyBtn = document.getElementsByName("modifyBtn");
        	console.log("수정버튼 갯수 :", modifyBtn.length);
        	for(let i=0; i<modifyBtn.length; i++){
        		modifyBtn[i].onclick =function(){
        			var parent = this.closest("tr");
        			var room_id_p = parent.children[0].textContent;
        			var room_name_p = parent.children[1].textContent;
        			var capacity_p = parent.children[2].textContent;
        			var created_at_p = parent.children[3].textContent;
        			var updated_at_p = parent.children[4].textContent;
        			
        			var room_id =  document.getElementById("room_id");
        			var room_name =  document.getElementById("room_name");
        			var capacity=  document.getElementById("capacity");
        			var created_at=  document.getElementById("created_at");       			
        			
        			
        			console.log("현재정보 : " , room_id_p , room_name_p, capacity_p, created_at_p, updated_at_p);
        			
        			room_id.value = room_id_p;
        			room_name.value = room_name_p;
        			capacity.value = capacity_p;
        			
        			updateModal = new bootstrap.Modal(document.getElementById("updateModal"));
        	        updateModal.show();
        		}
        	}
        	
        	
        	document.getElementById("updateRoomForm").onclick = function(event) {
        	    event.preventDefault();  // 폼 제출 이벤트 방지
        	    console.log(event.target) //  modal button 
        	    var room_id = document.getElementById("room_id").value;
        	    var room_name = document.getElementById("room_name").value;
    			var capacity = document.getElementById("capacity").value;

    			console.log("전송될 값 :", room_id,room_name, capacity);
    			
    			var roomDto = {
    					room_id: room_id,
    					room_name: room_name,
    					capacity: capacity
            	    };

    			fetch("./update.do", {
    			    method: "POST",
    			    headers: {
    			        "Content-Type": "application/json"
    			    },
    			    body: JSON.stringify(roomDto)
    			})
    			.then(response => {
    			    if (!response.ok) {
    			        throw new Error("서버 응답 오류: " + response.status);
    			    }
    			    return response.json(); // JSON 형식의 응답을 파싱
    			})
    			.then(data => {
    			    console.log(data);

					updateModal.hide();
    			    location.reload();  // 페이지 새로고침 또는 수정된 데이터 표시
    			})
    			.catch(error => {
    			    console.error("Error updating room data:", error);
    			});

        	}

        }
    </script>
</body>
</html>
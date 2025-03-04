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
<style type="text/css">
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}
</style>
</head>
<body>
	<%@ include file="./layout/nav.jsp"%>
	<%@ include file="./layout/sidebar.jsp"%>
	<div id="content">
		<h3 class="content_title">회의실 리스트</h3>
		<div class="card">
			<div class="card-body">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">●</th>
							<th scope="col">번호</th>
							<th scope="col">회의실 이름</th>
							<th scope="col">수용인원</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${roomList}" var="room">
							<tr>
								 <td><input type="checkbox" name="selectedRooms" value="${room.room_id}"></td>
								<td scope="col">${room.room_id}</td>
								<td scope="col">${room.room_name}</td>
								<td scope="col">${room.capacity}</td>
								<td scope="col">${room.created_at}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<button type="button" class="btn btn-success"
			onclick="location.href='./roomform.do'">회의실 등록</button>
		<button type="button" class="btn btn-warning"
			onclick="openUpdateModal('${room.room_id}', '${room.room_name}', ${room.room_capacity})">회의실 수정</button>
		<button type="button" class="btn btn-info"
			onclick="deleteRooms('${room.room_id}')">회의실 삭제</button>
	</div>
	
	<!-- 수정 모달 창 -->
	<!-- tabindex="-1": 키보드를 통해 모달을 닫을 수 없도록 -->
	<div class="modal" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dalog"> 모달의 대화 상자 역할
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">회의실 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="updateRoomForm" method="POST">
						<div class="mb-3">
							<label for="roomName" class="form-label">회의실 이름</label>
							<input type="text" class="form-control" id="roomName" name="roomName" required="true"/>
						</div>				
						<div class="mb-3">	
							<label for="roomCapacity" class="form-label">회의실 수용인원</label>
							<input type="text" class="form-control" id="roomCapacity" name="roomCapacity" required="true"/>
						</div>
						<input type="hidden" id="roomId" name="roomId"/>
						<button type="submit" class="btn btn-primary">수정</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
        function openUpdateModal(roomId, roomName, roomCapacity) {
        	 document.getElementById('roomId').value = roomId;
             document.getElementById('roomName').value = roomName;
             document.getElementById('roomCapacity').value = roomCapacity;
             
             //모달 띄우기
             $('#updateModal').modal('show');
         
             // 수정 버튼을 클릭했을 때 모달에서 서버로 수정된 데이터를 전송
             $('#updateRoomForm').submit(function(event) {
            	    event.preventDefault();  // 폼 제출 이벤트 방지

            	    var roomDto = {
            	        roomId: $('#roomId').val(),
            	        roomName: $('#roomName').val(),
            	        roomCapacity: $('#roomCapacity').val()
            	    };

            	    $.ajax({
            	        url: "/rooms/update", // Controller의 @PostMapping 경로
            	        method: "POST",
            	        data: JSON.stringify(roomDto), // RoomDto 객체를 JSON 형식으로 전송
            	        contentType: "application/json",  // JSON 형태로 요청 보냄
            	        success: function(response) {
            	            // 성공적으로 처리된 후, 모달을 닫고 페이지를 리로드하거나 갱신
            	            $('#updateModal').modal('hide');
            	            location.reload();  // 페이지 새로고침 또는 수정된 데이터 표시
            	        },
            	        error: function(error) {
            	            console.log("Error updating room data:", error);
            	        }
            	    });
            	});


        }
        
        //삭제
        function deleteRooms() {
            let selectedRooms = getSelectedRooms();
            if (selectedRooms.length === 0) {
                alert("삭제할 회의실을 선택해주세요.");
                return;
            }
            if (confirm("회의실을 삭제하시겠습니까?")) {
                fetch('/rooms/deleteRooms', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(selectedRooms)  // JSON 배열로 변환
                })
                .then(resp => resp.text())
                .then(data => {
                    alert(data);
                    selectedRooms.forEach(roomId => {
                        document.querySelector("#roomRow_" + roomId).remove();
                    });
                })
                .catch(err => console.error(err));
            }
        }
        
        function getSelectedRooms() { //삭제 할 회의실 리스트 가져옴
            let selectedRooms = [];
            let checkboxes = document.querySelectorAll("input[name=selectedRooms]:checked");
            checkboxes.forEach(checkbox => {
                selectedRooms.push(checkbox.value);
            });
            return selectedRooms;
        }
    </script>
</body>
</html>
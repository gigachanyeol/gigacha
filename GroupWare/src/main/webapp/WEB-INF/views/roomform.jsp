<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 등록 폼</title>
<%@ include file="./layout/header.jsp"%>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
.container {
	max-width: 960px;
	margin: 0 auto;
	border: 1px solid #ccc;
	background-color: white;
}

.header {
	background-color: #f0f4fa;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.main-content {
	flex-grow: 1;
	padding: 0 20px;
}

.info-box {
	display: flex;
	margin-bottom: 30px;
}

.info-left {
	width: 250px;
	background-color: #4a75cb;
	color: white;
	padding: 20px;
	text-align: center;
}

.info-left h3 {
	margin: 0 0 10px 0;
	font-size: 16px;
}

.info-right {
	flex-grow: 1;
	padding: 15px;
}

.form-group {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.form-label {
	width: 150px;
	text-align: center;
	padding-right: 15px;
	font-size: 14px;
}

.form-input input {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
}

.button-area {
	text-align: center;
	margin-top: 30px;
	margin-bottom: 20px;
}

.register-btn {
	background-color: #4a75cb;
	color: white;
	border: none;
	padding: 8px 20px;
	border-radius: 3px;
	cursor: pointer;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
}

.register-btn:hover {
	background-color: #3a65b8;
}

.btn-icon {
	margin-right: 5px;
	font-size: 16px;
}
</style>
</head>
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div id="content">
		<h3 class="content_title">회의실 등록</h3>
		<form id="roomform" action="/room/reservation.do" method="post">
		<div class="main-content">
			<div class="info-box">
				<div class="info-left">
					<h3>회의실 사진</h3>
				</div>

				<div class="info-right">
					<div class="form-group">
						<div class="form-label">회의실 이름:</div>
						<div class="form-input">
							<input type="text" name="room_name">
						</div>
					</div>

					<div class="form-group">
						<div class="form-label">회의실 수용인원:</div>
						<div class="form-input">
							<input type="text" name="capacity">
						</div>
					</div>
				</div>
			</div>
			<!-- 등록버튼 -->
			<div class="button-area">
				<button class="btn btn-primary" type="submit">등록하기</button>
			</div>
		</div>
			</form>
	</div>
	</main>
	<script type="text/javascript">
	 function registerRoom() {
         let formData = new FormData(document.forms[0]);
         formData.append("description", CKEDITOR.instances.description.getData()); // CKEditor 내용 추가

         fetch('/room/roomform.do', {
             method: 'POST',
             body: formData
         })
         .then(resp => resp.json())
         .then(data => {
             console.log(data);
             if (data.success) {
                 Swal.fire("등록 완료").then(() => {
                     // 등록된 회의실 정보를 테이블에 추가
                     let newRow = `
                         <tr>
                             <td>${data.room.roomName}</td>
                             <td><button class="btn_bg nocheck text-center">1</button></td>
                             <td><button class="btn_bg nocheck text-center">2</button></td>
                             <td><button class="btn_bg nocheck text-center">3</button></td>
                             <td><button class="btn_bg nocheck text-center">4</button></td>
                         </tr>
                     `;
                     $("#roomListTable tbody").append(newRow);

                     // 폼 초기화
                     $("#roomForm")[0].reset();
                     CKEDITOR.instances.description.setData('');
                 });
             } else {
                 Swal.fire("등록 실패: " + data.message);
             }
         })
         .catch(err => {
             console.error("등록 실패:", err);
             Swal.fire("등록 실패: " + err);
         });
     }
	</script>
</body>
</html>
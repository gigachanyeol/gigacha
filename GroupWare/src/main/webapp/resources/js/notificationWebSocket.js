var ws,url,nick, pageClosed;

window.onload = function () {
    url = location.href;
//    var wsUrl = "ws:"+url.substring(url.indexOf("//"),url.lastIndexOf("/")+1)+"ws/notification.do";
//    var wsUrl = "ws://localhost:9999/ws/notification.do";
//	var wsUrl = "ws://" + location.host + "/ws/notification.do";
	url = window.location.pathname; // 현재 페이지의 경로
	var contextPath = "/" + url.split("/")[1]; // 첫 번째 경로 추출
	var wsUrl = "ws://" + location.host + contextPath + "/ws/notification.do";
    console.log(wsUrl);

    ws = new WebSocket(wsUrl);
    console.log("생성 소켓 객체 ", ws);

    ws.onopen = function () {
        console.log("소켓 오픈");
        // ws.send("hello");
    }

	// TODO 00206 Socket - 서버에서 웹소켓 Handler가 메세지 전송하면 받아서 이벤트 창 js
    ws.onmessage = event => {
        var msg = event.data;
        
        try {
        	var parseData = JSON.parse(event.data); // JSON 파싱
 			console.log("이벤트 수신 데이터:", parseData);
        if (parseData.type === "notification") {
            // 📌 알림 메시지 처리
            var toastContainer = document.getElementById("toast-container");
            var toastId = "toast-" + new Date().getTime(); // 고유 ID 생성
            var toastHTML = `
                <div id="${toastId}" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
                    <div class="toast-header">
                        <strong class="me-auto">알림</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">${parseData.message}</div>
                </div>`;

            // Toast 컨테이너에 추가
            toastContainer.innerHTML += toastHTML;

            // Bootstrap Toast 초기화 및 표시
            var newToastEl = document.getElementById(toastId);
            var newToast = new bootstrap.Toast(newToastEl, { autohide: false });
            newToast.show();

        } else if (parseData.type === "userList") {
            // 📌 접속자 목록 업데이트
            console.log("현재 접속 중인 사용자:", parseData.users);

            var userListContainer = document.getElementById("connectedUsers");
            if (userListContainer) {
				userListContainer.innerHTML ='';
                var userListHTML = "<ul>";
                parseData.users.forEach(user => {
                    userListHTML += `<li>${user.empno} - ${user.name} (${user.job_title})</li>`;
                });
                userListHTML += "</ul>";

                userListContainer.innerHTML = userListHTML;
            }
        } 
	        
       } catch (error) {
        console.error("JSON 파싱 오류:", error);
    }
  }

    ws.onclose = () =>{
        console.log("연결종료");
    }


}
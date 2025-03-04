<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<div class="sidebar" id="mySidebar">
		<div class="card mb-3 mt-3">
			<img class="card-img-top"
				src="https://yt3.googleusercontent.com/xydasbAktJl4OMRQGV2mEy1Rvf5Y9miqlmVsdIR0Y14rm3fHCOstsYmMlD8MLm7PletRrJr_FiI=s160-c-k-c0x00ffffff-no-rj"
				alt="Card image cap">
			<div class="card-body">
				<!-- <h5 class="card-title">이름 | 사번</h5> -->
				<p class="card-text text-center">이름 | 사번</p>
				<p class="card-text text-center">부서 | 직급</p>
			</div>
		</div>
		<hr>
		<div class="dropdown">
			<button type="button" class="btn dropdown-toggle"
				data-bs-toggle="dropdown">문서관리</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#">Link 1</a></li>
				<li><a class="dropdown-item" href="#">Link 2</a></li>
				<li><a class="dropdown-item" href="#">Link 3</a></li>
			</ul>
		</div>
		<div class="dropdown">
			<button type="button" class="btn dropdown-toggle"
				data-bs-toggle="dropdown">문서관리</button>
			<ul class="dropdown-menu">
				<li class="dropdown-item">Cras justo odio</li>
				<li class="dropdown-item">Dapibus ac facilisis in</li>
				<li class="dropdown-item">Morbi leo risus</li>
				<li class="dropdown-item">Porta ac consectetur ac</li>
				<li class="dropdown-item">Vestibulum at eros</li>
				<li><a class="dropdown-item" href="#">Link 1</a></li>
				<li><a class="dropdown-item" href="#">Link 2</a></li>
				<li><a class="dropdown-item" href="#">Link 3</a></li>
			</ul>
		</div>
		<div class="dropdown">
			<button type="button" class="btn dropdown-toggle"
				data-bs-toggle="dropdown">예약관리</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#">회의실 등록(관리자)</a></li>
				<li><a class="dropdown-item" href="#">회의실 정보 수정 및 삭제(관리자)</a></li>
				<li><a class="dropdown-item" href="#">회의실 예약 내역 조회(관리자)</a></li>
			</ul>
		</div>
	</div>
	<script>
            var isc = true;
            function sidebar() {
                let sidebar = document.getElementById("mySidebar");
                let side = window.getComputedStyle(sidebar).display;  // 최종 적용된 display 값 확인
                
                

                console.log("현재 display 값:", side);
                let sideImg = document.querySelector(".teal>button>img");
                let sideOpenBtn = document.querySelector(".teal>button");
                console.log(sideImg.src);
                if (!isc) {
                    // sidebar.style.display = "block"; // 사이드바 열기
                    sideImg.src = "https://cdn3.iconfinder.com/data/icons/arrow-outline-8/32/left-24.png";
                    // sideOpenBtn.style="text-align:right";
                    sidebar.style.left="10px";
                    sideImg.style.left="163px";
                    isc = true;
                    console.log(isc);
                } else {
                    // sidebar.style.display = "none"; // 사이드바 닫기
                    sideImg.src = "https://cdn3.iconfinder.com/data/icons/arrow-outline-8/32/right-24.png"
                    // sideOpenBtn.style="";
                    sidebar.style.left="-250px";
                    sideImg.style.left="0px";
                    isc = false;
                    console.log(isc);
                }

                console.log("변경 후 display 값:", sidebar.style.display);
            }
            
            

        </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
  
</head>

<body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="teal">
                <button class="" onclick="sidebar()">
                    <img src="https://cdn3.iconfinder.com/data/icons/arrow-outline-8/32/left-24.png" alt="">
                </button>
            </div>
            <!-- <a class="navbar-brand" href="#">HOME</a> -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                 	<li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="./">홈</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">인사관리</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">근태관리</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./calendar.do">캘린더</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            전자결재
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">기안 작성</a></li>
                            <li><a class="dropdown-item" href="#">결재목록</a></li>
                            <li><a class="dropdown-item" href="#">나의 결재함</a></li>
                            <li><a class="dropdown-item" href="#">문서양식관리(관리자)</a></li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">예약</a>
                    </li>
                </ul>
            </div>
        </nav>
       
</body>

</html>
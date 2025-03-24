<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사 관리</title>

<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/>

</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
			<h2 class="content_title">부서관리</h2>
		
      <div class="row">
        <div class="col-4">
          <div class="card">
            <div>
            	<div>
            		<h5 class="card-title">조직도</h5>
            	</div>
				<input type="text" id="searchInput" placeholder="검색">
				<br>
				<div id="organizationTree"></div>
				<hr>
            </div>
          </div>
        </div>
        <div class="col-8">
          <div class="card">
            <div class="card-body pt-3">
              <div class="tab-content pt-2">
                  <h5 class="card-title">사원 정보</h5>
              </div>
              <div class="hero-calout">
            <div id="wrapper" class="list">
                <table id="employList" class="display nowrap dataTable dtr-inline collapsed" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>사원번호</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>내선번호</th>
                            <th>이메일</th> 
                            <th>입사일</th> 
                        </tr>
                    </thead>
                </table>
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
$(document).ready(function() {
    $('#employList').DataTable({
//         ajax: {
//             url: 'https://jsonplaceholder.typicode.com/users',
//             dataSrc: '' // 배열 형태 -> 객체형식으로 바꿔야함!
//         },
//         columns: [
//             { data: 'id' },
//             { data: 'name' },
//             { data: 'username' },
//             { data: 'email' },
//             { data: 'address.city' },
//             { data: 'phone' },
//             { data: 'website' },
//             { data: 'company.name' }
//         ],

		
        // 행 선택
        lengthMenu: [5, 10, 15],
        search: {
            return: true
        }
    });
});


</script>

</html>

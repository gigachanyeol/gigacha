<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 근태 현황</title>

<%@ include file="./layout/header.jsp"%>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<!-- <script type="text/javascript" -->
<!-- 	src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" -->
<!-- 	href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css" /> -->
<style type="text/css">
.modal-content {
	width: 220mm;
	/*     height: 307mm; */
}
</style>
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="row">
			<div id="content" class="col 10">
				<h3 class="content_title">내 문서함</h3>
				<div class="card">
					<div>
						<!-- 모달 -->
						<div class="modal fade" id="reservationModal"
							data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
							aria-labelledby="staticBackdropLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5" id="staticBackdropLabel">회의실
											예약</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div id="organization">
											<h2>조직도</h2>
											<input type="text" id="searchInput" placeholder="검색">
											<br>
											<div id="organizationTree"></div>
											<div id="approvalList"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 모달 END -->
						<hr>
					</div>
				</div>


				<table id="example"
					class="display nowrap dataTable dtr-inline collapsed"
					style="width: 100%;">
					<thead>
						<tr>
							<th>ID</th>
							<th>NAME</th>
							<th>USERNAME</th>
							<th>EMAIL</th>
							<th>CITY</th>
							<th>PHONE</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>

	</main>
</body>
<script src="https://unpkg.com/jspdf@latest/dist/jspdf.umd.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jspdf-html2canvas@latest/dist/jspdf-html2canvas.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/approval_comm.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('#example').DataTable({
    	// 샘플 데이터
        ajax: {
            url: 'https://jsonplaceholder.typicode.com/users',
            dataSrc: '' // 배열 형태 -> 객체형식으로 바꿔야함!
        },
        columns: [
            { data: 'id' },
            { data: 'name' },
            { data: 'username' },
            { data: 'email' },
            { data: 'address.city' },
            { data: 'phone' },
            { data: 'website' },
            { data: 'company.name' }
        ],
        // 행 선택
        lengthMenu: [1, 2, 3],
        search: {
            return: true
        }
    });
    
    
    

	// 조직도 jstress 조회 출력
    $('#organizationTree').jstree({
    	'plugins' : ["search"],
    	"search":{
            "show_only_matches": true // 검색 결과만 표시
    	},
        'core': {
            'data': function (node, cb) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/approval/treeAjax.do",
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

});
</script>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의결재함</title>

<%@ include file="./layout/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css" />
<style type="text/css">
.modal-content{
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
			<div id="content" class="col-lg-10">
				<h3 class="content_title">내 문서함</h3>

				<div>
					<label><input type="checkbox" class="filter-status"
						value="임시저장" checked> 임시저장</label> <label><input
						type="checkbox" class="filter-status" value="결재대기" checked>
						결재대기</label> <label><input type="checkbox" class="filter-status"
						value="진행중" checked> 진행중</label> <label><input
						type="checkbox" class="filter-status" value="결재완료" checked>
						결재완료</label> <label><input type="checkbox" class="filter-status"
						value="결재반려" checked> 결재반려</label>
				</div>

				<table id="documentsTable"
					class="display nowrap dataTable dtr-inline collapsed"
					style="width: 100%;">
					<thead>
						<tr>
							<th>문서번호</th>
							<th>양식명</th>
							<th>사원번호</th>
							<th>제목</th>
							<th>카테고리</th>
							<th>상태</th>
							<th>작성일</th>
							<th>마감기한</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		
	</main>
	<!-- 모달 -->
	<div class="modal" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false">
	  <div class="modal-dialog modal-dialog-scrollabl">
	    <div class="modal-content">
	    	
	      <div class="modal-header">
	      	<button type="button" class="btn-close modalBtn" data-bs-dismiss="modal"></button>
	      </div>
	      <div class="modal-body">
	      	
	      </div>
	
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
    let table = $('#documentsTable').DataTable({
        ajax: {
            url: './myApprovalData.json',
            type: 'POST',
            dataType: 'json',
            dataSrc: function(json) {
                console.log("서버 응답 데이터:", json);
                return json.data || [];
            }
        },
        columns: [
            { data: 'APPROVAL_ID' },
            { data: 'FORM_ID' },
            { data: 'EMPNO' },
            { data: 'APPROVAL_TITLE' },
            { data: 'CATEGORY_NAME' },
            { data: 'APPROVAL_STATUS' },
            { data: 'CREATE_DATE' },
            { data: 'APPROVAL_DEADLINE' }
        ],
        lengthMenu: [10, 20, 30],
        search: {
            return: true
        },
        rowCallback: function(row, data) {
            $(row).find('td:first').on('click', function() {
//                 window.location.href = './approvalDetail.do?id='+data.approval_id;
				console.log(data.approval_id);
				fetch("./approvalDetail.json?id="+data.APPROVAL_ID)
				.then(resp => resp.json())
				.then(data => {
					console.log(data);
					$(".modal-body").html(data.approval_content);
					$("#myModal").show();
				})
				.catch(err => console.log(err));
            }).css('cursor', 'pointer'); // 클릭 가능하게 포인터 변경
        }
    });
	$(".modalBtn").on('click', function(){
		$("#myModal").hide();
	})
	
    $('.filter-status').on('change', function() {
        let selectedStatuses = [];
        $('.filter-status:checked').each(function() {
            selectedStatuses.push($(this).val());
        });
        table.column(5).search(selectedStatuses.join('|'), true, false).draw();
    });
});
</script>
</html>

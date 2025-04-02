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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
<style type="text/css">
.card {
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border: none;
}

/* 검색 입력 스타일 */
#searchInput {
    width: 100%;
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ccc;
    margin-bottom: 10px;
}

/* JSTree 스타일 */
#organizationTree {
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 5px;
    background-color: #f8f9fa;
}

/* 사원 정보 테이블 스타일 */
#employeeList {
    width: 100% !important;
    border-collapse: collapse;
    border-spacing: 0;
}

#employeeList th, #employeeList td {
    text-align: center;
    padding: 10px;
}


/* 메인 컨테이너 스타일 */
.main {
    padding: 20px;
    background-color: #f4f6f9;
    min-height: 100vh;
}

/* 타이틀 스타일 */
.content_title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

/* 탭 스타일 */
.tab-content {
    background: #fff;
    padding: 15px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

</style>


</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col">
		<div class="pagetitle">
			<h1 class="content_title">사원 조회</h1>
			<nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item">Management</li>
                    <li class="breadcrumb-item active">Employee Directory</li>
                </ol>
            </nav>
		</div>
      <div class="row">
        <div class="col-4">
          <div class="card">
			<div id="organization">
				<h5 class="card-title">조직도</h5>
				<input type="text" id="searchInput" placeholder="검색"> <br>
				<div id="organizationTree"></div>
				<div id="approvalList"></div>
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
                <table id="employeeList" class="display nowrap dataTable dtr-inline collapsed" style="width: 100%;">
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
// 사원리스트 dataTables
var approvalLine = [];
        $(document).ready(function () {
            $('#organizationTree').jstree({
            	'plugins' : ["search"],
            	"search":{
                    "show_only_matches": true // 검색 결과만 표시
            	},
                'core': {
                    'data': function (node, cb) {
                        $.ajax({
                            url: "./tree.do",
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


$(document).ready(function() {
    $('#employeeList').DataTable({
        ajax: {
            url: './employeeList.do',
            dataSrc: '' 
        },
        columns: [
            { data: 'empno' },
            { data: 'name' },
            { data: 'deptname' },
            { data: 'job_title' },
            { data: 'tel' },
            { data: 'email' },
            { data: 'hiredate' }
        ],
        // 행 선택
        lengthMenu: [5, 10, 20],
        search: {
            return: true
        }
    });
});


// 회원 상세 조회
// JSTree 노드 클릭 이벤트 추가
$('#organizationTree').on('select_node.jstree', function (e, data) {
    var node = data.node;
    var nodeId = node.id;
    
    // 노드 타입 확인 (사원인지 부서인지)
    // JSTree에서 반환하는 node 객체를 확인하여 타입이나 속성 파악
    if (node.original && node.original.type === 'employee' || /^\d+$/.test(nodeId)) {
        // 사원인 경우 - 개별 정보 표시
        $('#employeeList_wrapper').hide();
        
        // 사원 정보 조회 AJAX 요청
        $.ajax({
            url: './empGet.do',
            type: 'GET',
            data: { seq: nodeId },
            success: function(data) {
            	 // 사원 정보를 표시할 HTML 생성
                var html = '<div class="employee-info">' +
                    '<h5>사원 정보</h5>' +
                    '<table class="table">' +
                    '<tr><th>사번</th><td>' + (data.empno || '') + '</td></tr>' +
                    '<tr><th>사원명</th><td>' + (data.name || '') + '</td></tr>' +
                    '<tr><th>부서</th><td>' + (data.deptname || '') + '</td></tr>' +
                    '<tr><th>직급</th><td>' + (data.job_title || '') + '</td></tr>' +
                    '<tr><th>내선번호</th><td>' + (data.tel || '') + '</td></tr>' +
                    '<tr><th>이메일</th><td>' + (data.email || '') + '</td></tr>' +
                    '<tr><th>입사일</th><td>' + (data.hiredate || '') + '</td></tr>' +
                    '</table></div>';

                
                // 정보 표시
                $('.tab-content').html(html);
            },
            error: function(xhr, status, error) {
                console.error('사원 정보 조회 실패:', error);
            }
        });
    } else {
        // 부서인 경우 - 테이블 표시하고 해당 부서 사원만 필터링
        var table = $('#employeeList').DataTable();
        
        // 기존 탭 제목과 표 복원
        $('.tab-content').html(`
            <h5 class="card-title">사원 정보</h5>
            <div class="hero-calout">
                <div id="wrapper" class="list">
                    <table id="employeeList" class="display nowrap dataTable dtr-inline collapsed" style="width: 100%;">
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
        `);
        
        // DataTable 재초기화
        $('#employeeList').DataTable({
            ajax: {
                url: './employeeList.do',
                dataSrc: '',
                data: function(d) {
                    // 선택한 부서 ID를 파라미터로 추가
                    d.deptId = nodeId;
                    return d;
                }
            },
            columns: [
                { data: 'empno' },
                { data: 'name' },
                { data: 'deptname' },
                { data: 'job_title' },
                { data: 'tel' },
                { data: 'email' },
                { data: 'hiredate' }
            ],
            lengthMenu: [5, 10, 20],
            search: {
                return: true
            }
        });
    }
});

</script>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
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
		
      <div class="row">
        <div class="col">
          <div class="card">
            <div class="card-body pt-3">
              <div class="tab-content pt-2">
                  <h5 class="card-title">공지사항</h5>
              </div>
              <div class="hero-calout">
            <div id="wrapper" class="list">
                <table id="boardList" class="display nowrap dataTable dtr-inline collapsed" style="width: 100%;">
                     <thead>
                        <tr>
                            <th>번호</th>
                            <th>작성자</th>
                            <th>제목</th>
                            <th>작성일</th>
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
    $('#boardList').DataTable({
        ajax: {
            url: './boardList.do',
            dataSrc: ''
        },
        columns: [
            { 
                data: null,
                render: function (data, type, row, meta) {
                    return meta.row + 1; // 1부터 시작하는 순차 번호
                }
            },
            { data: 'name' },
            { data: 'title' },
            { 
                data: 'create_date',
                // 날짜 포맷팅 옵션 추가 가능
                render: function(data) {
                    return new Date(data).toLocaleDateString(); // 날짜 형식 지정
                }
            }
        ],
        order: [[3, 'desc']], // 작성일 열(인덱스 3)을 내림차순으로 정렬 (최근 날짜 먼저)
        lengthMenu: [5, 10, 20],
        search: {
            return: true
        }
    });
});
</script>


</html>

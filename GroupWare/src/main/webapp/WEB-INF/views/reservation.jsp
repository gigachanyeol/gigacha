<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>항상 보이는 Datepicker</title>
    <%@ include file="./layout/header.jsp"%>

    <!-- jQuery UI CSS -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery 및 jQuery UI -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <style>
    #content {
	margin-right: 30px;
	margin-left: 230px;
}

	.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}
        /* 캘린더 스타일 조정 */
     #datepicker {
         float: right; 
/*          position: absolute;  */
         top: 200px; 
         right:  200px; 
        }
    </style>
</head>
<body>
<%@ include file="./layout/nav.jsp" %>
<%@ include file="./layout/sidebar.jsp" %>
    <!-- 항상 보이는 달력 -->
     <div id="content">
        
        <h3 class="content_title">예약하기</h3>
		<table class="table table-hover">
		<thead>
				<tr>
					<th>라이브러리</th>
				</tr>
			</thead>
				
			<tbody>
				<tr>
					<td><div id="datepicker"></div></td>
				</tr>
			</tbody>
		</table>
</div>

    <script>
        $(document).ready(function() {
            $("#datepicker").datepicker({
                inline: true, // 항상 보이도록 설정
                dateFormat: "yy-mm-dd", // 날짜 형식 설정
                changeYear: true, // 연도 변경 가능
                changeMonth: true, // 월 변경 가능
                showOtherMonths: true, // 이전/다음 달 날짜도 표시
                selectOtherMonths: true, // 다른 달 날짜도 선택 가능
                onSelect: function(dateText) {
                    alert("선택한 날짜: " + dateText);
                }
            });
        });
    </script>

</body>
</html>

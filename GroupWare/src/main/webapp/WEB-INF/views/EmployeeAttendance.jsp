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
			<div id="content" class="col 10">
				<h3 class="content_title">내 문서함</h3>
				
				<div class="card">
            <div>
            	<div>
            		<h5 class="card-title">조직도</h5>
          			<button id="addDept" class="btn btn-sm btn-primary">부서 추가</button>
            	</div>
            	<!-- 모달 -->
            	<div id="deptAddModal" class="modal">
            		<div class="modal-content">
	            			<span class="close" onclick="closeModal()">×</span>
				            <h4>부서 추가</h4>
				            <div class="mb-3">
				            <label for="deptType" class="form-label">부서 유형</label>
				            	<select id="deptType" class="form-select">
					                <option value="HQ">본부</option>
					                <option value="D">부서</option>
				              	</select>
							   	<label for="deptname">부서 이름:</label>
							    <input type="text" id="deptname" name="deptname" required="" class="form-control"> 
							   	<button class="btn btn-secondary btn-sm mt-1" type="button" onclick="duplicate()">중복검사</button><br>
							   	<select name="parentDeptNo" disabled="">
	    							<option value="">본부 선택</option>
	    							
       									  <option value="HQ21">IT본부</option>
							    	
       									  <option value="HQ05">TEST</option>
							    	
       									  <option value="HQ41">asd</option>
							    	
       									  <option value="HQ01">경영 지원 본부</option>
							    	
       									  <option value="HQ81">구디09</option>
							    	
       									  <option value="HQ03">기술 개발 본부</option>
							    	
       									  <option value="HQ64">마케팅본부</option>
							    	
       									  <option value="HQ02">사업 기획 본부</option>
							    	
       									  <option value="HQ04">영업 본부</option>
							    	
								</select>
				            </div>
				            <div class="modal-footer">
				                <button type="button" id="submit" class="btn btn-primary" onclick="savedept()">등록</button>
				                <button type="button" class="btn btn-outline-danger close" onclick="closeModal()">닫기</button>
				            </div>
            		</div>
            	</div>
            	<!-- 모달 END -->
            	
				<input type="text" id="searchInput" placeholder="검색">
				<br>
				<div id="organizationTree" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="HQ03" aria-busy="false"><ul class="jstree-container-ul jstree-children" role="group"><li role="none" id="HQ01" class="jstree-node  jstree-closed"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" aria-expanded="false" id="HQ01_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>경영 지원 본부</a></li><li role="none" id="HQ02" class="jstree-node  jstree-closed"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" aria-expanded="false" id="HQ02_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>사업 기획 본부</a></li><li role="none" id="HQ03" class="jstree-node  jstree-closed"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor jstree-clicked" href="#" tabindex="-1" role="treeitem" aria-selected="true" aria-level="1" aria-expanded="false" id="HQ03_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>기술 개발 본부</a></li><li role="none" id="HQ04" class="jstree-node  jstree-closed"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" aria-expanded="false" id="HQ04_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>영업 본부</a></li><li role="none" id="HQ05" class="jstree-node  jstree-closed"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" aria-expanded="false" id="HQ05_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>TEST</a></li><li role="none" id="HQ21" class="jstree-node  jstree-closed"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" aria-expanded="false" id="HQ21_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>IT본부</a></li><li role="none" id="HQ41" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" id="HQ41_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>asd</a></li><li role="none" id="HQ64" class="jstree-node  jstree-closed"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" aria-expanded="false" id="HQ64_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>마케팅본부</a></li><li role="none" id="HQ81" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl" role="presentation"></i><a class="jstree-anchor" href="#" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" id="HQ81_anchor"><i class="jstree-icon jstree-themeicon" role="presentation"></i>구디09</a></li></ul></div>
				<hr>
            </div>
          </div>

				<div>
					<label><input type="checkbox" class="filter-status form-check-input"
						value="임시저장" checked> 임시저장</label> <label><input
						type="checkbox" class="filter-status form-check-input" value="결재대기" checked>
						결재대기</label> <label><input type="checkbox" class="filter-status form-check-input"
						value="진행중" checked> 진행중</label> <label><input
						type="checkbox" class="filter-status form-check-input" value="결재완료" checked>
						결재완료</label> <label><input type="checkbox" class="filter-status form-check-input"
						value="결재반려" checked> 결재반려</label>
				</div>

				<table id="example" class="display nowrap dataTable dtr-inline collapsed" style="width: 100%;">
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
<script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jspdf-html2canvas@latest/dist/jspdf-html2canvas.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/approval_comm.js"></script>
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
});
</script>
</html>

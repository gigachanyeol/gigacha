<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

</head>
<body>
	<h2>카테고리</h2>
	<input type="text" id="searchInput" placeholder="검색">
	<br>
	
	<select id="category_id">
		<c:forEach items="${categoryList}" var="cate" varStatus="status">
			<option value="${cate.category_id}" ${status.index eq 0 ? 'selected':''}>${cate.category_name}</option>
		</c:forEach>
	</select>
	<button id="ok" onclick="ok()">완료</button>
	<button onclick="window.close()">취소</button>
	
	<script type="text/javascript">
	window.onload = function() {
		document.getElementById("category_id").addEventListener("change", function() {
		    selectValue = this.value;
		    console.log("선택된 카테고리 ID: " + selectedValue);
		});
		document.querySelector("#ok").addEventListener("click", ()=>{
			let category_id = document.querySelector("#category_id")[document.querySelector("#category_id").selectedIndex].value;
			let category_name = document.querySelector("#category_id")[document.querySelector("#category_id").selectedIndex].textContent;
	    	window.opener.categoryPick(category_id, category_name);
	    	window.close();	
		})
	}
	</script>
</body>
</html>
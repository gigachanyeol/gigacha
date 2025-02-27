<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서양식관리</title>

<%@ include file="./layout/header.jsp"%>
<style type="text/css">
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}
</style>
</head> 
<body>
<%@ include file="./layout/nav.jsp" %>
<%@ include file="./layout/sidebar.jsp" %>
	<div id="content">
		<h3 class="content_title">문서양식추가</h3>
		<button type="button" class="btn btn-primary" onclick="location.href='./approvalFormCreate.do'">문서양식등록</button>
		<div class="card">
            <div class="card-body">
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">양식아이디</th>
                    <th scope="col">카테고리이름</th>
                    <th scope="col">양식이름</th>
                    <th scope="col">생성일</th>
                  </tr>
                </thead>
                <tbody>
                 <c:forEach items="${formList}" var="frm">
	                 <tr>
	                    <td scope="col">#</td>
	                    <td scope="col">${frm.form_id}</td>
	                    <td scope="col">${frm.form_content}</td>
	                    <td scope="col"><a href="./approvalFormDetail/${frm.form_id}.do">${frm.form_name}</a></td>
	                    <td scope="col">${frm.create_date}</td>
	                  </tr>
                 </c:forEach>
                </tbody>
              </table>
              <!-- End Default Table Example -->
            </div>
          </div>
	</div>
</body>
</html>

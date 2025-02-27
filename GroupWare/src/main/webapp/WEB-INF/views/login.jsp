<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

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
	<div id="content">
		<h3 class="content_title">로그인페이지</h3>
		
		<table class="table table-hover">
			<thead>
				<tr>
					<th></th>
				</tr>
			</thead>

			<tbody>

				<div class="card-body">

					<div class="pt-4 pb-2">
						<h5 class="card-title text-center pb-0 fs-4">로그인</h5>
					</div>
					<form action="./login.do" method="post">
					<div class="col-12" style="align-items: center;">
						<label for="yourUsername" class="form-label">사원번호</label>
						<div class="input-group has-validation">
							<span class="input-group"></span> <input type="text"
								name="empno" class="form-control" id="yourUsername"
								required="required">
							<div class="invalid-feedback">사원번호를 입력해주세요.</div>
						</div>
					</div>

					<div class="col-12">
						<label for="yourPassword" class="form-label">비밀번호</label> <input
							type="password" name="password" class="form-control"
							id="yourPassword" required="">
						<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
					</div>

					<div class="col-12">
						<button class="btn btn-primary w-100" type="submit">Login</button>
					</div>
					</form>
					<div class="col-12" style="display: flex;justify-content: center; align-items: center;">
						<p class="small mb-0">
							<a href="pages-register.html">비밀번호 재설정</a>
						</p>
						<p class="small mb-0" style="margin-left: 10px;">
							<a href="pages-register.html">사원번호 찾기</a>
						</p>
					</div>

				</div>
			</tbody>
		</table>
	</div>



</body>
</html>

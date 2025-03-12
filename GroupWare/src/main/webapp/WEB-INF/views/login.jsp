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
	<main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">GIGACHA</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">GIGACHA</h5>
                  </div>

                  <form class="row g-3 needs-validation" action="./login.do" method="POST" novalidate="">

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">사원번호</label>
                      <div class="input-group has-validation">
                        <input type="text" name="empno"  class="form-control" id="yourUsername" required="">
                        <div class="invalid-feedback">사원번호 입력해주세요</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">비밀번호</label>
                      <input type="password" name="password" class="form-control" id="yourPassword" required="">
                      <div class="invalid-feedback">비밀번호 입력해주세요</div>
                    </div>

                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Login</button>
                    </div>
						<div class="col-12" style="display: flex;justify-content: center; align-items: center;">
						<p class="small mb-0">
							<a href="pages-register.html">비밀번호 재설정</a>
						</p>
						<p class="small mb-0" style="margin-left: 10px;">
							<a href="pages-register.html">사원번호 찾기</a>
						</p>
					</div>
                  </form>

                </div>
              </div>
            </div>
          </div>
        </div>

      </section>

    </div>
  </main>
</body>
</html>

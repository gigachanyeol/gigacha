<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyAttendance</title>

<%@ include file="./layout/header.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/attendance.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/attendance.css">
</head>
<body>
	<%@ include file="./layout/newNav.jsp"%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>근태 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}">Home</a></li>
					<li class="breadcrumb-item">마이페이지</li>
					<li class="breadcrumb-item active">나의 근무현황</li>
				</ol>
			</nav>
		</div>
		"${loginDto}"
		<div class="row">
			<div id="content" class="col-10">
				<div class="work-status">
					<div class="card info-card customers-card">
						<div class="card-body">
							<div class="attendance-container">
								<div class="navigation">
									<div class="nav-link">
										<i class=" brightness-alt-high"></i> 01:43:23 PM 6/15(월)
									</div>
								</div>

								<div class="time-card">
									<div class="row">
										<div class="col-md-7">
											<div class="work-time">오늘 근무한 시간</div>
											<div class="time-display">00:00:00</div>
											<div class="action-buttons">
												<button class="btn-check-in">출근</button>
												<button class="btn-check-out">퇴근</button>
											</div>
											<div class="notice">버튼을 눌러 출근시간을 기록하세요.</div>
										</div>
										<div class="col-md-5">
											<div class="work-system">
												<div class="work-system-title">나의 근태 현황</div>
												<div class="mb-3">
													<div class="d-flex justify-content-between">
														<span>• 입사 년도:</span> 
														<span class="text-primary fw-bold" id="hiredate">"${loginDto.hiredate}"</span>
														<span class="badge rounded-pill bg-secondary" id="hiredateText"></span>
													</div>
												</div>
												<div class="mb-3">
													<div class="d-flex justify-content-between">
														<span>• 발생 연차:</span> <span class="text-primary fw-bold">12개</span>
													</div>
												</div>
												<div class="mb-3">
													<div class="d-flex justify-content-between">
														<span>• 사용 연차:</span> <span class="text-primary fw-bold">12개</span>
													</div>
												</div>

												<div>
													<div class="d-flex justify-content-between">
														<span>• 남은 연차:</span> <span class="text-primary fw-bold">2.5개</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>

				</div>


				<div class="work-status">
					<div class="card info-card customers-card">
						<div class="card-body">
							<h5 class="card-title">근태 기록</h5>
							<!-- Default Tabs -->
							<ul class="nav nav-tabs" id="myTab" role="tablist">
								<li class="nav-item" role="presentation">
									<button class="nav-link active" id="home-tab"
										data-bs-toggle="tab" data-bs-target="#home" type="button"
										role="tab" aria-controls="home" aria-selected="true">근태</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
										data-bs-target="#profile" type="button" role="tab"
										aria-controls="profile" aria-selected="false" tabindex="-1">연차</button>
								</li>
							</ul>
							<div class="tab-content pt-2" id="myTabContent">
								<div class="tab-pane fade active show" id="home" role="tabpanel" aria-labelledby="home-tab">
														<!-- 기간 선택 -->
							<div
								class="d-flex align-items-center mb-3 justify-content-between">
								<div class="d-flex align-items-center">
									<label class="me-2">기간</label> 
									<select class="form-select w-auto me-2" id="yearSelect">
<!-- 										<option>2024</option> -->
<!-- 										<option>2025</option> -->
									</select> 
									<select class="form-select w-auto" id="monthSelect">
<!-- 										<option>1월</option> -->
<!-- 										<option selected>2월</option> -->
<!-- 										<option>3월</option> -->
									</select>
								</div>
								<!-- 근태 기록 다운로드 버튼 -->
								<button class="btn btn-outline-primary">
									<i class="bi bi-box-arrow-down"></i> 근태기록 다운로드
								</button>
							</div>

							<div class="scrollable-table-container" style="overflow: scroll">
								<!-- 근태 기록 테이블 -->
								<table class="table table-hover">
									<thead class="table-light">
										<tr>
											<th>일자</th>
											<th>출근</th>
											<th>퇴근</th>
											<th>연장</th>
											<th>야간</th>
											<th>합계</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
								</div>
								<div class="tab-pane fade" id="profile" role="tabpanel"
									aria-labelledby="profile-tab">Nesciunt totam et.
									Consequuntur magnam aliquid eos nulla dolor iure eos quia.
									Accusantium distinctio omnis et atque fugiat. Itaque doloremque
									aliquid sint quasi quia distinctio similique. Voluptate nihil
									recusandae mollitia dolores. Ut laboriosam voluptatum dicta.</div>
								<div class="tab-pane fade" id="contact" role="tabpanel"
									aria-labelledby="contact-tab">Saepe animi et soluta ad
									odit soluta sunt. Nihil quos omnis animi debitis cumque.
									Accusantium quibusdam perspiciatis qui qui omnis magnam.
									Officiis accusamus impedit molestias nostrum veniam. Qui amet
									ipsum iure. Dignissimos fuga tempore dolor.</div>
							</div>
							<!-- End Default Tabs -->


						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

</body>
</html>

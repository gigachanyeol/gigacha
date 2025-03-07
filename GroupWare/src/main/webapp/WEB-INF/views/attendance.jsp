<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyAttendance</title>

<%@ include file="./layout/header.jsp"%>
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
					<li class="breadcrumb-item active">나의 근태현황</li>
				</ol>
			</nav>
		</div>
		<div class="row">
			<div id="content" class="col-10">
				<div class="work-status">
					<div class="card info-card customers-card">
						<div class="card-body">
							<h5 class="card-title">
								Customers <span>| This Year</span>
							</h5>

							<div class="d-flex align-items-center">
								<div
									class="card-icon rounded-circle d-flex align-items-center justify-content-center">
								</div>
								<div class="ps-3">
									<hr>
									<p>오늘 근무한 시간</p>
									<h2>00:00:00</h2>
									<div class="work-buttons">
										<button class="btn btn-success">출근</button>
										<button class="btn btn-danger">퇴근</button>
									</div>
									<hr>
									<p>
										<strong>내가 적용받는 근로제:</strong> 일반근로제 <span
											class="badge bg-info">WiFi+GPS</span>
									</p>
									<p>
										<strong>남은 휴가:</strong> 12개
									</p>
									<p>
										<strong>미처리 근태사항:</strong> 100건
									</p>
								</div>
							</div>

						</div>
					</div>

				</div>


				<div class="work-status">
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">근태 기록</h5>

            <!-- 기간 선택 -->
            <div class="d-flex align-items-center mb-3">
                <label class="me-2">기간</label>
                <select class="form-select w-auto me-2">
                    <option>2024</option>
                    <option>2025</option>
                </select>
                <select class="form-select w-auto">
                    <option>1월</option>
                    <option selected>2월</option>
                    <option>3월</option>
                </select>
            </div>

            <!-- 근태 기록 테이블 -->
            <table class="table table-bordered">
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
                    <tr>
                        <td>2025-02-01(화)</td>
                        <td>8:20</td>
                        <td>18:00:56</td>
                        <td>0:00:00</td>
                        <td>0:00:00</td>
                        <td>9:40:00</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>2025-02-02(수)</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>9:40:00</td>
                        <td>연차</td>
                    </tr>
                    <tr>
                        <td>2025-02-03(목)</td>
                        <td>8:20:30</td>
                        <td>18:00:56</td>
                        <td>0:00:00</td>
                        <td>0:00:00</td>
                        <td>9:40:00</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="text-primary">2025-02-07(토)</td>
                        <td colspan="6"></td>
                    </tr>
                    <tr>
                        <td class="text-danger">2025-02-08(일)</td>
                        <td colspan="6"></td>
                    </tr>
                    <tr>
                        <td>2025-02-07(월)</td>
                        <td>8:20:30</td>
                        <td>18:00:56</td>
                        <td>0:00:00</td>
                        <td>0:00:00</td>
                        <td>9:40:00</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>2025-02-08(화)</td>
                        <td>9:20:30</td>
                        <td>18:00:56</td>
                        <td>0:00:00</td>
                        <td>0:00:00</td>
                        <td>9:40:00</td>
                        <td>지각</td>
                    </tr>
                </tbody>
            </table>

            <!-- 근태 기록 다운로드 버튼 -->
            <button class="btn btn-primary">
                <i class="fa fa-download"></i> 근태기록 다운로드
            </button>
        </div>
    </div>
</div>

			</div>
		</div>
	</main>

</body>
</html>

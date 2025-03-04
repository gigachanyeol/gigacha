<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<aside id="sidebar" class="sidebar">
   	<div class="card mb-3 mt-3">
		<img class="card-img-top"
			src="https://yt3.googleusercontent.com/xydasbAktJl4OMRQGV2mEy1Rvf5Y9miqlmVsdIR0Y14rm3fHCOstsYmMlD8MLm7PletRrJr_FiI=s160-c-k-c0x00ffffff-no-rj"
			alt="Card image cap">
		<div class="card-body">
			<!-- <h5 class="card-title">이름 | 사번</h5> -->
			<p class="card-text text-center">이름 | 사번</p>
			<p class="card-text text-center">부서 | 직급</p>
		</div>
	</div>
    <ul class="sidebar-nav" id="sidebar-nav">
      <li class="nav-item">
        <a class="nav-link " href="#">
          <i class="bi bi-grid"></i>
          <span>Dashboard</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#" aria-expanded="false">
          <span>전자결재</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="charts-nav" class="nav-content collapse show" data-bs-parent="#sidebar-nav">
          <li class="nav-heading">기안</li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalDocument.do">
              <span>기안문작성</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalList.do">
              <span>결재요청함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalListTemp.do">
              <span>임시저장함</span>
            </a>
          </li>
          <li class="nav-heading">결재</li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/approvalRequestList.do">
              <span>결재대기함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/selectApprovalInProgress.do">
              <span>결재진행함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/selectApprovalCompleted.do">
              <span>완료문서함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/selectApprovalRejected.do">
              <span>반려문서함</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/approval">
              <span>참조문서함</span>
            </a>
          </li>
          <li class="nav-heading">개인</li>
          <li>
            <a href="${pageContext.request.contextPath}/approval/myApproval.do">
              <span>나의결재목록</span>
            </a>
          </li>
        </ul>
      </li>
    </ul>

  </aside>
</body>
</html>
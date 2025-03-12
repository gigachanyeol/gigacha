<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 등록</title>

<%@ include file="./layout/header.jsp"%>

</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-12">
			<div class="pagetitle">
		    	<h1>사원 등록</h1>
		    	<nav>
			        <ol class="breadcrumb">
			        	<li class="breadcrumb-item"><a href="index.html">Home</a></li>
			          	<li class="breadcrumb-item">Users</li>
			          	<li class="breadcrumb-item active">Profile</li>
			        </ol>
		    	</nav>
	    	</div>
	    	<div class="row">
        <div class="col-xl-3">
        
         <div class="row mb-3">
                      <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                      <div class="col-md-8 col-lg-9">
                        <img src="https://data1.pokemonkorea.co.kr/newdata/pokedex/full/005203.png" alt="Profile">
                        <div class="pt-2">
                          <a href="#" class="btn btn-primary btn-sm" title="Upload new profile image"><i class="bi bi-upload"></i></a>
                          <a href="#" class="btn btn-danger btn-sm" title="Remove my profile image"><i class="bi bi-trash"></i></a>
                        </div>
                      </div>
                    </div>

          
        </div>
        
        <div class="tab-content pt-2 col-xl-4">
               	<div class="tab-pane fade profile-edit pt-3 active show" id="profile-edit" role="tabpanel">

                  <!-- Profile Edit Form -->
                  <form>
                   

                    <div class="row mb-3">
                      <label for="empNumber" class="col-md-4 col-lg-3 col-form-label">사번</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="empNumber" type="text" class="form-control" id="empNumber">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="name" class="col-md-4 col-lg-3 col-form-label">이름</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="name" type="text" class="form-control" id="name">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="birthday" class="col-md-4 col-lg-3 col-form-label">생년월일</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="birthday" type="text" class="form-control" id="birthday">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="degree" class="col-md-4 col-lg-3 col-form-label">최종학력</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="degree" type="text" class="form-control" id="degree">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="gender" class="col-md-4 col-lg-3 col-form-label">성별</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="gender" type="text" class="form-control" id="gender">
                      </div>
                    </div>
                  </form><!-- End Profile Edit Form -->

                </div>
                

              </div>
              
              <div class="tab-content pt-2 col-xl-4">
               	<div class="tab-pane fade profile-edit pt-3 active show" id="profile-edit" role="tabpanel">

                  <!-- Profile Edit Form -->
                  <form>
                    <div class="row mb-3">
                      <label for="empNumber" class="col-md-4 col-lg-3 col-form-label">내선번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="empNumber" type="text" class="form-control" id="empNumber">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="name" class="col-md-4 col-lg-3 col-form-label">휴대전화번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="name" type="text" class="form-control" id="name">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="birthday" class="col-md-4 col-lg-3 col-form-label">이메일</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="birthday" type="text" class="form-control" id="birthday">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="degree" class="col-md-4 col-lg-3 col-form-label">학교</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="degree" type="text" class="form-control" id="degree">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="gender" class="col-md-4 col-lg-3 col-form-label">주소</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="gender" type="text" class="form-control" id="gender">
                      </div>
                    </div>
                  </form><!-- End Profile Edit Form -->
                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>

                </div>
                

              </div>
        
        
        

        
      </div>


		       
		          
		          
		          
		          
		          
		          
		</div>
	</div>
</main>
	
</body>


</html>

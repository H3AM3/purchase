<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>LogIn Page</title>
    <meta name="theme-color" content="#563d7c">
    <meta charset="UTF-8">
<%@include file="/WEB-INF/views/include/common.jsp" %>
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>

<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
</style>

<script>
$(document).ready(function(){
let chechOK = false;
  
  // 상위부서 리스트를 가져오는 ajax
  $.ajax({
    url : '/code/getUpperDep',
    type : 'post',
    dataType : 'text',
    data : {},
    success : function(result){
      let upperDep = JSON.parse(result);
      console.log(upperDep);
      for(i=0; i<upperDep.length; i++){
        $("#upper_dep").append("<option value="+upperDep[i].dep_code+">"+upperDep[i].dep_name+"</option>");
      }
    }
    });

    // 코드 중복체크
    $("#codeCheck").on("click", function(){
      let depCode = $("#dep_code").val();
      $.ajax({
      url : '/code/depCheck',
      type : 'post',
      dataType : 'text',
      data : {dep_code : depCode},
      success : function(result){
        console.log(result);
        if(result == ""){
							$("#checkResult").text("코드 사용가능");
							$("#checkResult").removeAttr("hidden");
							chechOK = true;
						} else {
							$("#checkResult").text("코드 사용불가");
							$("#checkResult").removeAttr("hidden");
						}
          }
      });

      });

      // 입력데이터가 있는지 확인
      $("#btnMkdepCode").on("click", function(e){
        $("#btnMkdepCode").removeAttr();
        if($("#dep_code").val() == ""){
          alert("부서코드를 입력해주세요.");
          return false;
        } else if ($("#dep_name").val() == ""){
          alert("부서명을 입력해주세요.");
          return false;
        }
        if(chechOK){
          $("#btnMkdepCode").submit();
        }else{
          alert("코드 중복확인을 해주세요.");
          return false;
        }
      });

 });
    
 


</script>


<title>Insert title here</title>
</head>
<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>

<h3>부서코드생성</h3>

<div class="container">
  <div class="mb-3 text-center">
	  <form id="CreateDepCodeForm" method="post" action="/code/createDepCode">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">부서코드</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="dep_code" name="dep_code" placeholder="부서코드 입력">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-link" id="codeCheck" name="codeCheck">코드 중복체크</button>
		    </div>
		    <label for="staticEmail" hidden class="col-sm-2 col-form-label" style="color: red;" id="checkResult">중복체크결과</label>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">부서명</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="dep_name" name="dep_name" placeholder="부서명 입력">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">상위부서</label>
        <select id="upper_dep" name="upper_dep">
          <option value="null" selected>없음</option>
        </select>
		    </div>
			<div class="col-sm-12 text-center">
			  	<button type="submit" class="btn btn-dark" id="btnMkdepCode">코드생성</button>
			  </div>	
	 </form>
  </div>
</div>
<!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
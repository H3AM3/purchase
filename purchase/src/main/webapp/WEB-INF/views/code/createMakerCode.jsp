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
    <title>CreateMakerCode</title>
    <meta name="theme-color" content="#563d7c">
    <meta charset="UTF-8">
<%@include file="/WEB-INF/views/include/common.jsp" %>

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

    // 코드 중복체크(변경안됨)
    $("#codeCheck").on("click", function(){
      //console.log("체크 클릭");
      if($("#maker_code").val() == ""){
        alert("코드를 입력해주세요.");
        return false;
      }

      let maker_code = $("#maker_code").val();
      $.ajax({
      url : '/code/makerCheck',
      type : 'post',
      dataType : 'text',
      data : {maker_code : maker_code},
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

      // 입력데이터가 있는지 확인 후 submit
      $("#btnCreateCode").on("click", function(e){
        $("#btnCreateCode").removeAttr();
        if($("#maker_code").val() == ""){
          alert("제조사코드를 입력해주세요.");
          return false;
        } else if ($("#maker_name").val() == ""){
          alert("제조사명을 입력해주세요.");
          return false;
        }
        if(chechOK){
          $("#btnCreateCode").submit();
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

<h3>제조사 코드생성</h3>

<div class="container">
  <div class="mb-3 text-center">
	  <form id="CreateMakerCodeForm" method="post" action="/code/createMakerCode">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">제조사 코드</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="maker_code" name="maker_code" placeholder="코드 입력">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-link" id="codeCheck" name="codeCheck">코드 중복체크</button>
		    </div>
		    <label for="staticEmail" hidden class="col-sm-2 col-form-label" style="color: red;" id="checkResult">중복체크결과</label>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">거래처명</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="maker_name" name="maker_name" placeholder="거래처명 입력">
		    </div>
		  </div>
			<div class="col-sm-12 text-center">
			  	<button type="submit" class="btn btn-dark" id="btnCreateCode">코드생성</button>
			  </div>	
	 </form>
  </div>
</div>
<!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
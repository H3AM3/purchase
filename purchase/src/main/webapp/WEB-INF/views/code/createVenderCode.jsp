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
    <title>CreateVenderCode</title>
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

    // 코드 중복체크(변경안됨)
    $("#codeCheck").on("click", function(){
      //console.log("체크 클릭");
      if($("#vender_code").val() == ""){
        alert("코드를 입력해주세요.");
        return false;
      }

      let vender_code = $("#vender_code").val();
      $.ajax({
      url : '/code/venderCheck',
      type : 'post',
      dataType : 'text',
      data : {vender_code : vender_code},
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
      $("#btnMkvenderCode").on("click", function(e){
        $("#btnMkvenderCode").removeAttr();
        if($("#vender_code").val() == ""){
          alert("거래처코드를 입력해주세요.");
          return false;
        } else if ($("#vender_name").val() == ""){
          alert("거래처명을 입력해주세요.");
          return false;
        }
        if(chechOK){
          $("#btnMkvenderCode").submit();
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

<h3>거래처 코드생성</h3>

<div class="container">
  <div class="mb-3 text-center">
	  <form id="CreateVenderCodeForm" method="post" action="/code/createVenderCode">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">거래처 코드</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="vender_code" name="vender_code" placeholder="코드 입력">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-link" id="codeCheck" name="codeCheck">코드 중복체크</button>
		    </div>
		    <label for="staticEmail" hidden class="col-sm-2 col-form-label" style="color: red;" id="checkResult">중복체크결과</label>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">거래처명</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="vender_name" name="vender_name" placeholder="거래처명 입력">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">사업자 등록번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="vender_reg_num" name="vender_reg_num" placeholder="-없이 숫자만 입력해주세요.">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">은행</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="bank" name="bank" placeholder="은행명 입력">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">계좌번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="account_number" name="account_number" placeholder="-없이 숫자만 입력해주세요.">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="vender_email" name="vender_email" placeholder="EX) abcd@naver.com">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="description" name="description">
		    </div>
		  </div>
			<div class="col-sm-12 text-center">
			  	<button type="submit" class="btn btn-dark" id="btnMkvenderCode">코드생성</button>
			  </div>	
	 </form>
  </div>
</div>
<!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
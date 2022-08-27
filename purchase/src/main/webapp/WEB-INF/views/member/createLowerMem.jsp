<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
  <head>
	<%@include file="/WEB-INF/views/include/common.jsp" %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>DocMall Shopping</title>`

<meta name="theme-color" content="#563d7c">
<link rel="stylesheet" href="/resources/css/defaultForm.css">
    
    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">

<script>
let chechOK = false;

// 거래처 검색 팝업창 띄우기
function depSearchPopup(){
  window.open("/member/depSearchPopup","depSearchPopup","width=600, height=450, top=150, left=200");
}

	$(document).ready(function(){

		//아이디 중복체크
		$("#idCheck").on("click", function(){
			if($("#mem_id").val() == ""){
				alert("아이디를 입력하세요.")
			}else{
			$.ajax({
				url : '/member/idCheck',
				type : 'post',
				dataType : 'text',
				data : {mem_id:$("#mem_id").val()},
				success : function(result){
					console.log(result);
					if(result == ""){
						$("#checkResult").text("아이디 사용가능");
						$("#checkResult").removeAttr("hidden");
						chechOK = true;
					} else {
						$("#checkResult").text("아이디 사용불가");
						$("#checkResult").removeAttr("hidden");
					}
				}
			});
			}
		});

		// 계정생성 버튼 작동 ajax에는 없습니다.
		$("#btnMkMember").on("click", function(e){
			$("#btnMkMember").removeAttr();
			if($("#mem_id").val() == "") {
				alert("아이디를 작성하지 않았습니다.");
				return false;
			}else if($("#mem_password").val() == ""){
				alert("비밀번호를 작성하지 않았습니다.");
				return false;
			}else if($("#check_password").val() == ""){
				alert("비밀번호 확인을 작성하지 않았습니다.");
				return false;
			}else if($("#mem_name").val() == ""){
				alert("이름을 작성하지 않았습니다.")
				return false;
			}

			// 비밀번호 확인, 아이디 중복 체크
			if(chechOK){
				if($("#mem_password").val() != $("#check_password").val()){
					alert("비밀번호를 확인해주세요.");
					return false;
				}

				alert("계정생성 완료");
				e.submit();
			}else{
				alert("ID중복체크를 해주세요.")
				return false;
			}
		});
	});

</script>
  </head>
<body>

<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">

<div class="container">
<h3>청구부서 계정생성</h3>

  <div class="mb-3 text-center">
	  <form id="createLoweMemForm" method="post" action="/member/createLoweMem">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">아이디</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="아이디를  8~15이내로 입력">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-link" id="idCheck" name="idCheck">ID중복체크</button>
		    </div>
		    <label for="staticEmail" hidden class="col-sm-2 col-form-label" style="color: red;" id="checkResult">중복체크결과</label>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="mem_password" name="mem_password" placeholder="비밀번호를 입력">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">비밀번호확인</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="check_password" placeholder="비밀번호 확인">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">이름</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="mem_name" name="mem_name" placeholder="이름을 입력">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">부서</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="dep_name" name="dep_name" placeholder="" readonly>
		    </div>
			<div class="col-sm-1">
				<input type="button" value="검색" id="btnVenSearch" name="btnVenSearch" onclick="depSearchPopup();">
			  </div>
		  </div>
		  <input type="text" class="form-control" id="dep_code" name="dep_code" hidden>
		  <div class="form-group row">
			  <div class="col-sm-12 text-center">
			  	<button type="submit" class="btn btn-dark" id="btnMkMember">계정생성</button>
			  </div>			
		  </div>
	 </form>
  </div>
</div>
</div>
  <!--  footer.jsp -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>


    
  </body>
</html>
    
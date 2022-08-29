<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>LogIn Page</title>
  <link rel="stylesheet" href="/resources/css/defaultForm.css">


<meta name="theme-color" content="#563d7c">


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

    
    <!-- Custom styles for this template -->
    <link src="\resources\bootstrap4.6\" rel="stylesheet">
    <script>
    	let msg = "${msg}";
    	if(msg == "idFailure"){
    		alert("아이디를 확인하세요.");
    	}else if(msg == "passwdFailure"){
    		alert("비밀번호를 확인하세요");
    	}else if(msg == "loginSuccess"){
        alert("로그인 성공!")
      }
    </script>
  </head>
  <body>
<%@include file="/WEB-INF/views/include/common.jsp" %>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<!-- 로그인상태면 Redirect시켜주는 구문 -->
<c:if test="${sessionScope.loginStatus.mem_name != null}">
<c:redirect url="/code/productList"></c:redirect>
</c:if>
<h3 style=" margin-bottom: 30px;">로그인</h3>
<div style="display: block;">
	  <form id="loginForm" action="/member/loginOK" method="post">
		  <div style="display: block;">
		    <label for="mem_id" style="display: inline-block; width: 100px; background-color: #e9e9e9; margin-bottom: 30px;" class="form-control">아이디</label>
		      <input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="아이디를  8~15이내로 입력" style="display: inline-block; width: 300px;">
		  </div>
		  <div style="display: block;">
		    <label for="inputPassword" style="display: inline-block; width: 100px; background-color: #e9e9e9; margin-bottom: 30px;" class="form-control">비밀번호</label>
		      <input type="password" id="mem_password" name="mem_password" placeholder="비밀번호를  8~15이내로 입력" style="display: inline-block; width: 300px;">
		  </div>
		  <div style="display: block;">
			  	<button type="submit" class="btn btn-dark" id="btnLogin">로그인</button>			
		  </div>
	 </form>
</div>
<!--  footer.jsp -->
</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>


    
  </body>
</html>
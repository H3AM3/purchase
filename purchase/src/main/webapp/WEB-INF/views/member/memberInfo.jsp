<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
  <head>
	<%@include file="/WEB-INF/views/include/common.jsp" %>
	<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>DocMall Shopping</title>

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
    <link href="pricing.css" rel="stylesheet">

	<script>

		let chechOK = false;

		$(document).ready(function(){
			// 수정버튼 누르면 저장,삭제 버튼 나오는 기능
			$("#btnUpdate").on("click", function(){
				$("#mem_password").removeAttr("readonly");
				$("#btnSave").removeAttr("hidden");
				$("#btnDel").removeAttr("hidden");
				$("#btnUpdate").attr("hidden", true);
			});

			// 부서코드 수정
			$("#btnSave").on("click", function(){
				if($("#mem_password").val()==""){
					alert("변경된 내용이 없습니다!");
				} else if($("#mem_password").val()!=""){
					$.ajax({
						url : '/member/updateMemberInfo',
						type : 'post',
						dataType : 'text',
						data : {mem_id:$("#mem_id").val(), mem_password:$("#mem_password").val()},
						success : function(result){
						// let data = JSON.parse(result);
							if(result == 'success'){
							alert("변경 성공");
							}else{
								alert("비밀번호를 변경할 수 없습니다.");
							}
						}
					});
				}
				$("#mem_password").attr("readonly", true);
				$("#btnDel").attr("hidden", true);
				$("#btnUpdate").removeAttr("hidden");
				$("#btnSave").attr("hidden", true);
			});
			
			// 코드삭제
			$("#btnDel").on("click", function(){
				let del = confirm("이 코드를 삭제하시겠습니까?");
				if(del){
					$.ajax({
						url : '/member/delMember',
						type : 'post',
						dataType : 'text',
						data : {mem_id:$("#mem_id").val()},
								success : function(result){
									console.log(result);
									if(result == 'success'){
										alert("삭제 성공");
									// 목록으로 리턴
									$("#gotoList").click();
									} else {
										alert("오류가 발생했습니다. 삭제 실패!");
									}
								}
					});

				}
			});

		});

	</script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<h3>계정 조회/수정</h3>
<form id="joinForm" method="post" action="/member/updateMemberInfo">
	<div class="container">
		<div class="mb-3 text-center">
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="mem_id" name="mem_id" readonly value="${memberVO.mem_id}">
				</div>
			</div>
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">부서</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="dep_name" name="dep_name" readonly value="${memberVO.dep_name}">
				</div>	
			</div>
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">상위부서</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="upper_dep" name="upper_dep" readonly value="${upperDepName.dep_name}">
				</div>
			</div>
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="mem_password" name="mem_password" readonly value="" placeholder="변경시에만 입력해주세요.">
				</div>
			</div>
		</div>
		<div class="form-group row">
			<input type="button" class="btn btn-dark" id="gotoList" name="gotoList" onclick="location.href='/member/memberList'" value="목록">
			<input type="button" class="btn btn-dark" id="btnUpdate" name="btnUpdate" value="수정">
			<input type="button" class="btn btn-dark" id="btnSave" name="btnSave" hidden value="저장">
			<input type="button" class="btn btn-dark" id="btnDel" name="btnDel" hidden value="삭제">
		</div>	
	</div>
</form>
 

  <!--  footer.jsp -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
    
  </body>
</html>
    
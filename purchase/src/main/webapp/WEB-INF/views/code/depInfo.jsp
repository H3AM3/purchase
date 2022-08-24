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
				$("#dep_name").removeAttr("readonly");
				$("#btnSave").removeAttr("hidden");
				$("#btnDel").removeAttr("hidden");
				$("#btnUpdate").attr("hidden", true);
			});

			// 부서코드 수정
			$("#btnSave").on("click", function(){
				if($("#dep_name").val()==""){
					alert("부서명을 입력해주세요!");
					return false;
				}

				$.ajax({
				url : '/code/updateDepCode',
				type : 'post',
				dataType : 'text',
				data : {dep_code:$("#dep_code").val(), dep_name:$("#dep_name").val(), upper_dep: "${upper_dep}"},
				success : function(result){
				// let data = JSON.parse(result);
				if(result == 'success'){
				alert("변경 성공");
				}else{
					alert("코드를 변경할 수 없습니다.")
				}
				}
				});

				$("#dep_name").attr("readonly", true);
				$("#btnDel").attr("hidden", true);
				$("#btnUpdate").removeAttr("hidden");
				$("#btnSave").attr("hidden", true);
			});
			
			// 코드삭제
			$("#btnDel").on("click", function(){
				let del = confirm("이 코드를 삭제하시겠습니까?");
				if(del){
					$.ajax({
						url : '/code/delDepartment',
						type : 'post',
						dataType : 'text',
						data : {dep_code:$("#dep_code").val()},
								success : function(result){
								// let data = JSON.parse(result);
								console.log(result);
								if(result == 'success'){
									alert("삭제 성공");
								// 목록으로 리턴
								$("#gotoList").click();
								}else if (result == 'lowerCodeExist'){
									alert("하위 부서가 존재하여 코드를 삭제할 수 없습니다.");
									return false;
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

<h3>부서코드 조회/수정</h3>
<form id="joinForm" method="post" action="/member/depCodePage">
	<div class="container">
		<div class="mb-3 text-center">
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">부서코드</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="dep_code" name="dep_code" readonly value="${dep_code}">
					<a style="color: red;" id="check" hidden>중복된 코드입니다.</a>
				</div>
			</div>
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">부서명</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="dep_name" name="dep_name" readonly value="${dep_name}">
				</div>	
			</div>
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">상위부서</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="upper_dep" name="upper_dep" readonly value="${upper_dep_name}">
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
    
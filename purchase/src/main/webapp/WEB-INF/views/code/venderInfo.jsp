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
<link rel="stylesheet" href="/resources/css/defaultForm.css">
    
   <!-- Custom styles for this template -->
   <link href="pricing.css" rel="stylesheet">

<script>

	let chechOK = false;

	$(document).ready(function(){
		// 수정버튼 누르면 저장,삭제 버튼 나오는 기능 + readonly 해제
		$("#btnUpdate").on("click", function(){
			$("#vender_name").removeAttr("readonly");
			$("#vender_reg_num").removeAttr("readonly");
			$("#bank").removeAttr("readonly");
			$("#account_number").removeAttr("readonly");
			$("#vender_email").removeAttr("readonly");
			$("#description").removeAttr("readonly");

			$("#btnSave").removeAttr("hidden");
			$("#btnDel").removeAttr("hidden");
			$("#btnUpdate").attr("hidden", true);
		});

		// 부서코드 수정
		$("#btnSave").on("click", function(){
			if($("#vender_name").val()==""){
				alert("부서명을 입력해주세요!");
				return false;
			}

			$.ajax({
			url : '/code/updateVenderCode',
			type : 'post',
			dataType : 'text',
			data : {vender_code:$("#vender_code").val(), vender_name:$("#vender_name").val(),
					vender_reg_num:$("#vender_reg_num").val(), bank:$("#bank").val(),
					account_number:$("#account_number").val(), vender_email:$("#vender_email").val(),
					description:$("#description").val()},
			success : function(result){
			// let data = JSON.parse(result);
			if(result == 'success'){
				alert("변경 성공");
			}else{
				alert("코드를 변경할 수 없습니다.")
			}
			}
			});
			
			// 저장하면 저장, 삭제버튼 다시 hidden으로 변경하는 기능
			$("#vender_name").attr("readonly", true);
			$("#vender_reg_num").attr("readonly", true);
			$("#bank").attr("readonly", true);
			$("#account_number").attr("readonly", true);
			$("#vender_email").attr("readonly", true);
			$("#description").attr("readonly", true);
			$("#btnDel").attr("hidden", true);
			$("#btnUpdate").removeAttr("hidden");
			$("#btnSave").attr("hidden", true);
		});
		
		// 코드삭제
		$("#btnDel").on("click", function(){
			let del = confirm("이 코드를 삭제하시겠습니까?");
			if(del){
				$.ajax({
					url : '/code/delVender',
					type : 'post',
					dataType : 'text',
					data : {vender_code:$("#vender_code").val()},
							success : function(result){
							// let data = JSON.parse(result);
							if(result == 'success'){
								alert("삭제 성공");
							}else{
								alert("코드를 삭제할 수 없습니다.");
							}
							}
				});
				// 목록으로 리턴
				$("#gotoList").click();
			}
		});

	});

</script>
</head>
<body>

<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<div class="container">
  <h3>거래처 조회/수정</h3>
  <div class="mb-3 text-center">

<form id="VenderInfoForm" method="post" action="/code/venderInfo">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">거래처 코드</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="vender_code" name="vender_code" readonly value="${venderInfo.vender_code}">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">거래처명</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="vender_name" name="vender_name" readonly value="${venderInfo.vender_name}">
			</div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">사업자 등록번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="vender_reg_num" name="vender_reg_num" readonly value="${venderInfo.vender_reg_num}">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">은행</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="bank" name="bank" readonly value="${venderInfo.bank}">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">계좌번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="account_number" name="account_number" readonly value="${venderInfo.account_number}">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="vender_email" name="vender_email" readonly value="${venderInfo.vender_email}">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="description" name="description" readonly value="${venderInfo.description}">
		    </div>
		  </div>
		  <div class="form-group row">
			<input type="button" class="btn btn-dark" id="gotoList" name="gotoList" onclick="location.href='/code/venderList'" value="목록">
			<input type="button" class="btn btn-dark" id="btnUpdate" name="btnUpdate" value="수정">
			<input type="button" class="btn btn-dark" id="btnSave" name="btnSave" hidden value="저장">
			<input type="button" class="btn btn-dark" id="btnDel" name="btnDel" hidden value="삭제">
			</div>		
	 </form>
  </div>
</div>


</div>
  <!--  footer.jsp -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>

  </body>
</html>
    
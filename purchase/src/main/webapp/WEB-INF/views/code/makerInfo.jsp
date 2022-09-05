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
				$("#maker_name").removeAttr("readonly");

				$("#btnSave").removeAttr("hidden");
				$("#btnDel").removeAttr("hidden");
				$("#btnUpdate").attr("hidden", true);
			});

			// 부서코드 수정
			$("#btnSave").on("click", function(){
				if($("#maker_name").val()==""){
					alert("부서명을 입력해주세요!");
					return false;
				}

				$.ajax({
				url : '/code/updateMakerName',
				type : 'post',
				dataType : 'text',
				data : {maker_code:$("#maker_code").val(), maker_name:$("#maker_name").val()},
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
				$("#maker_name").attr("readonly", true);
				$("#btnDel").attr("hidden", true);
				$("#btnUpdate").removeAttr("hidden");
				$("#btnSave").attr("hidden", true);
			});
			
			// 코드삭제
			$("#btnDel").on("click", function(){
				let del = confirm("이 코드를 삭제하시겠습니까?");
				if(del){
					$.ajax({
						url : '/code/delMaker',
						type : 'post',
						dataType : 'text',
						data : {maker_code:$("#maker_code").val()},
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
<h3>제조사 조회/수정</h3>

  <div class="mb-3 text-center">
<form id="MakerInfoForm" method="post" action="/code/makerInfo">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">제조사 코드</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="maker_code" name="maker_code" readonly value="${makerInfo.maker_code}">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">제조사</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="maker_name" name="maker_name" readonly value="${makerInfo.maker_name}">
			</div>
		  </div>
		  <div class="form-group row">
			<input type="button" class="btn btn-dark" id="gotoList" name="gotoList" onclick="location.href='/code/makerList'" value="목록" style="margin-right: 5px">
			<input type="button" class="btn btn-dark" id="btnUpdate" name="btnUpdate" value="수정" style="margin-right: 5px">
			<input type="button" class="btn btn-dark" id="btnSave" name="btnSave" hidden value="저장" style="margin-right: 5px">
			<input type="button" class="btn btn-dark" id="btnDel" name="btnDel" hidden value="삭제" style="margin-right: 5px">
			</div>		
	 </form>
  </div>
</div>

</div>
  <!--  footer.jsp -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>

  </body>
</html>
    
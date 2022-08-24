<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

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
    <link href="\resources\pricing.css" rel="stylesheet">

	<script>

		let chechOK = false;
			// 셀렉트 태그 수정불가로 바꾸는 메소드
			function selectDisabled(){
				$("#category_1st").prop('disabled', true);
				$("#category_2nd").prop('disabled', true);
				$("#type").prop('disabled', true);
				$("#im_pakaging").prop('disabled', true);
				$("#ex_pakaging").prop('disabled', true);
				$("#usable").prop('disabled', true);
			}

			// 셀렉트 태그 수정가능으로 바꾸는 메소드
			function selectEndabled(){
				$("#category_1st").prop('disabled', false);
				$("#category_2nd").prop('disabled', false);
				$("#type").prop('disabled', false);
				$("#im_pakaging").prop('disabled', false);
				$("#ex_pakaging").prop('disabled', false);
				$("#usable").prop('disabled', false);
			}
			function venderSearchPopup(){
				window.open("/code/venSearchPopup","venSearchPopup","width=600, height=450, top=150, left=200");
			}
			function makerSearchPopup(){
				window.open("/code/makerSearchPopup","makerSearchPopup","width=600, height=450, top=150, left=200");
			}

		$(document).ready(function(){
			selectDisabled();

			// 수정버튼 누르면 저장,삭제 버튼 나오는 기능 + readonly 해제
			$("#btnUpdate").on("click", function(){
				console.log("버튼누름");
				selectEndabled();
				$("#product_name").removeAttr("readonly");
				$("#spec").removeAttr("readonly");
				$("#edi_code").removeAttr("readonly");
				$("#pak_quantity").removeAttr("readonly");
				$("#price").removeAttr("readonly");
				$("#description").removeAttr("readonly");
				$("#btnMakerSearch").removeAttr("hidden");
				$("#btnVenSearch").removeAttr("hidden");

				$("#btnSave").removeAttr("hidden");
				$("#btnUpdate").attr("hidden", true);
			});

			// 품목코드 수정
			$("#btnSave").on("click", function(){
				// 유효성 체크
				if($("#product_name").val()==""){
					alert("부서명을 입력해주세요!");
					return false;
				} else if($("#vender_name").val()==""){
					alert("거래처를 입력해주세요!");
				} else if($("#pak_quantity").val()==""){
					alert("포장수량을 입력해주세요!");
				} else if($("#price").val()==""){
					alert("단가를 입력해주세요!");
				}
				if($("#spec").val() == ""){
					$("#spec").val("-");
				}
				if($("#edi_code").val() == ""){
				$("#edi_code").val("-");
				}
				console.log($("#edi_code").val());
				console.log($("#usable").val());
				$.ajax({
				url : '/code/updateProductCode',
				type : 'post',
				dataType : 'text',
				data : {product_code:$("#product_code").val(), product_name:$("#product_name").val(),
						category_1st:$("#category_1st").val(), category_2nd:$("#category_2nd").val(),
						spec:$("#spec").val(), vender_name:$("#vender_name").val(),
						vender_code:$("#vender_code").val(), edi_code:$("#edi_code").val(),
						type:$("#type").val(), im_pakaging :$("#im_pakaging").val(),
						ex_pakaging :$("#ex_pakaging").val(), pak_quantity:$("#pak_quantity").val(),
						price :$("#price").val(), usable : $("#usable").val(), description:$("#description").val(),
						maker_name :$("#maker_name").val(), maker_code : $("#maker_code").val()},
				success : function(result){
				// let data = JSON.parse(result);
				if(result == 'success'){
					alert("변경 성공");
					window.location = '/code/prodInfo?product_code='+ $("#product_code").val();
				}else{
					alert("코드를 변경할 수 없습니다.")
				}
				}
				});
				
				// 저장하면 수정불가로 바꿔주는 기능
				selectDisabled();
				$("#product_name").attr("readonly", true);
				$("#spec").attr("readonly", true);
				$("#edi_code").attr("readonly", true);
				$("#pak_quantity").attr("readonly", true);
				$("#price").attr("readonly", true);
				$("#description").attr("readonly", true);
				$("#btnMakerSearch").attr("hidden", true);
				$("#btnVenSearch").attr("hidden", true);
				
				// 저장하면 저장, 삭제버튼 다시 hidden으로 변경하는 기능
				$("#btnUpdate").removeAttr("hidden");
				$("#btnSave").attr("hidden", true);
			});

		});

	</script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<h3>품목 조회/수정</h3>

<div class="container">
  <div class="mb-3 text-center">
<form id="prodInfoForm" method="post" action="/code/prodInfo">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">품목 코드</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="product_code" name="product_code" readonly value="${prodInfo.product_code}">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">품명</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="product_name" name="product_name" readonly value="${prodInfo.product_name}">
			</div>
		  </div>
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label" >상위 카테고리</label>
						<div class="col-sm-2">
						<select class="form-control" id="category_1st" name="category_1st">
						<c:forEach items="${upperCat}" var="upperCat">
							<option value="${upperCat.category_code}" <c:if test="${upperCat.category_code eq prodInfo.category_1st}"> selected</c:if> >${upperCat.category_name}</option>
						</c:forEach>
					</select>
						</div>
					<label for="staticEmail" class="col-sm-2 col-form-label">하위 카테고리</label>
						<div class="col-sm-2">
						<select class="form-control" id="category_2nd" name="category_2nd">
						<c:forEach items="${lowerCat}" var="lowerCat">
							<option value="${lowerCat.category_code}" <c:if test="${lowerCat.category_code eq prodInfo.category_2nd}"> selected</c:if> >${lowerCat.category_name}</option>
						</c:forEach>
						</select>
					</div>
				</div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">규격</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="spec" name="spec" readonly value="${prodInfo.spec}">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">제조사</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="maker_name" name="maker_name" readonly value="${prodInfo.maker_name}">
		      <input type="text" class="form-control" id="maker_code" name="maker_code" readonly value="${prodInfo.maker_code}" hidden>
		    </div>
			<div class="col-sm-1">
				<input type="button" hidden value="검색" id="btnMakerSearch" name="btnMakerSearch" onclick="makerSearchPopup();">
			  </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">거래처</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="vender_name" name="vender_name" readonly value="${prodInfo.vender_name}">
		      <input type="text" class="form-control" id="vender_code" name="vender_code" readonly value="${prodInfo.vender_code}" hidden>
		    </div>
			<div class="col-sm-1">
				<input type="button" hidden value="검색" id="btnVenSearch" name="btnVenSearch" onclick="venderSearchPopup();">
			  </div>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">EDI코드</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="edi_code" name="edi_code" readonly value="${prodInfo.edi_code}">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">타입</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="type" name="type">
				<c:forEach items="${type}" var="type">
					<option value="${type.type}" <c:if test="${type.type eq prodInfo.type}"> selected</c:if> >${type.type}</option>
				</c:forEach>
          </select>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">입고단위</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="im_pakaging" name="im_pakaging">
				<c:forEach items="${pakaging}" var="pakaging">
					<option value="${pakaging.pakaging}" <c:if test="${pakaging.pakaging eq prodInfo.im_pakaging}"> selected</c:if> >${pakaging.pakaging}</option>
				</c:forEach>
				</select>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">출고단위</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="ex_pakaging" name="ex_pakaging">
				<c:forEach items="${pakaging}" var="pakaging">
					<option value="${pakaging.pakaging}" <c:if test="${pakaging.pakaging eq prodInfo.ex_pakaging}"> selected</c:if> >${pakaging.pakaging}</option>
				</c:forEach>
				</select>
          </div>
          </div>
				<div class="form-group row">
					<label for="inputPassword" class="col-sm-2 col-form-label">포장수량</label>
					<div class="col-sm-2">
					  <input type="text" class="form-control" id="pak_quantity" name="pak_quantity" readonly value="${prodInfo.pak_quantity}">
					</div>
				  </div>
				  <div class="form-group row">
					<label for="inputPassword" class="col-sm-2 col-form-label">단가</label>
					<div class="col-sm-2">
					  <input type="text" class="form-control" id="price" name="price" readonly value="${prodInfo.price}">
					</div>
				  </div>
				  <div class="form-group row">
					<label for="staticEmail" class="col-sm-2 col-form-label">사용여부</label>
					<div class="col-sm-2">
					  <select class="form-control" id="usable" name="usable">
					  <option value="0" <c:if test="${prodInfo.usable eq '0'}"> selected</c:if>>사용가능</option>
					  <option value="1" <c:if test="${prodInfo.usable eq '1'}"> selected</c:if>>사용불가</option>
				  </select>
				  </div>
				  </div>
		<div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">생성일자</label>
			<a><fmt:formatDate value="${prodInfo.reg_date}" pattern="yyyy-MM-dd"/></a>
		  </div>
      <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="description" name="description" readonly value="${prodInfo.description}">
		    </div>
		  </div>
		  <div class="form-group row">
			<input type="button" class="btn btn-dark" id="gotoList" name="gotoList" onclick="location.href='/code/productList'" value="목록">
			<input type="button" class="btn btn-dark" id="btnUpdate" name="btnUpdate" value="수정">
			<input type="button" class="btn btn-dark" id="btnSave" name="btnSave" hidden value="저장">
			</div>		
	 </form>
  </div>
</div>

<!-- 코드정보 변경 히스토리 내역 -->
<table class="table" style="margin-top: 10px;">
	<thead class="thead-dark">
	  <tr>
		<th scope="vnaa">수정일자</th>
		<th scope="col">품명</th>
		<th scope="col">카테고리</th>
		<th scope="col">규격</th>
		<th scope="col">제조사</th>
		<th scope="col">거래처</th>
		<th scope="col">EDI코드</th>
		<th scope="col">타입</th>
		<th scope="col">입고단위</th>
		<th scope="col">출고단위</th>
		<th scope="col">포장수량</th>
		<th scope="col">단가</th>
	  </tr>
	</thead>
	<tbody id="codeEditList" style="border: 1px solid">
	<c:forEach items="${codeHistory}" var="codeHistory">
		<tr>
		<th scope="row"><fmt:formatDate value="${codeHistory.update_date}" pattern="yyyy-MM-dd"/></th>
		<td>${codeHistory.product_name}</td>
		<td>${codeHistory.category_2nd}</td>
		<td>${codeHistory.spec}</td>
		<td>${codeHistory.maker_name}</td>
		<td>${codeHistory.vender_name}</td>
		<td>${codeHistory.edi_code}</td>
		<td>${codeHistory.type}</td>
		<td>${codeHistory.im_pakaging}</td>
		<td>${codeHistory.ex_pakaging}</td>
		<td>${codeHistory.pak_quantity}</td>
		<td>${codeHistory.price}</td>
		<tr>
	</c:forEach>
	</tbody>
  </table>

  <!--  footer.jsp -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>

    
  </body>
</html>
    
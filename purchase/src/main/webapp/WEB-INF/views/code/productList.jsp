<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/include/common.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>


<h3>품목코드 목록</h3><br>
<!-- 카테고리 영역 -->
<a style="float: left;">카테고리 선택 &nbsp</a>
<div style="float: left;">
	<form id="selectCategory_1st" name="selectCategory_1st" action=""
		method="post">
		<!-- 카테고리(상) -->
		<select id="category_1st" name="category_1st">
			<option value="none" selected>대분류</option>
		</select>
	</form>
</div>
<div style="float: left;">
	<form id="selectCategory_2nd" name="selectCategory_2nd" action="">
		<!-- 카테고리(하) -->
		<select id="category_2nd">
			<option value="none" selected>소분류</option>
		</select>
	</form>
</div>

<!-- 사용불가코드 조회 여부 체크박스 -->
<div style="display: block;">
<label>&nbsp&nbsp|&nbsp 사용불가코드 &nbsp</label>
<input type="checkbox" id="usable" name="usable" value="false">
</div>

<!-- 검색창 영역 -->
<div style="float: left;">
	<form name="searchForm" id="searchForm" onsubmit="false">
	<input type="text" id="product_code" name="product_code" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="품목코드">
	<input type="text" id="product_name" name="product_name" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="품명">
	<input type="text" id="vender_name" name="vender_name" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="거래처명">
	<input type="button" id="btnSearch" name="btnSearch" value="검색">
	</form>
</div>

<!-- 코드생성버튼 -->
<div>
	<label>&nbsp|&nbsp</label>
	<input type="button" value="코드생성" onclick="location.href='/code/createProductCode'">
	</div>
	<div>
	</div>

<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
  <thead class="thead-dark">
    <tr>
      <th scope="vnaa">품목코드</th>
      <th scope="">품명</th>
      <th scope="col">규격</th>
	  <th scope="col">제조사</th>
      <th scope="col">거래처</th>
    </tr>
  </thead>
  <tbody id="codeList">
    <tr>
    </tr>
  </tbody>
</table>



<%@include file="/WEB-INF/views/include/footer.jsp"%>


<script>
	let catObj;
	let upperCat
	let lowerCat;
	let codeList = $("#codeList");
	let usable = '0';
	$(document).ready(function() {
		getUpperCat();
		getProdCodeList();
		//체크박스 체크여부
		$("#usable").change(function(){
        if($("#usable").is(":checked")){
			usable='1';
        }else{
            usable='0'
        }
    });

		// 페이지 로딩시 대분류를 불러오는 메소드
		function getUpperCat(){
			upperCat = $("#category_1st");
			$.ajax({
				url : '/code/getUpperCat',
				type : "post",
				dataType : 'text',
				data : {},
				success : function(result) {
					catObj = JSON.parse(result);
					// 리턴값을 받아서 상위 카테고리 생성
					setUpperCategory(catObj, upperCat);
				}
			});
		}


		// 상위 카테고리를 고르면 하위 카테고리가 나타나게 만드는 메소드
		$("#category_1st").on("change", function() {
			let cat1value = $("#category_1st").val();
			lowerCat = $("#category_2nd");

			// 대분류 없음을 고르면 하위카테고리를 삭제하는 메소드
			if ($("#category_1st").val() == 'none') {
				lowerCat.children().remove();
				lowerCat.append("<option value='none' selected>소분류</option>");
				return;
			}
			// 불러오기 전 기존에 생성된 하위카테고리가 있으면 삭제하는 작업
			lowerCat.children().remove();
			lowerCat.append("<option value='none' selected>소분류</option>");
			$.ajax({
				url : '/code/getLowerCat',
				type : "post",
				dataType : 'text',
				data : {
					category_code : cat1value
				},
				success : function(result) {
					catObj = JSON.parse(result);
					// 리턴값을 받아서 하위 카테고리 생성
					setCategory(catObj, lowerCat);
				}
			});

		});

		// 검색버튼 작동
		$("#btnSearch").on("click", function(){
			codeList.children().remove();
			getProdCodeList();
		});

	});
	// 상위 카테고리를 생성하는 메소드
	function setUpperCategory(list, catId) {
		for (i = 0; i < list.length; i++) {
			catId.append("<option value="+list[i].category_code+">"
					+ list[i].category_name + "</option>");
		}
	}

	// 하위 카테고리를 생성하는 메소드
	function setCategory(list, catId) {
		for (i = 0; i < list.length; i++) {
			catId.append("<option value="+list[i].category_code+">"
					+ list[i].category_name + "</option>");
		}
	}

	// 코드 리스트를 불러오는 메소드
	function getProdCodeList(){
		console.log("검색버튼 작동");
		console.log($("#category_1st").val());
	$.ajax({
		url : '/code/getProdCodeList',
		type : 'post',
		dataType : 'text',
		data : {category_1st : $("#category_1st").val() ,category_2nd : $("#category_2nd").val(),
				product_code : $("#product_code").val(), product_name : $("#product_name").val(),
				vender_name : $("#vender_name").val(), usable : usable},
		success : function(result){
		let prodList = JSON.parse(result);
		console.log(prodList);
			
			for(i=0; i<prodList.length; i++){
				codeList.append("<tr>");
				codeList.append("<th scope='row'>"+prodList[i].product_code+"</th>");
				codeList.append("<td><a href='/code/prodInfo?product_code="+prodList[i].product_code+"'>"+prodList[i].product_name+"<a></td>");
				codeList.append("<td>"+prodList[i].spec+"</td>");				
				codeList.append("<td>"+prodList[i].maker_name+"</td>");				
				codeList.append("<td>"+prodList[i].vender_name+"</td>");
				codeList.append("</tr>");
			}
		}
	});
}
</script>
</body>
</html>
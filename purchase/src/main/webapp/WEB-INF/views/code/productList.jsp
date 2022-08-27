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
<%@include file="/WEB-INF/views/include/common.jsp"%>
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>

<link rel="stylesheet" href="/resources/css/defaultForm.css">

<body>

<%@include file="/WEB-INF/views/include/header.jsp"%>
<div class="body">

<h3>품목코드 목록</h3>
<div style="width: 2000px; display: block; margin: 0 auto;">
<!-- 카테고리 영역 -->
<span style="display: inline-block;">카테고리 선택</span>
<div style="display: inline-block;">
	<form id="selectCategory_1st" name="selectCategory_1st" action=""
		method="post">
		<!-- 카테고리(상) -->
		<select id="category_1st" name="category_1st">
			<option value="none" selected>대분류</option>
		</select>
	</form>
</div>
<div style="display: inline-block;">
	<form id="selectCategory_2nd" name="selectCategory_2nd" action="">
		<!-- 카테고리(하) -->
		<select id="category_2nd">
			<option value="none" selected>소분류</option>
		</select>
	</form>
</div>

<!-- 사용불가코드 조회 여부 체크박스 -->
<div style="display: inline-block; margin-left: 20px; margin-right: 20px;">
<span>사용불가코드</span>
<input type="checkbox" id="usable" name="usable" value="false">
</div>

<!-- 검색창 영역 -->
<div style="display: inline-block;">
	<form name="searchForm" id="searchForm" onsubmit="false">
	<input type="text" id="product_code" name="product_code" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="품목코드">
	<input type="text" id="product_name" name="product_name" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="품명">
	<input type="text" id="vender_name" name="vender_name" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="거래처명">
	<input type="button" id="btnSearch" name="btnSearch" value="검색">
	</form>
</div>

<!-- 코드생성버튼 -->
<div style="display: inline-block;">
	<input type="button" value="코드생성" onclick="location.href='/code/createProductCode'">
	</div>
	<div>
	</div>
</div>

<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px; width: 1400px; margin: 0 auto; margin-top: 20px">
  <thead>
    <tr>
      <th scope="vnaa" style="width: 150px;">품목코드</th>
      <th scope="" style="width: 200px">품명</th>
      <th scope="col" style="width: 400px">규격</th>
	  <th scope="col" style="width: 150px">제조사</th>
      <th scope="col" style="width: 150px">거래처</th>
    </tr>
  </thead>
  <tbody id="codeList">
  </tbody>
</table>


</div>
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
			let str = '';
			for(i=0; i<prodList.length; i++){
				str += "<tr>";
				str += "<td scope='row'>"+prodList[i].product_code+"</th>";
				str += "<td><a href='/code/prodInfo?product_code="+prodList[i].product_code+"'>"+prodList[i].product_name+"<a></td>";
				str += "<td>"+prodList[i].spec+"</td>";
				str += "<td>"+prodList[i].maker_name+"</td>";				
				str += "<td>"+prodList[i].vender_name+"</td>";
				str += "</tr>";
			}
			codeList.append(str);
		}
	});
}
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="/WEB-INF/views/include/common.jsp"%>
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>

<h3>품목코드 목록</h3><br>


<!-- 검색창 영역 -->
<div style="float: left;">
	<form name="searchForm" id="searchForm" onsubmit="false">
	<input type="text" id="product_code" name="product_code" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="품목코드">
	<input type="text" id="product_name" name="product_name" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="품명">
	<input type="text" id="vender_name" name="vender_name" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="거래처명">
	<input type="button" id="btnSearch" name="btnSearch" value="검색">
	</form>
</div>


<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
  <thead class="thead-dark">
    <tr>
      <th scope="vnaa">품목코드</th>
      <th scope="">품명</th>
      <th scope="col">규격</th>
      <th scope="col">거래처</th>
    </tr>
  </thead>
  <tbody id="codeList">
    <tr>
    </tr>
  </tbody>
</table>

<script>
	let catObj;
	let upperCat
	let lowerCat;
	let codeList = $("#codeList");
	let usable = '0';
	let selectedRow = window.opener.getSelectedRow();
	let parent_category_1st = window.opener.getCategory_1st();
	let parent_category_2nd = window.opener.getCategory_2nd();
	let req_date = window.opener.getReq_date();
	let req_page = window.opener.getReq_page();
	let totalRow = window.opener.getTotalRow();
	let mem_id = "<c:out value='${sessionScope.loginStatus.mem_id}'/>";
	let dep_code = "<c:out value='${sessionScope.loginStatus.dep_code}'/>";
	let dep_name = "<c:out value='${sessionScope.loginStatus.dep_name}'/>";
	window.opener.setCategory_2nd(parent_category_2nd);


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

	// 리스트를 불러오는 메소드(검색어 유무 상관없이)
	function getProdCodeList(){
		$.ajax({
			url : '/code/getProdCodeList',
			type : 'post',
			dataType : 'text',
			data : {category_1st : parent_category_1st ,category_2nd : parent_category_2nd,
				product_code : $("#product_code").val(), product_name : $("#product_name").val(),
				vender_name : $("#vender_name").val(), usable : usable},
			success : function(result){
			let prodList = JSON.parse(result);
			for(i=0; i<prodList.length; i++){
				var tempArr = '<tr>';
				tempArr += '<th scope="row">'+prodList[i].product_code+'</th>';
				tempArr += '<td><a href="#" onclick="setVender(\''+ prodList[i].product_name +'\',\''+ prodList[i].maker_code +'\',\''+ prodList[i].maker_name +'\',\''+ prodList[i].pak_quantity +'\',\''+ prodList[i].price +'\',\''+ prodList[i].vender_name +'\',\''+ prodList[i].vender_code +'\',\''+ prodList[i].product_code +'\',\''+ prodList[i].ex_pakaging +'\', \''+ prodList[i].spec +'\')" >'+prodList[i].product_name+'</a></td>';
				tempArr += '<td>'+prodList[i].spec+'</td>';
				tempArr += '<td>'+prodList[i].vender_name+'</td>';
				tempArr += '</tr>'
				codeList.append(tempArr);
			}
			}
		});
	}
// 코드 선택하면 팝업창 닫히는 메소드
function setVender(product_name, maker_code, maker_name, pak_quantity, price, vender_name, vender_code, product_code, ex_pakaging, spec){
	let checkOk = true;
		for(i=0; i<totalRow+1; i++){
			if($(opener.document).find("#tableBody").children('tr:eq('+i+')').find("#product_code").val() == product_code){
				alert("이미 선택한 코드입니다!");
				checkOk = false;
			}
		}
	if(checkOk){
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#product_code").val(product_code);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#product_name").val(product_name);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#spec").val(spec);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#ex_pakaging").val(ex_pakaging);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#req_date").val(req_date);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#req_page").val(req_page);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#dep_code").val(dep_code);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#dep_name").val(dep_name);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#mem_id").val(mem_id);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#vender_name").val(vender_name);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#vender_code").val(vender_code);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#pak_quantity").val(pak_quantity);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#price").val(price);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#maker_code").val(maker_code);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#maker_name").val(maker_name);
	$(opener.document).find("#tableBody").children('tr:eq('+selectedRow+')').find("#category_2nd").val(parent_category_2nd);
	window.close();
	}
	window.opener.addRow();
	return checkOk;
}
</script>
</body>
</html>
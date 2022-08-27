<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <meta name="theme-color" content="#563d7c">
<title>Insert title here</title>
<%@include file="/WEB-INF/views/include/common.jsp" %>
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>

</head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
  <title>Test</title>

<link rel="stylesheet" href="/resources/css/defaultForm.css">

<!-- bootstrap 4.6, jquery, .. -->
<link  href="/resources/calendar/css/bootstrap.min.css" rel="stylesheet">

   <!-- datetimepicker3 -->
<script src="/resources/calendar/js/moment-with-locales.min.js"></script>
<script src="/resources/calendar/js/bootstrap-datetimepicker.min.js"></script>
<link  href="/resources/calendar/css/bootstrap-datetimepicker.min.css" rel="stylesheet">

   <!-- font-awesome icon -->
<link  href="/resources/calendar/css/fontawesome-all.css" rel="stylesheet">

   <!-- 사용자 css -->
<link  href="/resources/calendar/css/my.css" rel="stylesheet">

<script>
let rowCount = 0;
let rowVal = 0;
let selectedRow = 0;
let category_2nd_value = 0;

// 팝업 검색창에 값을 념겨주는 메소드
function getSelectedRow(){return selectedRow;}
function getCategory_1st(){let val = $("#category_1st").val(); return val;}
function getCategory_2nd(){let val = $("#category_2nd").val(); return val;}
function getReq_date(){let val = $("#selectDate").val(); return val;}
function getReq_page(){let val = $("#select_page").val(); return val;}
function getTotalRow(){return rowCount;}
function setCategory_2nd(value){value = category_2nd_value;}
function getDate(){return $("#selectDate").val();}
function getPage(){return $("#select_page").val();}


let delReq_orderList = [];

// 달력 메소드
$(function() {
	$("#calendar") .datetimepicker({ 
		locale: "ko",
		format: "YYYY-MM-DD",
		defaultDate: moment()
	});
	$("#calendar") .on("dp.change", function (e) {

	});
});

// 체크박스 전체를 체크하는 메소드
function selectAll(selectAll)  {
  const checkboxes 
       = document.getElementsByName('selectRow');
  
  checkboxes.forEach((checkbox) => {
    checkbox.checked = selectAll.checked;
  })
}


// 행추가 메소드
function addRow(){
	let rowStr = "<tr>";
		rowStr += "<td><input type='checkbox' id='selectRow' name='selectRow'></td>";
		rowStr += "<td>"+(rowCount+1)+"</td>";
		rowStr += "<td colspan='2'><input readonly id='product_code' name='req_ordersList["+rowCount+"].product_code' onkeypress='javascript:if(event.keyCode==13) {addRow();}' size='10' type='text' value=''></td>";
		rowStr += "<td><input type='image' id='btnCodeSearch' name='btnCodeSearch' src='/resources/image/searchIcon.png' onclick='return false;'></td>"
		rowStr += "<td><input id='product_name' name='req_ordersList["+rowCount+"].product_name' readonly style='border: none;'></td>";
		rowStr += "<td><input id='spec' name='req_ordersList["+rowCount+"].spec' readonly style='border: none;'></td>";
		rowStr += "<td><input id='maker_name' name='req_ordersList["+rowCount+"].maker_name' readonly style='border: none;'></td>";
		rowStr += "<td><input size='5px;' id='ex_pakaging' name='req_ordersList["+rowCount+"].ex_pakaging' readonly style='border: none;'></td>";
		rowStr += "<td><input size='3px;' id='req_quantity' name='req_ordersList["+rowCount+"].req_quantity'></td>";
		rowStr += "<td><input type='text'size='30px;' id='description' name='req_ordersList["+rowCount+"].description'></td>";
		rowStr += "<td hidden><input id='vender_code' name='req_ordersList["+rowCount+"].vender_code' readonly ></td>";
		rowStr += "<td hidden><input type='checkbox' id='approval' name='req_ordersList["+rowCount+"].approval' onClick='return false;' ></td>";
		rowStr += "<td hidden><input type='checkbox' id='req_reject' name='req_ordersList["+rowCount+"].req_reject'onClick='return false;' ></td>";
		rowStr += "<td hidden><input type='text' id='req_page' name='req_ordersList["+rowCount+"].req_page'></td>";
		rowStr += "<td hidden><input type='text' id='req_date' name='req_ordersList["+rowCount+"].req_date'></td>";
		rowStr += "<td hidden><input type='text' id='dep_code' name='req_ordersList["+rowCount+"].dep_code'></td>";
		rowStr += "<td hidden><input type='text' id='mem_id' name='req_ordersList["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input type='text' id='vender_name' name='req_ordersList["+rowCount+"].vender_name'></td>"
		rowStr += "<td hidden><input type='number' id='pak_quantity' name='req_ordersList["+rowCount+"].pak_quantity'></td>"
		rowStr += "<td hidden><input type='number' id='price' name='req_ordersList["+rowCount+"].price'></td>"
		rowStr += "<td hidden><input type='text' id='dep_name' name='req_ordersList["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input id='maker_code' name='req_ordersList["+rowCount+"].maker_code' readonly></td>";
		rowStr += "<td hidden><input id='category_2nd' name='req_ordersList["+rowCount+"].category_2nd' readonly></td>";
		rowStr += "<td hidden><input id='req_no' name='req_ordersList["+rowCount+"].req_no' readonly></td>";
		rowStr += "</tr>"
		rowCount += 1;
	$("#tableBody").append(rowStr);

}
// 행 삭제 메소드
function delRow(){
	$("input:checkbox[name='selectRow']:checked").each(function(k,kVal){
			let a = $(this).parent().parent();
		//let a = kVal.parentElement.parentElement;
			if(a.find("td:eq(10)").find("#approval").is(':checked') || a.find("td:eq(11)").find("#req_reject").is(':checked')){
				alert("승인 또는 반려된 항목은 삭제할 수 없습니다.");
			}else{
				alert(a.find("td:eq(24)").find("#req_no").val());
			$(a).remove();
			delReq_orderList.push(a.find("td:eq(24)").find("#req_no").val());
			}
	});
	$("#selectall").prop("checked", false);
	rowCount = document.getElementById("tableBody").childNodes.length;
	}

// 페이지 로딩시 상위 카테고리를 불러오는 메소드
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

// 카테고리 선택 이전에 검색버튼 클릭시
$(function(){
	$("#tableBody").on("click", "input[name='btnCodeSearch']", function(){
		selectedRow = $(this).parent().parent().index();
		if($("#category_2nd").val() == 'none'){
			alert("분류를 골라주세요!");
			return false;
		}
		window.open("/request/productSearchPopup","productSearchPopup","width=600, height=450, top=150, left=200");
	});
});

// 페이지 설정하는 메소드
function getNewPage(){
	$.ajax({
			url : '/request/getNewPage',
			type : "post",
			dataType : 'text',
			data : {
				category_2nd : $("#category_2nd").val(),
				req_date : $("#selectDate").val(),
				dep_code : <c:out value="${sessionScope.loginStatus.dep_code}"/>
			},
			success : function(result) {
				if(result == ''){result = 0;}
				let newPage = parseInt(result);
				newPage += 1;
				$("#select_page").val(newPage);
			}
		})
}



$(document).ready(function() {
	getUpperCat();

	addRow();

	// 하위 카테고리를 고르면 테이블을 초기화시키는 메소드
	$("#category_2nd").change(function() {
		getNewPage();
		$("#tableBody").empty();
		rowCount = 0;
		addRow();
	});

	$("#calendar") .on("dp.change", function() {
		if($("#category_2nd").val() != 'none'){
			getNewPage();
		}
	});

    //테이블의 tbody를 클릭하면 selected로 클래스를 토글(클로즈업)
    $('#tableBody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });

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

	//저장버튼 클릭시 유효성검사
	$("#send").on("click", function(){
		$("#send").removeAttr();
		let pass = true;
		let passCount = 0;
		for(i=0; i<rowCount; i++){
			if($("#product_code:eq("+i+")").val().length == 0){
				passCount += 1;
			}
			if(($("#req_quantity:eq("+i+")").val().length == 0)||($("#req_quantity:eq("+i+")").val() == 0)){
				alert("수량을 입력하지 않은 품목이 있습니다!");
				return false;
			}
		}

		if(passCount == (rowCount)){
			alert("입력된 데이터가 없습니다!");
			return false;
		}else{
			$("#send").submit();
		}
	});

});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<h3>청구서 작성</h3>
<!-- 상단 폼 -->
<div style="text-align: left; float: left;">
<form name="calendarForm" method="post" action="/request/requestOrder">
<div class="row" style="display: inline-block;">
	<div class="col">
		<!-- 카테고리 영역 -->
<div style="float: left;">
	<!-- 카테고리(상) -->
	<select id="category_1st" name="category_1st">
		<option value="none" selected>대분류</option>
	</select>
</div>
<div style="float: left;">
	<!-- 카테고리(하) -->
	<select id="category_2nd">
		<option value="none" selected>소분류</option>
	</select>
</div>
	<div class="form-inline">
		<div class="input-group input-group-sm date" id="calendar">
			<div class="input-group-prepend">
				<span class="input-group-text">날짜</span>
			</div>
			<input type="text" name="selectDate" id="selectDate" value="" class="form-control form-control-sm" size="9"
				onkeydown="if (event.keyCode == 13) {}">
			<div class="input-group-append">
				<span class="input-group-text">
					<div class="input-group-addon"><i class="far fa-calendar-alt fa-lg"></i></div>
				</span>
			</div>
		</div>
			<div style="display: inline-block;">
				<input type="number" id="select_page" name="select_page" min="1" max="9999" value="1" readonly>
			</div>		
		</div>
	</div>	
</div>
</form>
<input type="button" id="btnDelRow" name="btnDelRow" value="행추가" onclick="addRow();">
<input type="button" id="btnDelRow" name="btnDelRow" value="행삭제" onclick="delRow();">
</div>

<div style="display: block;">
<form id="req_orderList" name="req_orderList" method="post" action="/request/req_orderInsert">

		<table class="table table-bordered table-hover" id="table_id">
			<thead style="background-color: rgb(148, 146, 146);">
				<tr>
					<th><input type="checkbox" value="selectall" name="selectall" id="selectall" onclick="selectAll(this)"></th>
					<th>#</th>
					<th colspan="2">품목코드</th>
					<th></th>
					<th>품명</th>
					<th>규격</th>
					<th>제조사</th>
					<th>단위</th>
					<th>수량</th>
					<th hidden>청구부서코드</th>
					<th>비고</th>
				</tr>
			</thead>
			<input type="submit" id="send" name="send" value="저장" style="float: left;">
			<tbody class="tableBody" id="tableBody">
			</tbody>
		</table>
</form>
</div>
  </div> 
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
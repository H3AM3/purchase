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
<link rel="stylesheet" href="/resources/css/defaultForm.css">



<script>
let rowCount = 0;
let rowVal = 0;
let selectedRow = 0;
let category_2nd_value = 0;

// 팝업 검색창에 값을 념겨주는 메소드
function getCategory_2nd(){return $("#category_2nd").val();}
function setRowCount(number){rowCount = number;}
function emptyTableBody(){$("#tableBody").empty();}
function getImport_date(){return $("#selectDate").val()}
function setShowDep_name(name){$("#showDep_name").val(name)}
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
		rowStr += "<td colspan='2'><input readonly id='product_code' name='tbl_export["+rowCount+"].product_code' onkeypress='javascript:if(event.keyCode==13) {addRow();}' size='10' type='text' value='' style='border: none;'></td>";
		rowStr += "<td><input readonly id='product_name' name='tbl_export["+rowCount+"].product_name' style='border: none;'></td>";
		rowStr += "<td><input readonly id='spec' name='tbl_export["+rowCount+"].spec' style='border: none;'></td>";
		rowStr += "<td><input readonly id='maker_name' name='tbl_export["+rowCount+"].maker_name' style='border: none;'></td>";
		rowStr += "<td><input readonly size='5px;' id='ex_pakaging' name='tbl_export["+rowCount+"].ex_pakaging' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='req_quantity' name='req_quantity' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='unimported_qty' name='unimported_qty' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='stock_quantity' name='stock_quantity' style='border: none;'></td>";
		rowStr += "<td><input size='3px;' id='ex_quantity' name='tbl_export["+rowCount+"].ex_quantity' style='border: none;'></td>";
		rowStr += "<td><input readonly type='text'size='30px;' id='description' name='tbl_export["+rowCount+"].description' style='border: none;'></td>";
		

		rowStr += "<td hidden><input type='checkbox' id='mk_order' name='mk_order' onClick='return false;'></td>";
		rowStr += "<td hidden><input type='checkbox' id='req_reject' name='req_reject'></td>";
		rowStr += "<td hidden><input type='checkbox' id='approval' name='approval'></td>";
		rowStr += "<td hidden><input readonly id='vender_code' name='vender_code'></td>";
		rowStr += "<td hidden><input type='text' id='req_page' name='tbl_export["+rowCount+"].export_page'></td>";
		rowStr += "<td hidden><input type='text' id='req_date' name='tbl_export["+rowCount+"].export_date'></td>";
		rowStr += "<td hidden><input type='text' id='dep_code' name='tbl_export["+rowCount+"].dep_code'></td>";
		rowStr += "<td hidden><input type='text' id='mem_id' name='tbl_export["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input type='text' id='vender_name' name='vender_name'></td>"
		rowStr += "<td hidden><input type='number' id='pak_quantity' name='pak_quantity'></td>"
		rowStr += "<td hidden><input type='text' id='dep_name' name='tbl_export["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input readonly id='maker_code' name='tbl_export["+rowCount+"].maker_code'></td>";
		rowStr += "<td hidden><input readonly id='category_2nd' name='tbl_export["+rowCount+"].category_2nd'></td>";
		rowStr += "<td hidden><input readonly id='req_no' name='tbl_export["+rowCount+"].req_no'></td>";
		rowStr += "<td hidden><input readonly id='end_request' name='end_request'></td>";
		rowStr += "</tr>"
		rowCount += 1;
	$("#tableBody").append(rowStr);

}

// 행 삭제 메소드
function delRow(){
	$("input:checkbox[name='selectRow']:checked").each(function(k,kVal){
			let a = $(this).parent().parent();
			$(a).remove();
			delReq_orderList.push(a.find("td:eq(24)").find("#req_no").val());
			// }
	});
	$("#selectall").prop("checked", false);
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


// 미입고내역 검색
function searchReq_order(){
	if($("#category_2nd").val() == 'none'){
		alert("하위 카테고리를 선택해주세요.");
		return false;
	} else{
	window.open("/export/searchReq_order","searchReq_order","width=1200, height=900, top=150, left=200");
	}
}

// 체크박스 전체를 체크하는 메소드
function selectAll(selectAll)  {
  const checkboxes 
       = document.getElementsByName('selectRow');
  
  checkboxes.forEach((checkbox) => {
    checkbox.checked = selectAll.checked;
  })
}

// 입고수량 기본값 세팅(자식창에서 내용 불러올 때 실행됨)
function changeEx_quantity(){
	for(let i=0; i<rowCount; i++){
		$.ajax({
			url : '/export/getStockQty',
				type : "post",
				dataType : 'text',
				data : {product_code : $("#tableBody").children('tr:eq('+i+')').find("#product_code").val()},
				async : false,
				success : function(result) {
						Number(result);
						$("#tableBody").children('tr:eq('+i+')').find("#stock_quantity").val(result);
						let unimported_qty = $("#tableBody").children('tr:eq('+i+')').find("#unimported_qty").val();
						let stock_quantity = $("#tableBody").children('tr:eq('+i+')').find("#stock_quantity").val();
						if(!unimported_qty >= stock_quantity){
							$("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val(stock_quantity);
						}
						if(!unimported_qty < stock_quantity){
							$("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val(unimported_qty);
						}
					
				}
		})
	}
}

let pageData = 1;
// 페이지값 가져와서 행에 적용하는 메소드(자식창에서 내용 불러올 때 실행됨)
function getNewPage(){
	let date = $("#selectDate").val().replace(' 00:00:00', '');
	$.ajax({
		url : '/export/getNewExportPage',
			type : "post",
			dataType : 'text',
			data : {category_2nd : $("#category_2nd").val(), export_date : $("#selectDate").val()},
			async : false,
			success : function(result) {
				if(pageData = ''){
					pageData = 1;
				}else{pageData = Number(result)+1;}
				$("#select_page").val(pageData);
				for(let i=0; i<rowCount; i++){
					$("#tableBody").children('tr:eq('+i+')').find("#req_page").val(pageData);
					$("#tableBody").children('tr:eq('+i+')').find("#req_date").val(date)
				}
			}
	})
}



//저장버튼 클릭시 유효성검사
function submitCheck(){
	let pass = true;
	for(let i=0; i<rowCount; i++){
		let unimported_qty = $("#tableBody").children('tr:eq('+i+')').find("#unimported_qty").val();
		let stock_quantity = $("#tableBody").children('tr:eq('+i+')').find("#stock_quantity").val();
		let ex_quantity = $("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
		if(ex_quantity > unimported_qty){
			alert("["+$("#tableBody").children('tr:eq('+i+')').find("#product_name").val()+"]의 출고수량이 미입고 수량보다 많습니다.");
			pass = false;
		}
		if(!ex_quantity > stock_quantity){
			alert("["+$("#tableBody").children('tr:eq('+i+')').find("#product_name").val()+"]의 재고가 부족합니다.");
			pass = false;
		}
	}
	return pass;
}


$(document).ready(function() {
	getUpperCat();
	addRow();

	// 하위 카테고리를 고르면 테이블을 초기화시키는 메소드
	$("#category_2nd").change(function() {
		$("#tableBody").empty();
		rowCount = 0;
		addRow();
	});

	$("#calendar") .on("dp.change", function() {
		if($("#category_2nd").val() != 'none'){
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


});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<!-- 상단 폼 -->
<h3>출고내역 작성</h3>
<div style="text-align: left;">
<form name="calendarForm">
<div style="display: block;">

<div style="display: inline-block;">
	<!-- 카테고리(상) -->
	<select id="category_1st" name="category_1st">
		<option value="none" selected>대분류</option>
	</select>
	<!-- 카테고리(하) -->
	<select id="category_2nd">
		<option value="none" selected>소분류</option>
	</select>
</div>
<div style="display: inline-block; margin-right: 5px;">
	<div class="input-group-prepend">
		<span class="input-group-text">부서</span>
		<input type="text" id="showDep_name" name="showDep_name" value="" readonly class="form-control">
	</div>
</div>
<div style="display: inline-block;">
	<div class="form-inline">
		<div class="input-group date" id="calendar">
			<div class="input-group-prepend">
				<span class="input-group-text">날짜</span>
			</div>
			<input type="text" name="selectDate" id="selectDate" value="" class="form-control" size="9"
				onkeydown="if (event.keyCode == 13) {}">
			<div class="input-group-append">
				<span class="input-group-text">
					<div class="input-group-addon"><i class="far fa-calendar-alt fa-lg"></i></div>
				</span>
			</div>
		</div>
</div>
		</div>
			<div style="display: inline-block; margin-right: 5px;">
				<div class="input-group-prepend">
					<span class="input-group-text">페이지</span>
					<input type="number" id="select_page" name="select_page" min="1" max="9999" value="1" readonly class="form-control">
				</div>
			</div>			
<input type="button" id="btnSearchWatingImports" name="btnSearchWatingImports" value="청구서 조회" onclick="searchReq_order()">
</div>
</form>
</div>

<div style="text-align: left;">
<input type="button" id="btnDelRow" name="btnDelRow" value="행추가" onclick="addRow();">
<input type="button" id="btnDelRow" name="btnDelRow" value="행삭제" onclick="delRow();">
</div>


<form id="importListForm" name="importListForm" method="post" action="/export/insertExport" onsubmit="return submitCheck()" style="display: block; margin-top: 10px">
	<table class="table table-bordered table-hover" id="table_id">
		<thead style="background-color: rgb(148, 146, 146);">
			<tr>
				<th><input type="checkbox" value="selectall" name="selectall" id="selectall" onclick="selectAll(this)"></th>
				<th>#</th>
				<th>품목코드</th>
				<th colspan="2">품명</th>
				<th>규격</th>
				<th>제조사</th>
				<th>단위</th>
				<th>청구수량</th>
				<th>미출고<br>수량</th>
				<th>재고<br>수량</th>
				<th>출고<br>수량</th>
				<th>비고</th>
			</tr>
		</thead>
		<input type="submit" id="send" name="send" value="저장" style="float: left;">
		<tbody class="tableBody" id="tableBody">
		</tbody>
	</table>
</form>

</div> 
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
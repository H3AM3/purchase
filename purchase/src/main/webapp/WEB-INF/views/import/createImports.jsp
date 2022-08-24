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

    <style>


body {
    background-color: #F1F4F5;
}

.card-body {
    padding: 0rem 1.25rem;
}
       
.tableBody tr td {
	padding: 0;
	font-size: 15px;
} 

</style>
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
function getCategory_2nd(){return $("#category_2nd").val();}
function setRowCount(number){rowCount = number;}
function emptyTableBody(){$("#tableBody").empty();}
function getImport_date(){return $("#selectDate").val()}
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

// 입고수량 변경시 입고금액도 변경되는 메소드
function checkIm_quantity(event){
	let order_im_qty = $(event).val();
	let price = $(event).parent().parent().children('td:eq(10)').find("#price").val();
	$(event).parent().parent().children('td:eq(11)').find("#im_price").val(order_im_qty * price);
}


// 행추가 메소드
function addRow(){
	let rowStr = "<tr>";
		rowStr += "<td><input type='checkbox' id='selectRow' name='selectRow'></td>";
		rowStr += "<td>"+(rowCount+1)+"</td>";
		rowStr += "<td colspan='2'><input readonly size='12px' id='product_code' name='tbl_importVO["+rowCount+"].product_code' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='16px' id='product_name' name='tbl_importVO["+rowCount+"].product_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='12px' id='spec' name='tbl_importVO["+rowCount+"].spec' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='4px' id='vender_name' name='tbl_importVO["+rowCount+"].vender_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='8px' type='text' id='ex_pakaging' name='tbl_importVO["+rowCount+"].ex_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 100px; border: none;' type='number' id='waiting_qty' name='waiting_qty' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input style='width: 100px; border: none;' type='number' min=0 id='order_im_qty' name='tbl_importVO["+rowCount+"].ex_quantity' onchange='checkIm_quantity(this)' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 100px; border: none;' type='number' id='order_noneIm_qty' name='order_noneIm_qty' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 70px; border: none; type='number' id='price' name='tbl_importVO["+rowCount+"].price' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 70px; border: none; background-color: WhiteSmoke;' type='number' id='im_price' name='im_price'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input style='border: none;' type='text' id='order_description' name='tbl_importVO["+rowCount+"].description'></td>"
		
		rowStr += "<td hidden><input size='4px;' id='import_date' name='tbl_importVO["+rowCount+"].import_date' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input size='4px;' id='waiting_num' name='tbl_importVO["+rowCount+"].waiting_num' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input id='import_page' name='tbl_importVO["+rowCount+"].import_page'></td>"
		rowStr += "<td hidden><input id='mem_id' name='tbl_importVO["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input id='vender_code' name='tbl_importVO["+rowCount+"].vender_code'></td>";
		rowStr += "<td hidden><input style='width: 90px; border: none;' type='number' id='pak_quantity' name='tbl_importVO["+rowCount+"].pak_quantity' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td hidden><input size='8px' id='category_2nd' name='tbl_importVO["+rowCount+"].category_2nd' type='text' value='' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input style='width: 100px; border: none;' type='number' id='order_num' name='tbl_importVO["+rowCount+"].order_num' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowCount += 1;
	$("#tableBody").append(rowStr);

}

// 행 삭제 메소드
function delRow(){
	$("input:checkbox[name='selectRow']:checked").each(function(k,kVal){
			let a = $(this).parent().parent();
		// //let a = kVal.parentElement.parentElement;
		// 	if(a.find("td:eq(10)").find("#approval").is(':checked') || a.find("td:eq(11)").find("#req_reject").is(':checked')){
		// 		alert("승인 또는 반려된 항목은 삭제할 수 없습니다.");
		// 	}else{
		// 		alert(a.find("td:eq(24)").find("#req_no").val());
			$(a).remove();
			delReq_orderList.push(a.find("td:eq(24)").find("#req_no").val());
			// }
	});
	$("#selectall").prop("checked", false);
	// rowCount = document.getElementById("tableBody").childNodes.length;
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
function searchWatingImports(){
	if($("#category_2nd").val() == 'none'){
		alert("하위 카테고리를 선택해주세요.");
		return false;
	} else{
	window.open("/import/searchWaiting","searchWaiting","width=1200, height=900, top=150, left=200");
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
function changeIm_quantity(){
	for(let i=0; i<rowCount; i++){
		let order_im_qty = $("#tableBody").children('tr:eq('+i+')').find("#order_im_qty").val();
		let order_noneIm_qty = $("#tableBody").children('tr:eq('+i+')').find("#order_noneIm_qty").val();
		$("#tableBody").children('tr:eq('+i+')').find("#order_im_qty").val(order_noneIm_qty);
		checkIm_quantity($("#tableBody").children('tr:eq('+i+')').find("#order_im_qty"));
	}

}

let pageData = 1;
// 페이지값 가져와서 행에 적용하는 메소드(자식창에서 내용 불러올 때 실행됨)
function getNewPage(){
	$.ajax({
		url : '/import/getNewImportPage',
			type : "post",
			dataType : 'text',
			data : {category_2nd : $("#category_2nd").val(), import_date : $("#selectDate").val()},
			async : false,
			success : function(result) {
				if(pageData = ''){
					pageData = 1;
				}else{pageData = Number(result)+1;}
				$("#select_page").val(pageData);
				for(let i=0; i<rowCount; i++){
					$("#tableBody").children('tr:eq('+i+')').find("#order_page").val(pageData);
				}
			}
	})
}



//저장버튼 클릭시 유효성검사
function submitCheck(){
	let pass = true;
	for(let i=0; i<rowCount; i++){
		let order_noneIm_qty = $("#tableBody").children('tr:eq('+i+')').find("#order_noneIm_qty").val();
		let order_im_qty = $("#tableBody").children('tr:eq('+i+')').find("#order_im_qty").val();
		if(order_im_qty > order_noneIm_qty){
			alert("["+$("#tableBody").children('tr:eq('+i+')').find("#product_name").val()+"]의 입고수량이 미입고 수량보다 많습니다.")
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
<!-- 상단 폼 -->
<div class="card-body">
<h3>입고내역 작성</h3>
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
				<input type="button" id="btnSearchWatingImports" name="btnSearchWatingImports" value="미입고내역" onclick="searchWatingImports()">
			</div>
				
		</div>
	</div>	
</div>
</form>
<input type="button" id="btnDelRow" name="btnDelRow" value="행추가" onclick="addRow();">
<input type="button" id="btnDelRow" name="btnDelRow" value="행삭제" onclick="delRow();">
</div>

<div>
<br>
</div>
<form id="importListForm" name="importListForm" method="post" action="/import/insertImport" onsubmit="return submitCheck()">
	<div class="col-md-12">
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
					<th>발주수량</th>
					<th>입고수량</th>
					<th>미입고 수량</th>
					<th>단가</th>
					<th>입고금액</th>
					<th>비고</th>
				</tr>
			</thead>
			<input type="submit" id="send" name="send" value="저장">
			<tbody class="tableBody" id="tableBody">
			</tbody>
		</table>
	</div>
</form>

   
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
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
let noCategory = 'noCategory';
let delListCount = 0;
let req_noList = [];
let req_prodCodeList = [];10
let select_page = 0;

$(function() {
	$("#calendar") .datetimepicker({ 
		locale: "ko",
		format: "YYYY-MM-DD",
		defaultDate: moment()
	});
	$("#calendar") .on("dp.change", function (e) {
		if($("#category_2nd").val() != 'none'){
			getNewPage();
		}
	});
});

//저장버튼 클릭시 유효성검사
function sendList(){
	let pass = true;
		for(i=0; i<rowCount; i++){
		if($("#tableBody").children("tr:eq("+i+")").find("#mk_order").is(":checked")){
			if((!$("#tableBody").children("tr:eq("+i+")").find("#approval").is(":checked")) || ($("#tableBody").children("tr:eq("+i+")").find("#req_reject").is(":checked"))){
				alert("이미 발주한 품목은 승인취소/반려할 수 없습니다.");
				pass = false;
			}
		}
		if(!($("#tableBody").children("tr:eq("+i+")").find("#mk_order").is(":checked"))){
			if(($("#tableBody").children("tr:eq("+i+")").find("#approval").is(":checked")) && ($("#tableBody").children("tr:eq("+i+")").find("#req_reject").is(":checked"))){
				alert("승인취소/반려 중복된 항목이 있습니다.");
				pass = false;
			}
		}
	}
	return pass;
}


// 페이지 설정하는 메소드
function getNewPage(){
	$.ajax({
			url : '/order/getNewOrderPage',
			type : "post",
			dataType : 'text',
			async : false,
			data : {
				category_2nd : '${defaultData.category_2nd}',
				order_date : $("#selectDate").val(),
				dep_code : <c:out value="${sessionScope.loginStatus.dep_code}"/>,
				vender_code : '${defaultData.vender_code}'
			},
			success : function(result) {
				if(result == ''){result = 0;}
				let newPage = parseInt(result);
				newPage += 1;
				$("#select_page").val(newPage);
				select_page = newPage;
			}
		})
}

// 행추가 메소드
function addRow(){
	let rowStr = "<tr>";
		rowStr += "<td>"+(rowCount+1)+"</td>";
		rowStr += "<td><input readonly size='8px' id='product_code' name='tbl_orderVO["+rowCount+"].product_code' onkeypress='javascript:if(event.keyCode==13) {addRow();}' type='text' value=''  style='border: none;'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='12px' id='product_name' name='tbl_orderVO["+rowCount+"].product_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='16px' id='spec' name='tbl_orderVO["+rowCount+"].spec' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='10px' id='maker_name' name='tbl_orderVO["+rowCount+"].maker_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='3px;' id='ex_pakaging' name='tbl_orderVO["+rowCount+"].ex_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='4px;' id='ex_quantity' name='tbl_orderVO["+rowCount+"].ex_quantity' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='4px;' id='stock_quantity' name='stock_quantity' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";

		rowStr += "<td><input readonly size='4px' id='im_pakaging' name='tbl_orderVO["+rowCount+"].im_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";

		rowStr += "<td><input style='width: 70px; border: none; background-color: WhiteSmoke;' type='number' id='im_quantity' name='tbl_orderVO["+rowCount+"].im_quantity' onchange='checkIm_quantity(this)' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 70px; border: none;' type='number' id='im_quantityToEx' name='im_quantityToEx' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 70px; border: none; type='number' id='im_price' name='tbl_orderVO["+rowCount+"].im_price' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 60px; border: none;' type='number' id='pak_quantity' name='tbl_orderVO["+rowCount+"].pak_quantity' onkeydown='if(event.keyCode == 13) return false'></td>"

		rowStr += "<td><input readonly style='width: 90px; border: none;' type='number' id='price' name='tbl_orderVO["+rowCount+"].price' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 100px; border: none;' type='number' id='totalPrice' name='tbl_orderVO["+rowCount+"].totalPrice' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly size='8px' type='checkbox' id='mk_order' name='tbl_orderVO["+rowCount+"].mk_order' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input type='text'size='30px;' id='description' name='tbl_orderVO["+rowCount+"].description' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";

		rowStr += "<td hidden><input id='vender_code' name='tbl_orderVO["+rowCount+"].vender_code'></td>";
		rowStr += "<td hidden><input type='text' id='vender_name' name='tbl_orderVO["+rowCount+"].vender_name'></td>"
		rowStr += "<td hidden><input type='text' id='dep_name' name='tbl_orderVO["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input id='maker_code' name='tbl_orderVO["+rowCount+"].maker_code'></td>";
		rowStr += "<td hidden><input id='category_2nd' name='tbl_orderVO["+rowCount+"].category_2nd' value='${defaultData.category_2nd}'></td>";
		rowStr += "<td hidden><input id='order_date' name='tbl_orderVO["+rowCount+"].order_date'></td>"
		rowStr += "<td hidden><input id='order_page' name='tbl_orderVO["+rowCount+"].order_page'></td>"
		rowStr += "<td hidden><input id='mem_id' name='tbl_orderVO["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input id='dep_code' name='tbl_orderVO["+rowCount+"].dep_code'></td>"
		rowStr += "</tr>"
		rowCount += 1;
	$("#tableBody").append(rowStr);

}

// 집계에 사용한 req_no리스트 불러오기
function getReq_no(){
	$.ajax({
			url : '/order/getReq_no',
			type : "post",
			dataType : 'text',
			data : {selectDate1 : '${defaultData.selectDate1}', selectDate2 : '${defaultData.selectDate2}',
					vender_code : '${defaultData.vender_code}', category_2nd : '${defaultData.category_2nd}',
					approval : '${defaultData.approval}', mk_order : '${defaultData.mk_order}'},
			async : false,
			success : function(result) {
				let data = JSON.parse(result);
				for(let i=0; i<data.length; i++){
					req_noList[i] = data[i].req_no;
					req_prodCodeList[i] = data[i].product_code;
				}
			}
		});
}

// 요청내역 불러오는 메소드
function createOrderList(){
	$.ajax({
		url : '/order/createOrderList',
		type : "post",
		dataType : 'text',
		data : {selectDate1 : '${defaultData.selectDate1}', selectDate2 : '${defaultData.selectDate2}',
                vender_code : '${defaultData.vender_code}', category_2nd : '${defaultData.category_2nd}',
				approval : '${defaultData.approval}', mk_order : '${defaultData.mk_order}'},
		async : false,
		success : function(result) {
			let data = JSON.parse(result);
			let strArr = '';
            for(let i=0; i<data.length; i++){
				addRow();
				// 행 데이터삽입, (예시로 2개만 남겨놓음) 
				$("#tableBody").children('tr:eq('+i+')').find("#product_code").val(data[i].product_code);
				$("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val(data[i].req_quantity);

				if(data[i].approval == '1'){
					$("#tableBody").children('tr:eq('+i+')').find("#approval").attr("checked", true);
				}
            }
		}
	});
	// 불러온 품목코드로 품목코드의 나머지 데이터 불러오기
	for(let i=0; i<rowCount; i++){
		let product_code = $("#tableBody").children('tr:eq('+i+')').find("#product_code").val();
		$.ajax({
			url : '/order/OrderListProdData',
			type : "post",
			dataType : 'text',
			data : {product_code : product_code},
			async : false,
			success : function(result) {
				let data = JSON.parse(result);
				$("#tableBody").children('tr:eq('+i+')').find("#product_name").val(data.product_name);
				$("#tableBody").children('tr:eq('+i+')').find("#spec").val(data.spec);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_name").val(data.maker_name);
				$("#tableBody").children('tr:eq('+i+')').find("#im_pakaging").val(data.im_pakaging);
				// 출고단가
				$("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val(data.pak_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val(data.ex_pakaging);
				$("#tableBody").children('tr:eq('+i+')').find("#price").val(data.price);
				//총 금액
				$("#tableBody").children('tr:eq('+i+')').find("#description").val(data.description);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_code").val(data.vender_code);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_name").val(data.vender_name);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_code").val(data.dep_code);
				$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val(data.mem_id);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_name").val('${sessionScope.loginStatus.dep_name}');
				$("#tableBody").children('tr:eq('+i+')').find("#maker_code").val(data.maker_code);
				$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data.category_2nd);
				$("#tableBody").children('tr:eq('+i+')').find("#order_date").val($('#selectDate').val());
				$("#tableBody").children('tr:eq('+i+')').find("#order_page").val($('#select_page').val());
				$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val('${sessionScope.loginStatus.mem_id}');
				$("#tableBody").children('tr:eq('+i+')').find("#dep_code").val('${sessionScope.loginStatus.dep_code}');
				
			}
		});
	}
	// 발주수량, 발주단위, 총 금액 계산
	for(let i=0; i<rowCount; i++){
		// 출고단위
		let ex_quantity = $("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
		// 출고단위 기준 단가
		let price = $("#tableBody").children('tr:eq('+i+')').find("#price").val();
		// 총 금액
		let totalPrice = $("#tableBody").children('tr:eq('+i+')').find("#totalPrice");
		// 포장수량
		let pak_quantity = $("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val();

		$("#tableBody").children('tr:eq('+i+')').find("#im_price").val(pak_quantity * price);
	}
	for(let i=0; i<rowCount; i++){
	let product_code = $("#tableBody").children('tr:eq('+i+')').find("#product_code").val();
	$.ajax({
		url : '/order/getStock',
			type : "post",
			dataType : 'text',
			data : {product_code : product_code},
			async : false,
			success : function(result){
				let data = JSON.parse(result);
				let pak_quantity = $("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val();
				let ex_quantity =  $("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
					let stockQuantity = Math.floor(data/pak_quantity);
					let im_quantityVal = (Math.ceil(ex_quantity/pak_quantity))-stockQuantity;
					if(im_quantityVal <1){
						im_quantityVal = 1;
					}
					$("#tableBody").children('tr:eq('+i+')').find("#im_quantity").val(im_quantityVal);
					$("#tableBody").children('tr:eq('+i+')').find("#stock_quantity").val(result);
					checkIm_quantity($("#tableBody").children('tr:eq('+i+')').find("#im_quantity"));
			}
		})
	}
	
}
// 구매수량 변경시 금액 변경되는 메소드
function checkIm_quantity(event){
	let im_quantity = $(event);
	let totalPrice = $(event).parent().parent().children('td:eq(14)').find("#totalPrice");
	let pak_quantity = $(event).parent().parent().children('td:eq(12)').find("#pak_quantity");
	let im_price = $(event).parent().parent().children('td:eq(11)').find("#im_price");
	let im_quantityToEx = $(event).parent().parent().children('td:eq(10)').find("#im_quantityToEx");
	totalPrice.val(im_quantity.val() * im_price.val());
	im_quantityToEx.val(im_quantity.val() * pak_quantity.val());
}

// 저장시 유효성 체크 및 전송
function sendSync(){
	for(let i=0; i<rowCount; i++){
		// 발주서의 발주수량(출고단위)을 환산수량에 맞게 수정하는 부분
		let im_quantityToEx = $("#tableBody").children('tr:eq('+i+')').find("#im_quantityToEx").val();
		$("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val(im_quantityToEx);

		$("#tableBody").children('tr:eq('+i+')').find("#order_date").val($('#selectDate').val());
		if($("#tableBody").children('tr:eq('+i+')').find("#mk_order").is(":checked")){
			for(let k=0; k<req_noList.length; k++){
				if(req_prodCodeList[k] == $("#tableBody").children('tr:eq('+i+')').find("#product_code").val()){
					$.ajax({
						url : '/order/syncInsert',
						type : "post",
						dataType : 'text',
						async:false,
						data : {req_no : req_noList[k], order_date : $('#selectDate').val(),
								order_page : $('#select_page').val(), mem_id : '${sessionScope.loginStatus.mem_id}',
								product_code : $('#tableBody').children('tr:eq('+i+')').find("#product_code").val(),
								category_2nd : '${defaultData.category_2nd}', dep_code : '${sessionScope.loginStatus.dep_code}'},
						async : false
					})
				}
			}
		}	
	}
}

function getCatName(){
    $.ajax({
        url : '/code/getCatName',
		type : "post",
		dataType : 'text',
		data : {category_code : $("#category_2nd").val()},
		success : function(result) {
			let data = JSON.parse(result);
			$("#showCategory_2nd").val(data.category_name);
		}
    })
}

$(document).ready(function() {
	getNewPage();
	createOrderList();
	getReq_no();
	getCatName();
    //테이블의 tbody를 클릭하면 selected로 클래스를 토글(클로즈업)
    $('#tableBody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });
});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<h3>발주서 작성</h3>
<!-- 상단 폼 -->

<div style="display: block; text-align: left;">
	<div style="display: inline-block; margin-right: 5px;">
		<div class="input-group-prepend">
			<span class="input-group-text">거래처</span>
			<input type="text" id="showVender_name" name="showVender_name" value="${defaultData.vender_name}" class="form-control" readonly size="11">
			</div>
	</div>
	<div style="display: inline-block; margin-right: 5px;">
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
    <div style="display: inline-block; margin-right: 5px;">
	    <div class="input-group-prepend">
			<span class="input-group-text">카테고리</span>
            <!-- 카테고리(하) -->
            <input type="text" id="category_2nd" name="category_2nd" value="${defaultData.category_2nd}" readonly hidden>
            <input type="text" id="showCategory_2nd" name="showCategory_2nd" value="${defaultData.category_2nd}" readonly class="form-control" size="9" >
        </div>
    </div>
	<div style="display: inline-block; margin-right: 5px;">
		<div class="input-group-prepend">
			<span class="input-group-text">페이지</span>
			<input type="number" id="select_page" name="select_page" min="1" max="9999" readonly value="" class="form-control" size="9">
		</div>
	</div>
</div>

<div style="display: block; margin: 0 auto; margin-top: 20px">
<form id="req_orderList" name="req_orderList" method="post" action="/order/createOrderPage" onsubmit="sendSync()">
		<table class="table" id="table_id" style="margin: 0 auto; width: 2000px">
			<thead>
				<tr>
					<th>#</th>
					<th style="width: 105px">품목코드</th>
					<th>품명</th>
					<th>규격</th>
					<th>제조사</th>
					<th style="width: 110px">요청단위</th>
					<th style="width: 110px">요청수량</th>
					<th style="width: 90px">현 재고</th>
					<th style="width: 110px">구매단위</th>
					<th style="width: 110px">구매수량</th>
					<th style="width: 110px">환산수량</th>
					<th style="width: 150px">구매단위 단가</th>
					<th style="width: 110px">포장수량</th>
					<th style="width: 150px">출고단위 단가</th>
					<th style="width: 80px">금액</th>
					<th style="width: 70px;">발주</th>
					<th style="width: 150px;">비고</th>
				</tr>
			</thead>
		<input type="submit" id="btnSend" name="btnSend" value="저장" style="float: left;">
			<tbody class="tableBody" id="tableBody">
			</tbody>

		</table>
</form>
</div>
</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
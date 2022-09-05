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

  <script src="//cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.print.min.js"></script>

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
let noCategory = 'noCategory';
let delListCount = 0;
let req_noList = [];
let req_prodCodeList = [];



$(function() {
	$("#calendar") .datetimepicker({ 
		locale: "ko",
		format: "YYYY-MM-DD",
		defaultDate: moment()
	});
	$("#calendar") .on("dp.change", function (e) {
		if($("#category_2nd").val() != 'none'){
		}
	});
});

//저장버튼 클릭시 유효성검사
function sendList(){
	let pass = true;
		for(i=0; i<rowCount; i++){
		if($("#tableBody").children("tr:eq("+i+")").find("#imported").is(":checked")){
			if(!($("#tableBody").children("tr:eq("+i+")").find("#mk_order").is(":checked"))){
				alert((i+1)+"번 품목은 이미 입고되어 삭제할 수 없습니다.");
				pass = false;
			}
		}
	}
	return pass;
}

// 행추가 메소드
function addRow(){
	let rowStr = "<tr>";
		rowStr += "<td>"+(rowCount+1)+"</td>";
		rowStr += "<td><input readonly size='12px' id='product_name' name='tbl_orderVO["+rowCount+"].product_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='16px' id='spec' name='tbl_orderVO["+rowCount+"].spec' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='12px' id='maker_name' name='tbl_orderVO["+rowCount+"].maker_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='4px' id='im_pakaging' name='tbl_orderVO["+rowCount+"].im_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 70px; border: none; background-color: WhiteSmoke;' type='number' id='im_quantity' name='tbl_orderVO["+rowCount+"].im_quantity' onchange='checkIm_quantity(this)' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 70px; border: none; type='number' id='im_price' name='im_price' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 100px; border: none;' type='number' id='totalPrice' name='tbl_orderVO["+rowCount+"].totalPrice' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly size='8px' type='checkbox' id='imported' name='tbl_orderVO["+rowCount+"].imported' style='border: none;' onkeydown='if(event.keyCode == 13) return false' onClick='return false;''></td>";
		rowStr += "<td><input readonly type='text'size='30px;' id='description' name='tbl_orderVO["+rowCount+"].description' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input size='8px' type='checkbox' id='mk_order' name='tbl_orderVO["+rowCount+"].mk_order' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input style='width: 60px; border: none;' type='number' id='pak_quantity' name='tbl_orderVO["+rowCount+"].pak_quantity' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td hidden><input size='4px;' id='ex_pakaging' name='tbl_orderVO["+rowCount+"].ex_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input size='4px;' id='ex_quantity' name='tbl_orderVO["+rowCount+"].ex_quantity' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input style='width: 90px; border: none;' type='number' id='price' name='tbl_orderVO["+rowCount+"].price' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td hidden><input size='8px' id='product_code' name='tbl_orderVO["+rowCount+"].product_code' type='text' value=''  style='border: none;'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input id='vender_code' name='tbl_orderVO["+rowCount+"].vender_code'></td>";
		rowStr += "<td hidden><input type='text' id='vender_name' name='tbl_orderVO["+rowCount+"].vender_name'></td>"
		rowStr += "<td hidden><input type='text' id='dep_name' name='tbl_orderVO["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input id='maker_code' name='tbl_orderVO["+rowCount+"].maker_code'></td>";
		rowStr += "<td hidden><input id='category_2nd' name='tbl_orderVO["+rowCount+"].category_2nd' value='${defaultData.category_2nd}'></td>";
		rowStr += "<td hidden><input id='order_date' name='tbl_orderVO["+rowCount+"].order_date'></td>"
		rowStr += "<td hidden><input id='order_page' name='tbl_orderVO["+rowCount+"].order_page'></td>"
		rowStr += "<td hidden><input id='mem_id' name='tbl_orderVO["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input id='dep_code' name='tbl_orderVO["+rowCount+"].dep_code'></td>"
		rowStr += "<td hidden><input id='order_num' name='tbl_orderVO["+rowCount+"].order_num'></td>"
		rowStr += "</tr>"
		rowCount += 1;
	$("#tableBody").append(rowStr);
}


// 발주서 내역 불러오는 메소드
function createOrderList(){
	let dateStr = '${defaultData.order_date}';
	let slicedDate = dateStr.replace(' 00:00:00', '');
	
	$.ajax({
		url : '/order/getOrder',
		type : "post",
		dataType : 'text',
		data : {selectDate1 : '${defaultData.selectDate1}', selectDate2 : '${defaultData.selectDate2}',
                vender_code : '${defaultData.vender_code}', category_2nd : '${defaultData.category_2nd}',
				order_page : '${defaultData.order_page}', order_date : slicedDate
				},
		async : false,
		success : function(result) {
			let data = JSON.parse(result);
			console.log(data);
            for(let i=0; i<data.length; i++){
				addRow();
				let originDate = data[i].order_date;
				let changeDate = originDate.replace(' 00:00:00', '');
				// 행 데이터삽입
				$("#tableBody").children('tr:eq('+i+')').find("#product_code").val(data[i].product_code);
				$("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val(data[i].ex_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#product_name").val(data[i].product_name);
				$("#tableBody").children('tr:eq('+i+')').find("#spec").val(data[i].spec);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_name").val(data[i].maker_name);
				$("#tableBody").children('tr:eq('+i+')').find("#im_pakaging").val(data[i].im_pakaging);
				$("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val(data[i].pak_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val(data[i].ex_pakaging);
				$("#tableBody").children('tr:eq('+i+')').find("#price").val(data[i].price);
				$("#tableBody").children('tr:eq('+i+')').find("#description").val(data[i].description);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_code").val(data[i].vender_code);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_name").val(data[i].vender_name);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_code").val(data[i].dep_code);
				$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val(data[i].mem_id);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_name").val(data[i].dep_name);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_code").val(data[i].maker_code);
				$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data[i].category_2nd);
				$("#tableBody").children('tr:eq('+i+')').find("#order_date").val(changeDate);
				$("#tableBody").children('tr:eq('+i+')').find("#order_page").val(data[i].order_page);
				$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val(data[i].mem_id);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_code").val(data[i].dep_code);
				$("#tableBody").children('tr:eq('+i+')').find("#order_num").val(data[i].order_num);
				$("#tableBody").children('tr:eq('+i+')').find("#mk_order").attr("checked", true);
				if(data[i].imported == 1){
					$("#tableBody").children('tr:eq('+i+')').find("#imported").attr("checked", true);
				}
            }
		}
	});
	for(let i=0; i<rowCount; i++){
			// 출고단위
			let ex_quantity = $("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
			// 출고단위 기준 단가
			let price = $("#tableBody").children('tr:eq('+i+')').find("#price").val();
			// 총 금액
			let totalPrice = $("#tableBody").children('tr:eq('+i+')').find("#totalPrice");
			// 포장수량
			let pak_quantity = $("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val();

			$("#tableBody").children('tr:eq('+i+')').find("#im_quantity").val((Math.ceil(ex_quantity/pak_quantity)));
			$("#tableBody").children('tr:eq('+i+')').find("#im_price").val(pak_quantity * price);
			$("#tableBody").children('tr:eq('+i+')').find("#totalPrice").val($("#tableBody").children('tr:eq('+i+')').find("#im_quantity").val() * $("#tableBody").children('tr:eq('+i+')').find("#im_price").val());
	}
}


// 구매수량 변경시 금액 변경되는 메소드
function checkIm_quantity(event){
	let im_quantity = $(event);
	let totalPrice = $(event).parent().parent().find('td:eq(13)').find("#totalPrice");
	let im_price = $(event).parent().parent().find('td:eq(8)').find("#im_price");
	$(totalPrice).val(im_quantity.val() * im_price.val());
}

// 저장시 유효성 체크 및 전송
function sendCheck(){
	let pass = true;
	for(i=0; i<rowCount; i++){
		if($("#tableBody").children("tr:eq("+i+")").find("#imported").is(":checked")){
			if(!($("#tableBody").children("tr:eq("+i+")").find("#mk_order").is(":checked"))){
				alert((i+1)+"번 품목은 이미 입고되어 삭제할 수 없습니다.");
				pass = false;
			}
		}
	}
	return pass;
}

function excelDownload(){
		$("#cloneTable_wrapper").children('div').eq(0).children('button').eq(0).click();
	}

function pdfDownload(){
	$("#cloneTable_wrapper").children('div').eq(0).children('button').eq(1).click();
}

function Cloning(){
	$("#cloneTable").find("tbody").empty();
	for(let i=0; i<rowCount; i++){
		$("#cloneBody").append('<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
		for(let k=1; k<10; k++){
			$("#cloneBody").children("tr").eq(i).children("td").eq(0).text(i+1);
			let val = $("#tableBody").children('tr').eq(i).children('td').eq(k).find('input').eq(0).val();
			$("#cloneBody").children("tr").eq(i).children("td").eq(k).text(val);
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
	createOrderList();
	Cloning();
	getCatName();
	// getReq_no();
    //테이블의 tbody를 클릭하면 selected로 클래스를 토글(클로즈업)
    $('#tableBody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });

	// 수정버튼 클릭시 저장, 발주여부 버튼 나오는 기능
	$("#btnEdit").on("click", function(){
		$("#btnSend").removeAttr('hidden');
		$("#btnEdit").attr('hidden', true);
		$("#tableHead").children("tr").find('th:eq(10)').removeAttr('hidden');
		for(let i=0; i<rowCount; i++){
			$("#tableBody").children('tr:eq('+i+')').children('td:eq(10)').removeAttr('hidden');
		}
	});

	$('#cloneTable').DataTable( {
        dom: 'Bfrtip',
        buttons: [
		{ extend: 'excel', charset: 'UTF-8', bom: true }, { extend: 'pdf', charset: 'UTF-8', bom: true }, 'print'
        ]
    } );
});
</script>

</head>

<body>

<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<!-- 상단 폼 -->
	<h3>발주서</h3>
	<div style="text-align: left; display: block; width: 1500px;">
	    <div style="display: inline-block; margin-right: 5px;">
		    <div class="input-group-prepend">
				<span class="input-group-text">거래처</span>
	            <input type="text" id="showVender_name" name="showVender_name" value="${defaultData.vender_name}" readonly class="form-control">
            </div>
        </div>
		<div style="display: inline-block; margin-right: 5px;">
		<div class="input-group" id="calendar">
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
	            <input type="text" id="showCategory_2nd" name="showCategory_2nd" value="${defaultData.category_2nd}" readonly class="form-control">
            </div>
        </div>
        <div style="display: inline-block; margin-right: 5px;">
	        <div class="input-group-prepend">
				<span class="input-group-text">페이지</span>
	            <input type="number" id="select_page" name="select_page" readonly value="${defaultData.order_page}" class="form-control">
	        </div>
        </div>
    </div>

<div style="display: block; margin: 0 auto; margin-top: 20px;">
<form id="req_orderList" name="req_orderList" method="post" action="/order/orderUpdate" onsubmit="return sendCheck()">
			<div style="float: left;">
				<input type="button" id="btnEdit" name="btnEdit" value="수정">
				<input type="button" id="btnExcelDownload" name="btnExcelDownload" value="excel" onclick="excelDownload();">
				<input type="button" id="btnPDFDownload" name="btnPDFDownload" value="PDF" onclick="pdfDownload();">
				<input hidden type="submit" id="btnSend" name="btnSend" value="저장">
			</div>
		<table class="table table-bordered table-hover" id="table_id">
			<thead style="background-color: rgb(148, 146, 146);" id="tableHead">
				<tr>
					<th>#</th>
					<th>품명</th>
					<th>규격</th>
					<th>제조사</th>
					<th>단위</th>
					<th>수량</th>
					<th>단가</th>
					<th>금액</th>
					<th>입고여부</th>
					<th>비고</th>
					<th hidden>발주여부</th>
				</tr>
			</thead>

			<tbody class="tableBody" id="tableBody">
			</tbody>

		</table>
</form>
</div>
<script>

</script>
<div id="clone" hidden>
	<table id="cloneTable">
		<caption style="caption-side: top;">발주서</caption>
		<thead id="cloneHead" class="cloneHead">
			<th>#</th>
			<th>품명</th>
			<th>규격</th>
			<th>제조사</th>
			<th>단위</th>
			<th>수량</th>
			<th>단가</th>
			<th>금액</th>
			<th>입고여부</th>
			<th>비고</th>
		</thead>
		<tbody id="cloneBody" class="cloneBody">

		</tbody>
	</table>
</div>
</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
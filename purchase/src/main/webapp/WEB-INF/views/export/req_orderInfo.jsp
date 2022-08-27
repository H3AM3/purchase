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
let parentDate = window.opener.getImport_date();
let import_date = parentDate.replace(' 00:00:00', '');


// 체크박스 전체를 체크하는 메소드
function selectAll(selectAll)  {
  const checkboxes 
       = document.getElementsByName('selectRow');
  
  checkboxes.forEach((checkbox) => {
    checkbox.checked = selectAll.checked;
  })
}

// 가져오기 버튼 클릭시
function getInfo(){
	window.opener.emptyTableBody();
	window.opener.setRowCount(0);
	let count = 0;
	for(let i=0; i<rowCount; i++){
		let tableBody = $("#tableBody");
		if(tableBody.children('tr:eq('+i+')').children('td:eq(0)').find('#selectRow').is(":checked")){
			window.opener.addRow();
			let j=2;
			for(let k=2; k<tableBody.children('tr:eq('+i+')').children().length+2; k++){
				if(k == 9){k = 11;}
					let value = tableBody.children('tr:eq('+i+')').children('td:eq('+j+')').children().val();
					$(opener.document).find("#tableBody").children('tr:eq('+count+')').children('td:eq('+k+')').children(":first").val(value);
					j++;
			}
			count += 1;
		}
	}
	// 입고수량 기본값을 미입고수량만큼 바꿔주는 메소드
	window.opener.changeEx_quantity();
	window.opener.getNewPage();
	window.close();	
}

// 행추가 메소드
function addRow(){
	let rowStr = "<tr>";
		rowStr += "<td><input type='checkbox' id='selectRow' name='selectRow'></td>";
		rowStr += "<td>"+(rowCount+1)+"</td>";
		rowStr += "<td colspan='2'><input readonly id='product_code' name='req_ordersList["+rowCount+"].product_code' onkeypress='javascript:if(event.keyCode==13) {addRow();}' size='10' type='text' value='' style='border: none;'></td>";
		rowStr += "<td><input readonly id='product_name' name='req_ordersList["+rowCount+"].product_name' style='border: none;'></td>";
		rowStr += "<td><input readonly id='spec' name='req_ordersList["+rowCount+"].spec' style='border: none;'></td>";
		rowStr += "<td><input readonly id='maker_name' name='req_ordersList["+rowCount+"].maker_name' style='border: none;'></td>";
		rowStr += "<td><input readonly size='5px;' id='ex_pakaging' name='req_ordersList["+rowCount+"].ex_pakaging' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='req_quantity' name='req_ordersList["+rowCount+"].req_quantity' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='unimported_qty' name='req_ordersList["+rowCount+"].unimported_qty' style='border: none;'></td>";
		rowStr += "<td><input readonly type='text'size='30px;' id='description' name='req_ordersList["+rowCount+"].description' style='border: none;'></td>";

		rowStr += "<td hidden><input type='checkbox' id='mk_order' name='req_ordersList["+rowCount+"].mk_order' onClick='return false;'></td>";
		rowStr += "<td hidden><input type='checkbox' id='req_reject' name='req_ordersList["+rowCount+"].req_reject'></td>";
		rowStr += "<td hidden><input type='checkbox' id='approval' name='req_ordersList["+rowCount+"].approval'></td>";
		rowStr += "<td hidden><input readonly id='vender_code' name='req_ordersList["+rowCount+"].vender_code'></td>";
		rowStr += "<td hidden><input type='text' id='req_page' name='req_ordersList["+rowCount+"].req_page'></td>";
		rowStr += "<td hidden><input type='text' id='req_date' name='req_ordersList["+rowCount+"].req_date'></td>";
		rowStr += "<td hidden><input type='text' id='dep_code' name='req_ordersList["+rowCount+"].dep_code'></td>";
		rowStr += "<td hidden><input type='text' id='mem_id' name='req_ordersList["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input type='text' id='vender_name' name='req_ordersList["+rowCount+"].vender_name'></td>"
		rowStr += "<td hidden><input type='number' id='pak_quantity' name='req_ordersList["+rowCount+"].pak_quantity'></td>"
		rowStr += "<td hidden><input type='text' id='dep_name' name='req_ordersList["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input readonly id='maker_code' name='req_ordersList["+rowCount+"].maker_code'></td>";
		rowStr += "<td hidden><input readonly id='category_2nd' name='req_ordersList["+rowCount+"].category_2nd'></td>";
		rowStr += "<td hidden><input readonly id='req_no' name='req_ordersList["+rowCount+"].req_no'></td>";
		rowStr += "<td hidden><input readonly id='end_request' name='req_ordersList["+rowCount+"].end_request'></td>";
		rowStr += "</tr>"
		rowCount += 1;
	$("#tableBody").append(rowStr);
}


// 미입고내역 불러오는 메소드
function getReq_orderInfo(){
	$.ajax({
		url : '/export/getReq_orderInfo',
		type : "post",
		dataType : 'text',
		data : {req_date : '${defaultData.req_date}', req_page : '${defaultData.req_page}',
				dep_code : '${defaultData.dep_code}', category_2nd : '${defaultData.category_2nd}'
				},
		async : false,
		success : function(result) {
			let data = JSON.parse(result);
			console.log(data);
            for(let i=0; i<data.length; i++){
				addRow();
				$("#tableBody").children('tr:eq('+i+')').find("#product_code").val(data[i].product_code);
				$("#tableBody").children('tr:eq('+i+')').find("#product_name").val(data[i].product_name);
				$("#tableBody").children('tr:eq('+i+')').find("#spec").val(data[i].spec);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_name").val(data[i].maker_name);
				$("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val(data[i].ex_pakaging);
				$("#tableBody").children('tr:eq('+i+')').find("#req_quantity").val(data[i].req_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#unimported_qty").val(data[i].unimported_qty);
				$("#tableBody").children('tr:eq('+i+')').find("#description").val(data[i].description);
				$("#tableBody").children('tr:eq('+i+')').find("#req_page").val(data[i].req_page);
				$("#tableBody").children('tr:eq('+i+')').find("#req_date").val(data[i].req_date);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_code").val(data[i].dep_code);
				$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val(data[i].mem_id);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_name").val(data[i].vender_name);
				if(data[i].approval == '1'){
					$("#tableBody").children('tr:eq('+i+')').find("#approval").attr("checked", true);
				}
                if(data[i].req_reject == '1'){
					$("#tableBody").children('tr:eq('+i+')').find("#req_reject").attr("checked", true);
				}
				if(data[i].mk_order == '1'){
					$("#tableBody").children('tr:eq('+i+')').find("#mk_order").attr("checked", true);
				}
				if(data[i].end_request == '1'){
					$("#tableBody").children('tr:eq('+i+')').find("#end_request").attr("checked", true);
				}
				$("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val(data[i].pak_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_name").val(data[i].dep_name);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_code").val(data[i].maker_code);
				$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data[i].category_2nd);
				$("#tableBody").children('tr:eq('+i+')').find("#req_no").val(data[i].req_no);
            }
		}
	});
}


$(document).ready(function() {
	getReq_orderInfo();

	//테이블의 tbody를 클릭하면 selected로 클래스를 토글(클로즈업)
    $('#tableBody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });

});
</script>

</head>

<body>
<a>${order_date } </a>
<a>${order_page } </a>
<a>${vender_code } </a>
<a>${category_2nd } </a>
<!-- 상단 폼 -->
<div class="card-body"></div>
<br>
	<div class="card-body">
		<div class="col-md-12">
		<table class="table table-bordered table-hover" id="table_id">
			<thead style="background-color: rgb(148, 146, 146);" id="tableHead">
				<tr>
					<th><input type="checkbox" value="selectall" name="selectall" id="selectall" onclick="selectAll(this)"></th>
					<th>#</th>
					<th>품목코드</th>
					<th colspan="2">품명</th>
					<th>규격</th>
					<th>제조사</th>
					<th>단위</th>
					<th>청구수량</th>
					<th>미입고 수량</th>
					<th>비고</th>
				</tr>
			</thead>
		<input type="button" id="btnGetInfo" name="btnGetInfo" value="가져오기" onclick="getInfo()">
			<tbody class="tableBody" id="tableBody">
			</tbody>

		</table>
		</div>
	</div>
   
</body>

</html>
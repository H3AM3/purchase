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
let dep_code = '${defaultData.dep_code}';
let category_2nd = '${defaultData.category_2nd}';
let delRowCount = 0;


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
		rowStr += "<td><input readonly size='8px' id='product_code' name='tbl_export["+rowCount+"].product_code' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='14px' id='product_name' name='tbl_export["+rowCount+"].product_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='16px' id='spec' name='tbl_export["+rowCount+"].spec' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='12px' id='maker_name' name='tbl_export["+rowCount+"].maker_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='4px' type='text' id='ex_pakaging' name='tbl_export["+rowCount+"].ex_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";

		rowStr += "<td><input readonly style='width: 60px; border: none;' type='number' min=0 id='req_quantity' name='req_quantity' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 60px; border: none;' type='number' min=0 id='unimported_qty' name='unimported_qty' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 60px; border: none;' type='number' min=0 id='stock_quantity' name='stock_quantity' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td hidden><input readonly style='width: 60px; border: none;' type='number' min=0 id='original_ex_quantity' name='tbl_export["+rowCount+"].original_ex_quantity' onchange='checkquantity(this)' onkeydown='if(event.keyCode == 13) return false'></td>"


		rowStr += "<td><input style='width: 60px; border: none;' type='number' min=0 id='ex_quantity' name='tbl_export["+rowCount+"].ex_quantity' onchange='checkquantity(this)' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='border: none;' type='text' id='description' name='tbl_export["+rowCount+"].description' onkeydown='if(event.keyCode == 13) return false'></td>"

		rowStr += "<td hidden><input id='export_date' name='tbl_export["+rowCount+"].export_date' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input id='export_num' name='tbl_export["+rowCount+"].export_num' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input id='export_page' name='tbl_export["+rowCount+"].export_page'></td>"
		rowStr += "<td hidden><input id='mem_id' name='tbl_export["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input type='number' id='req_no' name='tbl_export["+rowCount+"].req_no'></td>";
		rowStr += "<td hidden><input id='dep_code' name='tbl_export["+rowCount+"].dep_code'></td>"
		rowStr += "<td hidden><input id='dep_name' name='tbl_export["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input id='maker_code' name='tbl_export["+rowCount+"].maker_code'></td>"
		rowStr += "<td hidden><input type='number' id='pak_quantity' name='tbl_export["+rowCount+"].pak_quantity' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td hidden><input id='category_2nd' name='tbl_export["+rowCount+"].category_2nd' type='text' value=''  style='border: none;'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowCount += 1;
	$("#tableBody").append(rowStr);

}

function getQuantity(req_no, product_code, rowCount){
	$.ajax({
		url : '/export/getReq_qty',
		type : "post",
		dataType : 'text',
		data : {req_no : req_no},
		success : function(result){
			data = JSON.parse(result);
			let req_quantity = Number(data.req_quantity);
			let unimported_qty = Number(data.unimported_qty);
			$("#tableBody").children('tr:eq('+rowCount+')').find("#req_quantity").val(req_quantity);
			$("#tableBody").children('tr:eq('+rowCount+')').find("#unimported_qty").val(unimported_qty);
		}
	})
	$.ajax({
		url : '/export/getStockQty',
		type : "post",
		dataType : 'text',
		data : {product_code : product_code},
		success : function(result){
			data = JSON.parse(result);
			let stock_quantity = Number(data);
			$("#tableBody").children('tr:eq('+rowCount+')').find("#stock_quantity").val(stock_quantity);
		}
	})
}

// 행 삭제 메소드
function delRow(){
	for(let i=0; i<rowCount; i++){
		if($("#tableBody").children('tr:eq('+i+')').find("#selectRow").is(":checked")){
			// 삭제내역 저장하는 기능
			let a = $("#tableBody").children('tr:eq('+i+')').find("#selectRow");
			let product_code = $(a).parent().parent().find("#product_code").val();
			let req_no = $(a).parent().parent().find("#req_no").val();
			let ex_quantity = $(a).parent().parent().find("#ex_quantity").val();
			let export_num = $(a).parent().parent().find("#export_num").val();
			let original_ex_quantity = $(a).parent().parent().find("#original_ex_quantity").val();
			let rowStr = "<tr>";
			rowStr += "<td><input readonly id='export_num' name='delImportDTO["+delRowCount+"].export_num'></td>";	
			rowStr += "<td><input readonly id='product_code' name='delImportDTO["+delRowCount+"].product_code'></td>";
			rowStr += "<td><input readonly id='req_no' name='delImportDTO["+delRowCount+"].req_no'></td>";
			rowStr += "<td><input readonly id='ex_quantity' name='delImportDTO["+delRowCount+"].ex_quantity'></td>";
			rowStr += "<td><input readonly id='original_ex_quantity' name='delImportDTO["+delRowCount+"].original_ex_quantity'></td>";
			rowStr += "</tr>";
			$("#delTableBody").append(rowStr);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#product_code").val(product_code);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#req_no").val(req_no);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#ex_quantity").val(ex_quantity);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#export_num").val(export_num);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#original_ex_quantity").val(original_ex_quantity);
			delRowCount += 1;
		}
	}

	$("input:checkbox[name='selectRow']:checked").each(function(k,kVal){
			let a = $(this).parent().parent();
			$(a).remove();
	});
	$("#selectall").prop("checked", false);
}

//저장버튼 클릭시 유효성검사
function submitCheck(){
	let pass = true;
	// 재고수량 남아있는지, 미출고 수량보다 많이 불출하는지 확인
	for(let i=0; i<rowCount; i++){
		let ex_quantity = $("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
		let original_ex_quantity = $("#tableBody").children('tr:eq('+i+')').find("#original_ex_quantity").val();
		let stock_quantity = $("#tableBody").children('tr:eq('+i+')').find("#stock_quantity").val();
		let product_name = $("#tableBody").children('tr:eq('+i+')').find("#product_name").val();
		let unimported_qty = $("#tableBody").children('tr:eq('+i+')').find("#unimported_qty").val();
		let ex_pakaging = $("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val();
		let total = Number(original_ex_quantity) + Number(unimported_qty)
		if((ex_quantity - original_ex_quantity) > unimported_qty){
			pass = false;
			alert("["+product_name+"]의 출고수량은 "+(total)+ex_pakaging+"를 초과할 수 없습니다.");
		}
		if((ex_quantity - original_ex_quantity) > stock_quantity){
			pass = false;
			alert("["+product_name+"]의 재고가 부족합니다.");
		}	
	}
///////////////////////////////////// 여기부터 해야함 ////////////////////////////////////////////////
	// 유효성검사 통과시 내용 반영
	if(pass){
		for(let i=0; i<delRowCount; i++){
			let export_num = $("#delTableBody").children('tr:eq('+i+')').find("#export_num").val();
			let product_code = $("#delTableBody").children('tr:eq('+i+')').find("#product_code").val();
			let ex_quantity = $("#delTableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
			let original_ex_quantity = $("#delTableBody").children('tr:eq('+i+')').find("#original_ex_quantity").val();
			let req_no = $("#delTableBody").children('tr:eq('+i+')').find("#req_no").val();
			$.ajax({
				url : '/export/delExport',
				type : "post",
				dataType : 'text',
				async : false,
				data : {export_num : export_num,
						product_code : product_code,
						ex_quantity : ex_quantity,
						req_no : req_no,
						original_ex_quantity : original_ex_quantity
						},
				success : function(result){
					data = JSON.parse(result);
					if(data == 'successs'){
					}else if(data == 'failure'){
						alert("오류발생");
						pass = false;
					}
				}
			})
		}
	}
	return pass;
}

function getCatName(){
    $.ajax({
        url : '/code/getCatName',
		type : "post",
		dataType : 'text',
		data : {category_code : '${defaultData.category_2nd}'},
		success : function(result) {
			let data = JSON.parse(result);
			$("#showCategory_2nd").val(data.category_name);
		}
    })
}

$(document).ready(function() {
	getCatName();
    //테이블의 tbody를 클릭하면 selected로 클래스를 토글(클로즈업)
    $('#tableBody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });

	// 입고내역 가져오는 메소드
	$.ajax({
			url : '/export/getExportInfo',
			type : "post",
			dataType : 'text',
			data : {
				category_2nd : category_2nd,
                dep_code : dep_code,
				export_date : $("#selectDate").val(),
				export_page : $("#select_page").val()
			},
			success : function(result){
				data = JSON.parse(result);
				console.log(data);
				for(let i=0; i<data.length; i++){
					addRow();
					$("#tableBody").children('tr:eq('+i+')').find("#export_num").val(data[i].export_num);
					$("#tableBody").children('tr:eq('+i+')').find("#export_date").val(data[i].export_date);
					$("#tableBody").children('tr:eq('+i+')').find("#export_page").val(data[i].export_page);
					$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val(data[i].mem_id);
					$("#tableBody").children('tr:eq('+i+')').find("#product_code").val(data[i].product_code);
					$("#tableBody").children('tr:eq('+i+')').find("#product_name").val(data[i].product_name);
					$("#tableBody").children('tr:eq('+i+')').find("#spec").val(data[i].spec);
					$("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val(data[i].ex_pakaging);
					$("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val(data[i].ex_quantity);
					$("#tableBody").children('tr:eq('+i+')').find("#dep_code").val(data[i].dep_code);
					$("#tableBody").children('tr:eq('+i+')').find("#dep_name").val(data[i].dep_name);
					$("#tableBody").children('tr:eq('+i+')').find("#description").val(data[i].description);
					$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data[i].category_2nd);
					$("#tableBody").children('tr:eq('+i+')').find("#maker_code").val(data[i].maker_code);
					$("#tableBody").children('tr:eq('+i+')').find("#maker_name").val(data[i].maker_name);
					$("#tableBody").children('tr:eq('+i+')').find("#req_no").val(data[i].req_no);
					$("#tableBody").children('tr:eq('+i+')').find("#original_ex_quantity").val($("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val());
					getQuantity($("#tableBody").children('tr:eq('+i+')').find("#req_no").val(), $("#tableBody").children('tr:eq('+i+')').find("#product_code").val(), i);
				}
			}
	})

});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<!-- 상단 폼 -->
<h3>출고내역</h3>
<div style="display: block;">
	<div class="form-inline">
			<div class="input-group date" id="calendar" style="margin-right: 5px;">
			<div class="input-group-prepend">
				<span class="input-group-text">부서</span>
			</div>
			<input type="text" id="showDep_name" name="showDep_name" value="${defaultData.dep_name }" readonly class="form-control" size="8px">
		</div>
		
				<div class="input-group date" id="calendar" style="margin-right: 5px;">
			<div class="input-group-prepend">
				<span class="input-group-text">카테고리</span>
			</div>
			<input type="text" id="showCategory_2nd" name="showCategory_2nd" value="" readonly class="form-control" size="8px">
		</div>
	
		<div class="input-group date" id="calendar" style="margin-right: 5px;">
			<div class="input-group-prepend">
				<span class="input-group-text">날짜</span>
			</div>
			<input readonly type="text" name="selectDate" id="selectDate" value="${defaultData.export_date }" class="form-control" size="9"
				onkeydown="if (event.keyCode == 13) {}">
		</div>
		<div class="input-group date" id="calendar" style="margin-right: 5px;">
			<div class="input-group-prepend">
				<span class="input-group-text">페이지</span>
			</div>
			<input type="number" id="select_page" name="select_page" min="1" max="9999" value="${defaultData.export_page }" readonly class="form-control">
		</div>
	</div>
</div>

<div style="text-align: left;">
<input type="button" id="btnDelRow" name="btnDelRow" value="행삭제" onclick="delRow();">
</div>

<form id="importListForm" name="importListForm" method="post" action="/export/updateExport" onsubmit="return submitCheck()" style="display: block; margin-top: 20px; text-align: left;">
		<input type="submit" id="send" name="send" value="저장">
		<table id="table_id" style="margin: 0 auto; width: 100%">
			<thead>
				<tr>
					<th><input type="checkbox" value="selectall" name="selectall" id="selectall" onclick="selectAll(this)"></th>
					<th>#</th>
					<th>품목코드</th>
					<th>품명</th>
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
			<tbody class="tableBody" id="tableBody">
			</tbody>
		</table>
</form>


<table>
	<thead>
	</thead>
	<tbody id="delTableBody">
	</tbody>
</table>

</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
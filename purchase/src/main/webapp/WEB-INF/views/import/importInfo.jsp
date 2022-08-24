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
let vender_code = '${vender_code}';
let category_2nd = '${category_2nd}';
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
		rowStr += "<td colspan='2'><input readonly size='8px' id='product_code' name='tbl_importVO["+rowCount+"].product_code' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='14px' id='product_name' name='tbl_importVO["+rowCount+"].product_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='16px' id='spec' name='tbl_importVO["+rowCount+"].spec' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='12px' id='vender_name' name='tbl_importVO["+rowCount+"].vender_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='4px' type='text' id='ex_pakaging' name='tbl_importVO["+rowCount+"].ex_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 60px; border: none;' type='number' min=0 id='ex_quantity' name='tbl_importVO["+rowCount+"].ex_quantity' onchange='checkIm_quantity(this)' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 80px; border: none; type='number' id='price' name='tbl_importVO["+rowCount+"].price' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 90px; border: none; background-color: WhiteSmoke;' type='number' id='im_price' name='im_price'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='border: none;' type='text' id='description' name='tbl_importVO["+rowCount+"].description'></td>"
		
		rowStr += "<td><input hidden id='import_date' name='tbl_importVO["+rowCount+"].import_date' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input hidden id='import_num' name='tbl_importVO["+rowCount+"].import_num' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input hidden id='import_page' name='tbl_importVO["+rowCount+"].import_page'></td>"
		rowStr += "<td><input hidden id='mem_id' name='tbl_importVO["+rowCount+"].mem_id'></td>"
		rowStr += "<td><input hidden id='vender_code' name='tbl_importVO["+rowCount+"].vender_code'></td>";
		rowStr += "<td><input hidden type='number' id='waiting_num' name='tbl_importVO["+rowCount+"].waiting_num'></td>";
		rowStr += "<td><input hidden type='number' id='tbl_importVO["+rowCount+"].pak_quantity' name='tbl_importVO["+rowCount+"].pak_quantity' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input hidden id='category_2nd' name='tbl_importVO["+rowCount+"].category_2nd' type='text' value=''  style='border: none;'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowCount += 1;
	$("#tableBody").append(rowStr);

}

// 행 삭제 메소드
function delRow(){
	for(let i=0; i<rowCount; i++){
		if($("#tableBody").children('tr:eq('+i+')').find("#selectRow").is(":checked")){
			// 삭제내역 저장하는 기능
			let a = $("#tableBody").children('tr:eq('+i+')').find("#selectRow");
			let product_code = $(a).parent().parent().find("#product_code").val();
			let waiting_num = $(a).parent().parent().find("#waiting_num").val();
			let ex_quantity = $(a).parent().parent().find("#ex_quantity").val();
			let import_num = $(a).parent().parent().find("#import_num").val();
			let rowStr = "<tr>";
			rowStr += "<td><input readonly id='import_num' name='delImportDTO["+delRowCount+"].import_num'></td>";	
			rowStr += "<td><input readonly id='product_code' name='delImportDTO["+delRowCount+"].product_code'></td>";
			rowStr += "<td><input readonly id='waiting_num' name='delImportDTO["+delRowCount+"].waiting_num'></td>";
			rowStr += "<td><input readonly id='ex_quantity' name='delImportDTO["+delRowCount+"].ex_quantity'></td>";
			$("#delTableBody").append(rowStr);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#import_num").val(import_num);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#product_code").val(product_code);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#waiting_num").val(waiting_num);
			$("#delTableBody").children('tr:eq('+delRowCount+')').find("#ex_quantity").val(ex_quantity);
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
	let pass = false;
	if(delRowCount == 0){
		alert("수정사항이 없습니다!");
	} else if(delRowCount > 0){
		pass = true;
	}
	// 재고수량 남아있는지 확인하고 pass값에 반영
	if(pass){
		for(let i=0; i<delRowCount; i++){
			let product_code = $("#delTableBody").children('tr:eq('+i+')').find("#product_code").val();
			let ex_quantity = $("#delTableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
			$.ajax({
				url : '/import/checkStock',
				type : "post",
				dataType : 'text',
				async : false,
				data : {product_code : product_code
				},
				success : function(result){
					data = JSON.parse(result);
					let stock_quantity = parseInt(data.stock_quantity);
					if(stock_quantity<ex_quantity){
						alert("["+product_code+"]의 재고가 부족하여 입고를 취소할 수 없습니다.");
						pass=false;
					} else{
						pass = true;
					}
				}
			})
		}
	}

	// 재고수량 있는경우 미입고내역 테이블의 입고수량 마이너스, wating테이블 입고수량변경 및 import_end를 0으로 변경
	if(pass){
		for(let i=0; i<delRowCount; i++){
			let import_num = $("#delTableBody").children('tr:eq('+i+')').find("#import_num").val();
			let product_code = $("#delTableBody").children('tr:eq('+i+')').find("#product_code").val();
			let ex_quantity = $("#delTableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
			let waiting_num = $("#delTableBody").children('tr:eq('+i+')').find("#waiting_num").val();
			$.ajax({
				url : '/import/delImport',
				type : "post",
				dataType : 'text',
				async : false,
				data : {product_code : product_code,
						ex_quantity : ex_quantity,
						waiting_num : waiting_num,
						import_num : import_num
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


$(document).ready(function() {
	
    //테이블의 tbody를 클릭하면 selected로 클래스를 토글(클로즈업)
    $('#tableBody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });

	// 입고내역 가져오는 메소드
	$.ajax({
			url : '/import/getImportInfo',
			type : "post",
			dataType : 'text',
			data : {
				category_2nd : category_2nd,
                vender_code : vender_code,
				import_date : $("#selectDate").val(),
				import_page : $("#select_page").val()
			},
			success : function(result){
				data = JSON.parse(result);
				console.log(data);
				for(let i=0; i<data.length; i++){
					addRow();
					$("#tableBody").children('tr:eq('+i+')').find("#import_num").val(data[i].import_num);
					$("#tableBody").children('tr:eq('+i+')').find("#import_date").val(data[i].import_date);
					$("#tableBody").children('tr:eq('+i+')').find("#import_page").val(data[i].import_page);
					$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val(data[i].mem_id);
					$("#tableBody").children('tr:eq('+i+')').find("#product_code").val(data[i].product_code);
					$("#tableBody").children('tr:eq('+i+')').find("#product_name").val(data[i].product_name);
					$("#tableBody").children('tr:eq('+i+')').find("#spec").val(data[i].spec);
					$("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val(data[i].ex_pakaging);
					$("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val(data[i].ex_quantity);
					$("#tableBody").children('tr:eq('+i+')').find("#price").val(data[i].price);
					$("#tableBody").children('tr:eq('+i+')').find("#vender_code").val(data[i].vender_code);
					$("#tableBody").children('tr:eq('+i+')').find("#vender_name").val(data[i].vender_name);
					$("#tableBody").children('tr:eq('+i+')').find("#reg_date").val(data[i].reg_date);
					$("#tableBody").children('tr:eq('+i+')').find("#description").val(data[i].description);
					$("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val(data[i].pak_quantity);
					$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data[i].category_2nd);
					$("#tableBody").children('tr:eq('+i+')').find("#waiting_num").val(data[i].waiting_num);

					let ex_quantity = $("#tableBody").children('tr:eq('+i+')').find("#ex_quantity").val();
					let price = $("#tableBody").children('tr:eq('+i+')').find("#price").val();
					$("#tableBody").children('tr:eq('+i+')').find("#im_price").val(ex_quantity * price);
				}
			}
	})

});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<!-- 상단 폼 -->
<div class="card-body">
<h3>입고내역</h3>
	<div class="form-inline">
		<div class="input-group input-group-sm date" id="calendar">
			<div class="input-group-prepend">
				<span class="input-group-text">날짜</span>
			</div>
			<input readonly type="text" name="selectDate" id="selectDate" value="${import_date }" class="form-control form-control-sm" size="9"
				onkeydown="if (event.keyCode == 13) {}">
		</div>
		<div class="input-group input-group-sm date" id="calendar">
			<div class="input-group-prepend">
				<span class="input-group-text">페이지</span>
			</div>
			<input type="number" id="select_page" name="select_page" min="1" max="9999" value="${import_page }" readonly>
		</div>
	</div>
	<div>
		<br>
	</div>
	<input type="button" id="btnDelRow" name="btnDelRow" value="행삭제" onclick="delRow();">
</div>	

<div>
	<br>
</div>

<form id="importListForm" name="importListForm" method="post" action="/import/redirecImportInfo" onsubmit="return submitCheck()">
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
					<th>입고수량</th>
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

<table>
	<thead>
	</thead>
	<tbody id="delTableBody">
	</tbody>
</table>
   
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
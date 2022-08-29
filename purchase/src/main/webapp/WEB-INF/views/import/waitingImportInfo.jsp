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
			for(let k=2; k<tableBody.children('tr:eq('+i+')').children().length; k++){
				let value = tableBody.children('tr:eq('+i+')').children('td:eq('+k+')').children().val();
				$(opener.document).find("#tableBody").children('tr:eq('+count+')').children('td:eq('+k+')').children(":first").val(value);
			}
			count += 1;
		}
	}
	// 입고수량 기본값을 미입고수량만큼 바꿔주는 메소드
	window.opener.changeIm_quantity();
	window.opener.getNewPage();
	window.close();	
}

// 행추가 메소드
function addRow(){
	let rowStr = "<tr>";
		rowStr += "<td><input type='checkbox' id='selectRow' name='selectRow'></td>";
		rowStr += "<td>"+(rowCount+1)+"</td>";
		rowStr += "<td><input readonly size='8px' id='product_code' name='wating_importsVO["+rowCount+"].product_code' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='16px' id='product_name' name='wating_importsVO["+rowCount+"].product_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='12px' id='spec' name='wating_importsVO["+rowCount+"].spec' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='12px' id='vender_name' name='wating_importsVO["+rowCount+"].vender_name' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly size='4px' type='text' id='ex_pakaging' name='wating_importsVO["+rowCount+"].ex_pakaging' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 100px; border: none;' type='number' id='waiting_qty' name='wating_importsVO["+rowCount+"].waiting_qty' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 100px; border: none;' type='number' id='order_im_qty' name='wating_importsVO["+rowCount+"].order_im_qty' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 100px; border: none;' type='number' id='order_noneIm_qty' name='order_noneIm_qty' onkeydown='if(event.keyCode == 13) return false'></td>"
		rowStr += "<td><input readonly style='width: 70px; border: none; type='number' id='price' name='wating_importsVO["+rowCount+"].price' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='width: 70px; border: none; background-color: WhiteSmoke;' type='number' id='im_price' name='im_price'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td><input readonly style='border: none;' type='text' id='order_description' name='wating_importsVO["+rowCount+"].order_description'></td>"
		
		rowStr += "<td hidden><input size='4px;' id='import_date' name='wating_importsVO["+rowCount+"].import_date' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input size='4px;' id='waiting_num' name='wating_importsVO["+rowCount+"].waiting_num' style='border: none;' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input id='order_page' name='wating_importsVO["+rowCount+"].order_page'></td>"
		rowStr += "<td hidden><input id='mem_id' name='wating_importsVO["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input id='vender_code' name='wating_importsVO["+rowCount+"].vender_code'></td>";
		rowStr += "<td hidden><input style='width: 90px; border: none;' type='number' id='pak_quantity' name='wating_importsVO["+rowCount+"].pak_quantity' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input size='8px' id='category_2nd' name='wating_importsVO["+rowCount+"].category_2nd' type='text' value=''  style='border: none;'  onkeydown='if(event.keyCode == 13) return false'></td>";
		rowStr += "<td hidden><input style='width: 100px; border: none;' type='number' id='order_num' name='wating_importsVO["+rowCount+"].order_num' onkeydown='if(event.keyCode == 13) return false'></td>";
		rowCount += 1;
	$("#tableBody").append(rowStr);
}


// 미입고내역 불러오는 메소드
function getWaitingListInfo(){
	$.ajax({
		url : '/import/getWaitingImportInfo',
		type : "post",
		dataType : 'text',
		data : {order_date : '${order_date}', order_page : '${order_page}',
                vender_code : '${vender_code}', category_2nd : '${category_2nd}'
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
				$("#tableBody").children('tr:eq('+i+')').find("#waiting_num").val(data[i].waiting_num);
				$("#tableBody").children('tr:eq('+i+')').find("#order_page").val(data[i].order_page);
				$("#tableBody").children('tr:eq('+i+')').find("#mem_id").val(data[i].mem_id);
				$("#tableBody").children('tr:eq('+i+')').find("#product_code").val(data[i].product_code);
				$("#tableBody").children('tr:eq('+i+')').find("#product_name").val(data[i].product_name);
				$("#tableBody").children('tr:eq('+i+')').find("#spec").val(data[i].spec);
				$("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val(data[i].ex_pakaging);
				$("#tableBody").children('tr:eq('+i+')').find("#order_im_qty").val(data[i].order_im_qty);
				$("#tableBody").children('tr:eq('+i+')').find("#waiting_qty").val(data[i].waiting_qty);
				$("#tableBody").children('tr:eq('+i+')').find("#price").val(data[i].price);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_code").val(data[i].vender_code);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_name").val(data[i].vender_name);
				$("#tableBody").children('tr:eq('+i+')').find("#order_description").val(data[i].order_description);
				$("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val(data[i].pak_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data[i].category_2nd);
				$("#tableBody").children('tr:eq('+i+')').find("#order_num").val(data[i].order_num);
				$("#tableBody").children('tr:eq('+i+')').find("#import_date").val(import_date);

				let order_im_qty = $("#tableBody").children('tr:eq('+i+')').find("#order_im_qty").val();
				let price = $("#tableBody").children('tr:eq('+i+')').find("#price").val();
				let waiting_qty = $("#tableBody").children('tr:eq('+i+')').find("#waiting_qty").val();
				$("#tableBody").children('tr:eq('+i+')').find("#im_price").val(order_im_qty * price);
				$("#tableBody").children('tr:eq('+i+')').find("#order_noneIm_qty").val(waiting_qty - order_im_qty);
            }
            window.opener.setShowVender_name($("#tableBody").children('tr:eq(0)').find("#vender_name").val());
		}
	});
}


$(document).ready(function() {
	getWaitingListInfo();

	//테이블의 tbody를 클릭하면 selected로 클래스를 토글(클로즈업)
    $('#tableBody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });

});
</script>

</head>

<body>
<!-- 상단 폼 -->
		<table class="table table-bordered table-hover" id="table_id">
			<thead style="background-color: rgb(148, 146, 146);" id="tableHead">
				<tr>
					<th><input type="checkbox" value="selectall" name="selectall" id="selectall" onclick="selectAll(this)"></th>
					<th>#</th>
					<th>품목코드</th>
					<th>품명</th>
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
		<input type="button" id="btnGetInfo" name="btnGetInfo" value="가져오기" onclick="getInfo()">
			<tbody class="tableBody" id="tableBody">
			</tbody>

		</table>
</form>
   
</body>

</html>
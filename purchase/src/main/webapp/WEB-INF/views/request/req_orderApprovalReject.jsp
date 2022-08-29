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



<script>
let rowCount = 0;
let rowVal = 0;
let selectedRow = 0;
let category_2nd_value = 0;
let noCategory = 'noCategory';
let delListCount = 0;

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



// 행추가 메소드
function addRow(){
	let rowStr = "<tr>";
		rowStr += "<td>"+(rowCount+1)+"</td>";
		rowStr += "<td><input readonly id='product_code' name='req_ordersList["+rowCount+"].product_code' onkeypress='javascript:if(event.keyCode==13) {addRow();}' size='10' type='text' value=''></td>";
		rowStr += "<td><input readonly id='product_name' name='req_ordersList["+rowCount+"].product_name' style='border: none;'></td>";
		rowStr += "<td><input readonly id='spec' name='req_ordersList["+rowCount+"].spec' style='border: none;'></td>";
		rowStr += "<td><input readonly id='maker_name' name='req_ordersList["+rowCount+"].maker_name' style='border: none;'></td>";
		rowStr += "<td><input readonly size='5px;' id='ex_pakaging' name='req_ordersList["+rowCount+"].ex_pakaging' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='req_quantity' name='req_ordersList["+rowCount+"].req_quantity'></td>";
		rowStr += "<td><input type='checkbox' id='approval' name='req_ordersList["+rowCount+"].approval'></td>";
		rowStr += "<td><input type='checkbox' id='req_reject' name='req_ordersList["+rowCount+"].req_reject'></td>";
		rowStr += "<td><input type='checkbox' id='mk_order' name='req_ordersList["+rowCount+"].mk_order' onClick='return false;'></td>";
		rowStr += "<td><input readonly type='text'size='30px;' id='description' name='req_ordersList["+rowCount+"].description'></td>";
		rowStr += "<td hidden><input readonly id='vender_code' name='req_ordersList["+rowCount+"].vender_code'></td>";
		rowStr += "<td hidden><input type='text' id='req_page' name='req_ordersList["+rowCount+"].req_page'></td>";
		rowStr += "<td hidden><input type='text' id='req_date' name='req_ordersList["+rowCount+"].req_date'></td>";
		rowStr += "<td hidden><input type='text' id='dep_code' name='req_ordersList["+rowCount+"].dep_code'></td>";
		rowStr += "<td hidden><input type='text' id='mem_id' name='req_ordersList["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input type='text' id='vender_name' name='req_ordersList["+rowCount+"].vender_name'></td>"
		rowStr += "<td hidden><input type='number' id='pak_quantity' name='req_ordersList["+rowCount+"].pak_quantity'></td>"
		rowStr += "<td hidden><input type='number' id='price' name='req_ordersList["+rowCount+"].price'></td>"
		rowStr += "<td hidden><input type='text' id='dep_name' name='req_ordersList["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input readonly id='maker_code' name='req_ordersList["+rowCount+"].maker_code'></td>";
		rowStr += "<td hidden><input readonly id='category_2nd' name='req_ordersList["+rowCount+"].category_2nd'></td>";
		rowStr += "<td hidden><input readonly id='req_no' name='req_ordersList["+rowCount+"].req_no'></td>";
		rowStr += "</tr>"
		rowCount += 1;
	$("#tableBody").append(rowStr);

}


// 요청내역 불러오는 메소드
function req_ordrInfo_pordList(){
	$.ajax({
		url : '/request/req_ordrInfo_pordList',
		type : "post",
		dataType : 'text',
		data : {req_date : '${req_date}', req_page : '${req_page}',
                dep_code : '${dep_code}', category_2nd : '${category_2nd}'},
		success : function(result) {
			let data = JSON.parse(result);
			let strArr = '';
            for(let i=0; i<data.length; i++){
				addRow();
				$("#tableBody").children('tr:eq('+i+')').find("#product_code").val(data[i].product_code);
				$("#tableBody").children('tr:eq('+i+')').find("#product_name").val(data[i].product_name);
				$("#tableBody").children('tr:eq('+i+')').find("#spec").val(data[i].spec);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_name").val(data[i].maker_name);
				$("#tableBody").children('tr:eq('+i+')').find("#ex_pakaging").val(data[i].ex_pakaging);
				$("#tableBody").children('tr:eq('+i+')').find("#req_quantity").val(data[i].req_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#vender_code").val(data[i].vender_code);
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
				$("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val(data[i].pak_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#price").val(data[i].price);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_name").val(data[i].dep_name);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_code").val(data[i].maker_code);
				$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data[i].category_2nd);
				$("#tableBody").children('tr:eq('+i+')').find("#req_no").val(data[i].req_no);

            }
		}
	});
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
    req_ordrInfo_pordList();
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
<!-- 상단 폼 -->
    <h3>물품청구 승인/반려</h3>
    <div style="display: block; text-align: left; margin-right: 5px;">
        	    <div style="display: inline-block;">
	    <div class="input-group-prepend">
				<span class="input-group-text">부서</span>
	    	<input type="text" id="req_dep_name" name="req_dep_name" value="${dep_name}" readonly class="form-control" size="9" >
	    	</div>
	    	</div>
	    <div style="display: inline-block; margin-right: 5px;">
            <!-- 카테고리(하) -->
            <div class="input-group-prepend">
				<span class="input-group-text">카테고리</span>
	            <input type="text" id="category_2nd" name="category_2nd" value="${category_2nd}" readonly hidden>
	            <input type="text" id="showCategory_2nd" name="showCategory_2nd" value="${category_2nd}" readonly class="form-control" size="9" >
            </div>
        </div>
        <div style="display: inline-block; margin-right: 5px;">
	        <div class="input-group-prepend">
			<span class="input-group-text">청구일자</span>
	            <input type="text" name="selectDate" id="selectDate" value="${req_date}" readonly class="form-control" size="9">
	        </div>
        </div>
        <div style="display: inline-block; margin-right: 5px;">
            <div class="input-group-prepend">
			<span class="input-group-text">페이지</span>
	            <input type="number" id="select_page" name="select_page" min="1" max="9999" readonly value="${req_page}" class="form-control" size="9">
	        </div>
        </div>  
        <div>
   </div>
<br>


<form id="req_orderList" name="req_orderList" method="post" action="/request/req_approvalRejectUpdate" onsubmit="return sendList();">
	<div style="float: left;">
		<input type="submit" id="send" name="send" value="저장" style="float: left;">
	</div>
		<table class="table table-bordered table-hover" id="table_id">
			<thead style="background-color: rgb(148, 146, 146);">
				<tr>
					<th>#</th>
					<th>품목코드</th>
					<th>품명</th>
					<th>규격</th>
					<th>제조사</th>
					<th>단위</th>
					<th>수량</th>
					<th hidden>청구부서코드</th>
					<th style="width: 90px;">승인</th>
					<th style="width: 90px;">반려</th>
					<th style="width: 90px;">발주</th>
					<th>비고</th>
				</tr>
			</thead>
				<tbody class="tableBody" id="tableBody">
			</tbody>
		</table>
</form>
</div>
</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
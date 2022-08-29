<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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


// 팝업 검색창에 값을 념겨주는 메소드
function getSelectedRow(){return selectedRow;}
function getCategory_1st(){return noCategory;}
function getCategory_2nd(){return '${category_2nd}';}
function getReq_date(){let val = $("#selectDate").val(); return val;}
function getReq_page(){let val = $("#select_page").val(); return val;}
function getTotalRow(){return rowCount;}
function setCategory_2nd(value){value = category_2nd_value;}
function getDate(){return $("#selectDate").val();}
function getPage(){return $("#select_page").val();}


let delReq_orderList = [];

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
		rowStr += "<td colspan='2'><input readonly id='product_code' name='req_ordersList["+rowCount+"].product_code' onkeypress='javascript:if(event.keyCode==13) {addRow();}' size='10' type='text' value='' style='border: none;'></td>";
		rowStr += "<td><input type='button' id='btnCodeSearch' name='btnCodeSearch'></td>"
		rowStr += "<td><input readonly  id='product_name' name='req_ordersList["+rowCount+"].product_name' style='border: none;'></td>";
		rowStr += "<td><input readonly id='spec' name='req_ordersList["+rowCount+"].spec' style='border: none;'></td>";
		rowStr += "<td><input readonly id='maker_name' name='req_ordersList["+rowCount+"].maker_name' style='border: none;'></td>";
		rowStr += "<td><input readonly size='5px;' id='ex_pakaging' name='req_ordersList["+rowCount+"].ex_pakaging' style='border: none;'></td>";
		rowStr += "<td><input size='3px;' id='req_quantity' name='req_ordersList["+rowCount+"].req_quantity' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='imported_qty' name='imported_qty' style='border: none;'></td>";
		rowStr += "<td><input readonly size='3px;' id='unimported_qty' name='req_ordersList["+rowCount+"].unimported_qty' style='border: none;'></td>";
		rowStr += "<td hidden><input id='vender_code' name='req_ordersList["+rowCount+"].vender_code' style='border: none;'></td>";
		rowStr += "<td><input type='checkbox' id='approval' name='req_ordersList["+rowCount+"].approval' onClick='return false;'></td>";
		rowStr += "<td><input type='checkbox' id='req_reject' name='req_ordersList["+rowCount+"].req_reject'onClick='return false;'></td>";
		rowStr += "<td><input type='checkbox' id='end_request' name='req_ordersList["+rowCount+"].end_request'onClick='return false;'></td>";
		rowStr += "<td><input type='text'size='30px;' id='description' name='req_ordersList["+rowCount+"].description' style='border: none;'></td>";
		rowStr += "<td hidden><input type='text' id='req_page' name='req_ordersList["+rowCount+"].req_page'></td>";
		rowStr += "<td hidden><input type='text' id='req_date' name='req_ordersList["+rowCount+"].req_date'></td>";
		rowStr += "<td hidden><input type='text' id='dep_code' name='req_ordersList["+rowCount+"].dep_code'></td>";
		rowStr += "<td hidden><input type='text' id='mem_id' name='req_ordersList["+rowCount+"].mem_id'></td>"
		rowStr += "<td hidden><input type='text' id='vender_name' name='req_ordersList["+rowCount+"].vender_name'></td>"
		rowStr += "<td hidden><input type='number' id='pak_quantity' name='req_ordersList["+rowCount+"].pak_quantity'></td>"
		rowStr += "<td hidden><input type='number' id='price' name='req_ordersList["+rowCount+"].price'></td>"
		rowStr += "<td hidden><input type='text' id='dep_name' name='req_ordersList["+rowCount+"].dep_name'></td>"
		rowStr += "<td hidden><input id='maker_code' name='req_ordersList["+rowCount+"].maker_code' style='border: none;'></td>";
		rowStr += "<td hidden><input id='category_2nd' name='req_ordersList["+rowCount+"].category_2nd' style='border: none;'></td>";
		rowStr += "<td hidden><input id='req_no' name='req_ordersList["+rowCount+"].req_no' style='border: none;'></td>";
		rowStr += "</tr>"
		rowCount += 1;
	$("#tableBody").append(rowStr);

}
// 행 삭제 메소드
function delRow(){
	$("input:checkbox[name='selectRow']:checked").each(function(k,kVal){
			let a = $(this).parent().parent();
		//let a = kVal.parentElement.parentElement;
			if(a.find("td:eq(12)").find("#approval").is(':checked') || a.find("td:eq(13)").find("#req_reject").is(':checked')){
				alert("승인 또는 반려된 항목은 삭제할 수 없습니다.");
			}else{
                if(!(a.find("td:eq(23)").find("#req_no").val() == '')){
                $("#delList").append("<input type='text' id='delNo' name='delNo' value='"+a.find("td:eq(23)").find("#req_no").val()+"' hidden>");
                }
			$(a).remove();
			}
	});
	$("#selectall").prop("checked", false);
	rowCount = document.getElementById("tableBody").childNodes.length;
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
				$("#tableBody").children('tr:eq('+i+')').find("#unimported_qty").val(data[i].unimported_qty);
				let req_quantity = $("#tableBody").children('tr:eq('+i+')').find("#req_quantity").val();
				let unimported_qty = $("#tableBody").children('tr:eq('+i+')').find("#unimported_qty").val();
				$("#tableBody").children('tr:eq('+i+')').find("#imported_qty").val(req_quantity - unimported_qty);
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
				if(data[i].end_request == '1'){
					$("#tableBody").children('tr:eq('+i+')').find("#end_request").attr("checked", true);
				}
				$("#tableBody").children('tr:eq('+i+')').find("#pak_quantity").val(data[i].pak_quantity);
				$("#tableBody").children('tr:eq('+i+')').find("#price").val(data[i].price);
				$("#tableBody").children('tr:eq('+i+')').find("#dep_name").val(data[i].dep_name);
				$("#tableBody").children('tr:eq('+i+')').find("#maker_code").val(data[i].maker_code);
				$("#tableBody").children('tr:eq('+i+')').find("#category_2nd").val(data[i].category_2nd);
				$("#tableBody").children('tr:eq('+i+')').find("#req_no").val(data[i].req_no);
				if($("#tableBody").children('tr:eq('+i+')').find("#approval").is(":checked") ||
				   $("#tableBody").children('tr:eq('+i+')').find("#req_reject").is(":checked") ||
				   $("#tableBody").children('tr:eq('+i+')').find("#end_request").is(":checked")){
					$("#tableBody").children('tr:eq('+i+')').find("#req_quantity").prop("readonly", true);
				   }
                
            }
		}
	});
}
// 검색버튼 클릭시
$(function(){
	$("#tableBody").on("click", "input[name='btnCodeSearch']", function(){
		selectedRow = $(this).parent().parent().index();
		window.open("/request/productSearchPopup","productSearchPopup","width=600, height=450, top=150, left=200");
	});
})

function sendDelList(){
    var delData = $("form[name=delListForm]").serializeArray();
    $.ajax({
        url : '/request/req_orderDel',
		type : "post",
		dataType : 'text',
		data : delData,
		success : function(result) {}
    })
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


	//저장버튼 클릭시 유효성검사
	$("#send").on("click", function(){
		$("#send").removeAttr();
		let pass = true;
		let passCount = 0;
		for(i=0; i<rowCount; i++){
			if($("#product_code:eq("+i+")").val().length == 0){
				passCount += 1;
			}
            if($("#tableBody").children().length > 1){
				if(($("#req_quantity:eq("+i+")").val().length == 0)||($("#req_quantity:eq("+i+")").val() == 0)){
					alert("수량을 입력하지 않은 품목이 있습니다!");
					return false;
				}
        }
		}
        $("#req_orderList").submit();
	});



});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<!-- 상단 폼 -->
<div class="card-body">
    <h3>청구서 내역</h3>
    <div style="text-align: left;">
    	    <div style="display: inline-block;">
	    <div class="input-group-prepend">
				<span class="input-group-text">부서</span>
	    	<input type="text" id="req_dep_name" name="req_dep_name" value="${dep_name}" readonly class="form-control" size="9" >
	    	</div>
	    	</div>
	    <div style="display: inline-block;">
          	<div class="input-group-prepend">
				<span class="input-group-text">카테고리</span>
	            <!-- 카테고리(하) -->
	            <input type="text" id="category_2nd" name="category_2nd" value="${category_2nd}" readonly hidden>
	            <input type="text" id="showCategory_2nd" name="showCategory_2nd" value="" readonly class="form-control" size="9">
	        </div>
        </div>
        <div style="display: inline-block;">
            <input type="text" name="selectDate" id="selectDate" value="${req_date}" readonly class="form-control" size="9">
        </div>
        <div style="display: inline-block;">
        	<div class="input-group-prepend">
				<span class="input-group-text">페이지</span>
            	<input type="number" id="select_page" name="select_page" min="1" max="9999" readonly value="${req_page}" class="form-control" size="9">
            </div>
        </div>
        <div>
            <input type="button" id="btnDelRow" name="btnDelRow" value="행추가" onclick="addRow();">
            <input type="button" id="btnDelRow" name="btnDelRow" value="행삭제" onclick="delRow();">
        </div>
    </div>		
</div>

<br>


<form id="req_orderList" name="req_orderList" method="post" action="/request/req_orderUpdate" onsubmit="sendDelList();">
	<div class="card-body">
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
					<th>청구수량</th>
					<th>불출수량</th>
					<th>잔여수량</th>
					<th hidden>청구부서코드</th>
					<th style="width: 90px;">승인</th>
					<th style="width: 90px;">반려</th>
					<th style="width: 90px;">종결</th>
					<th>비고</th>
				</tr>
			</thead>

        <input type="button" id="gotoList" name="gotoList" value="목록" onclick="location.href='/request/requestOrder_List'" style="float: left; margin-right: 5px">
		<input type="submit" id="send" name="send" value="저장" style="float: left; margin-right: 5px">
			<tbody class="tableBody" id="tableBody">
			</tbody>

		</table>
	</div>
</form>

<form id="delListForm" name="delListForm" method="post" action="/request/req_orderDel">
    <div id="delList">
    </div>
    <input type="submit" id="btnDel" name="btnDel" value="전송" hidden>
</form>

  </div> 
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
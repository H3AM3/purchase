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
<link rel="stylesheet" href="/resources/css/defaultForm.css">

</head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
  <title>Test</title>

<style>


.halfTable{
	width: 45%;
	display: inline-block;
	vertical-align: top;
}

.halfTable tr td{
	font-weight: bold;
}

.tableBody{
}
</style>

<!--캘린더-->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />


<script>
// 팝업창에 값을 넘겨주는 용도의 메소드
function getSelectedDate1(){return $("#selectDate1").val();}
function getSelectedDate2(){return $("#selectDate2").val();}
function getCategory_2nd(){return $("#category_2nd").val();}


$(function () {
    $('#datetimepicker1').datetimepicker({ format: 'YYYY-MM-DD', date: moment().subtract(1, "weeks").format()});
    $('#datetimepicker2').datetimepicker({ date: moment().format(),
        format: 'YYYY-MM-DD',
    });
    $("#datetimepicker1").on("change.datetimepicker", function (e) {
        $('#datetimepicker2').datetimepicker('minDate', e.date);
    });
    $("#datetimepicker2").on("change.datetimepicker", function (e) {
        $('#datetimepicker1').datetimepicker('maxDate', e.date);
    });
});

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


//집계 메소드
function statistics(){
	$("#tbodyL").empty();
	$("#tbodyR").empty();
	if($("#prodKeyword").val() == ''){
		alert("품목을 입력해주세요.");
		return false;
	}else{
		$.ajax({
			url : '/statistics/getReqStatistics',
			type : 'post',
			dataType : 'text',
			data : {category_2nd : $("#category_2nd").val(), dep_code : $("#depKeyword").val(),
					selectDate1 : $("#selectDate1").val(), selectDate2 : $("#selectDate2").val(),
					product_code : $("#prodKeyword").val()
					},
			success : function(result){
				let data = JSON.parse(result);
				console.log(data);
				let totalCount = 0;
				for(let i=0; i<data.length; i++){
					let slicedDate = data[i].req_date.replace(' 00:00:00', '');
					let arryStr = "";
					arryStr += '<tr class="tableBody">';
					arryStr += '<td>'+slicedDate+'</td>';
					arryStr += '<td>'+data[i].req_quantity+'</td>';
					arryStr += '<td>'+data[i].ex_pakaging+'</td>';
					arryStr += "</tr>";
					$("#tbodyL").append(arryStr);
					totalCount += data[i].req_quantity;
				}
				let str = '<tr><td><a>합계</a></td><td>'+totalCount+'</td><tr>'
				$("#tbodyL").append(str);
			}
		});
		$.ajax({
			url : '/statistics/getExportStatistics',
			type : 'post',
			dataType : 'text',
			data : {category_2nd : $("#category_2nd").val(), dep_code : $("#depKeyword").val(),
					selectDate1 : $("#selectDate1").val(), selectDate2 : $("#selectDate2").val(),
					product_code : $("#prodKeyword").val()
					},
			success : function(result){
				let data = JSON.parse(result);
				console.log(data);
				let totalCount = 0;
				for(let i=0; i<data.length; i++){
					let slicedDate = data[i].export_date.replace(' 00:00:00', '');
					console.log(data);
					let arryStr = "";
					arryStr += '<tr class="tableBody">';
					arryStr += '<td>'+slicedDate+'</td>';
					arryStr += '<td>'+data[i].ex_quantity+'</td>';
					arryStr += '<td>'+data[i].ex_pakaging+'</td>';
					arryStr += "</tr>";
					$("#tbodyR").append(arryStr);
					totalCount += data[i].ex_quantity;
				}
				let str = '<tr><td><a>합계</a></td><td>'+totalCount+'</td><tr>'
				$("#tbodyR").append(str);
			}
		});
	}
}

$(document).ready(function(){
    getUpperCat();
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
				let catObj = JSON.parse(result);
				// 리턴값을 받아서 하위 카테고리 생성
				setCategory(catObj, lowerCat);
			}
		});
	});

	$("#btnProdSearch").on("click", function(){
		if($("#category_2nd").val() == 'none'){
			alert("하위 카테고리를 선택해주세요.");
		}else{
			window.open("/statistics/productSearchPopup","productSearchPopup","width=1200, height=900, top=150, left=200");
		}
	});

	$("#btnDepSearch").on("click", function(){
		if($("#category_2nd").val() == 'none'){
			alert("하위 카테고리를 선택해주세요.");
		}else{
			window.open("/statistics/depSearchPopup","depSearchPopup","width=1200, height=900, top=150, left=200");
		}
	});

});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<h3>요청/출고내역 집계</h3>

<!-- 날짜 영역 -->
<div style="display: inline-block;">
    <!-- 카테고리(상) -->
    <select class="form-control datetimepicker-input" id="category_1st" name="category_1st">
        <option value="none" selected>대분류</option>
    </select>
</div>
<div  style="display: inline-block; margin-right: 15px">
    <!-- 카테고리(하) -->
    <select class="form-control datetimepicker-input" id="category_2nd">
        <option value="none" selected>소분류</option>
    </select>
</div>
<div class='col-md-2 col-xs-2' style="display: inline-block; margin-right: 0px">
    <div class="form-group">
        <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
            <input type="text" class="form-control datetimepicker-input" id="selectDate1" name="selectDate1" data-target="#datetimepicker1" value="">
            <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
            </div>
        </div>
    </div>
</div>
<div class='col-md-2 col-xs-2' style="display: inline-block; margin-right: 15px">
    <div class="form-group">
        <div class="input-group date" id="datetimepicker2" data-target-input="nearest">
            <input type="text" class="form-control datetimepicker-input" id="selectDate2" name="selectDate2" data-target="#datetimepicker2" value="">
            <div class="input-group-append" data-target="#datetimepicker2" data-toggle="datetimepicker">
                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
            </div>
        </div>
    </div>
</div>
<div style="display: inline-block;">
	<input type="image" src="/resources/image/searchIcon.png" id="btnDepSearch" name="btnDepSearch" value="" onclick="">
	<input type="text" readonly id="depKeyword"	name="depKeyword" value="" placeholder="부서명" size="15px">
	<input type="image" src="/resources/image/searchIcon.png" id="btnProdSearch" name="btnProdSearch" value="">
	<input type="text" readonly id="prodKeyword"	name="prodKeyword" value="" placeholder="품목" size="15px">    
    <input type="submit" id="btnSend2" name="btnSend" value="" hidden>
    <input type="button" id="btnSend" name="btnSend" value="집계" onclick="statistics();">
</div>

<div class="allTable">
<div class="halfTable">
	<table class="table" style="margin-top: 10px;">
		<thead>
			<tr>
				<th>요청일자</th>
				<th>요청수량</th>
				<th>단위</th>
			</tr>
		</thead>
		<tbody id="tbodyL" class="tableBody">

		</tbody>
	</table>
</div>
<div class="halfTable">
	<table class="table" style="margin-top: 10px;">
		<thead>
			<tr>
				<th>출고일자</th>
				<th>출고수량</th>
				<th>단위</th>
			</tr>
		</thead>
		<tbody id="tbodyR" class="tableBody">

		</tbody>
	</table>
</div>
</div>
</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
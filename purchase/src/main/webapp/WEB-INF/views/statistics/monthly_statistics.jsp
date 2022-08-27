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
<link rel="stylesheet" href="/resources/css/defaultForm.css">
</head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
  <title>Test</title>

<style>
.tableBody tr td {
	padding: 0;
	font-size: 15px;
	border: #9c9c9c solid 1px;
}

.tableBody tr th {
	padding: 0;
	font-size: 15px;
	border: #9c9c9c solid 1px;
	background-color: #949292;
}
</style>




<script>
// 팝업창에 값을 넘겨주는 용도의 메소드
function getSelectedDate1(){return $("#selectDate1").val();}
function getSelectedDate2(){return $("#selectDate2").val();}
function getCategory_2nd(){return $("#category_2nd").val();}

//연도 리스트 메소드
function getYear(){
	let yearCount = 2099;
	let date = new Date();
	let thisYear = date.getFullYear();
	for(let i=0; i<100; i++){
		if(yearCount < thisYear){
			$("#yearSelect").append("<option value='"+yearCount+"'>"+yearCount+"</option>");
		} else if(yearCount > thisYear){
			$("#yearSelect").append("<option hidden value='"+yearCount+"'>"+yearCount+"</option>");
		} else if(yearCount = thisYear){
			$("#yearSelect").append("<option selected value='"+yearCount+"'>"+yearCount+"</option>");
		}
		yearCount += -1;
	}
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


// 집계 메소드
function statistics(){
	// 품목데이터 가져오기
	let product_codePakaging = '단위 : ';
	let product_codePrice = 0;

	// 입고내역 집계
	let thisYearTotalQty = 0;
	let thisYearTotalPrice = 0;
	let prevYearLastMonthQty = 0;
	let prevYearLastMonthPrice = 0;

	let year2FirstDate = '';
	let year2LastDate = '';
	let last2Month = '';

	if($("#prodKeyword").val() == ''){
		alert("품목을 입력해주세요.");
		return false;
	}else{
		for(let i=0; i<12; i++){
			let selectedYear = $("#yearSelect").val();
			let tmp = '0'+(i+1);
			tmp = tmp.slice(-2);
			let firstDate = selectedYear+"-"+tmp+"-"+01;
			
			let lastDateBeforeChange = new Date(selectedYear, i+1, 0);
			let year = lastDateBeforeChange.getFullYear();
			let month = ('0' + (lastDateBeforeChange.getMonth() + 1)).slice(-2);
			let day = ('0' + lastDateBeforeChange.getDate()).slice(-2);
			let lastDate = year+"-"+month+"-"+day;

			$.ajax({
				url : '/statistics/getMonthlyReqStatistics',
				type : 'post',
				dataType : 'text',
				async : false,
				data : {selectDate1 : firstDate, selectDate2 : lastDate,
						product_code : $("#prodKeyword").val()
						},
				success : function(result){
					console.log(result);
					let count = i+1;
					if(result != ''){
						let data = JSON.parse(result);
						$("#qtyLine").children("td").eq(count).text(data.ex_quantity);
						$("#priceLine").children("td").eq(count).text(data.price);
						thisYearTotalQty += data.ex_quantity;
						thisYearTotalPrice += data.price;
					}else if(result == ''){
						$("#qtyLine").children("td").eq(count).text('0');
						$("#priceLine").children("td").eq(count).text('0');
					}
					
				}
			});
			$("#qtyLine").children("td").eq(13).text(thisYearTotalQty);
			$("#priceLine").children("td").eq(13).text(thisYearTotalPrice);
			$("#qtyLine").children("td").eq(14).text((thisYearTotalQty/12).toFixed(2));
			let avgQty = $("#qtyLine").children("td").eq(14).text();
			$("#priceLine").children("td").eq(14).text((avgQty*(thisYearTotalPrice/thisYearTotalQty)).toFixed(2));
		}
		let prevYear = $("#yearSelect").val()-1;
		let yearFirstDate = prevYear+"-01-01";
		let yearLastDate = prevYear+"-12-31";
		let lastMonth = prevYear+"-12-01";

		let prevYear2 = $("#yearSelect").val()-2;
		year2FirstDate = prevYear2+"-01-01";
		year2LastDate = prevYear2+"-12-31";
		last2Month = prevYear2+"-12-01";
		$.ajax({
			url : '/statistics/getPrevYear',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {selectDate1 : yearFirstDate, selectDate2 : yearLastDate,
					product_code : $("#prodKeyword").val()},
			success : function(result){
				if(result != ''){
						let data = JSON.parse(result);
						console.log(data);
						$("#qtyLine").children("td").eq(0).text(data.ex_quantity);
						$("#priceLine").children("td").eq(0).text(data.price);
					}else if(result == ''){
						$("#qtyLine").children("td").eq(0).text('0');
						$("#priceLine").children("td").eq(0).text('0');
					}
			}
		});
		$.ajax({
			url : '/statistics/getPrevYear',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {selectDate1 : lastMonth, selectDate2 : yearLastDate,
					product_code : $("#prodKeyword").val()},
			success : function(result){
				let data = JSON.parse(result);
				console.log(data);
				if(result != ''){
					prevYearLastMonthQty = data.ex_quantity;
					prevYearLastMonthPrice = data.price;
				}else if(result == ''){
					prevYearLastMonthQty = 0;
					prevYearLastMonthPrice = 0;
				}
			}
		});
		
		let firstMonth = $("#qtyLine").children("td").eq(1).text() - prevYearLastMonthQty;
		let prevYearTotalQty = $("#qtyLine").children("td").eq(0).text();

		$("#increaseLine").children("td").eq(1).text(firstMonth);
		$("#increaseLine").children("td").eq(13).text(thisYearTotalQty - prevYearTotalQty);
		for(let i=0; i<11; i++){
			let prevMonthQty = $("#qtyLine").children("td").eq(i+1).text();
			let thisMonthQty = $("#qtyLine").children("td").eq(i+2).text();
			$("#increaseLine").children("td").eq(i+2).text(thisMonthQty-prevMonthQty);
		}

		// 출고내역 집계
		let thisYearOrderTotalQty = 0;
		for(let i=0; i<12; i++){
			let selectedYear = $("#yearSelect").val();
			let tmp = '0'+(i+1);
			tmp = tmp.slice(-2);
			let firstDate = selectedYear+"-"+tmp+"-"+01;
			
			let lastDateBeforeChange = new Date(selectedYear, i+1, 0);
			let year = lastDateBeforeChange.getFullYear();
			let month = ('0' + (lastDateBeforeChange.getMonth() + 1)).slice(-2);
			let day = ('0' + lastDateBeforeChange.getDate()).slice(-2);
			let lastDate = year+"-"+month+"-"+day;

			$.ajax({
				url : '/statistics/getMonthlyOrderStatistics',
				type : 'post',
				dataType : 'text',
				async : false,
				data : {selectDate1 : firstDate, selectDate2 : lastDate,
						product_code : $("#prodKeyword").val()
						},
				success : function(result){
					console.log(result);
					let count = i+1;
					if(result != ''){
						let data = JSON.parse(result);
						$("#orderQtyLine").children("td").eq(count).text(data.ex_quantity);
						thisYearOrderTotalQty += data.ex_quantity;
					}else if(result == ''){
						$("#orderQtyLine").children("td").eq(count).text('0');
					}
				}
			});
			$("#orderQtyLine").children("td").eq(13).text(thisYearOrderTotalQty);
			$("#orderQtyLine").children("td").eq(14).text((thisYearOrderTotalQty/12).toFixed(2));
		}

		$.ajax({
			url : '/statistics/getOrderPrevYear',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {selectDate1 : yearFirstDate, selectDate2 : yearLastDate,
					product_code : $("#prodKeyword").val()},
			success : function(result){
				if(result != ''){
						let data = JSON.parse(result);
						console.log(data);
						$("#orderQtyLine").children("td").eq(0).text(data.ex_quantity);
					}else if(result == ''){
						$("#orderQtyLine").children("td").eq(0).text('0');
					}
			}
		});
		$.ajax({
			url : '/statistics/getOrderPrevYear',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {selectDate1 : lastMonth, selectDate2 : yearLastDate,
					product_code : $("#prodKeyword").val()},
			success : function(result){
				let data = JSON.parse(result);
				console.log(data);
				if(result != ''){
					prevYearLastMonthQty = data.ex_quantity;
				}else if(result == ''){
					prevYearLastMonthQty = 0;
				}
			}
		});

		$.ajax({
			url : '/statistics/getProductInfo',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {product_code : $("#prodKeyword").val()},
			success : function(result){
				let data = JSON.parse(result);
				console.log(data);
				product_codePrice = data.price;
				product_codePakaging += data.ex_pakaging;
				for(let i=0; i<12; i++){
					let qty = $("#orderQtyLine").children("td").eq(i+1).text();
					$("#orderPriceLine").children("td").eq(i+1).text(data.price * qty);
				}
			}
		});
		
		firstMonth = $("#orderQtyLine").children("td").eq(1).text() - prevYearLastMonthQty;
		prevYearTotalQty = $("#orderQtyLine").children("td").eq(0).text();

		$("#orderIncreaseLine").children("td").eq(1).text(firstMonth);
		$("#orderIncreaseLine").children("td").eq(13).text(thisYearOrderTotalQty - prevYearTotalQty);
		$("#req_thead").find("tr").children("th").eq(0).text(product_codePakaging);
		$("#order_thead").find("tr").children("th").eq(0).text(product_codePakaging);

		let qty = $("#orderQtyLine").children("td").eq(0).text();
		$("#orderPriceLine").children("td").eq(0).text(product_codePrice * qty);
		qty = $("#orderQtyLine").children("td").eq(13).text();
		$("#orderPriceLine").children("td").eq(13).text(product_codePrice * qty);
		qty = $("#orderQtyLine").children("td").eq(14).text();
		$("#orderPriceLine").children("td").eq(14).text((product_codePrice * qty).toFixed(2));

		for(let i=0; i<11; i++){
			let prevMonthQty = $("#orderQtyLine").children("td").eq(i+1).text();
			let thisMonthQty = $("#orderQtyLine").children("td").eq(i+2).text();
			$("#orderIncreaseLine").children("td").eq(i+2).text(thisMonthQty-prevMonthQty);
		}
	}


	$.ajax({
		url : '/statistics/getPrevYear',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {selectDate1 : year2FirstDate, selectDate2 : year2LastDate,
					product_code : $("#prodKeyword").val()},
			success : function(result){
				let prevYear2LastMonthQty = 0;
				let prevYear2LastMonthPrice = 0;
				if(result != ''){
					let data = JSON.parse(result);
					console.log(data);
					prevYear2LastMonthQty = data.ex_quantity;
					prevYear2LastMonthPrice = data.price;
				}else if(result == ''){
					prevYear2LastMonthQty = 0;
					prevYear2LastMonthPrice = 0;
				}
				let prevYearQty = $("#qtyLine").children("td").eq(0).text();
				$("#increaseLine").children("td").eq(0).text(prevYear2LastMonthQty-prevYearQty);
			}
	});
	$.ajax({
		url : '/statistics/getOrderPrevYear',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {selectDate1 : year2FirstDate, selectDate2 : year2LastDate,
					product_code : $("#prodKeyword").val()},
			success : function(result){
				let prevYear2LastMonthQty = 0;
				let prevYear2LastMonthPrice = 0;
				if(result != ''){
					let data = JSON.parse(result);
					console.log(data);
					prevYear2LastMonthQty = data.ex_quantity;
					prevYear2LastMonthPrice = data.price;
				}else if(result == ''){
					prevYear2LastMonthQty = 0;
					prevYear2LastMonthPrice = 0;
				}
				let prevYearQty = $("#orderQtyLine").children("td").eq(0).text();
				$("#orderIncreaseLine").children("td").eq(0).text(prevYear2LastMonthQty-prevYearQty);
			}
	});
}

$(document).ready(function(){
    getUpperCat();
	getYear();
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

});
</script>

</head>

<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="body">
<h3>월간 입고/소모내역 집계</h3>

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

<div style="display: inline-block; margin-right: 25px;">
	<a>연도 선택</a>
	<select name="yearSelect" id="yearSelect" style="width: 70px;">

	</select>
</div>

<div style="display: inline-block;">
	<input type="image" src="/resources/image/searchIcon.png" id="btnProdSearch" name="btnProdSearch" value="">
	<input type="text" readonly id="prodKeyword"	name="prodKeyword" value="" placeholder="품목" size="15px">    
    <input type="submit" id="btnSend2" name="btnSend" value="" hidden>
    <input type="button" id="btnSend" name="btnSend" value="집계" onclick="statistics();">
</div>

<div class="reqTable">
	<h3 style="float: left;">입고내역</h3>
	<table class="table" style="margin-top: 10px;">
		<thead class="thead" id="req_thead">
			<tr>
				<th>단위 : </th>
				<th>전년도</th>
				<th>1월</th>
				<th>2월</th>
				<th>3월</th>
				<th>4월</th>
				<th>5월</th>
				<th>6월</th>
				<th>7월</th>
				<th>8월</th>
				<th>9월</th>
				<th>10월</th>
				<th>11월</th>
				<th>12월</th>
				<th>합계</th>
				<th>연평균</th>
			</tr>
		</thead>

		<tbody id="tbody" class="tableBody">
			<tr id="qtyLine">
				<th>수량</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr id="priceLine">
				<th>금액</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr id="increaseLine">
				<th>증감</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>

<div class="reqTable">
	<h3 style="float: left;">출고내역</h3>
	<table class="table" style="margin-top: 10px;">
		<thead class="thead" id="order_thead">
			<tr>
				<th>단위 : </th>
				<th>전년도</th>
				<th>1월</th>
				<th>2월</th>
				<th>3월</th>
				<th>4월</th>
				<th>5월</th>
				<th>6월</th>
				<th>7월</th>
				<th>8월</th>
				<th>9월</th>
				<th>10월</th>
				<th>11월</th>
				<th>12월</th>
				<th>합계</th>
				<th>연평균</th>
			</tr>
		</thead>

		<tbody id="orderTbody" class="tableBody">
			<tr id="orderQtyLine">
				<th>수량</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr id="orderPriceLine">
				<th>금액</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr id="orderIncreaseLine">
				<th>증감</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>
</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
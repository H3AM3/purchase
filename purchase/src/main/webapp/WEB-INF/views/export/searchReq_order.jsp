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

<!--캘린더-->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />


<script>
let orderList = $("#orderList");
let category_2nd = window.opener.getCategory_2nd();

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

function searchList(){
    $("#btnSend").removeAttr('disabled');
		if($("#category_2nd").val() == 'none'){
			alert("분류를 골라주세요!");
		    return false;
		}
        $("#orderList").children().remove();;
        //검색 ajax
		$.ajax({
			url : '/export/getReqList',
			type : "post",
			dataType : 'text',
			data : {
				selectDate1 : $("#selectDate1").val(),
                selectDate2 : $("#selectDate2").val(),
                category_2nd : category_2nd
			},
			success : function(result) {
				Order_List = JSON.parse(result);
                for(i=0; i<Order_List.length; i++){
                let date = Order_List[i].req_date;
                let newDate = date.replace(' 00:00:00', '');
                newDate_page = newDate + ' / page : ' + Order_List[i].req_page;
				$("#orderList").append("<tr>");
                $("#orderList").append("<td><a href='/export/req_orderInfo?req_date="+newDate+"&req_page="+Order_List[i].req_page+"&dep_code="+Order_List[i].dep_code+"&category_2nd="+category_2nd+"&end_request=0'>"+newDate_page+"<a></td>");
                $("#orderList").append("<td>"+Order_List[i].dep_name+"</td>");
                $("#orderList").append("</tr>");
			}
			}
		});
	};

$(document).ready(function(){
    getUpperCat();
	searchList();
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
				catObj = JSON.parse(result);
				// 리턴값을 받아서 하위 카테고리 생성
				setCategory(catObj, lowerCat);
			}
		});
	});
});

    // 카테고리 선택 이전에 검색버튼 클릭시

</script>

</head>

<body>
<h3>물품청구서 미입고내역 조회</h3>

<!-- 날짜 영역 -->
<form id="CatDatePageForm" name="CatDatePageForm" method="post" action="/request/getReqOrder_List">
<div class='col-md-3 col-xs-3' style="display: inline-block;">
    <div class="form-group">
        <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
            <input type="text" class="form-control datetimepicker-input" id="selectDate1" name="selectDate1" data-target="#datetimepicker1" value="">
            <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
            </div>
        </div>
    </div>
</div>
<div class='col-md-3 col-xs-3' style="display: inline-block;">
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
    <input type="button" id="btnSend" name="btnSend" value="검색" onclick="searchList()">
    <input type="submit" id="btnSend2" name="btnSend" value="" hidden>
</div>
</form>
<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
	<thead class="thead-dark">
	  <tr>
		<th>청구일자</th>
		<th>청구부서</th>
	  </tr>
	</thead>
	<tbody id="orderList">

	</tbody>
  </table>
   
</body>

</html>
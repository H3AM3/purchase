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
</head>

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
let parent_category_2nd = window.opener.getCategory_2nd();
let mem_id = "<c:out value='${sessionScope.loginStatus.mem_id}'/>";

// 달력 메소드
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

function searchList(){
	$("#tableBody").empty();
	$.ajax({
		url : '/import/getWaitingList',
		type : "post",
		dataType : 'text',
		async : false,
		data : {category_2nd : parent_category_2nd, import_end : '0',
				selectedDate1 :$("#selectDate1").val(), selectedDate2 : $("#selectDate2").val(),
                keyword : $("#keyword").val()
				},
		success : function(result) {
			data = JSON.parse(result);
			for(let i=0; i<data.length; i++){
				let arrStr = "";
				let newDate = data[i].order_date.replace(' 00:00:00', '');
				arrStr += '<tr>';
				arrStr += '<td><a href="/import/waitingImportInfo?order_date='+newDate+'&order_page='+data[i].order_page+'&vender_code='+data[i].vender_code+'&category_2nd='+parent_category_2nd+'" >'+newDate+' - '+data[i].order_page+'</a></td>';
				arrStr += '<td>'+data[i].vender_name+'</td>'
				arrStr += '</tr>';
				$("#tableBody").append(arrStr);
			}
		}
	})
}

$(document).ready(function(){
	searchList();

});
</script>


<body>
<h3>미입고 리스트</h3>
<!-- 날짜 영역 -->
<div class='col-xs-2' style="display: inline-block;">
    <div class="form-group">
        <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
            <input type="text" class="form-control datetimepicker-input" id="selectDate1" name="selectDate1" data-target="#datetimepicker1" value="">
            <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
            </div>
        </div>
    </div>
</div>
<div class='col-xs-2' style="display: inline-block;">
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
	<input type="text" id="keyword" name="keyword" placeholder="거래처명">
    <input type="button" id="btnSend" name="btnSend" value="검색" onclick="searchList()" onkeydown="if(event.keyCode==13){searchList()}">
</div>

<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
	<thead class="thead-dark">
	  <tr>
		<th>발주일자-페이지</th>
		<th>거래처</th>
	  </tr>
	</thead>
	<tbody id="tableBody">

	</tbody>
  </table>

</body>

</html>
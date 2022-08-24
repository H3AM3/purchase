<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
</head>
<style>
.body{
	margin: 20px;

}
.codeList{
	border: 1px solid #e9e9e9;
}
.tableBody:hover{
	background-color: #e9e9e9;
}
.searchBar{
	margin-left: 1px;
	margin-bottom: 10px;
}
</style>

<body>
<%@include file="/WEB-INF/views/include/common.jsp"%>
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>
<div class="body">
<h3>품목코드 검색</h3><br>


<!-- 검색창 영역 -->
<div style="float: left;" class="searchBar">
	<form name="searchForm" id="searchForm" onsubmit="false">
	<input type="text" id="keyword" name="keyword" onkeypress="if(event.keyCode=='13'){event.preventDefault(); keywordSearch()}" placeholder="검색어">
	<input type="button" id="btnSearch" name="btnSearch" value="검색" onclick="keywordSearch();">
	</form>
</div>


<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
  <thead class="thead-dark">
    <tr>
      <th>품목코드</th>
      <th>품명</th>
      <th>규격</th>
      <th>거래처</th>
    </tr>
  </thead>
  <tbody id="codeList" class="codeList">
  </tbody>
</table>
</div>
<script>
let selectDate1 = window.opener.getSelectedDate1();
let selectDate2 = window.opener.getSelectedDate2();
let category_2nd = window.opener.getCategory_2nd();

function selectCode(product_code){
	window.opener.$("#prodKeyword").val(product_code);
	window.close();
}

function keywordSearch(){
	$("#codeList").empty();
	$.ajax({
		url : '/statistics/searchProduct',
		type : "post",
		dataType : 'text',
		data : {category_2nd : category_2nd,
				keyword : $("#keyword").val()},
		success : function(result) {
			let data = JSON.parse(result);
			console.log(data);
			for(let i=0; i<data.length; i++){
			let arryStr = "";
			arryStr += "<tr class='tableBody'>";
			arryStr += '<td><a href="#" onclick="selectCode(\''+data[i].product_code+'\');">'+data[i].product_code+'</a></td>'
			arryStr += '<td>'+data[i].product_name+'</td>'
			arryStr += "<td>"+data[i].spec+"</td>"
			arryStr += "<td>"+data[i].vender_name+"</td>"
			arryStr += "</tr>";
			$("#codeList").append(arryStr);
			}
		}
	});
}


$(document).ready(function() {
	keywordSearch();
});

</script>
</body>
</html>
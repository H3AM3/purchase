<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<%@include file="/WEB-INF/views/include/common.jsp"%>

<link rel="stylesheet" href="/resources/css/defaultForm.css">
<style>

</style>


<body>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<div class="body">
<h3>사용자 계정 목록</h3><br>
<div style="width: 800px; margin: 0 auto;">
<!-- 카테고리 영역 -->
<div style="display: inline-block;">
<div class="input-group-prepend">
	<span class="input-group-text">상위부서</span>
	<form id="selectDep" name="selectDep" action="" method="post">
		<!-- 상위부서 -->
		<select id="upper_dep" name="upper_dep">
			<option value=none selected>없음</option>
		</select>
	</form>
</div>
</div>

<!-- 검색창 영역 -->
<div style="display: inline-block; margin-right: 20px">
<form name="searchForm" id="searchForm" onsubmit="false">
<input type="text" id="searchName" name="searchName" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="검색할 부서명">
<input type="button" id="btnSearch" name="btnSearch" value="검색">
</form>
</div>

<!-- 코드생성 버튼 -->
<div style="display: inline-block;">
<input type="button" onclick="location.href='/code/createDepCode'" id="btnCreateCode" value="코드생성">
</div>
</div>
<!-- 본문 리스트 영역 -->
<table id="table" class="table" style="margin-top: 30px; width: 800px; margin: 0 auto;">
  <thead>
    <tr>
		<th style="width: 200px;">아이디</th>
    	<th style="width: 200px;">부서코드</th>
    	<th  style="width: 200px;">부서명</th>
    	<th  style="width: 200px;">상위부서</th>
    </tr>
  </thead>
  <tbody id="memberList">
  </tbody>
</table>

</div>
<%@include file="/WEB-INF/views/include/footer.jsp"%>


<script>
let catObj;
let lowerCat;
let codeList = $("#memberList");

function keywordSearch(){
	let keyword = $("#searchName").val();
	let upperDep = $("#upper_dep").val();
	let rowCount = 0;

	$.ajax({
		url : '/member/searchMemCode',
		type : 'post',
		dataType : 'text',
		async : false,
		data : {upper_dep : upperDep, keyword : keyword},
		beforeSend : function(xmlHttpRequest) {
			console.log("ajax xmlHttpRequest check");
			xmlHttpRequest.setRequestHeader("AJAX", "true");
		},
		success : function(result){
			let memberVO = JSON.parse(result);
			console.log(memberVO);
			codeList.children().remove();
			rowCount = memberVO.length;
			for(i=0; i<memberVO.length; i++){
				console.log(upperDep);
				let str = "";
				str += "<tr>";
				str += "<td><a href='/member/memberInfo?mem_id="+memberVO[i].mem_id+"&dep'>"+memberVO[i].mem_id+"<a></td>";
				str += "<td>"+memberVO[i].dep_code+"</td>";
				str += "<td>"+memberVO[i].dep_name+"</td>";
				str += "<td></td>";
				str += "</tr>";
				codeList.append(str);
			}
		},
		error:function(xhr, status, error){
			if(status == 400){
				location.href="/member/login";
			}
		}
		});
	for(let i=0; i<rowCount; i++){
		let dep_code = $("#memberList").children("tr").eq(i).children("td").eq("1").text();
		$.ajax({
			url : '/member/getUpperDepName',
			type : 'post',
			async : false,
			dataType : 'text',
			data : {dep_code : dep_code},
			beforeSend : function(xmlHttpRequest) {
				console.log("ajax xmlHttpRequest check");
				xmlHttpRequest.setRequestHeader("AJAX", "true");
			},
			success : function(result){
				let data = JSON.parse(result);
				// let data = JSON.parse(result);
				$("#memberList").children("tr").eq(i).children("td").eq("3").text(data.dep_name);
				if(data.dep_name == ''){
					$("#memberList").children("tr").eq(i).children("td").eq("3").text('없음');
				}
			},
			error:function(xhr, status, error){
				if(status == 400){
					location.href="/member/login";
				}
			}
		});
	}
}

$(document).ready(function() {

	// 페이지 로딩시 상위부서 리스트 받아오는 부분
	$.ajax({
		url : '/code/getUpperDep',
		type : 'post',
		dataType : 'text',
		data : {},
		beforeSend : function(xmlHttpRequest) {
			console.log("ajax xmlHttpRequest check");
			xmlHttpRequest.setRequestHeader("AJAX", "true");
		},
		success : function(result){
		let upperDep = JSON.parse(result);
		console.log(upperDep);
			for(i=0; i<upperDep.length; i++){
				$("#upper_dep").append("<option value="+upperDep[i].dep_code+">"+upperDep[i].dep_name+"</option>");
			}
			keywordSearch();
		},
		error:function(xhr, status, error){
			if(status == 400){
				location.href="/member/login";
			}
		}
	});

	// 검색기능
	$("#btnSearch").on("click", function (){
		keywordSearch();
	});

	// 카테고리 변경시 검색실행
	$("#upper_dep").on("change", function(){
		keywordSearch();
	});
});


	
</script>
</body>
</html>
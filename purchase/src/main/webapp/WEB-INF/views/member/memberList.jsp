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
<body>
<%@include file="/WEB-INF/views/include/common.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>

<h3>사용자 계정 목록</h3><br>
<!-- 카테고리 영역 -->
<a style="float: left;">상위부서 &nbsp</a>
<div style="float: left;">
	<form id="selectDep" name="selectDep" action="" method="post">
		<!-- 상위부서 -->
		<select id="upper_dep" name="upper_dep">
			<option value=none selected>없음</option>
		</select>
	</form>
</div>

<!-- 검색창 영역 -->
<div style="float: left;">
<form name="searchForm" id="searchForm" onsubmit="false">
<input type="text" id="searchName" name="searchName" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="검색할 부서명">
<input type="button" id="btnSearch" name="btnSearch" value="검색">
</form>
</div>

<!-- 사용불가코드 조회 여부 체크박스 -->
<div style="float: left;">
<label>&nbsp|&nbsp 사용불가코드 &nbsp</label>
<input type="checkbox">
</div>

<!-- 코드생성 버튼 -->
<div style="float: left;">
<label>&nbsp|&nbsp</label>
<input type="button" onclick="location.href='/code/createDepCode'" id="btnCreateCode" value="코드생성">
</div>

<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
  <thead class="thead-dark">
    <tr>
		<th>아이디</th>
    	<th >부서코드</th>
    	<th >부서명</th>
    	<th >상위부서</th>
    </tr>
  </thead>
  <tbody id="memberList">
  </tbody>
</table>



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
			success : function(result){
				let data = JSON.parse(result);
				// let data = JSON.parse(result);
				$("#memberList").children("tr").eq(i).children("td").eq("3").text(data.dep_name);
				if(data.dep_name == ''){
					$("#memberList").children("tr").eq(i).children("td").eq("3").text('없음');
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
		success : function(result){
		let upperDep = JSON.parse(result);
		console.log(upperDep);
			for(i=0; i<upperDep.length; i++){
				$("#upper_dep").append("<option value="+upperDep[i].dep_code+">"+upperDep[i].dep_name+"</option>");
			}
			keywordSearch();
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
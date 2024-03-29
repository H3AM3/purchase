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
<!-- 카테고리 영역 -->
<a style="float: left;">상위부서 &nbsp</a>
<div style="float: left;">
	<form id="selectDep" name="selectDep" action="" method="post">
		<!-- 상위부서 -->
		<select id="upper_dep" name="upper_dep">
			<option value=none>없음</option>
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

<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
  <thead class="thead-dark">
    <tr>
      <th >부서코드</th>
      <th >부서명</th>
      <th >상위부서</th>
    </tr>
  </thead>
  <tbody id="codeList">
  </tbody>
</table>



<%@include file="/WEB-INF/views/include/footer.jsp"%>


<script>
	let catObj;
	let lowerCat;
	let codeList = $("#codeList");
	$(document).ready(function() {
		// 검색어를 포함한 검색
		$("#btnSearch").on("click", function keywordSearch(){
			let keyword = $("#searchName").val();
			let upperDep = $("#upper_dep").val();

			console.log(upperDep);
			$.ajax({
				url : '/code/searchDepCode',
				type : 'post',
				dataType : 'text',
				data : {upper_dep : upperDep, keyword : keyword},
				success : function(result){
				let getcodeList = JSON.parse(result);
				console.log(codeList);
				codeList.children().remove();
				
				for(i=0; i<getcodeList.length; i++){
					var tempArr = '<tr>';
					tempArr += '<th scope="row">'+getcodeList[i].dep_code+'</th>';
					tempArr += '<td><a href="#" onclick="setDep(\''+ getcodeList[i].dep_code +'\', \''+ getcodeList[i].maker_code +'\')" >'+getcodeList[i].dep_name+'</a></td>';
					tempArr += '<th>'+getcodeList[i].upper_dep+'</th>';
					tempArr += '</tr>';
					codeList.append(tempArr);
				}
				}
			});
			});
		

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
				getDepCodeList();
			}
    	});
		
		// 상위부서를 고르면 하위부서 리스트가 나타나게 만드는 메소드
		$("#upper_dep").on("change", function() {

			// 기존에 생성된 리스트가 있으면 삭제하는 작업
			let depCodeList = $("#codeList");
			depCodeList.children().remove();

			if ($("#upper_dep").val() == null) {
				getDepCodeList();
				return;
			}
			getDepCodeList();
			});

	});

	// 검색어 없이 코드 리스트를 불러오는 메소드
	function getDepCodeList(){
		$.ajax({
			url : '/code/getDepCodeList',
			type : 'post',
			dataType : 'text',
			data : {upper_dep : $("#upper_dep").val()},
			success : function(result){
			let depList = JSON.parse(result);
			console.log(depList);
				
				for(i=0; i<depList.length; i++){
					var tempArr = '<tr>';
					tempArr += '<th scope="row">'+depList[i].dep_code+'</th>';
					tempArr += '<td><a href="#" onclick="setDep(\''+ depList[i].dep_code +'\', \''+ depList[i].dep_name +'\')" >'+depList[i].dep_name+'</a></td>';
					tempArr += '<th>'+depList[i].upper_dep+'</th>';
					tempArr += '</tr>';
					codeList.append(tempArr);
				}
			}
    	});
	}

// 코드 선택하면 팝업창 닫히는 메소드
function setDep(dep_code, dep_name){
	$(opener.document).find("#dep_name").val(dep_name);
	$(opener.document).find("#dep_code").val(dep_code);
	window.close();
}
</script>
</body>
</html>
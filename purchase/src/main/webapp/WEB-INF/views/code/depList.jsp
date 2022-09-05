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


<body>

<%@include file="/WEB-INF/views/include/header.jsp"%>
<div class="body">
<h3>부서코드 목록</h3><br>
<div style="width: 600px; margin: 0 auto; display: block;">
	<!-- 카테고리 영역 -->
	<div style="display: inline-block;">
	<div class="input-group-prepend">
	<span class="input-group-text">상위부서</span>
		<form id="selectDep" name="selectDep" action="" method="post">
			<!-- 상위부서 -->
			<select id="upper_dep" name="upper_dep">
				<option value=none>없음</option>
			</select>
		</form>
		</div>
	</div>

	<!-- 검색창 영역 -->
	<div style="display: inline-block;">
	<form name="searchForm" id="searchForm" onsubmit="false">
	<input type="text" id="searchName" name="searchName" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="부서명">
	<input type="button" id="btnSearch" name="btnSearch" value="검색">
	</form>
	</div>
	
	<!-- 코드생성 버튼 -->
	<div style="display: inline-block;">
	<span style="margin-left: 5px; margin-right: 5px;">|</span>
	<input type="button" onclick="location.href='/code/createDepCode'" id="btnCreateCode" value="코드생성">
	</div>
</div>

<div>
<!-- 본문 리스트 영역 -->
<table class="table" style="width: 600px; margin: 0 auto; margin-top: 20px; display: block;">
  <thead>
    <tr>
      <th style="width: 30px;">No</th>
      <th style="width: 170px;">부서코드</th>
      <th style="width: 200px;">부서명</th>
      <th style="width: 200px;">상위부서</th>
    </tr>
  </thead>
  <tbody id="codeList">
  </tbody>
</table>
</div>




<script>
	let catObj;
	let lowerCat;
	let codeList = $("#codeList");
	let rowCount = 0;

	$(document).ready(function() {
		// 검색어를 포함한 검색
		$("#btnSearch").on("click", function keywordSearch(){
			let keyword = $("#searchName").val();
			let upperDep = $("#upper_dep").val();
			rowCount = 0;
			console.log(upperDep);
			$.ajax({
				url : '/code/searchDepCode',
				type : 'post',
				dataType : 'text',
				async : false,
				data : {upper_dep : upperDep, keyword : keyword},
				success : function(result){
				let depList = JSON.parse(result);
				console.log(codeList);
				codeList.children().remove();
				
				for(i=0; i<depList.length; i++){
					let dep_code = depList[i].dep_code;
						$.ajax({
							url : '/member/getUpperDepName',
							type : 'post',
							async : false,
							dataType : 'text',
							data : {dep_code : dep_code},
							success : function(res){
								if(res == ''){
									depList[i].upper_dep = '-';
								}else{
									let data = JSON.parse(res);
									depList[i].upper_dep = data.dep_name;
								}
							}
						});
					let str = '';
					str += "<tr>";
					str += "<td>"+(i+1)+"</td>";
					str += "<td>"+depList[i].dep_code+"</td>";
					str += "<td><a href='/code/depInfo?dep_code="+depList[i].dep_code+"'>"+depList[i].dep_name+"<a></td>";
					str += "<td>"+depList[i].upper_dep+"</td>";
					str += "</tr>";
					codeList.append(str);
					rowCount += 1;
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
		rowCount = 0;
		$.ajax({
			url : '/code/getDepCodeList',
			type : 'post',
			dataType : 'text',
			async : false,
			data : {upper_dep : $("#upper_dep").val()},
			success : function(result){
			let depList = JSON.parse(result);
			console.log(depList);
				
				for(i=0; i<depList.length; i++){
					let dep_code = depList[i].dep_code;
						$.ajax({
							url : '/member/getUpperDepName',
							type : 'post',
							async : false,
							dataType : 'text',
							data : {dep_code : dep_code},
							success : function(res){
								if(res == ''){
									depList[i].upper_dep = '-';
								}else{
									let data = JSON.parse(res);
									depList[i].upper_dep = data.dep_name;
								}
							}
						});
					let str = '';
					str += "<tr>";
					str += "<td>"+(i+1)+"</td>";
					str += "<td>"+depList[i].dep_code+"</td>";
					str += "<td><a href='/code/depInfo?dep_code="+depList[i].dep_code+"'>"+depList[i].dep_name+"<a></td>";
					str += "<td>"+depList[i].upper_dep+"</td>";
					str += "</tr>";
					codeList.append(str);
					rowCount +=1;
				}
			}
    	});

	}
</script>
</div>
<%@include file="/WEB-INF/views/include/footer.jsp"%>

</body>
</html>
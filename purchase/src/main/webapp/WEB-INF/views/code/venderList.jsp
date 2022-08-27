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
<%@include file="/WEB-INF/views/include/loginRedirect.jsp" %>
<%@include file="/WEB-INF/views/include/common.jsp"%>
<link rel="stylesheet" href="/resources/css/defaultForm.css">


<body>

<%@include file="/WEB-INF/views/include/header.jsp"%>
<div class="body">
<h3>거래처 목록</h3><br>

<!-- 검색창 영역 -->
<div style="display: inline-block;">
<form name="searchForm" id="searchForm" onsubmit="false">
<input type="text" id="searchName" name="searchName" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="검색할 업체명">
<input type="button" id="btnSearch" name="btnSearch" value="검색">
</form>
</div>

<!-- 코드생성 -->
<div style="display: inline-block;">
<label>&nbsp|&nbsp</label>
<input type="button" onclick="location.href='/code/createVenderCode'" id="btnCreateCode" value="코드생성">
</div>

<!-- 본문 리스트 영역 -->
<div style="margin-top: 20px">
<table class="table" style="margin: 0 auto; width: 650px">
  <thead>
    <tr>
      <th style="width: 150px;">부서코드</th>
      <th style="width: 200px;">거래처명</th>
      <th style="width: 300px;">이메일</th>
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
	$(document).ready(function() {

		getVenderCodeList();

		// 검색버튼 클릭시 기존 리스트 삭제하고 검색 실행하는 메소드
		$("#btnSearch").on("click", function keywordSearch() {

			// 기존에 생성된 리스트가 있으면 삭제하는 작업
			let venderCodeList = $("#codeList");
			venderCodeList.children().remove();
			getVenderCodeList();
			});
		});

		// 리스트를 불러오는 메소드(검색어 유무 상관없이)
		function getVenderCodeList(){
			$.ajax({
				url : '/code/getVenderCodeList',
				type : 'post',
				dataType : 'text',
				data : {keyword : $("#searchName").val()},
				success : function(result){
				let venderList = JSON.parse(result);
				console.log(venderList);
					let str = '';
					for(i=0; i<venderList.length; i++){
						str += "<tr>";
						str += "<td scope='row'>"+venderList[i].vender_code+"</th>";
						str += "<td><a href='/code/venderInfo?vender_code="+venderList[i].vender_code+"'>"+venderList[i].vender_name+"<a></td>";
						str += "<td>"+venderList[i].vender_email+"</td>";
						str += "</tr>";
					}
					codeList.append(str);
				}
			});
		}
</script>
</div>
<%@include file="/WEB-INF/views/include/footer.jsp"%>

</body>
</html>
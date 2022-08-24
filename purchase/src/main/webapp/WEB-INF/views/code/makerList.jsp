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

<h3>제조사 목록</h3><br>

<!-- 검색창 영역 -->
<div style="float: left;">
<form name="searchForm" id="searchForm" onsubmit="false">
<input type="text" id="searchName" name="searchName" onkeyup="if(window.event.keyCode==13){keywordSearch()}" placeholder="검색할 업체명">
<input type="button" id="btnSearch" name="btnSearch" value="검색">
</form>
</div>

<!-- 코드생성 -->
<div style="float: left;">
<label>&nbsp|&nbsp</label>
<input type="button" onclick="location.href='/code/createMakerCode'" id="btnCreateCode" value="코드생성">
</div>

<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
  <thead class="thead-dark">
    <tr>
      <th >코드</th>
      <th >제조사</th>
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
				url : '/code/getMakerList',
				type : 'post',
				dataType : 'text',
				data : {keyword : $("#searchName").val()},
				success : function(result){
				let makerList = JSON.parse(result);
				console.log(makerList);
					
					for(i=0; i<makerList.length; i++){
						codeList.append("<tr>");
						codeList.append("<th scope='row'>"+makerList[i].maker_code+"</th>");
						codeList.append("<td><a href='/code/makerInfo?maker_code="+makerList[i].maker_code+"'>"+makerList[i].maker_name+"<a></td>");
						codeList.append("</tr>");
					}
				}
			});
		}
</script>
</body>
</html>
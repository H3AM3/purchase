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

<h3>거래처 검색</h3><br>

<!-- 검색창 영역 -->
<div style="float: left;">
<form name="searchForm" id="searchForm" onsubmit="false">
<input type="text" id="searchName" name="searchName" onkeypress="if(event.keyCode=='13'){event.preventDefault(); keywordSearch();}" placeholder="검색할 업체명">
<input type="button" id="btnSearch" name="btnSearch" value="검색">
</form>
</div>

<!-- 본문 리스트 영역 -->
<table class="table" style="margin-top: 10px;">
  <thead class="thead-dark">
    <tr>
      <th >부서코드</th>
      <th >거래처명</th>
      <th >이메일</th>
    </tr>
  </thead>
  <tbody id="codeList">
  </tbody>
</table>

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
			for(i=0; i<venderList.length; i++){
				var tempArr = '<tr>';
				tempArr += '<th scope="row">'+venderList[i].vender_code+'</th>';
				tempArr += '<td><a href="#" onclick="setVender(\''+ venderList[i].vender_name +'\', \''+ venderList[i].vender_code +'\')" >'+venderList[i].vender_name+'</a></td>';
				tempArr += '<td>'+venderList[i].vender_email+'</td>';
				tempArr += '</tr>';
				codeList.append(tempArr);
			}
			}
		});			
	}
	// 코드 선택하면 팝업창 닫히는 메소드
	function setVender(vender_name, vender_code){
		$(opener.document).find("#vender_name").val(vender_name);
		$(opener.document).find("#vender_code").val(vender_code);
		window.close();
	}
</script>
</body>
</html>
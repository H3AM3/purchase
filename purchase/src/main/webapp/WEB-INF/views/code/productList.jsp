<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div>
<a>카테고리 선택</a>
<form id="selectCategory1" name="selectCategory1" action="" method="post">
<!-- 카테고리(상) -->
<select id="Category1" name="Category1">
	<option value=null>대분류</option>
	<option value="1">소모품</option>
	<option value="2">고정자산</option>
</select>
<button id="btn_cat1" hidden>
</form>
</div>

<div>
<form id="selectCategory2" name="selectCategory2" action="">
<!-- 카테고리(중) -->
<select id="Category2">
<option value="null" selected>중분류</option>
</select>
<input id="btn_cat2" type="button" hidden>
</form>
</div>

<div>
<form id="selectCategory3" name="selectCategory3" action="">
	<!-- 카테고리(하) -->
<select id="Category3">
<option value="null" selected>소분류</option>
</select>
<input id="btn_cat3" type="button" hidden>
</form>
</div>
</div>




<%@include file="/WEB-INF/views/include/footer.jsp" %>
<%@include file="/WEB-INF/views/include/common.jsp" %>

<script>
	
	$(document).ready(function(){

		// 상위 카테고리를 고르면 하위 카테고리가 나타나게 만드는 메소드
		$("#Category1").on("change", function(){

			if($("#Category1").val() == null){
				return;
			}

			let cat1value = $("#Category1").val();
			//console.log(cat1value);

			$.ajax({
				url: '/code/getLowerCat',
					type: "post",
					dataType: 'text',
					data:{category_code : cat1value},
					success:function(result){

						console.log(result);
						console.log(result.CategoryVO[0]);
						
			}

			});

		});



	});

</script>
</body>
</html>
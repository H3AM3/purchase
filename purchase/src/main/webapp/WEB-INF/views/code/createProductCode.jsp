<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>CreateProductCode</title>
    <meta name="theme-color" content="#563d7c">
    <meta charset="UTF-8">
<%@include file="/WEB-INF/views/include/common.jsp" %>

<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
</style>

<script>
$(document).ready(function(){
let chechOK = false;
let upperCat
let lowerCat;
getUpperCat();
		// 페이지 로딩시 상위 카테고리를 불러오는 메소드
		function getUpperCat(){
			upperCat = $("#category_1st");
			$.ajax({
				url : '/code/getUpperCat',
				type : "post",
				dataType : 'text',
				data : {},
				success : function(result) {
					catObj = JSON.parse(result);
					// 리턴값을 받아서 하위 카테고리 생성
					setUpperCategory(catObj, upperCat);
				}
			});
		}

    // 페이지 로딩시 입고단위를 불러오는 메소드
    $.ajax({
				url : '/code/getpakaging',
				type : "post",
				dataType : 'text',
				data : {},
				success : function(result) {
					pakObj = JSON.parse(result);
          setPakaging(pakObj, $("#im_pakaging"));
				}
    });

        // 페이지 로딩시 출고단위를 불러오는 메소드
        $.ajax({
				url : '/code/getpakaging',
				type : "post",
				dataType : 'text',
				data : {},
				success : function(result) {
					pakObj = JSON.parse(result);
          setPakaging(pakObj, $("#ex_pakaging"));
				}
    });

        // 페이지 로딩시 타입을 불러오는 메소드
        $.ajax({
				url : '/code/getType',
				type : "post",
				dataType : 'text',
				data : {},
				success : function(result) {
					pakObj = JSON.parse(result);
          setType(pakObj, $("#type"));
				}
    });

    // 상위 카테고리 선택시 하위 카테고리를 불러오는 메소드
    $("#category_1st").on("change", function() {
			let cat1value = $("#category_1st").val();
			lowerCat = $("#category_2nd");

			// 대분류 없음을 고르면 하위카테고리를 삭제하는 메소드
			if ($("#category_1st").val() == null) {
				lowerCat.children().remove();
				lowerCat.append("<option value='null' selected>소분류</option>");
				return;
			}
			// 불러오기 전 기존에 생성된 하위카테고리가 있으면 삭제하는 작업
			lowerCat.children().remove();
			lowerCat.append("<option value='null' selected>소분류</option>");
			$.ajax({
				url : '/code/getLowerCat',
				type : "post",
				dataType : 'text',
				data : {
					category_code : cat1value
				},
				success : function(result) {
					catObj = JSON.parse(result);
					// 리턴값을 받아서 하위 카테고리 생성
					setCategory(catObj, lowerCat);
				}
			});

		});


    // 코드 중복체크
    $("#codeCheck").on("click", function(){
      //console.log("체크 클릭");
      if($("#product_code").val() == ""){
        alert("코드를 입력해주세요.");
        return false;
      }
      let product_code = $("#product_code").val();
      $.ajax({
      url : '/code/productCheck',
      type : 'post',
      dataType : 'text',
      data : {product_code : product_code},
      success : function(result){
        if(result == ""){
							$("#checkResult").text("코드 사용가능");
							$("#checkResult").removeAttr("hidden");
							chechOK = true;
						} else {
							$("#checkResult").text("코드 사용불가");
							$("#checkResult").removeAttr("hidden");
						}
          }
      });
      });

      // 입력데이터가 있는지 확인 후 submit
      $("#btnMkProductCode").on("click", function(e){
        $("#btnMkProductCode").removeAttr();
        if($("#product_code").val() == ""){
          alert("물품코드를 입력해주세요.");
          return false;
        } else if ($("#product_name").val() == ""){
          alert("품명을 입력해주세요.");
          return false;
        } else if($("#category_1st").val() == 'null'){
          alert("대분류를 선택해주세요.");
          return false;
        } else if($("#category_2nd").val() == 'null'){
          alert("소분류를 선택해주세요.");
          return false;
        } else if($("#vender_name").val() == ""){
          alert("거래처를 입력해주세요.");
          return false;
        } else if(!chechOK){
          alert("코드 중복확인을 해주세요.");
          return false;
        } else if($("#maker_code").val() == ""){
          alert("제조사를 입력해주세요");
          return false;
        }
        if($("#spec").val() == ""){
          $("#spec").val("-");
        }
        if($("#edi_code").val() == ""){
          $("#edi_code").val("-");
        }
        $("#btnMkProductCode").submit();
      });
 });

 // 거래처 검색 팝업창 띄우기
function venderSearchPopup(){
  window.open("/code/venSearchPopup","venderSearchPopup","width=600, height=450, top=150, left=200")
}
// 제조사 검색 팝업창 띄우기
function makerSearchPopup(){
				window.open("/code/makerSearchPopup","makerSearchPopup","width=600, height=450, top=150, left=200");
}

// 상위 카테고리를 생성하는 메소드
function setUpperCategory(list, catId) {
  catId.append("<option value=null>" + "대분류" + "</option>");
  for (i = 0; i < list.length; i++) {
    catId.append("<option value="+list[i].category_code+">"
        + list[i].category_name + "</option>");
  }
}

// 하위 카테고리를 생성하는 메소드
function setCategory(list, catId) {
  for (i = 0; i < list.length; i++) {
    catId.append("<option value="+list[i].category_code+">"
        + list[i].category_name + "</option>");
  }
}

// 포장단위 리스트를 보여주는 메소드
function setPakaging(list, pakagingId){
  for (i = 0; i < list.length; i++) {
    pakagingId.append("<option value="+list[i].pakaging+">"
        + list[i].pakaging + "</option>");
  }
}

// 타입 리스트를 보여주는 메소드
function setType(list, setTypeId){
  for (i = 0; i < list.length; i++) {
    setTypeId.append("<option value="+list[i].type+">"
        + list[i].type + "</option>");
  }
}

function inputNumberFormat(obj) {
     obj.value = comma(uncomma(obj.value));
 }

 function comma(str) {
     str = String(str);
     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
 }

 function uncomma(str) {
     str = String(str);
     return str.replace(/[^\d]+/g, '');
 }
</script>


<title>Insert title here</title>
</head>
<body>
<%@include file="/WEB-INF/views/include/header.jsp" %>

<h3>품목 코드생성</h3>

<div class="container">
  <div class="mb-3 text-center">
	  <form id="createProductCode" method="post" action="/code/createProductCode">
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">품목 코드</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="product_code" name="product_code" placeholder="코드 입력">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-link" id="codeCheck" name="codeCheck">코드 중복체크</button>
		    </div>
		    <label for="staticEmail" hidden class="col-sm-2 col-form-label" style="color: red;" id="checkResult">중복체크결과</label>
		  </div>
      <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label" >상위 카테고리</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="category_1st" name="category_1st">
          </select>
		    </div>
        <label for="staticEmail" class="col-sm-2 col-form-label">하위 카테고리</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="category_2nd" name="category_2nd">
            <option value="null" selected>소분류</option>
          </select>
          </div>
          </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">품명</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="product_name" name="product_name" placeholder="품명 입력">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">규격</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="spec" name="spec">
		    </div>
		  </div>
       <div class="form-group row">
	    <label for="staticEmail" class="col-sm-2 col-form-label">제조사</label>
	    <div class="col-sm-2">
	      <input type="text" class="form-control" id="maker_name" name="maker_name" readonly>
        <input hidden type="text" class="form-control" id="maker_code" name="maker_code" readonly>
	    </div>
       <div class="col-sm-1">
       <input type="button" value="검색" id="btnMakerSearch" name="btnMakerSearch" onclick="makerSearchPopup();">
     </div>
	  </div>
      <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">거래처</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="vender_name" name="vender_name" readonly>
		    </div>
        <div class="col-sm-1">
        <input type="button" value="검색" id="btnVenSearch" name="btnVenSearch" onclick="venderSearchPopup();">
      </div>
		  </div>
      <div class="form-group row">
		    <div class="col-sm-0">
		      <input type="text" class="form-control" id="vender_code" name="vender_code" hidden>
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">EDI코드</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="edi_code" name="edi_code">
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">타입</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="type" name="type">
          </select>
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">입고단위</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="im_pakaging" name="im_pakaging">
          </select>
		    </div>
		  </div>
      <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">출고단위</label>
		    <div class="col-sm-2">
		      <select class="form-control" id="ex_pakaging" name="ex_pakaging">
          </select>
          </div>
          </div>
          <div class="form-group row">
        <label for="staticEmail" class="col-sm-2 col-form-label">포장수량</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="pak_quantity" name="pak_quantity" value="1">
		    </div>
        </div>
        <div class="form-group row">
        <label for="staticEmail" class="col-sm-2 col-form-label">단가</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="price" name="price" value="0">
		    </div>
        </div>
        <div class="form-group row">
        <label for="staticEmail" class="col-sm-2 col-form-label">비고</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control " id="description" name="description" placeholder="기타사항 입력">
		    </div>
        </div>

		  </div>
			<div class="col-sm-12 text-center">
			  	<button type="submit" class="btn btn-dark" id="btnMkProductCode">코드생성</button>
			  </div>	
	 </form>
  </div>
</div>
<!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
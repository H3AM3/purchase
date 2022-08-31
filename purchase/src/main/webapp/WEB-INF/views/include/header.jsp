<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="/resources/css/defaultForm.css">

<div class="header">
<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
<nav class="navbar navbar-expand-lg navbar-light">
  <a class="navbar-brand">구매</a>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
    <c:if test="${sessionScope.loginStatus.mem_name == null}">
       <li class="nav-item">
        <a class="nav-link" href="/member/login">로그인</a>
      </li>
      <!-- 
      <li class="nav-item">
        <a class="nav-link" href="/member/join">회원가입</a>
      </li>
       -->
      </c:if>
      
	<c:if test="${sessionScope.loginStatus != null}">
      <li class="nav-item">
        <a class="nav-link" style="color: black;">| 사용자 : <c:out value="${sessionScope.loginStatus.mem_name}"/> |</a>
      </li>
	<c:if test="${sessionScope.loginStatus.mem_level == 1}">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
          	계정</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="/member/createLowerMem">계정 생성</a>
          <a class="dropdown-item" href="/member/memberList">계정 관리</a>
        </div>
        </li>
       </c:if>
       <c:if test="${sessionScope.loginStatus.mem_level == 1}">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
          	코드</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="/code/productList">품목 코드회/생성</a>
          <a class="dropdown-item" href="/code/venderList">거래처 코드조회/생성</a>
          <a class="dropdown-item" href="/code/depList">부서코드 조회/생성</a>
          <a class="dropdown-item" href="/code/makerList">제조사코드 조회/생성</a>
        </div>
        </li>
        </c:if>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
          	물품청구
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="/request/requestOrder">청구서 작성</a>
          <a class="dropdown-item" href="/request/requestOrder_List">청구서 조회</a>
          <c:if test="${sessionScope.loginStatus.mem_level == 1}">
          <a class="dropdown-item" href="/request/allOrder_List">청구서 승인/반려</a>
          </c:if>
        </div>
      </li>
      <c:if test="${sessionScope.loginStatus.mem_level == 1}">
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
          	발주</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="/order/createOrder">발주서 작성</a>
          <a class="dropdown-item" href="/order/orderList">발주서 조회/수정</a>
        </div>
        </li>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
          	입고</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="/import/createImports">입고내역 작성</a>
          <a class="dropdown-item" href="/import/importList">입고내역 조회/수정</a>
        </div>
        </li>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
          	출고</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="/export/createExports">출고서 작성</a>
          <a class="dropdown-item" href="/export/exportList">출고서 조회/수정</a>
        </div>
        </li>
        <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
          	집계</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="/statistics/req_statistics">청구/출고내역 집계</a>
          <a class="dropdown-item" href="/statistics/order_statistics">발주/입고내역 집계</a>
          <a class="dropdown-item" href="/statistics/monthly_statistics">월간 입고/소모내역 집계</a>
        </div>
        </li>
      </c:if>
      <li class="nav-item">
        <a class="nav-link" href="/member/logout" id="logout">로그아웃</a>
      </li>
	</c:if>
    </ul>
  </div>
</nav>
</div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 로그인상태가 아니면 로그인페이지로 Redirect시켜주는 구문 -->
<c:if test="${sessionScope.loginStatus.mem_name == null}">
<c:redirect url="/member/login"></c:redirect>
</c:if>
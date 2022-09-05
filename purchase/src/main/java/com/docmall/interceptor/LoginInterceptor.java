package com.docmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.docmall.domain.MemberVO;

import lombok.extern.log4j.Log4j;
@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		boolean result = false;
		
		//인증된 사용자인지 여부를 체크. 세션객체를 확인
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute("loginStatus");
		
		if(user == null) {
			result = false;
			// ajax요청인지 여부를 체크
			if(isAjaxRequest(request)) {
				System.out.println("ajax요청임");
				response.sendError(400); // ajax요청시 응답에러 코드
			} else {
				System.out.println("ajax요청 아님");
				getDestination(request);
				response.sendRedirect("/member/login");
			}
		}else {
			result = true;
		}
		return result;
	}

	//ajax요청을 체크한다.
	private boolean isAjaxRequest(HttpServletRequest request) {

		boolean isAjax = false;
		
		// ajax구문에서 요청시 헤더에 AJAX : "true"를 작업해두어야 한다.
		String header = request.getHeader("AJAX");
		if("true".equals(header)) {
			isAjax = true;
		}
		
		return isAjax;
	}

	private void getDestination(HttpServletRequest request) {
		// 브라우저가 요청했던 주소
		String uri = request.getRequestURI();
		// 브라우저가 전송한 쿼리스트링(?는 제외됨)
		String query = request.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?"+query;
		}
		
		String destination = uri + query;
		
		if(request.getMethod().equals("GET")) {
			// 사용자가 비로그인 상태에서 요청한 원래 주소를 세션으로 저장해둔다.
			request.getSession().setAttribute("dest", destination);
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	
}

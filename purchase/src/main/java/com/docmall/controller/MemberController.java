package com.docmall.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.dto.MemberListDTO;
import com.docmall.dto.UpperDep_NameDTO;
import com.docmall.service.CodeService;
import com.docmall.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@Controller
public class MemberController {
	
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private MemberService service;
	
	@Autowired
	private CodeService code_service;
	
	// 회원가입 폼
	@GetMapping("/join")
	public void join() {
		
	}
	
	// 아이디 중복확인 폼
	@PostMapping("/idCheck")
	public ResponseEntity<String> idCheck(@RequestParam("mem_id") String mem_id) {
		
		String userId;
		userId = service.idCheck(mem_id);
		
		ResponseEntity<String> entity;
		
		entity = new ResponseEntity<String>(userId, HttpStatus.OK);
		return entity;
	}
	
	// 회원정보 저장(어드민 계정)
	@PostMapping("/mkAdmin")
	public String mkAdmin(MemberVO vo, RedirectAttributes rttr) {
	
		String cryptEncoderPW = bCryptPasswordEncoder.encode(vo.getMem_password());
		
		vo.setMem_password(cryptEncoderPW);
		vo.setDep_code("101");
		vo.setMem_level(1);
		vo.setDep_name("구매");
		service.mkAdmin(vo);
		return "redirect:/member/login";
	}
	
	// 로그인 폼
	@GetMapping("/login")
	public void login() {
	}
	
	// 로그인 메소드
	@PostMapping("/loginOK")
	public String loginOk(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		MemberVO memberData = service.loginOK(dto);
		
		String url = "/request/requestOrder";
		String msg = "";
		
		if(memberData != null) {
			if(bCryptPasswordEncoder.matches(dto.getMem_password(), memberData.getMem_password())) {
				session.setAttribute("loginStatus", memberData);
				msg = "loginSuccess";
			}else {
				url ="/member/login";
				msg = "passwdFailure";
			}
		}else {
			url ="/member/login";
			msg = "idFailure";
		}
		
		rttr.addFlashAttribute("msg", msg);
		return "redirect:"+url;
	}
	
	// 로그아웃 기능
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/member/login";
	}
	
	// 청구부서 계정생성페이지
	@GetMapping("/createLowerMem")
	public void createLowerMem() {}
	
	// 아이디 생성창에서 사용할 부서리스트
	@GetMapping("/depSearchPopup")
	public void depSearchPopup() {}
	
	// 청구부서 계정생성
	@PostMapping("/createLoweMem")
	public String createLoweMem(MemberVO vo) {
		String cryptEncoderPW = bCryptPasswordEncoder.encode(vo.getMem_password());
		vo.setMem_password(cryptEncoderPW);
		vo.setMem_level(3);
		service.mkAdmin(vo);
		return "redirect:/member/memberList";
	}
	
	// 계정 리스트폼
	@GetMapping("/memberList")
	public void memberList() {}
	
	// 계정 리스트 검색기능
	@PostMapping("/searchMemCode")
	public ResponseEntity<List<MemberVO>> searchMemCode(MemberListDTO dto){
		ResponseEntity<List<MemberVO>> entity = null;
		List<MemberVO> list;
		if(dto.getUpper_dep().equals("none")) {
			list = service.searchMemCode(dto);
		}else {
			list = service.searchUpperCatMemCode(dto);
		}
		return entity = new ResponseEntity<List<MemberVO>>(list, HttpStatus.OK);
	}
	
	//계정 조회/수정 페이지
	@GetMapping("/memberInfo")
	public void memberInfo(String mem_id, Model model) {
		log.info(mem_id);
		MemberVO vo = service.getMemberInfo(mem_id);
		UpperDep_NameDTO upperDepName = code_service.getUpperDepName(vo.getDep_code());
		model.addAttribute("memberVO", vo);
		model.addAttribute("upperDepName", upperDepName);
	}
	
	@PostMapping("/updateMemberInfo")
	public ResponseEntity<String> updateMemberInfo(MemberVO vo){ 
		ResponseEntity<String> entity = null;
		String result = "failure";
		log.info(vo);
		if(vo.getMem_password() == "") {
			log.info("비밀번호 입력안됨");
		} else if(vo.getMem_password() != "") {
			log.info("받은 비밀번호 : "+vo.getMem_password());
			String cryptEncoderPW = bCryptPasswordEncoder.encode(vo.getMem_password());
			vo.setMem_password(cryptEncoderPW);
			service.updateMemberPw(vo);
			result = "success";
		}
		return entity = new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/delMember")
	public ResponseEntity<String> delMember(MemberVO vo){
		ResponseEntity<String> entity = null;
		String result = "failure";
		try {
			service.delMember(vo);
			result = "success";
		} catch (Exception e) {
			result = "failure";
		}
		
		return entity = new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/getUpperDepName")
	public ResponseEntity<UpperDep_NameDTO> getUpperDepName(String dep_code){
		log.info("받은값 : "+dep_code);
		ResponseEntity<UpperDep_NameDTO> entity = null;
		UpperDep_NameDTO upperDepName = code_service.getUpperDepName(dep_code);
		log.info("보낸값 : "+upperDepName);
		return entity = new ResponseEntity<UpperDep_NameDTO>(upperDepName, HttpStatus.OK);
	}
}

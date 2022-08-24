package com.docmall.service;

import java.util.List;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.dto.MemberListDTO;

public interface MemberService {

	void mkAdmin(MemberVO vo);

	String idCheck(String vo);
	
	MemberVO loginOK(LoginDTO dto);

	List<MemberVO> searchMemCode(MemberListDTO dto);
	
	List<MemberVO> searchUpperCatMemCode(MemberListDTO dto);

	MemberVO getMemberInfo(String mem_id);
	
	public void updateMemberPw(MemberVO vo);

	public void delMember(MemberVO vo);
}

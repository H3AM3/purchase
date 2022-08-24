package com.docmall.mapper;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.dto.MemberListDTO;

public interface MemberMapper {
	
	void mkAdmin(MemberVO vo);
	
	public String idCheck(String vo);
	
	public MemberVO loginOK(LoginDTO dto);

	public List<MemberVO> searchMemCode(MemberListDTO dto);
	
	public List<MemberVO> searchUpperCatMemCode(MemberListDTO dto);

	public MemberVO getMemberInfo(String mem_id);
	
	public void updateMemberPw(MemberVO vo);
	
	public void delMember(MemberVO vo);
}

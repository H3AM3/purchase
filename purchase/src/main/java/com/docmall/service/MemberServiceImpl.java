package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.dto.MemberListDTO;
import com.docmall.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public void mkAdmin(MemberVO vo) {
		mapper.mkAdmin(vo);
	}

	@Override
	public String idCheck(String vo) {
		return mapper.idCheck(vo);
	}

	@Override
	public MemberVO loginOK(LoginDTO dto) {

		return mapper.loginOK(dto);
	}

	@Override
	public List<MemberVO> searchMemCode(MemberListDTO dto) {
		return mapper.searchMemCode(dto);
	}

	@Override
	public List<MemberVO> searchUpperCatMemCode(MemberListDTO dto) {
		return mapper.searchUpperCatMemCode(dto);
	}

	@Override
	public MemberVO getMemberInfo(String mem_id) {
		return mapper.getMemberInfo(mem_id);
	}

	@Override
	public void updateMemberPw(MemberVO vo) {
		mapper.updateMemberPw(vo);
	}

	@Override
	public void delMember(MemberVO vo) {
		mapper.delMember(vo);
	}

}

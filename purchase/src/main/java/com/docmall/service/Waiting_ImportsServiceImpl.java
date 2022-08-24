package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.Tbl_ImportVO;
import com.docmall.domain.Waiting_ImportsVO;
import com.docmall.dto.ImportListDTO;
import com.docmall.dto.ImportPageDTO;
import com.docmall.dto.WaitingListDTO;
import com.docmall.mapper.Waiting_ImportsMapper;

@Service
public class Waiting_ImportsServiceImpl implements Waiting_ImportsService {

	@Autowired
	private Waiting_ImportsMapper mapper;
	
	
	@Override
	public List<Waiting_ImportsVO> getWaitingList(WaitingListDTO dto) {
		return mapper.getWaitingList(dto);
	}
	@Override
	public List<Waiting_ImportsVO> getWaitingImportInfo(Waiting_ImportsVO vo) {
		return mapper.getWaitingImportInfo(vo);
	}
	@Override
	public void insertImport(Tbl_ImportVO vo) {
		mapper.insertImport(vo);
	}
	@Override
	public void order_im_qtyChange(Tbl_ImportVO vo) {
		mapper.order_im_qtyChange(vo);
	}
	@Override
	public void stockChange(Tbl_ImportVO vo) {
		mapper.stockChange(vo);
	}
	@Override
	public void importEndCheck(Tbl_ImportVO vo) {
		mapper.importEndCheck(vo);
	}
	@Override
	public Long getNewImportPage(ImportPageDTO dto) {
		return mapper.getNewImportPage(dto);
	}




}

package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.StockVO;
import com.docmall.domain.Tbl_ImportVO;
import com.docmall.dto.DeleteImportDTO;
import com.docmall.dto.ImportListDTO;
import com.docmall.mapper.ImportMapper;
@Service
public class ImportServiceImpl implements ImportService {

	@Autowired
	private ImportMapper mapper;
	
	@Override
	public List<Tbl_ImportVO> getImportList(ImportListDTO dto) {
		return mapper.getImportList(dto);
	}

	@Override
	public List<Tbl_ImportVO> getImportInfo(Tbl_ImportVO vo) {
		return mapper.getImportInfo(vo);
	}

	@Override
	public StockVO checkStock(StockVO vo) {
		return mapper.checkStock(vo);
	}

	@Override
	public void delWaitingQuantity(DeleteImportDTO dto) {
		mapper.delWaitingQuantity(dto);
	}

	@Override
	public void stockMinus(DeleteImportDTO dto) {
		mapper.stockMinus(dto);
	}

	@Override
	public void delImprot(DeleteImportDTO dto) {
		mapper.delImprot(dto);
	}

	@Override
	public void orderImportedCheck(Tbl_ImportVO vo) {
		mapper.orderImportedCheck(vo);
	}

	@Override
	public Long getOrderNum(DeleteImportDTO dto) {
		return mapper.getOrderNum(dto);
	}

	@Override
	public void orderImportedFalse(Long orderNum) {
		mapper.orderImportedFalse(orderNum);
	}

}

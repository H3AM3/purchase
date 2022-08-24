package com.docmall.service;

import java.util.List;

import com.docmall.domain.StockVO;
import com.docmall.domain.Tbl_ImportVO;
import com.docmall.dto.DeleteImportDTO;
import com.docmall.dto.ImportListDTO;

public interface ImportService {

	public List<Tbl_ImportVO> getImportList(ImportListDTO dto);
	public List<Tbl_ImportVO> getImportInfo(Tbl_ImportVO vo);
	public StockVO checkStock(StockVO vo);
	public void delWaitingQuantity(DeleteImportDTO dto);
	public void stockMinus(DeleteImportDTO dto);
	public void delImprot(DeleteImportDTO dto);
	public void orderImportedCheck(Tbl_ImportVO vo);
	public Long getOrderNum(DeleteImportDTO dto);
	public void orderImportedFalse(Long orderNum);
}

package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.Tbl_ImportVO;
import com.docmall.domain.Waiting_ImportsVO;
import com.docmall.dto.ImportListDTO;
import com.docmall.dto.ImportPageDTO;
import com.docmall.dto.WaitingListDTO;

public interface Waiting_ImportsMapper {
	
	public List<Waiting_ImportsVO> getWaitingList(WaitingListDTO dto);
	public List<Waiting_ImportsVO> getWaitingImportInfo(Waiting_ImportsVO vo);
	public Long getNewImportPage(ImportPageDTO dto);
	public void insertImport(Tbl_ImportVO vo);
	public void order_im_qtyChange(Tbl_ImportVO vo);
	public void stockChange(Tbl_ImportVO vo);
	public void importEndCheck(Tbl_ImportVO vo);

}

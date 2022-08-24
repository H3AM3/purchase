package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.ExportSearchDTO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.Tbl_ExportVO;
import com.docmall.dto.ExportDelDTO;

public interface ExportMapper {

	public List<Req_OrdersVO> getReqList(ExportSearchDTO dto);
	public List<Req_OrdersVO> getReq_orderInfo(Req_OrdersVO vo);
	public Long getStockQty(String product_code);
	public Long getNewExportPage(Tbl_ExportVO vo);
	public void insertExport(Tbl_ExportVO vo);
	public void stockMinus(Tbl_ExportVO vo);
	public void stockPlus(Tbl_ExportVO vo);
	public void changeReq_order_qty(Tbl_ExportVO vo);
	public void checkReq_order_end(Long req_no);
	public List<Tbl_ExportVO> getExportList(ExportSearchDTO dto);
	public List<Tbl_ExportVO> getExportInfo(Tbl_ExportVO vo);
	public Req_OrdersVO getReq_qty(Long product_code);
	public void delExport(Tbl_ExportVO vo);
	public void req_qtyChange(Tbl_ExportVO vo);
	public void updateExport(Tbl_ExportVO vo);
	
}

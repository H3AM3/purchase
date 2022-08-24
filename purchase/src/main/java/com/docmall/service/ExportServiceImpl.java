package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.ExportSearchDTO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.Tbl_ExportVO;
import com.docmall.dto.ExportDelDTO;
import com.docmall.mapper.ExportMapper;

@Service
public class ExportServiceImpl implements ExportService {

	@Autowired
	private ExportMapper mapper;

	@Override
	public List<Req_OrdersVO> getReqList(ExportSearchDTO dto) {
		return mapper.getReqList(dto);
	}

	@Override
	public List<Req_OrdersVO> getReq_orderInfo(Req_OrdersVO vo) {
		return mapper.getReq_orderInfo(vo);
	}

	@Override
	public Long getStockQty(String product_code) {
		return mapper.getStockQty(product_code);
	}

	@Override
	public Long getNewExportPage(Tbl_ExportVO vo) {
		return mapper.getNewExportPage(vo);
	}

	@Override
	public void insertExport(Tbl_ExportVO vo) {
		mapper.insertExport(vo);
	}

	@Override
	public void stockMinus(Tbl_ExportVO vo) {
		mapper.stockMinus(vo);
	}

	@Override
	public void changeReq_order_qty(Tbl_ExportVO vo) {
		mapper.changeReq_order_qty(vo);
	}

	@Override
	public void checkReq_order_end(Long req_no) {
		mapper.checkReq_order_end(req_no);	
	}

	@Override
	public List<Tbl_ExportVO> getExportList(ExportSearchDTO dto) {
		return mapper.getExportList(dto);
	}

	@Override
	public List<Tbl_ExportVO> getExportInfo(Tbl_ExportVO vo) {
		return mapper.getExportInfo(vo);
	}

	@Override
	public Req_OrdersVO getReq_qty(Long product_code) {
		return mapper.getReq_qty(product_code);
	}

	@Override
	public void delExport(Tbl_ExportVO vo) {
		mapper.delExport(vo);
	}

	@Override
	public void req_qtyChange(Tbl_ExportVO vo) {
		mapper.req_qtyChange(vo);
	}

	@Override
	public void updateExport(Tbl_ExportVO vo) {
		mapper.updateExport(vo);
	}

	@Override
	public void stockPlus(Tbl_ExportVO vo) {
		mapper.stockPlus(vo);
	}
	
	
}

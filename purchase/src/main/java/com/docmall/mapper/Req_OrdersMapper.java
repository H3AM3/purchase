package com.docmall.mapper;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.docmall.domain.Req_OrdersVO;
import com.docmall.dto.Req_OrderDelDTO;
import com.docmall.dto.Req_OrdersDTO;
import com.docmall.dto.Req_checkPageDTO;

public interface Req_OrdersMapper {

	public void insertReq_orders(Req_OrdersVO vo);

	public Long checkPage(Req_checkPageDTO dto);
	public List<Req_OrdersVO> req_orderInDatePageList(Req_checkPageDTO dto);
	public void update_req_order(Req_OrdersVO vo);
	public List<Req_OrdersVO> getReqOrder_List(Req_OrdersDTO dto);
	public List<Req_OrdersVO> req_ordrInfo_pordList(Req_OrdersVO vo);
	public void req_orderDel(String delNo);
	public List<Req_OrdersVO> getAllOrder_List(Req_OrdersDTO dto);
	public void req_approvalRejectUpdate(Req_OrdersVO vo);
	public Long getNewPage(Req_OrdersVO vo);

}

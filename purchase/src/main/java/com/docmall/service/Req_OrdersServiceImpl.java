package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.Tbl_OrdersVO;
import com.docmall.dto.OrderFormByVenderDTO;
import com.docmall.dto.Req_OrdersDTO;
import com.docmall.dto.Req_checkPageDTO;
import com.docmall.mapper.Req_OrdersMapper;
@Service
public class Req_OrdersServiceImpl implements Req_OrdersService {

	@Autowired
	private Req_OrdersMapper mapper;

	@Override
	public void insertReq_orders(Req_OrdersVO vo) {
		mapper.insertReq_orders(vo);}

	@Override
	public Long checkPage(Req_checkPageDTO dto) {
		return mapper.checkPage(dto);
	}

	@Override
	public List<Req_OrdersVO> req_orderInDatePageList(Req_checkPageDTO dto) {
		return mapper.req_orderInDatePageList(dto);
	}

	@Override
	public void update_req_order(Req_OrdersVO vo) {
		mapper.update_req_order(vo);}

	@Override
	public List<Req_OrdersVO> getReqOrder_List(Req_OrdersDTO dto) {
		return mapper.getReqOrder_List(dto);
	}

	@Override
	public List<Req_OrdersVO> req_ordrInfo_pordList(Req_OrdersVO vo) {
		return mapper.req_ordrInfo_pordList(vo);
	}

	@Override
	public void req_orderDel(String delNo) {
		mapper.req_orderDel(delNo);
	}

	@Override
	public List<Req_OrdersVO> getAllOrder_List(Req_OrdersDTO dto) {
		return mapper.getAllOrder_List(dto);
	}

	@Override
	public void req_approvalRejectUpdate(Req_OrdersVO vo) {
		mapper.req_approvalRejectUpdate(vo);
	}

	@Override
	public Long getNewPage(Req_OrdersVO vo) {
		return mapper.getNewPage(vo);
	}


}

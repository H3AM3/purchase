package com.docmall.service;

import java.util.List;

import com.docmall.domain.Order_SyncVO;
import com.docmall.domain.ProductVO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.StockVO;
import com.docmall.domain.Tbl_OrdersVO;
import com.docmall.domain.VenderVO;
import com.docmall.dto.ApprovalListDTO;
import com.docmall.dto.OrderDeleteDTO;
import com.docmall.dto.OrderFormByVenderDTO;

public interface OrdersService {
	
	public List<ApprovalListDTO> getAprrovalList(ApprovalListDTO dto);
	public List<VenderVO> createOrderVnederList(ApprovalListDTO dto);
	public Long getNewOrderPage(Tbl_OrdersVO vo);
	public List<Req_OrdersVO> createOrderList(OrderFormByVenderDTO dto);
	public ProductVO OrderListProdData(ProductVO vo);
	public List<Req_OrdersVO> getReq_noList(OrderFormByVenderDTO dto);
	public void createOrderPage(Tbl_OrdersVO tbl_orderVO);
	public void syncInsert(Order_SyncVO vo);
	public void check_mkOrder(Order_SyncVO vo);
	public List<Tbl_OrdersVO> getOrderList(ApprovalListDTO dto);
	public List<Tbl_OrdersVO> getOrder(OrderFormByVenderDTO dto);
	public void delOrder(Tbl_OrdersVO vo);
	public List<OrderDeleteDTO> getSyncReq_no(Tbl_OrdersVO vo);
	public void changeReqMk_order(OrderDeleteDTO dto);
	public void delOrder_Sync(OrderDeleteDTO dto);
	public Long getStock(StockVO vo);
	public void waiting_importsInsert(Tbl_OrdersVO tbl_orderVO);
	public void delWaiting_imports(Tbl_OrdersVO vo);

}

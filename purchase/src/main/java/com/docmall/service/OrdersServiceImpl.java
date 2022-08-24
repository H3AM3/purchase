package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.Order_SyncVO;
import com.docmall.domain.ProductVO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.StockVO;
import com.docmall.domain.Tbl_OrdersVO;
import com.docmall.domain.VenderVO;
import com.docmall.dto.ApprovalListDTO;
import com.docmall.dto.OrderDeleteDTO;
import com.docmall.dto.OrderFormByVenderDTO;
import com.docmall.mapper.OrdersMapper;

@Service
public class OrdersServiceImpl implements OrdersService {
	
	@Autowired
	private OrdersMapper mapper;

	@Override
	public List<ApprovalListDTO> getAprrovalList(ApprovalListDTO dto) {
		return mapper.getAprrovalList(dto);}

	@Override
	public List<VenderVO> createOrderVnederList(ApprovalListDTO dto) {
		return mapper.createOrderVnederList(dto);}

	@Override
	public Long getNewOrderPage(Tbl_OrdersVO vo) {
		return mapper.getNewOrderPage(vo);}

	@Override
	public List<Req_OrdersVO> createOrderList(OrderFormByVenderDTO dto) {
		return mapper.createOrderList(dto);}

	@Override
	public ProductVO OrderListProdData(ProductVO vo) {
		return mapper.OrderListProdData(vo);}

	@Override
	public List<Req_OrdersVO> getReq_noList(OrderFormByVenderDTO dto) {
		return mapper.getReq_noList(dto);}

	@Override
	public void createOrderPage(Tbl_OrdersVO tbl_orderVO) {
		mapper.createOrderPage(tbl_orderVO);}

	@Override
	public void syncInsert(Order_SyncVO vo) {
		mapper.syncInsert(vo);}

	@Override
	public void check_mkOrder(Order_SyncVO vo) {
		mapper.check_mkOrder(vo);}

	@Override
	public List<Tbl_OrdersVO> getOrderList(ApprovalListDTO dto) {
		return mapper.getOrderList(dto);}

	@Override
	public List<Tbl_OrdersVO> getOrder(OrderFormByVenderDTO dto) {
		return mapper.getOrder(dto);}

	@Override
	public void delOrder(Tbl_OrdersVO vo) {
		mapper.delOrder(vo);}

	@Override
	public List<OrderDeleteDTO> getSyncReq_no(Tbl_OrdersVO vo) {
		return mapper.getSyncReq_no(vo);}

	@Override
	public void changeReqMk_order(OrderDeleteDTO dto) {
		mapper.changeReqMk_order(dto);}

	@Override
	public void delOrder_Sync(OrderDeleteDTO dto) {
		mapper.delOrder_Sync(dto);}

	@Override
	public Long getStock(StockVO vo) {
		return mapper.getStock(vo);}

	@Override
	public void waiting_importsInsert(Tbl_OrdersVO tbl_orderVO) {
		mapper.waiting_importsInsert(tbl_orderVO);}

	@Override
	public void delWaiting_imports(Tbl_OrdersVO vo) {
		mapper.delWaiting_imports(vo);}


}

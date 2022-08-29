package com.docmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.docmall.domain.Order_SyncVO;
import com.docmall.domain.ProductVO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.StockVO;
import com.docmall.domain.Tbl_OrdersVO;
import com.docmall.domain.VenderVO;
import com.docmall.dto.ApprovalListDTO;
import com.docmall.dto.OrderDeleteDTO;
import com.docmall.dto.OrderFormByVenderDTO;
import com.docmall.service.OrdersService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order/*")
@Log4j
public class OrderController {
	
	@Autowired
	private OrdersService service;

	// 발주서 작성 폼
	@GetMapping("/createOrder")
	public void createOrder() {}
	
	// 발주서 작성 업체리스트 검색
	@PostMapping("/createOrderVnederList")
	public ResponseEntity<List<VenderVO>> createOrderVnederList(ApprovalListDTO dto){
		ResponseEntity<List<VenderVO>> entity = null;
		List<VenderVO> list = service.createOrderVnederList(dto);
		return entity = new ResponseEntity<List<VenderVO>>(list, HttpStatus.OK);
	}
	
	// 업체별 발주요청서 작성 페이지
	@GetMapping("/orderFormByVender")
	public void orderFormByVender(OrderFormByVenderDTO dto, Model model) {
		model.addAttribute("defaultData", dto);

	}
	
	// 집계에 사용한 req_no리스트 불러오기
	@PostMapping("/getReq_no")
	public ResponseEntity<List<Req_OrdersVO>> getReq_no(OrderFormByVenderDTO dto){
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		List<Req_OrdersVO> req_noList = service.getReq_noList(dto);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(req_noList, HttpStatus.OK);
	}

	// 발주서 페이지번호 가져오기
	@PostMapping("/getNewOrderPage")
	public ResponseEntity<Long> getNewOrderPage(Tbl_OrdersVO vo){
		ResponseEntity<Long> entity = null;
		Long page = service.getNewOrderPage(vo);
		return entity = new ResponseEntity<Long>(page, HttpStatus.OK);
	}
	
	// 요청서 집계한것, 코드 별 수량 리스트 불러오기
	@PostMapping("/createOrderList")
	public ResponseEntity<List<Req_OrdersVO>> createOrderList(OrderFormByVenderDTO dto){
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		// 품목코드 리스트
		List<Req_OrdersVO> list = service.createOrderList(dto);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(list, HttpStatus.OK);
	}
	
	// 코드 데이터 불러오기
	@PostMapping("/OrderListProdData")
	public ResponseEntity<ProductVO> OrderListProdData(ProductVO vo){
		ResponseEntity<ProductVO> entity = null;
		ProductVO prodVO = service.OrderListProdData(vo);
		return entity = new ResponseEntity<ProductVO>(prodVO, HttpStatus.OK);
	}
	
	//품목 재고 불러오기
	@PostMapping("/getStock")
	public ResponseEntity<Long> getStock(StockVO vo){
		ResponseEntity<Long> entity = null;
		Long quantity =service.getStock(vo);
		return entity = new ResponseEntity<Long>(quantity, HttpStatus.OK);
	}
	
	// 발주서 생성
	@Transactional
	@PostMapping("/createOrderPage")
	public String createOrderPage(@ModelAttribute("tbl_orderVO") Tbl_OrdersVO tbl_orderVO) {
		log.info("테스트내역 : "+tbl_orderVO.getTbl_orderVO());
		for(int i=0; i<tbl_orderVO.getTbl_orderVO().size(); i++) {
			if(tbl_orderVO.getTbl_orderVO().get(i).getMk_order() != null) {
				tbl_orderVO.getTbl_orderVO().get(i).setOrder_send("0");
				tbl_orderVO.getTbl_orderVO().get(i).setImported("0");
				log.info(i+"번째 저장내역"+tbl_orderVO.getTbl_orderVO().get(i));
				service.createOrderPage(tbl_orderVO.getTbl_orderVO().get(i));
				// 미입고내역 생성
				service.waiting_importsInsert(tbl_orderVO.getTbl_orderVO().get(i));
			}
		}
		return "redirect:/order/createOrder";
	}
	
	// 발주서-요청서 싱크정보 insert
	@Transactional
	@PostMapping("/syncInsert")
	public ResponseEntity<String> syncInsert(Order_SyncVO vo){
		ResponseEntity<String> entity = null;
		log.info("싱크 메소드 : "+vo);
		service.syncInsert(vo);
		vo.setMk_order("1");
		service.check_mkOrder(vo);
		return entity;
	}
	
	// 발주서 리스트 페이지
	@GetMapping("/orderList")
	public void orderList() {}


	//발주서 리스트 불러오기
	@PostMapping("/getOrderList")
	public ResponseEntity<List<Tbl_OrdersVO>> getOrderList(ApprovalListDTO dto){
		ResponseEntity<List<Tbl_OrdersVO>> entity = null;
		List<Tbl_OrdersVO> list = service.getOrderList(dto);
		return entity = new ResponseEntity<List<Tbl_OrdersVO>>(list, HttpStatus.OK);
	}


	// 발주서 폼
	@GetMapping("/orderInfo")
	public void orderInfo(OrderFormByVenderDTO dto, Model model) {
		model.addAttribute("defaultData", dto);
	}

	// 발주서 내역 불러오는 기능
	@PostMapping("/getOrder")
	public ResponseEntity<List<Tbl_OrdersVO>> getOrder(OrderFormByVenderDTO dto){
		log.info("받은 데이터 : "+dto);
		ResponseEntity<List<Tbl_OrdersVO>> entity = null;
		List<Tbl_OrdersVO> list = service.getOrder(dto);
		log.info("보낸 데이터 : " + list);
		return entity = new ResponseEntity<List<Tbl_OrdersVO>>(list, HttpStatus.OK);
	}
	
	// 발주서 내용수정(업데이트)
	@Transactional
	@PostMapping("/orderUpdate")
	public String orderUpdate(Tbl_OrdersVO vo) {
		log.info("받은 내역 : "+vo.getTbl_orderVO());
		List<OrderDeleteDTO> dto;
		for(int i=0; i<vo.getTbl_orderVO().size(); i++) {
			log.info(i+" 번째 for문 시작");
			log.info(vo.getTbl_orderVO().get(i));
			if(vo.getTbl_orderVO().get(i).getMk_order() == null) {
				log.info(i+" 번째 배열 작업 시작");
				// order_num으로 발주서 테이블 행삭제
				service.delOrder(vo.getTbl_orderVO().get(i));
				// 미입고내역 삭제
				service.delWaiting_imports(vo.getTbl_orderVO().get(i));
				// 발주일, 페이지, 품목코드, 카테고리 받아서 REQ_NO가져오기
				dto = service.getSyncReq_no(vo.getTbl_orderVO().get(i));
				log.info("dto 생성 : "+dto);
				for(int k=0; k<dto.size(); k++) {
					// REQ_NO받아서 mk_order '0'으로 변경
					service.changeReqMk_order(dto.get(k));
					// 발주일, 페이지, 품목코드, 카테고리로 ORDER_SYNC행 삭제
					service.delOrder_Sync(dto.get(k));
				}
			}
		}
		return "redirect:/order/orderList";
	}
	

}
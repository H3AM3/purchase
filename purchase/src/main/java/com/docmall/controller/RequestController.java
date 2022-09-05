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

import com.docmall.domain.Req_OrdersVO;
import com.docmall.dto.Req_OrderDelDTO;
import com.docmall.dto.Req_OrdersDTO;
import com.docmall.dto.Req_checkPageDTO;
import com.docmall.service.Req_OrdersService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/request/*")
@Log4j
public class RequestController {
	
	@Autowired
	private Req_OrdersService service;

	@GetMapping("/requestOrder")
	public void requestOrder() {}
	
	@PostMapping("/requestOrder")
	public void getDateTest(String selectDate) {}
	
	// 품목검색용 팝업창
	@GetMapping("/productSearchPopup")
	public void productSearchPopup() {}
	
	// 발주요청 저장
	@Transactional
	@PostMapping("/req_orderInsert")
	public String orderinsert(@ModelAttribute("req_ordersList") Req_OrdersVO vo) {
		log.info("받은 요청 : "+vo.getReq_ordersList());
		for(int i=0; i<vo.getReq_ordersList().size(); i++) {
			if(!(vo.getReq_ordersList().get(i).getProduct_code() == "")) {
				vo.getReq_ordersList().get(i).setApproval("0");
				vo.getReq_ordersList().get(i).setMk_order("0");
				vo.getReq_ordersList().get(i).setReq_reject("0");
				vo.getReq_ordersList().get(i).setEnd_request("0");
				vo.getReq_ordersList().get(i).setUnimported_qty(vo.getReq_ordersList().get(i).getReq_quantity());
				service.insertReq_orders(vo.getReq_ordersList().get(i));
			}
		}
		return "redirect:/request/requestOrder";
	}
	
	// 사용자,날짜, 카테고리 페이지 보내서 현재 가장 큰 페이지 값을 리턴
	@PostMapping("/checkPage")
	public ResponseEntity<String> checkPage(Req_checkPageDTO dto) {
		ResponseEntity<String> entity = null;

		
		return entity = new ResponseEntity<String>("", HttpStatus.OK);
	}

	// 발주요청서 리스트 폼
	@GetMapping("/requestOrder_List")
	public void requestOrder_List() {}
	
	// 발주요청서 리스트(자신의 부서것만) 불러오기
	@PostMapping("/getReqOrder_List")
	public ResponseEntity<List<Req_OrdersVO>> getReqOrder_List(Req_OrdersDTO dto) {
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		List<Req_OrdersVO> list = service.getReqOrder_List(dto);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(list, HttpStatus.OK);
	}

	// 발주요청서 폼
	@GetMapping("/req_orderInfo")
	public void req_orderInfo(String req_date, String req_page, String dep_code, String category_2nd, String dep_name, Model model) {
		model.addAttribute("req_date", req_date);
		model.addAttribute("req_page", req_page);
		model.addAttribute("dep_code", dep_code);
		model.addAttribute("category_2nd", category_2nd);
		model.addAttribute("dep_name", dep_name);
	}

	// 발주요청서 내용 가져오는 기능
	@PostMapping("/req_ordrInfo_pordList")
	public ResponseEntity<List<Req_OrdersVO>> req_ordrInfo_pordList(Req_OrdersVO vo){
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		log.info("받은값"+vo);
		List<Req_OrdersVO> list = service.req_ordrInfo_pordList(vo);
		log.info("보낸값"+list);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(list, HttpStatus.OK);
	}
	
	// 발주요청내역 수정/추가 기능
	@PostMapping("/req_orderUpdate")
	public String req_orderUpdate(Req_OrdersVO vo){
		String on = "on";
		log.info("아무것도 없을 때 체크 :"+vo.getReq_ordersList());
		if(vo.getReq_ordersList() != null) {
		for(int i=0; i<vo.getReq_ordersList().size(); i++) {
		if(vo.getReq_ordersList().get(i).getReq_no()!=null) {
			// 이미 저장 된 데이터일 때
			if(vo.getReq_ordersList().get(i).getApproval() == null &&
			   vo.getReq_ordersList().get(i).getReq_reject() == null &&
			   vo.getReq_ordersList().get(i).getReq_quantity() == vo.getReq_ordersList().get(i).getUnimported_qty()) {
				// 승인 또는 반려된 상태가 아니면 update (덮어쓰면서 아래 3가지는 0처리)
				vo.getReq_ordersList().get(i).setApproval("0");
				vo.getReq_ordersList().get(i).setMk_order("0");
				vo.getReq_ordersList().get(i).setReq_reject("0");
				vo.getReq_ordersList().get(i).setEnd_request("0");
				vo.getReq_ordersList().get(i).setUnimported_qty(vo.getReq_ordersList().get(i).getReq_quantity());
				service.update_req_order(vo.getReq_ordersList().get(i));
			}
		}else if(vo.getReq_ordersList().get(i).getReq_no() == null) {
			// 저장된적 없는 데이터일 때(새로 추가한 데이터)
			if(vo.getReq_ordersList().get(i).getProduct_code() == "") {
			} else if(vo.getReq_ordersList().get(i).getProduct_code() != null) {
			// 내용이 있으면 새로 insert
			vo.getReq_ordersList().get(i).setApproval("0");
			vo.getReq_ordersList().get(i).setMk_order("0");
			vo.getReq_ordersList().get(i).setReq_reject("0");
			vo.getReq_ordersList().get(i).setEnd_request("0");
			vo.getReq_ordersList().get(i).setUnimported_qty(vo.getReq_ordersList().get(i).getReq_quantity());
			service.insertReq_orders(vo.getReq_ordersList().get(i));
			}
		}
		}
		}
		return "redirect:/request/requestOrder_List";
	}
	
	// 발주요청 내역 삭제 기능
	@PostMapping("/req_orderDel")
	public void req_orderDel(String[] delNo) {
		log.info("삭제 메소드 작동");
		log.info(delNo.length);
		log.info("delNo"+delNo);
		if(delNo != null) {
			for(int i=0; i<delNo.length; i++) {
			service.req_orderDel(delNo[i]);
			}
		}

	}
	
	// 모든부서 발주요청 페이지 폼
	@GetMapping("allOrder_List")
	public void allOrder_List() {}
	
	// 모든부서 발주요청 내역(리스트) 불러오기
	@PostMapping("/getAllOrder_List")
	public ResponseEntity<List<Req_OrdersVO>> getAllOrder_List(Req_OrdersDTO dto){
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		List<Req_OrdersVO> list = service.getAllOrder_List(dto);
		log.info(list);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(list, HttpStatus.OK);
	}
	
	//승인, 반려 페이지 폼
	@GetMapping("req_orderApprovalReject")
	public void req_orderApprovalReject(String req_date, String req_page, String dep_code, String category_2nd, String dep_name, Model model) {
		model.addAttribute("req_date", req_date);
		model.addAttribute("req_page", req_page);
		model.addAttribute("dep_code", dep_code);
		model.addAttribute("category_2nd", category_2nd);
		model.addAttribute("dep_name", dep_name);
	}
	
	// 승인, 반려 내용 저장
	@PostMapping("req_approvalRejectUpdate")
	public String req_approvalRejectUpdate(Req_OrdersVO vo) {
		log.info(vo.getReq_ordersList());
		for(int i=0; i<vo.getReq_ordersList().size(); i++) {
			// 승인 내용변환
			if(vo.getReq_ordersList().get(i).getApproval()==null) {
				vo.getReq_ordersList().get(i).setApproval("0");
			}else {
				vo.getReq_ordersList().get(i).setApproval("1");
			}
			// 반려 내용변환
			if(vo.getReq_ordersList().get(i).getReq_reject()==null) {
				vo.getReq_ordersList().get(i).setReq_reject("0");
			}else {
				vo.getReq_ordersList().get(i).setReq_reject("1");
			}
			// 발주여부 내용변환
			if(vo.getReq_ordersList().get(i).getMk_order() == null) {
				vo.getReq_ordersList().get(i).setMk_order("0");
			} else {
				vo.getReq_ordersList().get(i).setMk_order("1");
			}
			service.req_approvalRejectUpdate(vo.getReq_ordersList().get(i));
		}
		return "redirect:/request/allOrder_List";
	}
	
	// 발주요청서 새 페이지 번호 받아오는 기능
	@PostMapping("/getNewPage")
	public ResponseEntity<Long> getNewPage(Req_OrdersVO vo) {
		log.info("페이지 데이터 : "+vo);
		ResponseEntity<Long> entity = null;
		Long newPage = service.getNewPage(vo);
		log.info("페이지 결과 : "+ newPage);
		return entity = new ResponseEntity<Long>(newPage, HttpStatus.OK);
	}


}

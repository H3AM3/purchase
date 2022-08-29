package com.docmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.docmall.domain.ExportSearchDTO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.Tbl_ExportVO;
import com.docmall.service.ExportService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/export/*")
public class ExportController {
	
	@Autowired
	private ExportService service;

	@GetMapping("/createExports")
	public void createExports() {}
	
	@GetMapping("/searchReq_order")
	public void searchReq_order() {}
	
	@PostMapping("/getReqList")
	public ResponseEntity<List<Req_OrdersVO>> getReqList(ExportSearchDTO dto) {
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		log.info(dto);
		List<Req_OrdersVO> list = service.getReqList(dto);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/req_orderInfo")
	public void req_orderInfo(Req_OrdersVO vo, Model model) {
		log.info("defaultData"+vo);
		model.addAttribute("defaultData", vo);
	}
	
	@PostMapping("/getReq_orderInfo")
	public ResponseEntity<List<Req_OrdersVO>> getReq_orderInfo(Req_OrdersVO vo){
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		List<Req_OrdersVO> list = service.getReq_orderInfo(vo);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping("/getStockQty")
	public ResponseEntity<Long> getStockQty(String product_code){
		log.info("받은 품목코드 : "+product_code);
		ResponseEntity<Long> entity = null;
		Long quantity = service.getStockQty(product_code);
		log.info("보낸 재고량 : "+quantity);
		return entity = new ResponseEntity<Long>(quantity, HttpStatus.OK);
	}
	
	@PostMapping("/getNewExportPage")
	public ResponseEntity<Long> getNewExportPage(Tbl_ExportVO vo){
		ResponseEntity<Long> entity = null;
		Long page = service.getNewExportPage(vo);
		return entity = new ResponseEntity<Long>(page, HttpStatus.OK);
	}

	@Transactional
	@PostMapping("/insertExport")
	public String insertExport(Tbl_ExportVO vo) {
		for(int i=0; i<vo.getTbl_export().size(); i++) {
			log.info(vo.getTbl_export().get(i));
			// export테이블 값 추가하는 기능
			service.insertExport(vo.getTbl_export().get(i));
			log.info("export테이블 값 추가함");
			//stock테이블 값 빼는 기능
			service.stockMinus(vo.getTbl_export().get(i));
			log.info("Stock테이블 값 뻄");
			//req_order테이블 값 빼는 기능(값이 0되면 end_request값 변경)
			service.changeReq_order_qty(vo.getTbl_export().get(i));
			service.checkReq_order_end(vo.getTbl_export().get(i).getReq_no());
			log.info("req_order테이블 수정함");
		}
		
		return "redirect:/export/createExports";
	}
	
	@GetMapping("/exportList")
	public void exportList() {}
	
	@PostMapping("/getExportList")
	public ResponseEntity<List<Tbl_ExportVO>> getExportList(ExportSearchDTO dto){
		ResponseEntity<List<Tbl_ExportVO>> entity = null;
		log.info(dto);
		List<Tbl_ExportVO> list = service.getExportList(dto);
		log.info(list);
		return entity = new ResponseEntity<List<Tbl_ExportVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/exportInfo")
	public void exportInfo(Tbl_ExportVO vo, Model model) {
		model.addAttribute("defaultData", vo);
	}
	
	@PostMapping("/getExportInfo")
	public ResponseEntity<List<Tbl_ExportVO>> getExportInfo(Tbl_ExportVO vo){
		ResponseEntity<List<Tbl_ExportVO>> entity = null;
		log.info(vo);
		List<Tbl_ExportVO> list = service.getExportInfo(vo);
		log.info(list);
		return entity = new ResponseEntity<List<Tbl_ExportVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping("/getReq_qty")
	public ResponseEntity<Req_OrdersVO> getReq_qty(Long req_no){
		ResponseEntity<Req_OrdersVO> entity = null;
		Req_OrdersVO quantity = service.getReq_qty(req_no);
		log.info("보낸 청구내역 : " + quantity);
		return entity = new ResponseEntity<Req_OrdersVO>(quantity, HttpStatus.OK);
	}
	
	@Transactional
	@PostMapping("/delExport")
	public void delExport(Tbl_ExportVO vo){
		log.info(vo);
		// 출고내역 삭제
		service.delExport(vo);
		// 삭제한 출고내역 수량만큼 요청서의 미입고수량 추가
		service.req_qtyChange(vo);
		// 요청서 종결처리 취소
		service.checkReq_order_end(vo.getReq_no());
		// 재고수량 조정
		service.stockPlus(vo);
	}
	
	@Transactional
	@PostMapping("/updateExport")
	public String updateExport(Tbl_ExportVO vo) {
		log.info(vo.getTbl_export());
		if(vo.getTbl_export() != null) {
			for(int i=0; i<vo.getTbl_export().size(); i++) {
				vo.getTbl_export().get(i).setEx_quantity(
						vo.getTbl_export().get(i).getEx_quantity()-vo.getTbl_export().get(i).getOriginal_ex_quantity());
				// 출고내역 수량, 비고란 변경
				service.updateExport(vo.getTbl_export().get(i));
				// 재고수량 변경
				service.stockMinus(vo.getTbl_export().get(i));
				// 청구서 미입고수량 변경
				vo.getTbl_export().get(i).setOriginal_ex_quantity(vo.getTbl_export().get(i).getEx_quantity());
				service.req_qtyChange(vo.getTbl_export().get(i));
				service.checkReq_order_end(vo.getTbl_export().get(i).getReq_no());
			} 
		}
		return "redirect:/export/exportList";
	}
}

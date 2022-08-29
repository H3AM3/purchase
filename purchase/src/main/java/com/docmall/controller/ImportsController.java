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

import com.docmall.domain.StockVO;
import com.docmall.domain.Tbl_ImportVO;
import com.docmall.domain.Waiting_ImportsVO;
import com.docmall.dto.DeleteImportDTO;
import com.docmall.dto.ImportListDTO;
import com.docmall.dto.ImportPageDTO;
import com.docmall.dto.WaitingListDTO;
import com.docmall.service.ImportService;
import com.docmall.service.Waiting_ImportsService;


import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/import/*")
@Log4j
public class ImportsController {
	
	@Autowired
	private Waiting_ImportsService wating_service;
	@Autowired
	private ImportService import_service;

	@GetMapping("/createImports")
	public void createImports() {}
	
	@GetMapping("/searchWaiting")
	public void searchWaiting() {}
	
	@PostMapping("/getWaitingList")
	public ResponseEntity<List<Waiting_ImportsVO>> getWaitingList(WaitingListDTO dto){
		ResponseEntity<List<Waiting_ImportsVO>> entity = null;
		List<Waiting_ImportsVO> list = wating_service.getWaitingList(dto);
		return entity = new ResponseEntity<List<Waiting_ImportsVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/waitingImportInfo")
	public void waitingImportInfo(
			String order_date, Long order_page,
			String vender_code, String category_2nd,
			Model model) {
		model.addAttribute("order_date", order_date);
		model.addAttribute("order_page", order_page);
		model.addAttribute("vender_code", vender_code);
		model.addAttribute("category_2nd", category_2nd);
	}
	
	@PostMapping("/getWaitingImportInfo")
	public ResponseEntity<List<Waiting_ImportsVO>> getWaitingImportInfo(Waiting_ImportsVO vo){
		ResponseEntity<List<Waiting_ImportsVO>> entity = null;
		List<Waiting_ImportsVO> list = wating_service.getWaitingImportInfo(vo);
		return entity = new ResponseEntity<List<Waiting_ImportsVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping("/getNewImportPage")
	public ResponseEntity<Long> getNewImportPage(ImportPageDTO dto){
		ResponseEntity<Long> entity = null;
		Long page = wating_service.getNewImportPage(dto);
		log.info("새 페이지 : "+page);
		return entity = new ResponseEntity<Long>(page, HttpStatus.OK);
	}
	
	@Transactional
	@PostMapping("/insertImport")
	public String insertImport(Tbl_ImportVO tbl_importVO) {
		log.info("받은 데이터 : " + tbl_importVO);
		for(int i=0; i<tbl_importVO.getTbl_importVO().size(); i++) {
			// 입고내역 테이블 작성
			wating_service.insertImport(tbl_importVO.getTbl_importVO().get(i));
			log.info("입고테이블 작성 성공");
			
			// waiting테이블 입고수량 반영
			wating_service.order_im_qtyChange(tbl_importVO.getTbl_importVO().get(i));
			log.info("waiting입고수량 반영 성공");
			
			// Stock테이블 입고수량 반영
			wating_service.stockChange(tbl_importVO.getTbl_importVO().get(i));
			log.info("재고테이블 작성 성공");
			
			// import_end 1로 변경할지 수량 체크
			wating_service.importEndCheck(tbl_importVO.getTbl_importVO().get(i));
			log.info("미입고 종결처리 성공");
			
			// order페이지 입고처리
			import_service.orderImportedCheck(tbl_importVO.getTbl_importVO().get(i));
		}
		return "redirect:/import/createImports";	
	}
	
	@GetMapping("/importList")
	public void importList() {}
	
	@PostMapping("/getImportList")
	public ResponseEntity<List<Tbl_ImportVO>> getImportList(ImportListDTO dto){
		ResponseEntity<List<Tbl_ImportVO>> entity = null;
		List<Tbl_ImportVO> list = import_service.getImportList(dto);
		log.info("리턴 : "+list);
		return entity = new ResponseEntity<List<Tbl_ImportVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/importInfo")
	public void importInfo(String category_2nd, String vender_code,
						   String import_date, Long import_page,
						   String vender_name, Model model) {
		model.addAttribute("category_2nd", category_2nd);
		model.addAttribute("vender_code", vender_code);
		model.addAttribute("import_date", import_date);
		model.addAttribute("import_page", import_page);
		model.addAttribute("vender_name", vender_name);
		log.info("부서명: "+vender_name);
		
	}
	
	@PostMapping("/getImportInfo")
	public ResponseEntity<List<Tbl_ImportVO>> getImportInfo(Tbl_ImportVO vo){
		log.info("받은 데이터 : "+vo);
		ResponseEntity<List<Tbl_ImportVO>> entity = null;
		List<Tbl_ImportVO> list = import_service.getImportInfo(vo);
		log.info("내역 : "+list);
		return entity = new ResponseEntity<List<Tbl_ImportVO>>(list, HttpStatus.OK);
	}
	
	// 입고내역 삭제시 재고수량 확인기능
	@PostMapping("/checkStock")
	public ResponseEntity<StockVO> checkStock(StockVO vo){
		ResponseEntity<StockVO> entity = null;
		StockVO stock_quantity = import_service.checkStock(vo);
		log.info(stock_quantity);
		return entity = new ResponseEntity<StockVO>(stock_quantity, HttpStatus.OK);
	}
	
	// 입고내역 삭제기능
	@Transactional
	@PostMapping("/delImport")
	public ResponseEntity<String> delImport(DeleteImportDTO dto){
		String returnVal = "";
		ResponseEntity<String> entity = null;
		try {
			Long orderNum = import_service.getOrderNum(dto);
			import_service.orderImportedFalse(orderNum);
			import_service.delImprot(dto);
			import_service.delWaitingQuantity(dto);
			import_service.stockMinus(dto);
			returnVal = "success";
		} catch (Exception e) {
			returnVal = "failure";
		}
		return entity = new ResponseEntity<String>(returnVal, HttpStatus.OK);
	}
	
	//입고내역 저장(삭제시) redirect해주는 기능
	@PostMapping("/redirecImportInfo")
	public String redirecImportInfo() {
		return "redirect:/import/importList";
	}
}

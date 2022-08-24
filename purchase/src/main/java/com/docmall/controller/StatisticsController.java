package com.docmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.docmall.domain.DepartmentVO;
import com.docmall.domain.ProductVO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.Tbl_ExportVO;
import com.docmall.domain.Tbl_ImportVO;
import com.docmall.domain.Tbl_OrdersVO;
import com.docmall.dto.DepSearchDTO;
import com.docmall.dto.Monthly_StatisticsDTO;
import com.docmall.dto.OrderFormByVenderDTO;
import com.docmall.dto.StatisticsDTO;
import com.docmall.service.StatsticsService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/statistics/*")
@Controller
@Log4j
public class StatisticsController {

	@Autowired
	private StatsticsService service;
	
	@GetMapping("/req_statistics")
	public void req_statistics() {}
	
	@GetMapping("/productSearchPopup")
	public void productSearchPopup() {}
	
	@PostMapping("/searchProduct")
	public ResponseEntity<List<ProductVO>> searchProduct(OrderFormByVenderDTO dto) {
		ResponseEntity<List<ProductVO>> entity = null;
		List<ProductVO> list = service.searchProduct(dto);
		return entity = new ResponseEntity<List<ProductVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/depSearchPopup")
	public void depSearchPopup() {}
	
	@PostMapping("/depSearchPopup")
	public ResponseEntity<List<DepartmentVO>> depSearchPopup(DepSearchDTO dto){
		ResponseEntity<List<DepartmentVO>> entity= null;
			List<DepartmentVO> list = service.depSearchPopup(dto);
			for(int i=0; i<list.size(); i++) {
				if(list.get(i).getUpper_dep() != null) {
					list.get(i).setUpper_dep(service.getUpper_depName(list.get(i)));
				}
			}
			log.info(list);
		return entity = new ResponseEntity<List<DepartmentVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping("/getReqStatistics")
	public ResponseEntity<List<Req_OrdersVO>> getReqStatistics(StatisticsDTO dto){
		log.info("요청 받은 데이터 : "+dto);
		ResponseEntity<List<Req_OrdersVO>> entity = null;
		List<Req_OrdersVO> list = service.getReqStatistics(dto);
		log.info("요청 보낸 데이터 : "+list);
		return entity = new ResponseEntity<List<Req_OrdersVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping("/getExportStatistics")
	public ResponseEntity<List<Tbl_ExportVO>> getExportStatistics(StatisticsDTO dto){
		log.info("출고 받은 데이터 : "+dto);
		ResponseEntity<List<Tbl_ExportVO>> entity = null;
		List<Tbl_ExportVO> list = service.getExportStatistics(dto);
		log.info("출고 보낸 데이터 : "+list);
		return entity = new ResponseEntity<List<Tbl_ExportVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/order_statistics")
	public void order_statistics() {}
	
	@PostMapping("/getOrderStatistics")
	public ResponseEntity<List<Tbl_OrdersVO>> getOrderStatistics(StatisticsDTO dto) {
		log.info(dto);
		ResponseEntity<List<Tbl_OrdersVO>> entity = null;
		List<Tbl_OrdersVO> list = service.getOrderStatistics(dto);
		log.info(list);
		return entity = new ResponseEntity<List<Tbl_OrdersVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping("/getImportStatistics")
	public ResponseEntity<List<Tbl_ImportVO>> getImportStatistics(StatisticsDTO dto){
		log.info(dto);
		ResponseEntity<List<Tbl_ImportVO>> entity = null;
		List<Tbl_ImportVO> list = service.getImportStatistics(dto);
		log.info(list);
		return entity = new ResponseEntity<List<Tbl_ImportVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/monthly_statistics")
	public void monthly_statistics() {}
	
	@PostMapping("/getMonthlyReqStatistics")
	public ResponseEntity<Monthly_StatisticsDTO> getMonthlyReqStatistics(StatisticsDTO dto) {
		log.info(dto);
		ResponseEntity<Monthly_StatisticsDTO> entity = null;
		Monthly_StatisticsDTO result = service.getMonthlyReqStatistics(dto);
		log.info(result);
		return entity = new ResponseEntity<Monthly_StatisticsDTO>(result, HttpStatus.OK);
	}

	@PostMapping("/getPrevYear")
	public ResponseEntity<Monthly_StatisticsDTO> getPrevYear(StatisticsDTO dto){
		log.info(dto);
		ResponseEntity<Monthly_StatisticsDTO> entity = null;
		Monthly_StatisticsDTO result = service.getPrevYear(dto);
		log.info(result);
		return entity = new ResponseEntity<Monthly_StatisticsDTO>(result, HttpStatus.OK);
	}
	
	@PostMapping("/getMonthlyOrderStatistics")
	public ResponseEntity<Monthly_StatisticsDTO> getMonthlyOrderStatistics(StatisticsDTO dto) {
		log.info(dto);
		ResponseEntity<Monthly_StatisticsDTO> entity = null;
		Monthly_StatisticsDTO result = service.getMonthlyOrderStatistics(dto);
		log.info(result);
		return entity = new ResponseEntity<Monthly_StatisticsDTO>(result, HttpStatus.OK);
	}
	
	@PostMapping("/getOrderPrevYear")
	public ResponseEntity<Monthly_StatisticsDTO> getOrderPrevYear(StatisticsDTO dto){
		log.info(dto);
		ResponseEntity<Monthly_StatisticsDTO> entity = null;
		Monthly_StatisticsDTO result = service.getOrderPrevYear(dto);
		log.info(result);
		return entity = new ResponseEntity<Monthly_StatisticsDTO>(result, HttpStatus.OK);
	}
	
	@PostMapping("/getProductInfo")
	public ResponseEntity<ProductVO> getProductInfo(String product_code){
		ResponseEntity<ProductVO> entity = null;
		ProductVO vo = service.getProductInfo(product_code);
		return entity = new ResponseEntity<ProductVO>(vo, HttpStatus.OK);
	}
	
}

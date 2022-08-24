package com.docmall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.DepartmentVO;
import com.docmall.domain.MakerVO;
import com.docmall.domain.PakagingVO;
import com.docmall.domain.ProductHistoryVO;
import com.docmall.domain.ProductInfoDTO;
import com.docmall.domain.ProductVO;
import com.docmall.domain.TypeVO;
import com.docmall.domain.VenderVO;
import com.docmall.dto.DepSearchDTO;
import com.docmall.dto.ProductDTO;
import com.docmall.service.CodeService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/code/*")
@Log4j
public class CodeController {

	@Autowired
	CodeService service;
/**********************************품목 컨트롤러**********************************/	
	// 품목리스트 폼
	@GetMapping("/productList")
	public void productList(){}
	
	// 품목 생성 폼
	@GetMapping("/createProductCode")
	public void createProductForm() {}
	
	// 품목리스트 상위카테고리 생성기능
	@PostMapping("/getUpperCat")
	public ResponseEntity<List<CategoryVO>> getUpperCat(){
		List<CategoryVO> vo = service.getUpperCat();
		ResponseEntity<List<CategoryVO>> entity = null;
		return entity = new ResponseEntity<List<CategoryVO>>(vo, HttpStatus.OK);
	}
	
	// 품목리스트 하위카테고리 생성 폼 
	@ResponseBody
	@PostMapping("/getLowerCat")
	public ResponseEntity<List<CategoryVO>> getLowerCat(@RequestParam("category_code") String category_code){
		List<CategoryVO> list = service.getLowerCat(category_code);
		ResponseEntity<List<CategoryVO>> entity;
		// log.info(list);
		entity = new ResponseEntity<List<CategoryVO>>(list, HttpStatus.OK);
		return entity;
	}
	
	// 품목코드생성 거래처검색 팝업창
	@GetMapping("/venSearchPopup")
	public void venSearchPopup() {}
	
	// 품목코드 중복체크
	@PostMapping("/productCheck")
	public ResponseEntity<String> productCheck(String product_code){
		ResponseEntity<String> entity = null;
		String check = service.productCheck(product_code);		
		return entity = new ResponseEntity<String>(check, HttpStatus.OK);
	}
	
	// 입고단위 불러오는 컨트롤러
	@PostMapping("/getpakaging")
	public ResponseEntity<List<PakagingVO>> getPakaging(){
		ResponseEntity<List<PakagingVO>> entity;
		List<PakagingVO> list = service.getPakaging();		
		return entity = new ResponseEntity<List<PakagingVO>>(list, HttpStatus.OK);
	}
	
	// 물품 타입 리스트를 불러오는 컨트롤러
	@PostMapping("/getType")
	public ResponseEntity<List<TypeVO>> getType(){
		ResponseEntity<List<TypeVO>> entity = null;
		List<TypeVO> list = service.getType();
		return entity = new ResponseEntity<List<TypeVO>>(list, HttpStatus.OK);
	}
	
	// 물품코드 저장
	@Transactional
	@PostMapping("/createProductCode")
	public String createProductCode(ProductVO vo, HttpSession session) {
		String usableTrue = "0";
		vo.setUsable(usableTrue);
		service.createProductCode(vo);
		service.updateHistory(vo);
		service.createStock(vo);
		return "redirect:/code/productList";}
	
	// 품목 리스트 가져오기
	@PostMapping("/getProdCodeList")
	@ResponseBody
	public ResponseEntity<List<ProductVO>> getProdCodeList(ProductDTO dto) {
		String none = "none";
		String noCategory = "noCategory";
		List<ProductVO> prodList = null;
			if(dto.getCategory_1st().equals(none)) {
				// 카테고리 미선택시
				prodList = service.getAllProdCodeList(dto);
			} else if(dto.getCategory_2nd().equals(none)) {
				// 카테고리 1만 선택시
				prodList = service.get1stCatProdCodeList(dto);
			} else if(dto.getCategory_1st().equals(noCategory) && dto.getCategory_2nd() != null) {
				// 카테고리 2만 가지고 검색
				prodList = service.get2enCatProdCodeList(dto);
			} else {
				// 카테고리 전부 선택하고 검색
				prodList = service.getProdCodeList(dto);
			}
			ResponseEntity<List<ProductVO>> entity;
		return entity = new ResponseEntity<List<ProductVO>>(prodList, HttpStatus.OK);}
	
	// 품목코드조회 및 수정
	@GetMapping("/prodInfo")
	public void prodInfo(@RequestParam("product_code") String product_code, Model model) {
		ProductInfoDTO vo = service.prodInfo(product_code);
		List<CategoryVO> upperCat = service.getUpperCat();
		List<CategoryVO> lowerCat = service.getLowerCat(vo.getCategory_1st());
		List<TypeVO> type = service.getType();
		List<PakagingVO> pakaging = service.getPakaging();
		List<ProductHistoryVO> codeHistory = service.getProdHistoryList(product_code);
		// 카테고리 코드로 카테고리명 가져오기
		vo.setCategory_1st_name(service.getCategoryName(vo.getCategory_1st()));
		vo.setCategory_2nd_name(service.getCategoryName(vo.getCategory_2nd()));
		model.addAttribute("prodInfo", vo);
		model.addAttribute("upperCat", upperCat);
		model.addAttribute("lowerCat", lowerCat);
		model.addAttribute("type", type);
		model.addAttribute("pakaging", pakaging);
		model.addAttribute("codeHistory", codeHistory);}
	
	// 품목코드 수정
	@PostMapping("/updateProductCode")
	@Transactional
	public ResponseEntity<String> updateProductCode(ProductVO vo) {
//		log.info("받은값"+vo);
		ResponseEntity<String> entity = null;
		String msg = "";
		try {
			service.updateProductCode(vo);
			// 품목변경 히스토리 업데이트 전 유효성검사(비고란만 수정된것인지 확인)
			ProductHistoryVO hvo = service.getProdHistory(vo.getProduct_code());
			if((hvo.getProduct_name().equals(vo.getProduct_name()) &&
				hvo.getCategory_1st().equals(vo.getCategory_1st()) &&
				hvo.getCategory_2nd().equals(vo.getCategory_2nd()) &&
				hvo.getSpec().equals(vo.getSpec()) &&
				hvo.getVender_code().equals(vo.getVender_code()) &&
				hvo.getEdi_code().equals(vo.getEdi_code()) &&
				hvo.getType().equals(vo.getType()) &&
				hvo.getIm_pakaging().equals(vo.getIm_pakaging()) &&
				hvo.getEx_pakaging().equals(vo.getEx_pakaging()) &&
				hvo.getPak_quantity().equals(vo.getPak_quantity()) &&
				hvo.getPrice().equals(vo.getPrice()) &&
				hvo.getMaker_code().equals(vo.getMaker_code()))) {
				msg = "success";
			} else {
			service.updateHistory(vo);
			msg = "success";}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		}
		return entity = new ResponseEntity<String>(msg, HttpStatus.OK);}


/**********************************부서 컨트롤러**********************************/	
	// 부서코드 리스트 폼
	@GetMapping("/depList")
	public void depList() {}

	// 부서코드 생성 폼
	@GetMapping("/createDepCode")
	public void createDepCodeForm() {}
	
	// 부서코드 저장
	@PostMapping("/createDepCode")
	public String createDepCode(String dep_code, String dep_name, String upper_dep) {
		DepartmentVO vo = new DepartmentVO();
		// log.info(vo);
		vo.setDep_code(dep_code);
		vo.setDep_name(dep_name);
		vo.setUpper_dep(upper_dep);
		// log.info("상위부서코드? "+vo.getUpper_dep());
		if(!vo.getUpper_dep().isEmpty()) {
			// 상위부서가 없는 경우 상위부서코드 값을 넣지 않고 생성
			service.createNoUpperDepCode(vo);
		}else {
			// 상위부서가 있는 경우
			service.createDepCode(vo);
		}
		return "redirect:/code/depList";
	}
	
	// 부서코드생성 중복확인
	@PostMapping("/depCheck")
	public ResponseEntity<String> idCheck(@RequestParam("dep_code") String dep_code) {
		String depCode;
		depCode = service.depCheck(dep_code);
		// log.info("받은 부서코드"+dep_code);
		// log.info("db부서코드 존재? : "+depCode);
		ResponseEntity<String> entity;
		entity = new ResponseEntity<String>(depCode, HttpStatus.OK);
		return entity;
	}
	
	// 상위부서 코드 전달
	@ResponseBody
	@PostMapping("/getUpperDep")
	public ResponseEntity<List<DepartmentVO>> getUpperDep() {		
		List<DepartmentVO> upperDep = service.getUpperDep();
		// log.info(upperDep);
		ResponseEntity<List<DepartmentVO>> entity = null;
		entity = new ResponseEntity<List<DepartmentVO>>(upperDep, HttpStatus.OK);
		return entity;
	}
	
	// 상위부서에 소속된 부서 리스트
	@PostMapping("/getDepCodeList")
	@ResponseBody
	public ResponseEntity<List<DepartmentVO>>  getDepCodeList(String upper_dep) {
		//log.info("받은 상위부서코드 : "+upper_dep);
		String none = "none";
		List<DepartmentVO> depList = null;
			if(upper_dep.equals(none)) {
				//log.info("none값으로 인식됨");
				depList = service.getAllDepCodeList();
			} else {
				//log.info("값이 있는것으로 인식됨");
				depList = service.getDepCodeList(upper_dep);
			}
			// log.info(depList);
			ResponseEntity<List<DepartmentVO>> entity;
			entity = new ResponseEntity<List<DepartmentVO>>(depList, HttpStatus.OK);
		return entity;
	}
	
	// 부서 검색메소드
	@PostMapping("/searchDepCode")
	@ResponseBody
	public ResponseEntity<List<DepartmentVO>> searchDepCode(DepSearchDTO dto){
		String none = "none";
		List<DepartmentVO> depList = null;
			if(!dto.getUpper_dep().equals(none)) {
				depList = service.getSearchDepCode(dto);
			} else {
				depList = service.getSearchDepCodeNoneUpper(dto);
			}
		ResponseEntity<List<DepartmentVO>> entity = new ResponseEntity<List<DepartmentVO>>(depList, HttpStatus.OK);
		return entity;
	}
	
	// 부서코드조회 페이지 폼, 페이지 오픈과 동시에 부서코드 조회
	@GetMapping("/depInfo")
	public void depInfo(@RequestParam("dep_code") String dep_code, Model model) {
		DepartmentVO vo = service.depInfo(dep_code);
		model.addAttribute("dep_code", vo.getDep_code());
		model.addAttribute("dep_name", vo.getDep_name());
		model.addAttribute("upper_dep", vo.getUpper_dep());
		//log.info(vo.getUpper_dep());
		if(!(vo.getUpper_dep()==null)) {
		model.addAttribute("upper_dep_name", service.getDepName(vo.getUpper_dep()));
		}
	}
	
	// 부서명 수정
	@PostMapping("/updateDepCode")
	public ResponseEntity<String> updateDepCode(DepartmentVO vo) {
		ResponseEntity<String> entity = null;
		String msg = "";
		try {service.updateDepCode(vo);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";}
		entity = new ResponseEntity<String>(msg, HttpStatus.OK);
		return entity;
	}
	
	@PostMapping("delDepartment")
	public ResponseEntity<String> delDepartment(String dep_code) {		
		ResponseEntity<String> entity = null;
		String msg = "";
		// 하위부서가 존재하는지 체크
		List<DepartmentVO> lowerDepTest = service.lowerCodeCheck(dep_code);
		if(lowerDepTest.size() == 0) {
			service.delDepartment(dep_code);
			msg = "success";
		}else {
			msg = "lowerCodeExist";
		}
		return entity = new ResponseEntity<String>(msg, HttpStatus.OK);
	}

/**********************************거래처 컨트롤러**********************************/	
	// 거래처 리스트 폼
	@GetMapping("/venderList")
	public void venderList() {}
	
	// 거래처 코드생성 폼
	@GetMapping("/createVenderCode")
	public void createVenderCode() {}
	
	// 거래처 코드생성 코드 중복체크
	@PostMapping("/venderCheck")
	public ResponseEntity<String> venderCheck(@RequestParam("vender_code") String vender_code){
		ResponseEntity<String> entity = null;		
		return entity = new ResponseEntity<String>(service.venderCheck(vender_code), HttpStatus.OK);
	}
	
	// 거래처 코드생성
	@PostMapping("/createVenderCode")
	public String createDepCode
	(String vender_code, String vender_name, Long vender_reg_num, String bank,
	Long account_number, String vender_email, String description) {
		VenderVO vo = new VenderVO();
		vo.setVender_code(vender_code);
		vo.setVender_name(vender_name);
		vo.setVender_reg_num(vender_reg_num);
		vo.setBank(bank);
		vo.setAccount_number(account_number);
		vo.setVender_email(vender_email);
		vo.setDescription(description);
		service.createVenderCode(vo);
		return "redirect:/code/venderList";
	}
	
	// 거래처 리스트 가져오기
	@PostMapping("/getVenderCodeList")
	public ResponseEntity<List<VenderVO>> getVenderCodeList(String keyword){
		if(keyword == null) {
			keyword = "";
		}
		// log.info(keyword);
		List<VenderVO> list = service.getVenderList(keyword);
		ResponseEntity<List<VenderVO>> entity = null;
		// log.info(list);
		return entity = new ResponseEntity<List<VenderVO>>(list, HttpStatus.OK);
	}
	
	// 거래처 정보 가져오기
	@GetMapping("/venderInfo")
	public void venderInfo(@RequestParam("vender_code") String vender_code, Model model) {
		model.addAttribute("venderInfo", service.getVenderInfo(vender_code));
	}
	
	// 거래처 정보 수정
	@PostMapping("/updateVenderCode")
	public ResponseEntity<String> updateVenderCode(VenderVO vo){
	ResponseEntity<String> entity = null;
	String msg = "";
	try {
		service.updateVenderCode(vo);
		msg = "success";
	} catch (Exception e) {
		e.printStackTrace();
		msg = "failure";
	}
	return entity = new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
	// 거래처 삭제
	@PostMapping("/delVender")
	public ResponseEntity<String> delVender(String vender_code) {
		ResponseEntity<String> entity = null;
		String msg = "";
		try {
			service.delVender(vender_code);;
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		}
		return entity = new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
/**********************************제조사 컨트롤러**********************************/
	@GetMapping("/makerList")
	public void makerList() {}
	
	@PostMapping("/getMakerList")
	public ResponseEntity<List<MakerVO>> getMakerList(String keyword){
		ResponseEntity<List<MakerVO>> entity = null;
		List<MakerVO> makerList = service.getMakerList(keyword);
		
		return entity = new ResponseEntity<List<MakerVO>>(makerList, HttpStatus.OK);
	}
	
	@GetMapping("/makerInfo")
	public void makerInfo(String maker_code, Model model) {
		model.addAttribute("makerInfo", service.getMakerInfo(maker_code));}
	
	@PostMapping("/updateMakerName")
	public ResponseEntity<String> updateMakerName(MakerVO vo){
		ResponseEntity<String> entity = null;
		String msg = "";
		try {
			service.updateMakerName(vo);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		}
		
		return entity = new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
	@PostMapping("/delMaker")
	public ResponseEntity<String> delMaker(MakerVO vo){
		ResponseEntity<String> entity = null;
		String msg = "";
		try {
			service.delMaker(vo.getMaker_code());
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		}
		return entity = new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
	// 코드생성 페이지
	@GetMapping("/createMakerCode")
	public void createMakerCode() {}
	
	// 제조사 코드생성 코드 중복체크
	@PostMapping("/makerCheck")
	public ResponseEntity<String> makerCheck(@RequestParam("maker_code") String maker_code){
		ResponseEntity<String> entity = null;
		return entity = new ResponseEntity<String>(service.makerCheck(maker_code), HttpStatus.OK);}
	
	@PostMapping("/createMakerCode")
	public String createMakerCode(MakerVO vo) {
		service.createMakerCode(vo);
		return "redirect:/code/makerList";
	}
	
	@GetMapping("/makerSearchPopup")
	public void makerSearchPopupf() {}
	
	@PostMapping("/getMakerCodeList")
	public ResponseEntity<List<MakerVO>> getMakerCodeList(String keyword){
		ResponseEntity<List<MakerVO>> entity = null;
		List<MakerVO> makerList = service.getMakerList(keyword);
		return entity = new ResponseEntity<List<MakerVO>>(makerList, HttpStatus.OK);
	}
}







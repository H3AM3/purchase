package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.docmall.dto.UpperDep_NameDTO;
import com.docmall.mapper.CodeMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CodeServiceImpl implements CodeService {

	@Autowired
	CodeMapper mapper;

	@Override
	public List<CategoryVO> getLowerCat(String category_code) {
		return mapper.getLowerCat(category_code);}
	@Override
	public List<CategoryVO> getUpperCat() {
		return mapper.getUpperCat();}
	@Override
	public String productCheck(String product_code) {
		return mapper.productCheck(product_code);}
	@Override
	public List<PakagingVO> getPakaging() {
		return mapper.getPakaging();}
	@Override
	public List<TypeVO> getType() {
		return mapper.getType();}
	@Override
	public void createProductCode(ProductVO vo) {
		mapper.createProductCode(vo);}
	@Override
	public void updateHistory(ProductVO vo) {
		mapper.updateHistory(vo);}
	@Override
	public List<ProductVO> getAllProdCodeList(ProductDTO dto) {
		return mapper.getAllProdCodeList(dto);}
	@Override
	public List<ProductVO> getProdCodeList(ProductDTO dto) {
		return mapper.getProdCodeList(dto);}
	@Override
	public List<ProductVO> get1stCatProdCodeList(ProductDTO dto) {
		return mapper.get1stCatProdCodeList(dto);}
	@Override
	public List<ProductVO> get2enCatProdCodeList(ProductDTO dto) {
		return mapper.get2enCatProdCodeList(dto);}
	@Override
	public ProductInfoDTO prodInfo(String product_code) {
		return mapper.prodInfo(product_code);}
	@Override
	public String getCategoryName(String category_code) {
		return mapper.getCategoryName(category_code);}
	@Override
	public void updateProductCode(ProductVO vo) {
		mapper.updateProductCode(vo);
	}
	@Override
	public ProductHistoryVO getProdHistory(String product_code) {
		return mapper.getProdHistory(product_code);
	}
	@Override
	public List<ProductHistoryVO> getProdHistoryList(String product_code) {
		return mapper.getProdHistoryList(product_code);
	}
	
	
	
	@Override
	public List<DepartmentVO> getUpperDep() {
		return mapper.getUpperDep();}
	@Override
	public String depCheck(String dep_code) {
		return mapper.depCheck(dep_code);}
	@Override
	public void createNoUpperDepCode(DepartmentVO vo) {
		mapper.createNoUpperDepCode(vo);}
	@Override
	public void createDepCode(DepartmentVO vo) {
		mapper.createDepCode(vo);}
	@Override
	public List<DepartmentVO> getDepCodeList(String upper_dep) {
		return mapper.getDepCodeList(upper_dep);}
	@Override
	public List<DepartmentVO> getAllDepCodeList() {
		return mapper.getAllDepCodeList();}
	@Override
	public List<DepartmentVO> getSearchDepCode(DepSearchDTO dto) {
		return mapper.getSearchDepCode(dto);}
	@Override
	public List<DepartmentVO> getSearchDepCodeNoneUpper(DepSearchDTO dto) {
		return mapper.getSearchDepCodeNoneUpper(dto);}
	@Override
	public DepartmentVO depInfo(String dep_code) {
		return mapper.depInfo(dep_code);}
	@Override
	public String getDepName(String dep_code) {
		return mapper.getDepName(dep_code);}
	@Override
	public void updateDepCode(DepartmentVO vo) {
		mapper.updateDepCode(vo);}
	@Override
	public void createStock(ProductVO vo) {
		mapper.createStock(vo);
	}
	
	
	@Override
	public String venderCheck(String vender_code) {
		return mapper.venderCheck(vender_code);}
	@Override
	public void createVenderCode(VenderVO vo) {
		mapper.createVenderCode(vo);}
	@Override
	public List<VenderVO> getVenderList(String keyword) {
		return mapper.getVenderList(keyword);}
	@Override
	public VenderVO getVenderInfo(String vender_code) {
		return mapper.getVenderInfo(vender_code);}
	@Override
	public void updateVenderCode(VenderVO vo) {
		mapper.updateVenderCode(vo);}
	@Override
	public void delVender(String vender_code) {
		mapper.delVender(vender_code);}
	@Override
	public List<DepartmentVO> lowerCodeCheck(String dep_code) {
		return mapper.lowerCodeCheck(dep_code);}
	@Override
	public void delDepartment(String dep_code) {
		mapper.delDepartment(dep_code);}
	
	
	
	
	@Override
	public List<MakerVO> getMakerList(String keyword) {
		return mapper.getMakerList(keyword);}
	@Override
	public MakerVO getMakerInfo(String maker_code) {
		return mapper.getMakerInfo(maker_code);
	}
	@Override
	public void updateMakerName(MakerVO vo) {
		mapper.updateMakerName(vo);}
	@Override
	public void delMaker(String maker_code) {
		mapper.delMaker(maker_code);}
	@Override
	public String makerCheck(String maker_code) {
		return mapper.makerCheck(maker_code);
				}
	@Override
	public void createMakerCode(MakerVO vo) {
		mapper.createMakerCode(vo);}
	@Override
	public UpperDep_NameDTO getUpperDepName(String dep_code) {
		return mapper.getUpperDepName(dep_code);
	}
	@Override
	public CategoryVO getCatName(CategoryVO vo) {
		return mapper.getCatName(vo);
	}

	

}

package com.docmall.service;

import java.util.List;

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

public interface CodeService {

	public List<CategoryVO> getLowerCat(String category_code);
	public List<CategoryVO> getUpperCat();
	public String productCheck(String product_code);
	public List<PakagingVO> getPakaging();
	public List<TypeVO> getType();
	public void createProductCode(ProductVO vo);
	public void updateHistory(ProductVO vo);
	public List<ProductVO> getAllProdCodeList(ProductDTO dto);
	public List<ProductVO> getProdCodeList(ProductDTO dto);
	public List<ProductVO> get1stCatProdCodeList(ProductDTO dto);
	public List<ProductVO> get2enCatProdCodeList(ProductDTO dto);
	public ProductInfoDTO prodInfo(String product_code);
	public String getCategoryName(String category_code);
	public void createStock(ProductVO vo);


	
	
	
	public List<DepartmentVO> getUpperDep();
	public String depCheck(String dep_code);
	public void createNoUpperDepCode(DepartmentVO vo);
	public void createDepCode(DepartmentVO vo);	
	public List<DepartmentVO> getDepCodeList(String upper_dep);
	public List<DepartmentVO> getAllDepCodeList();
	public List<DepartmentVO> getSearchDepCode(DepSearchDTO dto);
	public List<DepartmentVO> getSearchDepCodeNoneUpper(DepSearchDTO dto);
	public DepartmentVO depInfo(String dep_code);
	public String getDepName(String dep_code);
	public void updateDepCode(DepartmentVO vo);
	public List<DepartmentVO> lowerCodeCheck(String dep_code);
	public void delDepartment(String dep_code);
	public void updateProductCode(ProductVO vo);
	public ProductHistoryVO getProdHistory(String product_code);
	public List<ProductHistoryVO> getProdHistoryList(String product_code);



	
	public String venderCheck(String vender_code);
	public void createVenderCode(VenderVO vo);
	public List<VenderVO> getVenderList(String keyword);
	public VenderVO getVenderInfo(String vender_code);
	public void updateVenderCode(VenderVO vo);
	public void delVender(String vender_code);
	
	
	
	public List<MakerVO> getMakerList(String keyword);
	public MakerVO getMakerInfo(String maker_code);
	public void updateMakerName(MakerVO vo);
	public void delMaker(String maker_code);
	public String makerCheck(String maker_code);
	public void createMakerCode(MakerVO vo);

	public UpperDep_NameDTO getUpperDepName(String dep_code);

}

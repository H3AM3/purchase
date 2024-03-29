package com.docmall.mapper;

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

public interface CodeMapper {

	//상위 카테고리값을 받아서 하위 카테고리값을 가져오는 기능

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
	public void updateProductCode(ProductVO vo);
	public ProductHistoryVO getProdHistory(String product_code);
	public List<ProductHistoryVO> getProdHistoryList(String product_code);
	public void createStock(ProductVO vo);


	
	// 부서코드생성시 상위 카테고리 선택하는 메뉴의 값 불러오기
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
	
	
	//삭제 전 하위코드를 가지고있는지 체크
	public List<DepartmentVO> lowerCodeCheck(String dep_code);
	public void delDepartment(String dep_code);
	public String venderCheck(String vender_code);
	public void createVenderCode(VenderVO vo);
	public List<VenderVO> getVenderList(String keyword);
	public VenderVO getVenderInfo(String vender_code);
	public void updateVenderCode(VenderVO vo);
	public String delVender(String vender_code);
	
	// 제조사코드 관련
	public List<MakerVO> getMakerList(String keyword);
	public MakerVO getMakerInfo(String maker_code);
	public void updateMakerName(MakerVO vo);
	public void delMaker(String maker_code);
	public String makerCheck(String maker_code);
	public void createMakerCode(MakerVO vo);

	//부서 코드로 상위부서명을 반환하는 기능
	public UpperDep_NameDTO getUpperDepName(String dep_code);
	
	//카테고리코드 받아서 카테고리명 반환하는 기능
	public CategoryVO getCatName(CategoryVO vo);

}

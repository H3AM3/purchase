package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.CategoryVO;

public interface CodeMapper {

	//상위 카테고리값을 받아서 하위 카테고리값을 가져오는 기능

	public List<CategoryVO> getLowerCat(String category_code);
}

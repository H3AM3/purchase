package com.docmall.service;

import java.util.List;

import com.docmall.domain.CategoryVO;

public interface CodeService {

	public List<CategoryVO> getLowerCat(String category_code);

}

package com.docmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CategoryVO;
import com.docmall.mapper.CodeMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CodeServiceImpl implements CodeService {

	@Autowired
	CodeMapper mapper;

	@Override
	public List<CategoryVO> getLowerCat(String category_code) {
		
		return mapper.getLowerCat(category_code);
	}
	


}

package com.docmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CategoryVO;
import com.docmall.service.CodeService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/code/*")
@Log4j
public class CodeController {

	@Autowired
	CodeService service;
	
	@GetMapping("/productList")
	public void productList(){
		
	}
	
	@ResponseBody
	@PostMapping("/getLowerCat")
	public ResponseEntity<List<CategoryVO>> getLowerCat(@RequestParam("category_code") String category_code){
		
		List<CategoryVO> list = service.getLowerCat(category_code);
		
		
		ResponseEntity<List<CategoryVO>> entity;
		
		log.info(list);
		
		entity = new ResponseEntity<List<CategoryVO>>(list, HttpStatus.OK);
		
		return entity;
	}
	
}

package com.docmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/exportFile/*")
@Log4j
public class ExportFileController {

	
	
	@GetMapping("/tablePage")
	public void tablePage(Model model, String type) {
		model.addAttribute("type", type);
	}
	
}

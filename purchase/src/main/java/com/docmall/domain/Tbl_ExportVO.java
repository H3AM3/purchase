package com.docmall.domain;

import java.util.List;

import lombok.Data;

@Data
public class Tbl_ExportVO {
	
	private Long export_num;
	private String export_date;
	private Long export_page;
	private String mem_id;
	private String product_code;
	private String product_name;
	private String spec;
	private String ex_pakaging;
	private Long ex_quantity;
	private String dep_code;
	private String dep_name;
	private String reg_date;
	private String description;
	private String category_2nd;
	private String maker_code;
	private String maker_name;
	private Long req_no;
	
	private Long original_ex_quantity;
	
	private List<Tbl_ExportVO> tbl_export;
}

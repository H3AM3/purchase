package com.docmall.domain;

import java.util.List;

import lombok.Data;

@Data
public class Tbl_ImportVO {
// import_num, import_date, import_page, mem_id,
// product_code, product_name, spec, ex_pakaging,
// ex_quantity, price, vender_code, vender_name,
// reg_date, description
// pak_quantity, category_2nd, waiting_num
	
	private Long import_num;
	private String import_date;
	private Long import_page;
	private String mem_id;
	private String product_code;
	private String product_name;
	private String spec;
	private String ex_pakaging;
	private Long ex_quantity;
	private Long price;
	private String vender_code;
	private String vender_name;
	private String reg_date;
	private String description;
	private Long pak_quantity;
	private String category_2nd;
	private Long waiting_num;
	
	private Long order_num;
	
	private List<Tbl_ImportVO> tbl_importVO;
}

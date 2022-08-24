package com.docmall.domain;

import java.util.List;

import lombok.Data;

@Data
public class Waiting_ImportsVO {
// waiting_num, order_date, order_page, mem_id,
// product_code, product_name, spec, ex_pakaging,
// order_im_qty, waiting_qty, price, vender_code,
// vender_name, import_end, order_discription, pak_quantity
	
	private Long waiting_num;
	private String order_date;
	private Long order_page;
	private String mem_id;
	private String product_code;
	private String product_name;
	private String spec;
	private String ex_pakaging;
	private Long order_im_qty;
	private Long waiting_qty;
	private Long price;
	private String vender_code;
	private String vender_name;
	private String import_end;
	private String order_description;
	private Long pak_quantity;
	private String category_2nd;
	private Long order_num;
	
	private String import_date;
	
	private List<Waiting_ImportsVO> wating_importsVO;
}

package com.docmall.domain;

import java.util.Date;

import lombok.Data;
@Data
public class ProductVO {
/* product_code, category_1st, category_2nd, product_name, spec,vender_code, vender_name,
   edi_code, im_pakaging, ex_pakaging, pak_quantity, price, usable, discription, reg_date, update_date */
	
	private String selectRow;
	
	private String product_code;
	private String category_1st;
	private String category_2nd;
	private String product_name;
	private String spec;
	private String vender_code;
	private String vender_name;
	private String edi_code;
	private String im_pakaging;
	private String ex_pakaging;
	private Long pak_quantity;
	private Long price;
	private String usable;
	private String description;
	private Date reg_date;
	private Date update_date;
	private String type;
	private String maker_code;
	private String maker_name;
}

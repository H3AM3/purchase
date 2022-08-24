package com.docmall.domain;

import java.util.Date;

import lombok.Data;
@Data
public class ProductInfoDTO {

	private String product_code;
	private String category_1st;
	private String category_1st_name;
	private String category_2nd;
	private String category_2nd_name;
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

package com.docmall.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Tbl_OrdersVO {
// order_num, order_date, order_page, mem_id, product_code, product_name,
// spec, im_pakaging, im_quantity, ex_pakaging, ex_quantity, price, vender_code,
// vender_name, order_send, send_date, reg_date, discription
// category_2nd, maker_name, maker_code, pak_quantity, im_price,
//	dep_code, dep_name, totalPrice
	
	private Long order_num;
	private String order_date;
	private Long order_page;
	private String mem_id;
	private String product_code;
	private String product_name;
	private String spec;
	private String im_pakaging;
	private Long im_quantity;
	private String ex_pakaging;
	private Long ex_quantity;
	private Long price;
	private String vender_code;
	private String vender_name;
	private String order_send;
	private Date send_date;
	private Date reg_date;
	private String description;
	private String category_2nd;
	private String maker_name;
	private String maker_code;
	private Long pak_quantity;
	private Long im_price;
	private String dep_code;
	private String dep_name;
	private String imported;
	
	private String mk_order;
	private String keyword;
	
	private List<Tbl_OrdersVO> tbl_orderVO;
}

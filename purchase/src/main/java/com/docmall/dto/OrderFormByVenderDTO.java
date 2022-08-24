package com.docmall.dto;

import lombok.Data;

@Data
public class OrderFormByVenderDTO {
	
	private String approval;
	private String mk_order;
	private String category_2nd;
	private String vender_code;
	private String vender_name;
	private String selectDate1;
	private String selectDate2;
	private String keyword;
	private Long order_page;
	private String order_date;

}

package com.docmall.dto;

import lombok.Data;

@Data
public class ApprovalListDTO {
	// product_code, req_quantity
	
	
	private String product_code;
	private String req_quantity;
	
	private String approval;
	private String mk_order;
	private String selectDate1;
	private String selectDate2;
	private String category_2nd;
	
	private String keyword;
	private String order_date;
}

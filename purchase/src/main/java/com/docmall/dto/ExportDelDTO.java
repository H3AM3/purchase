package com.docmall.dto;

import lombok.Data;

@Data
public class ExportDelDTO {

	private Long export_num;
	private String product_code;
	private Long ex_quantity;
	private Long original_ex_quantity;
	private Long req_no;
}

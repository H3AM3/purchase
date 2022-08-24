package com.docmall.dto;

import lombok.Data;

@Data
public class DeleteImportDTO {

	private String product_code;
	private Long ex_quantity;
	private Long waiting_num;
	private Long import_num;
}
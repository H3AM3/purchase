package com.docmall.dto;

import lombok.Data;

@Data
public class Req_checkPageDTO {

	private String req_date;
	private String dep_code;
	private String category_2nd;
	private Long req_page;
}

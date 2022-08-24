package com.docmall.domain;

import lombok.Data;

@Data
public class StockVO {
// stock_no, product_code, stock_quantity

	private Long stock_no;
	private String product_code;
	private Long stock_quantity;
}

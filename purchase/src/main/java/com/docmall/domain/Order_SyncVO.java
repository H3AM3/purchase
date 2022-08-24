package com.docmall.domain;

import lombok.Data;

@Data
public class Order_SyncVO {
// sync_num, req_no, order_date, order_page,
// mem_id, product_code, category_2nd, dep_code
	
	private Long sync_num;
	private Long req_no;
	private String order_date;
	private Long order_page;
	private String mem_id;
	private String product_code;
	private String category_2nd;
	private String dep_code;
	
	private String mk_order;
}

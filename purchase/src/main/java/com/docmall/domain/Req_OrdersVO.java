package com.docmall.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.Setter;

@Data
@Setter
public class Req_OrdersVO {
// req_no, req_date, req_page, mem_id, product_code, product_name, spec,
// ex_pakaging, ex_quantity, price, dep_code, dep_name, vender_code,
// vender_name, approval, mk_order, req_reject, reg_date, description
	
	private Long req_no;
	private String req_date;
	private String req_page;
	private String mem_id;
	private String product_code;
	private String product_name;
	private String spec;
	private String ex_pakaging;
	private Long pak_quantity;
	private Long price;
	private String dep_code;
	private String dep_name;
	private String vender_code;
	private String vender_name;
	private String approval;
	private String mk_order;
	private String req_reject;
	private Date reg_date;
	private String description;
	private Long req_quantity;
	private String maker_code;
	private String maker_name;
	private String category_2nd;
	private Long unimported_qty;
	private String end_request;
	
	private List<Req_OrdersVO> req_ordersList;
	
	public List<Req_OrdersVO> getReq_ordersList(){
		return req_ordersList;
	}
	
	public void setReq_ordersList(List<Req_OrdersVO> req_ordersList) {
		this.req_ordersList = req_ordersList;
	}
	private Long changePage;
	
}


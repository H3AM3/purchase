package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class VenderVO {
	// vender_code, vender_name, vender_reg_num, bank, account_number
	// description, vender_email, reg_date, update_date
	
	private String vender_code;
	private String vender_name;
	private Long vender_reg_num;
	private String bank;
	private Long account_number;
	private String description;
	private String vender_email;
	private Date reg_date;
	private Date update_date;
}

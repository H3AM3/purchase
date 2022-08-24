package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
//mem_id, mem_password, mem_level, dep_code, reg_date, update_date
	private String mem_id;
	private String mem_password;
	private int mem_level;
	private String dep_code;
	private Date reg_date;
	private Date update_date;
	private String mem_name;
	private String dep_name;
	
	private MemberVO memberVO;
}

package com.hh.edu.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import com.hh.hibernate.dao.inf.Order;
import com.hh.hibernate.util.base.BaseTwoEntity;

@Order
@SuppressWarnings("serial")
@Entity
@Table(name = "EDU_TEST_PAPER")
public class EduTestPaper extends BaseTwoEntity {
	private String type;
	
	private String title;
	
	private String head;
	
	private String dataitems;
	
	private String remark;

	@Column(name = "TYPE_", length = 36)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Lob
	@Column(name="HEAD_")
	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}
	
	@Lob
	@Column(name = "DATAITEMS_")
	public String getDataitems() {
		return dataitems;
	}

	public void setDataitems(String dataitems) {
		this.dataitems = dataitems;
	}

	@Column(name = "TITLE_",length=512)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "REMARK_",length=2048)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
}
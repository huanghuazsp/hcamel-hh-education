package com.hh.edu.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Lob;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import com.hh.hibernate.util.base.BaseEntity;

@SuppressWarnings("serial")
@MappedSuperclass
public class BaseTestPaper extends BaseEntity{
	private String type;

	private String text;

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
	@Column(name = "HEAD_")
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

	@Column(name = "TEXT_", length = 512)
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Column(name = "REMARK_", length = 2048)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Transient
	public Date getStartDate() {
		return null;
	}
	@Transient
	public long getWhenLong() {
		return 0;
	}
	
	private int state;
	@Column(name="STATE_")
	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
}

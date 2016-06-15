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
@Table(name = "EDU_RESOURCES")
public class EduResources extends BaseTwoEntity {
	private String type;
	private String text;
	private String remark;
	private String files;

	@Column(name = "TYPE_", length = 36)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "TEXT_", length = 256)
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Lob
	@Column(name = "REMARK_")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Lob
	@Column(name = "FILES_")
	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}
	
	private Integer state;
	@Column(name="STATE_")
	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		if (state!=null) {
			this.state = state;
		}
	}

}
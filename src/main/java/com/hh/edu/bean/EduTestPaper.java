package com.hh.edu.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.hh.hibernate.dao.inf.Order;
import com.hh.hibernate.util.base.BaseTwoEntity;

@Order
@SuppressWarnings("serial")
@Entity
@Table(name = "EDU_TEST_PAPER")
public class EduTestPaper extends BaseTwoEntity {
	private String type;

	@Column(name = "TYPE_", length = 36)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
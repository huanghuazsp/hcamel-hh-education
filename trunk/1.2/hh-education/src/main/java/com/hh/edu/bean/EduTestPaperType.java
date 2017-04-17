 package com.hh.edu.bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.hh.hibernate.dao.inf.Comment;
import com.hh.hibernate.dao.inf.Order;
import com.hh.hibernate.util.base.BaseEntityTree;
@Order
@SuppressWarnings("serial")
@Entity
@Table(name="EDU_TEST_PAPER_TYPE")
public class EduTestPaperType  extends BaseEntityTree<EduTestPaperType>{
	private int type;

	@Comment("0:类型,1:知识点")
	@Column(name="TYPE_",columnDefinition = "int default 0")
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
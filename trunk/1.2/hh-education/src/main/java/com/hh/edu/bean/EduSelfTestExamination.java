package com.hh.edu.bean;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.Lob;
import com.hh.hibernate.util.base.*;
import com.hh.hibernate.dao.inf.Order;

@Order
@SuppressWarnings("serial")
@Entity
@Table(name = "EDU_SELF_TEST_EXAMINATION")
public class EduSelfTestExamination extends BaseEntity {
	// answer
	private String answer;

	@Lob
	@Column(name = "ANSWER")
	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	// testPaperId
	private String testPaperId;

	@Column(name = "TEST_PAPER_ID",length=36)
	public String getTestPaperId() {
		return testPaperId;
	}

	public void setTestPaperId(String testPaperId) {
		this.testPaperId = testPaperId;
	}

	// testPaperName
	private String testPaperName;

	@Column(name = "TEST_PAPER_NAME",length=256)
	public String getTestPaperName() {
		return testPaperName;
	}

	public void setTestPaperName(String testPaperName) {
		this.testPaperName = testPaperName;
	}

	private String userId;

	
	@Column(name = "USER_ID",length=36)
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}
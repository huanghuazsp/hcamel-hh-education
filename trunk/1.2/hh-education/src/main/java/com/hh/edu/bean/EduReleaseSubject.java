package com.hh.edu.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.hh.hibernate.dao.inf.Order;

@Order
@SuppressWarnings("serial")
@Entity
@Table(name = "EDU_RELEASE_SUBJECT")
public class EduReleaseSubject extends BaseSubject {
	private String subjectId;
	private String releaseTestPaperId;

	@Column(name = "SUBJECT_ID", length = 36)
	public String getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}
	
	@Column(name = "RELEASE_TESTPAPER_ID", length = 36)
	public String getReleaseTestPaperId() {
		return releaseTestPaperId;
	}

	public void setReleaseTestPaperId(String releaseTestPaperId) {
		this.releaseTestPaperId = releaseTestPaperId;
	}

}
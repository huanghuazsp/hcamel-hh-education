package com.hh.edu.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.hh.hibernate.dao.inf.Order;

@Order
@SuppressWarnings("serial")
@Entity
@Table(name = "EDU_RELEASE_TEST_PAPER")
public class EduReleaseTestPaper extends BaseTestPaper {
	private Date startDate;
	private String mc;
	private long WhenLong;
	private String userIds;
	private String userNames;
	
	private String testPaperId;
	
	private String score;
	private Date openDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "START_DATE", length = 7)
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@Column(name="MC_", length = 512)
	public String getMc() {
		return mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}

	@Column(name="WHEN_LONG")
	public long getWhenLong() {
		return WhenLong;
	}

	public void setWhenLong(long whenLong) {
		WhenLong = whenLong;
	}

	@Lob
	@Column(name="USER_IDS")
	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

	@Lob
	@Column(name="USER_NAMES")
	public String getUserNames() {
		return userNames;
	}

	public void setUserNames(String userNames) {
		this.userNames = userNames;
	}

	@Column(name="TEST_PAPER_ID",length=36)
	public String getTestPaperId() {
		return testPaperId;
	}

	public void setTestPaperId(String testPaperId) {
		this.testPaperId = testPaperId;
	}

	@Transient
	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	@Transient
	public Date getOpenDate() {
		return openDate;
	}

	public void setOpenDate(Date openDate) {
		this.openDate = openDate;
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
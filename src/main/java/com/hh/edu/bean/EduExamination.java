 package com.hh.edu.bean;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.hh.hibernate.dao.inf.Order;
import com.hh.hibernate.util.base.BaseTwoEntity;
@Order
@SuppressWarnings("serial")
@Entity
@Table(name="EDU_EXAMINATION")
public class EduExamination  extends BaseTwoEntity{
	//userId
	private String userId;
	
	@Column(name="USER_ID",length=36)
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	//userName
	private String userName;
	
	@Lob
	@Column(name="USER_NAME",length=64)
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	//answer
	private String answer;
	
	@Lob
	@Column(name="ANSWER_")
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	private String artificial;
	
	@Lob
	@Column(name="ARTIFICIAL_")
	public String getArtificial() {
		return artificial;
	}
	public void setArtificial(String artificial) {
		this.artificial = artificial;
	}

	//score
	private int score;
	
	@Column(name="SCORE_")
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
	
	private String releaseTestPaperId;

	@Column(name="RELEASE_TEST_PAPERID")
	public String getReleaseTestPaperId() {
		return releaseTestPaperId;
	}
	public void setReleaseTestPaperId(String releaseTestPaperId) {
		this.releaseTestPaperId = releaseTestPaperId;
	}
	
	private Date submitDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "SUBMIT_DATE", length = 7)
	public Date getSubmitDate() {
		return submitDate;
	}
	public void setSubmitDate(Date submitDate) {
		this.submitDate = submitDate;
	}
	
	private int calculationScore;
	private int artificialScore;
	
	private int openScore;

	@Column(name="CALCULATION_SCORE")
	public int getCalculationScore() {
		return calculationScore;
	}
	public void setCalculationScore(int calculationScore) {
		this.calculationScore = calculationScore;
	}
	
	@Column(name="ARTIFICIAL_SCORE")
	public int getArtificialScore() {
		return artificialScore;
	}
	public void setArtificialScore(int artificialScore) {
		this.artificialScore = artificialScore;
	}
	
	@Column(name="OPEN_SCORE")
	public int getOpenScore() {
		return openScore;
	}
	public void setOpenScore(int openScore) {
		this.openScore = openScore;
	}
	
	
}
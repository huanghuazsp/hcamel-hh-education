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
	
}
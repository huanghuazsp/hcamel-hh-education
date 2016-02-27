package com.hh.edu.bean;

import javax.persistence.Column;
import javax.persistence.Lob;
import javax.persistence.MappedSuperclass;

import com.hh.hibernate.util.base.BaseTwoEntity;

@SuppressWarnings("serial")
@MappedSuperclass
public class BaseSubject extends BaseTwoEntity {
	private String type;
	private String text;
	private String dataitems;
	private String answer;
	private String titleType;
	
	private int score;

	@Column(name = "TYPE_", length = 36)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Lob
	@Column(name = "TEXT_")
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Lob
	@Column(name = "DATAITEMS_")
	public String getDataitems() {
		return dataitems;
	}

	public void setDataitems(String dataitems) {
		this.dataitems = dataitems;
	}

	@Lob
	@Column(name = "ANSWER_")
	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Column(name = "TITLE_TYPE_", length = 64)
	public String getTitleType() {
		return titleType;
	}

	public void setTitleType(String titleType) {
		this.titleType = titleType;
	}

	@Column(name = "SCORE_")
	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}
	
}

package com.hh.edu.bean;

import javax.persistence.Column;
import javax.persistence.Lob;
import javax.persistence.MappedSuperclass;

import com.hh.hibernate.util.base.BaseEntity;

@SuppressWarnings("serial")
@MappedSuperclass
public class BaseSubject extends BaseEntity {
	private String type;
	private String text;
	private String dataitems;
	private String answer;
	private String titleType;
	private int score;

	private String textpic;
	private String textpic2;
	private String textpic3;
	
	private String knowledgePoint;
	private String knowledgePointText;

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

	@Column(name = "TEXT_PIC", length = 36)
	public String getTextpic() {
		return textpic;
	}

	public void setTextpic(String textpic) {
		this.textpic = textpic;
	}

	@Column(name = "TEXT_PIC2", length = 36)
	public String getTextpic2() {
		return textpic2;
	}

	public void setTextpic2(String textpic2) {
		this.textpic2 = textpic2;
	}

	@Column(name = "TEXT_PIC3", length = 36)
	public String getTextpic3() {
		return textpic3;
	}

	public void setTextpic3(String textpic3) {
		this.textpic3 = textpic3;
	}

	private int state;
	@Column(name="STATE_")
	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	
	@Column(name="KNOWLEDGE_POINT",length=36)
	public String getKnowledgePoint() {
		return knowledgePoint;
	}

	public void setKnowledgePoint(String knowledgePoint) {
		this.knowledgePoint = knowledgePoint;
	}

	@Column(name="KNOWLEDGE_POINT_TEXT",length=128)
	public String getKnowledgePointText() {
		return knowledgePointText;
	}

	public void setKnowledgePointText(String knowledgePointText) {
		this.knowledgePointText = knowledgePointText;
	}
	
	
}

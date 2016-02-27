package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.edu.bean.EduExamination;
import com.hh.edu.service.impl.EduExaminationService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionExamination extends BaseServiceAction<EduExamination> {
	@Autowired
	private EduExaminationService eduexaminationService;
	
	private String submitType;

	public BaseService<EduExamination> getService() {
		return eduexaminationService;
	}

	public EduExamination examination() {
		EduExamination object = eduexaminationService.examination(this.object);
		return object;
	}
	
	public void updateAnswer(){
		 eduexaminationService.updateAnswer(this.object,submitType);
	}

	public String getSubmitType() {
		return submitType;
	}

	public void setSubmitType(String submitType) {
		this.submitType = submitType;
	}
}

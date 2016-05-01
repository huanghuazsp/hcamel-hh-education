package com.hh.edu.action.out;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.edu.bean.EduSelfTestExamination;
import com.hh.edu.service.impl.EduSelfTestExaminationService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionSelfTestExamination extends
		BaseServiceAction<EduSelfTestExamination> {
	@Autowired
	private EduSelfTestExaminationService eduselftestexaminationService;

	public BaseService<EduSelfTestExamination> getService() {
		return eduselftestexaminationService;
	}

	public Object saveAnswer() {
		try {
			EduSelfTestExamination object = eduselftestexaminationService
					.saveAnswer(this.object);
			return object;
		} catch (MessageException e) {
			return e;
		}
	}
}

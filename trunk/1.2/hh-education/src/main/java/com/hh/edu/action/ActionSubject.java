 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduSubject;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduSubjectService;

@SuppressWarnings("serial")
public class ActionSubject extends BaseServiceAction< EduSubject > {
	@Autowired
	private EduSubjectService edusubjectService;
	public BaseService<EduSubject> getService() {
		return edusubjectService;
	}
}
 
 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduReleaseSubject;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduReleaseSubjectService;

@SuppressWarnings("serial")
public class ActionReleaseSubject extends BaseServiceAction< EduReleaseSubject > {
	@Autowired
	private EduReleaseSubjectService edureleasesubjectService;
	public BaseService<EduReleaseSubject> getService() {
		return edureleasesubjectService;
	}
}
 
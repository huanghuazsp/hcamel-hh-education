 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduSubjectType;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduSubjectTypeService;

@SuppressWarnings("serial")
public class ActionSubjectType extends BaseServiceAction< EduSubjectType > {
	@Autowired
	private EduSubjectTypeService edusubjecttypeService;
	public BaseService<EduSubjectType> getService() {
		return edusubjecttypeService;
	}
}
 
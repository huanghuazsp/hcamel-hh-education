 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduTestPaperType;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduTestPaperTypeService;

@SuppressWarnings("serial")
public class ActionTestPaperType extends BaseServiceAction< EduTestPaperType > {
	@Autowired
	private EduTestPaperTypeService edutestpapertypeService;
	public BaseService<EduTestPaperType> getService() {
		return edutestpapertypeService;
	}
}
 
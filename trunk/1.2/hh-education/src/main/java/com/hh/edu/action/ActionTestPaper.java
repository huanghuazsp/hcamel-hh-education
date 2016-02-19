 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduTestPaper;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduTestPaperService;

@SuppressWarnings("serial")
public class ActionTestPaper extends BaseServiceAction< EduTestPaper > {
	@Autowired
	private EduTestPaperService edutestpaperService;
	public BaseService<EduTestPaper> getService() {
		return edutestpaperService;
	}
}
 
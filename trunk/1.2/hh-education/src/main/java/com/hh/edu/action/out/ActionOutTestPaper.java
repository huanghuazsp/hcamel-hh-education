package com.hh.edu.action.out;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.edu.bean.EduTestPaper;
import com.hh.edu.service.impl.EduTestPaperService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionOutTestPaper extends BaseServiceAction<EduTestPaper> {

	@Autowired
	private EduTestPaperService edutestpaperService;

	public BaseService<EduTestPaper> getService() {
		return edutestpaperService;
	}

	public Object queryPagingDataAll() {
		return edutestpaperService.queryPagingDataAll(object,
				this.getPageRange());
	}



}

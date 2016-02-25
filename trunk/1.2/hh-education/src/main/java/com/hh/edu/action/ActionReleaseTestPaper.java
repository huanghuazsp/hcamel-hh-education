 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduReleaseTestPaperService;

@SuppressWarnings("serial")
public class ActionReleaseTestPaper extends BaseServiceAction< EduReleaseTestPaper > {
	@Autowired
	private EduReleaseTestPaperService edureleasetestpaperService;
	public BaseService<EduReleaseTestPaper> getService() {
		return edureleasetestpaperService;
	}
	public Object queryStartPagingData() {
		return edureleasetestpaperService.queryStartPagingData(object,
				this.getPageRange());
	}
	
}
 
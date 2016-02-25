package com.hh.edu.action;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.edu.service.impl.EduReleaseTestPaperService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.base.BaseServiceAction;
import com.hh.system.util.dto.PagingData;

@SuppressWarnings("serial")
public class ActionReleaseTestPaper extends BaseServiceAction<EduReleaseTestPaper> {
	@Autowired
	private EduReleaseTestPaperService edureleasetestpaperService;

	public BaseService<EduReleaseTestPaper> getService() {
		return edureleasetestpaperService;
	}

	public PagingData<EduReleaseTestPaper> queryStartPagingData() {
		PagingData<EduReleaseTestPaper> page = edureleasetestpaperService.queryStartPagingData(object,
				this.getPageRange());
		List<EduReleaseTestPaper> EduReleaseTestPaperList = page.getItems();
		long currTime = new Date().getTime();
		for (EduReleaseTestPaper eduReleaseTestPaper : EduReleaseTestPaperList) {
			long when = eduReleaseTestPaper.getWhenLong()*60*1000;
			long start = eduReleaseTestPaper.getStartDate().getTime();
			if (start>currTime ) {
				eduReleaseTestPaper.setState(2);
			}
			if ((when+start)<currTime) {
				eduReleaseTestPaper.setState(3);
			}
		}
		return page;
	}

}

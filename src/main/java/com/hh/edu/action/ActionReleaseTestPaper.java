package com.hh.edu.action;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.hh.edu.bean.EduExamination;
import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.edu.service.impl.EduExaminationService;
import com.hh.edu.service.impl.EduReleaseTestPaperService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Convert;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseServiceAction;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;

@SuppressWarnings("serial")
public class ActionReleaseTestPaper extends BaseServiceAction<EduReleaseTestPaper> {
	@Autowired
	private EduReleaseTestPaperService edureleasetestpaperService;

	@Autowired
	private EduExaminationService eduexaminationService;

	public BaseService<EduReleaseTestPaper> getService() {
		return edureleasetestpaperService;
	}
	
	
	public Object emailRemind() {
		try {
			 edureleasetestpaperService.emailRemind(this.object);
			 return null;
		} catch (MessageException e) {
			return e;
		}
	}

	public PagingData<EduReleaseTestPaper> queryStartPagingData() {
		PagingData<EduReleaseTestPaper> page = edureleasetestpaperService.queryStartPagingData(object,
				this.getPageRange());
		List<EduReleaseTestPaper> EduReleaseTestPaperList = page.getItems();
		long currTime = new Date().getTime();
		for (EduReleaseTestPaper eduReleaseTestPaper : EduReleaseTestPaperList) {
			long when = eduReleaseTestPaper.getWhenLong() * 60 * 1000;
			long start = eduReleaseTestPaper.getStartDate().getTime();
			if (start > currTime) {
				eduReleaseTestPaper.setState(2);
			}
			if ((when + start) < currTime) {
				eduReleaseTestPaper.setState(3);
			}
		}
		return page;
	}

	public Object queryTestResult() {
		EduReleaseTestPaper eduReleaseTestPaper = edureleasetestpaperService.findObjectById(object.getId());
		String[] userIds = Convert.toString(eduReleaseTestPaper.getUserIds()).split(",");
		String[] userNames = Convert.toString(eduReleaseTestPaper.getUserNames()).split(",");
		List<EduExamination> eduExaminationList = eduexaminationService
				.queryList(ParamFactory.getParamHb().is("releaseTestPaperId", object.getId()).orderDesc("score"));
		
		List<String> userIdList = Convert.arrayToList(userIds);
		List<String> userNameList = Convert.arrayToList(userNames);
		
		for (EduExamination eduExamination : eduExaminationList) {
			userIdList.remove(eduExamination.getUserId());
			userNameList.remove(eduExamination.getUserName());
		}
		for (int i = 0; i < userIdList.size(); i++) {
			EduExamination eduExamination = new EduExamination();
			eduExamination.setUserId(userIdList.get(i));
			eduExamination.setUserName(userNameList.get(i)+"（缺考）");
			eduExaminationList.add(eduExamination);
		}
		return eduExaminationList;
	}

}

package com.hh.edu.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.edu.bean.EduExamination;
import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.edu.service.impl.EduExaminationService;
import com.hh.edu.service.impl.EduReleaseTestPaperService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseServiceAction;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.usersystem.bean.usersystem.UsUser;
import com.hh.usersystem.service.impl.UserService;

@SuppressWarnings("serial")
public class ActionReleaseTestPaper extends BaseServiceAction<EduReleaseTestPaper> {
	@Autowired
	private EduReleaseTestPaperService edureleasetestpaperService;

	@Autowired
	private EduExaminationService eduexaminationService;

	@Autowired
	private UserService userService;

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

	public Object queryUserList() {
		EduReleaseTestPaper eduReleaseTestPaper = edureleasetestpaperService.findObjectById(object.getId());

		return userService.queryListByIds(Convert.strToList(eduReleaseTestPaper.getUserIds()));
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

		List<UsUser> users = userService.queryListByIds(userIdList);

		Map<String, UsUser> userMap = new HashMap<String, UsUser>();
		for (UsUser usUser : users) {
			userMap.put(usUser.getId(), usUser);
		}

		for (EduExamination eduExamination : eduExaminationList) {
			userIdList.remove(eduExamination.getUserId());
			userNameList.remove(eduExamination.getUserName());
			if (Check.isNoEmpty(userMap.get(eduExamination.getUserId()))) {
				eduExamination.setUserName(
						eduExamination.getUserName() + "[" + userMap.get(eduExamination.getUserId()).getVdzyj() + "]");
			}
			if (eduExamination.getQk()==1) {
				eduExamination.setUserName(eduExamination.getUserName() + "（缺考）");
			}
		}
		for (int i = 0; i < userIdList.size(); i++) {
			EduExamination eduExamination = new EduExamination();
			eduExamination.setUserId(userIdList.get(i));
			eduExamination.setUserName(userNameList.get(i) + "（缺考）");
			if (userMap.get(userIdList.get(i)) != null && Check.isNoEmpty(userMap.get(userIdList.get(i)).getVdzyj())) {
				eduExamination.setUserName(
						eduExamination.getUserName() + "[" + userMap.get(userIdList.get(i)).getVdzyj() + "]");
			}

			eduExaminationList.add(eduExamination);
		}
		return eduExaminationList;
	}

}

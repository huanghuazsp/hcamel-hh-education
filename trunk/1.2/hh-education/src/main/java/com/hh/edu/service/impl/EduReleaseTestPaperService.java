package com.hh.edu.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduExamination;
import com.hh.edu.bean.EduReleaseSubject;
import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.edu.bean.EduSubject;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.BeanUtils;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.Json;
import com.hh.system.util.MessageException;
import com.hh.system.util.date.DateFormat;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.system.util.email.JavaMail;
import com.hh.usersystem.LoginUserServiceInf;
import com.hh.usersystem.bean.usersystem.UsUser;
import com.hh.usersystem.service.impl.UserService;

@Service
public class EduReleaseTestPaperService extends
		BaseService<EduReleaseTestPaper> {

	@Autowired
	private LoginUserServiceInf loginUserService;

	@Autowired
	private EduSubjectService eduSubjectService;

	@Autowired
	private EduReleaseSubjectService eduReleaseSubjectService;

	@Autowired
	private EduExaminationService eduExaminationService;

	@Autowired
	private EduTestPaperService eduTestPaperService;
	
	@Autowired
	private UserService userService;

	@Override
	public EduReleaseTestPaper save(EduReleaseTestPaper entity)
			throws MessageException {
		if (Check.isEmpty(entity.getMc())) {
			entity.setMc(entity.getText() + DateFormat.getDate());
		}

		String dataitems = entity.getDataitems();
		List<Map<String, Object>> mapList = Json.toMapList(dataitems);

		List<String> subjectList = new ArrayList<String>();

		for (Map<String, Object> map : mapList) {
			String subjects = Convert.toString(map.get("subjects"));
			List<String> subjectList2 = Convert.strToList(subjects);
			subjectList.addAll(subjectList2);
		}
		List<EduSubject> eduSubjectList = eduSubjectService
				.queryListByIds(subjectList);

		super.save(entity);

		eduReleaseSubjectService.deleteByProperty("releaseTestPaperId",
				entity.getId());
		eduExaminationService.deleteByProperty("releaseTestPaperId",
				entity.getId());

		// EduTestPaper eduTestPaper=
		// eduTestPaperService.findObjectById(entity.getTestPaperId());
		// String dataitems = eduTestPaper.getDataitems();
		// List<Map<String,Object>> mapList = Json.toMapList(dataitems);

		Map<String, Integer> scoreMap = new HashMap<String, Integer>();
		for (Map<String, Object> map : mapList) {
			String subjects = Convert.toString(map.get("subjects"));
			int score = Convert.toInt(map.get("score"));
			List<String> subjectList2 = Convert.strToList(subjects);
			int score1 = score / subjectList2.size();
			for (String string : subjectList2) {
				scoreMap.put(string, score1);
			}
		}

		int score = 0;
		for (EduSubject eduSubject : eduSubjectList) {
			EduReleaseSubject eduReleaseSubject = new EduReleaseSubject();
			BeanUtils.copyProperties(eduReleaseSubject, eduSubject);
			BeanUtils.defautlPropertiesSetNull(eduReleaseSubject);
			eduReleaseSubject.setSubjectId(eduSubject.getId());
			eduReleaseSubject.setReleaseTestPaperId(entity.getId());
			eduReleaseSubject.setScore(scoreMap.get(eduSubject.getId()));
			score += eduReleaseSubject.getScore();
			eduReleaseSubjectService.save(eduReleaseSubject);
		}
		if (score != 100) {
			throw new MessageException("总分数不等于100不能发布");
		}

		return entity;
	}

	public PagingData<EduReleaseTestPaper> queryStartPagingData(
			EduReleaseTestPaper entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
		paramInf.like("userIds", loginUserService.findUserId());
		PagingData<EduReleaseTestPaper> pageData = super.queryPagingData(
				entity, pageRange, paramInf);

		List<String> releasePageIdList = new ArrayList<String>();

		for (EduReleaseTestPaper eduReleaseTestPaper : pageData.getItems()) {
			releasePageIdList.add(eduReleaseTestPaper.getId());
		}

		List<EduExamination> examinations = eduExaminationService
				.queryList(ParamFactory.getParamHb()
						.is("userId", loginUserService.findUserId())
						.in("releaseTestPaperId", releasePageIdList));

		Map<String, EduExamination> examinationMap = new HashMap<String, EduExamination>();
		for (EduExamination eduExamination : examinations) {
			if (eduExamination.getOpenScore() == 1) {
				examinationMap.put(eduExamination.getReleaseTestPaperId(),
						eduExamination);
			}

		}

		for (EduReleaseTestPaper eduReleaseTestPaper : pageData.getItems()) {
			EduExamination eduExamination = examinationMap
					.get(eduReleaseTestPaper.getId());
			if (eduExamination != null) {
				eduReleaseTestPaper.setScore(Convert.toString(eduExamination
						.getScore()));
				eduReleaseTestPaper.setOpenDate(eduExamination.getOpenDate());
			} else {
				eduReleaseTestPaper.setScore("未发布");
			}

		}

		return pageData;
	}

	@Override
	public void deleteByIds(List<String> deleteIds) {
		eduReleaseSubjectService.deleteByProperty("releaseTestPaperId",
				deleteIds);
		eduExaminationService.deleteByProperty("releaseTestPaperId", deleteIds);
		super.deleteByIds(deleteIds);
	}

	public void emailRemind(EduReleaseTestPaper object) throws MessageException{
		EduReleaseTestPaper eduReleaseTestPaper = findObjectById(object.getId());
		long currTime = new Date().getTime();
		long when = eduReleaseTestPaper.getWhenLong() * 60 * 1000;
		long start = eduReleaseTestPaper.getStartDate().getTime();
		if (start > currTime) {

			
			List<String> userIdList = Convert.strToList(eduReleaseTestPaper.getUserIds());
			if (userIdList.size()>0) {
				List<String> maiList = new ArrayList<String>();
				List<UsUser> users = userService.queryListByIds(userIdList);
				
				
				for (UsUser usUser : users) {
					if (Check.isNoEmpty(usUser.getVdzyj())) {
						maiList.add(usUser.getVdzyj());
					}
				}
				
				
				JavaMail se = new JavaMail();
				String msg = "请于"+ DateFormat.dateToStr(eduReleaseTestPaper.getStartDate(), "YYYY-MM-DD HH:mm:ss")+"参加【"+eduReleaseTestPaper.getText()+"】考试。";
				
				se.doSendHtmlEmail(maiList, "考试提醒"  ,msg);
			}
			
		}else{
			throw new MessageException("只能在考试未开始的时候进行邮件提醒！");
		}
		
	
	}

}

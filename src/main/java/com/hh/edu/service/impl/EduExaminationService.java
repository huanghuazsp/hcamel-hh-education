package com.hh.edu.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javassist.expr.NewArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hh.edu.bean.EduExamination;
import com.hh.edu.bean.EduReleaseSubject;
import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.Json;
import com.hh.system.util.dto.ParamFactory;
import com.hh.usersystem.LoginUserServiceInf;

@Service
public class EduExaminationService extends BaseService<EduExamination> {

	@Autowired
	private LoginUserServiceInf loginUserService;

	@Autowired
	private EduReleaseTestPaperService eduReleaseTestPaperService;

	@Autowired
	private EduReleaseSubjectService eduReleaseSubjectService;

	@Transactional
	public EduExamination examination(EduExamination entity) {

		EduExamination eduExamination = findObject(ParamFactory.getParamHb()
				.is("releaseTestPaperId", entity.getReleaseTestPaperId())
				.is("userId", loginUserService.findUserId()));

		if (eduExamination == null) {
			eduExamination = entity;
		}
		eduExamination.setUserId(loginUserService.findUserId());
		eduExamination.setUserName(loginUserService.findUserName());
		if (Check.isEmpty(eduExamination.getId())) {
			dao.createEntity(eduExamination);
		} else {
			dao.updateEntity(eduExamination);
		}
		return eduExamination;
	}

	public void updateAnswer(EduExamination object, String submitType) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("answer", object.getAnswer());
		map.put("releaseTestPaperId", object.getReleaseTestPaperId());
		map.put("userId", loginUserService.findUserId());

		String updateString = "";
		
		if ("submit".equals(submitType)) {
			map.put("submitDate", new Date());
			updateString=",submitDate=:submitDate";
		}
		dao.updateEntity(
				"update "
						+ EduExamination.class.getName()
						+ " set answer=:answer"+updateString+" where releaseTestPaperId=:releaseTestPaperId and userId=:userId ",
				map);
	}

	@Transactional
	public void calculation(EduExamination object) {
		
		
		Map<String, Integer> releaseScoreMap = new HashMap<String, Integer>();
		
		List<EduExamination> eduExaminationList = queryListByProperty(
				"releaseTestPaperId", object.getReleaseTestPaperId());
		List<EduReleaseSubject> eduReleaseSubjectList = eduReleaseSubjectService
				.queryListByProperty("releaseTestPaperId",
						object.getReleaseTestPaperId());

		Map<String, EduReleaseSubject> map = new HashMap<String, EduReleaseSubject>();
		for (EduReleaseSubject eduReleaseSubject : eduReleaseSubjectList) {
			map.put(eduReleaseSubject.getId(), eduReleaseSubject);
			releaseScoreMap.put(eduReleaseSubject.getId(), eduReleaseSubject.getScore());
		}

		for (EduExamination eduExamination : eduExaminationList) {
			Map<String, Object> answerMap = Json.toMap(eduExamination
					.getAnswer());
			Set<String> keySet = answerMap.keySet();
			int score = 0;
			for (String key : keySet) {
				String answer = Convert.toString(answerMap.get(key));

				EduReleaseSubject eduReleaseSubject = map.get(key);
				int score22 = releaseScoreMap.get(key);
				if (eduReleaseSubject != null) {
					String subjectAnswer = Convert.toString(eduReleaseSubject
							.getAnswer());
					if ("radio".equals(eduReleaseSubject.getTitleType()) || "check".equals(eduReleaseSubject.getTitleType())|| "fillEmpty".equals(eduReleaseSubject.getTitleType())) {
						if (answer.equals(subjectAnswer.replaceAll("、", ","))) {
							score+=score22;
						}else {
//							System.out.println(subjectAnswer);
//							System.out.println(answer);
//							System.out.println(eduReleaseSubject.getText());
						}
					}
				}

			}
			eduExamination.setCalculationScore(score);
			eduExamination.setScore(eduExamination.getCalculationScore()+eduExamination.getArtificialScore());
			dao.updateEntity(eduExamination);
		}

	}

	public void artificial(EduExamination object) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artificial",object.getArtificial());
		map.put("releaseTestPaperId", object.getReleaseTestPaperId());
		map.put("userId", loginUserService.findUserId());
		map.put("artificialDate",new Date());
		
		Map<String, Object> artificialMap=Json.toMap(object.getArtificial());
		
		int score = 0;
		for (String key : artificialMap.keySet()) {
			score+=Convert.toInt(artificialMap.get(key));
		}
		map.put("artificialScore",score);
		dao.updateEntity(
				"update "
						+ EduExamination.class.getName()
						+ " set score=:artificialScore + calculationScore,artificial=:artificial,artificialDate = :artificialDate,artificialScore=:artificialScore where releaseTestPaperId=:releaseTestPaperId and userId=:userId ",
				map);
		
	}

	@Transactional
	public void openScore(EduExamination object) {
		
		calculation(object);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("openScore",1);
		map.put("releaseTestPaperId", object.getReleaseTestPaperId());
		map.put("openDate",new Date());
		dao.updateEntity(
				"update "
						+ EduExamination.class.getName()
						+ " set openScore=:openScore,openDate=:openDate where releaseTestPaperId=:releaseTestPaperId  ",
				map);
	}
}

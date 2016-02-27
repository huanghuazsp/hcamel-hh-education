package com.hh.edu.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javassist.expr.NewArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hh.edu.bean.EduExamination;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Check;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.usersystem.LoginUserServiceInf;

@Service
public class EduExaminationService extends BaseService<EduExamination> {

	@Autowired
	private LoginUserServiceInf loginUserService;

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
		map.put("submitDate", null);
		
		if ("submit".equals(submitType)) {
			map.put("submitDate", new Date());
		}
		dao.updateEntity(
				"update "
						+ EduExamination.class.getName()
						+ " set answer=:answer,submitDate=:submitDate where releaseTestPaperId=:releaseTestPaperId and userId=:userId ",
				map);
	}
}

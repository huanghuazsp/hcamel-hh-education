package com.hh.edu.service.impl;

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
		
		if (eduExamination==null) {
			eduExamination=entity;
		}
		eduExamination.setUserId(loginUserService.findUserId());
		eduExamination.setUserName(loginUserService.findUserName());
		if (Check.isEmpty(eduExamination.getId())) {
			dao.createEntity(eduExamination);
		} else {
			dao.updateEntity(eduExamination);
		}
		return entity;
	}
}

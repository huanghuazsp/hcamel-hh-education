package com.hh.edu.service.impl;

import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Check;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.usersystem.bean.usersystem.UsUser;
import com.hh.usersystem.service.impl.LoginUserUtilService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduSelfTestExamination;
import com.hh.edu.bean.EduTestPaper;

@Service
public class EduSelfTestExaminationService extends
		BaseService<EduSelfTestExamination> {

	@Autowired
	private LoginUserUtilService loginUserService;
	
	
	@Override
	public PagingData<EduSelfTestExamination> queryPagingData(EduSelfTestExamination entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
		if (Check.isNoEmpty(entity.getText())) {
			paramInf.like("text", entity.getText());
		}
		UsUser user = loginUserService.findLoginUser();
		if (!"admin".equals(user.getRoleIds())) {
			paramInf.is("createUser", loginUserService.findUserId());
		}

		return super.queryPagingData( pageRange, paramInf);
	}
	

	public EduSelfTestExamination saveAnswer(EduSelfTestExamination entity) {
		EduSelfTestExamination eduSelfTestExamination = findObject(ParamFactory
				.getParamHb().is("userId", loginUserService.findUserId())
				.is("testPaperId", entity.getTestPaperId()));
		if (eduSelfTestExamination != null) {
			eduSelfTestExamination.setAnswer(entity.getAnswer());
			dao.updateEntity(eduSelfTestExamination);
			return eduSelfTestExamination;
		} else {
			entity.setUserId(loginUserService.findUserId());
			dao.createEntity(entity);
			return entity;
		}
	}

	public EduSelfTestExamination findMyObject(String testPaperId) {
		return findObject(ParamFactory.getParamHb()
				.is("userId", loginUserService.findUserId())
				.is("testPaperId", testPaperId));
	}
}

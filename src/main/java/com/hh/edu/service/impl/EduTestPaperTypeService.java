package com.hh.edu.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduTestPaperType;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.usersystem.bean.usersystem.UsRole;
import com.hh.usersystem.bean.usersystem.UsUser;
import com.hh.usersystem.service.impl.LoginUserUtilService;

@Service
public class EduTestPaperTypeService extends BaseService<EduTestPaperType> {

	@Autowired
	private EduSubjectService eduSubjectService;
	@Autowired
	private EduTestPaperService eduTestPaperService;

	@Autowired
	private LoginUserUtilService loginUserService;

	public Object querySubjectTreeList(String node) {
		List<EduTestPaperType> eduTestPaperTypeList = queryTreeList(ParamFactory.getParamHb().is("node", node));
		converSubjecttText(eduTestPaperTypeList, false);
		return eduTestPaperTypeList;
	}

	public void converSubjecttText(List<EduTestPaperType> eduTestPaperTypeList, boolean all) {
		for (EduTestPaperType eduTestPaperType : eduTestPaperTypeList) {
			if (eduTestPaperType.getChildren() != null) {
				converSubjecttText(eduTestPaperType.getChildren(), all);
			}
			if (eduTestPaperType.getLeaf() == 1) {
				ParamInf paramInf = ParamFactory.getParamHb().is("type", eduTestPaperType.getId());
				boolean admin = false;
				UsUser user = loginUserService.findLoginUser();
				if (user != null) {
					if ("admin".equals(user.getRoleIds())) {
						admin = true;
					}
				}

				if (all) {
					paramInf.is("state", 1);
				} else {
					if (!admin) {
						paramInf.is("createUser", loginUserService.findUserId());
					}
				}

				int count = eduSubjectService.findCount(paramInf);
				eduTestPaperType.setText(eduTestPaperType.getName() + "(" + count + ")");
			}
		}
	}

	public void converTestPagerText(List<EduTestPaperType> eduTestPaperTypeList, boolean all) {
		for (EduTestPaperType eduTestPaperType : eduTestPaperTypeList) {
			if (eduTestPaperType.getChildren() != null) {
				converTestPagerText(eduTestPaperType.getChildren(), all);
			}
			if (eduTestPaperType.getLeaf() == 1) {
				ParamInf paramInf = ParamFactory.getParamHb().is("type", eduTestPaperType.getId());
				boolean admin = false;
				UsUser user = loginUserService.findLoginUser();
				if (user != null) {
					if ("admin".equals(user.getRoleIds())) {
						admin = true;
					}
				}

				if (all) {
					paramInf.is("state", 1);
				} else {
					if (!admin) {
						paramInf.is("createUser", loginUserService.findUserId());
					}
				}
				int count = eduTestPaperService.findCount(paramInf);
				eduTestPaperType.setName(eduTestPaperType.getName() + "(" + count + ")");
			}
		}

	}

	public Object queryTestPagerTreeList(String node) {
		List<EduTestPaperType> eduTestPaperTypeList = queryTreeList(ParamFactory.getParamHb().is("node", node));
		converTestPagerText(eduTestPaperTypeList, false);
		return eduTestPaperTypeList;
	}
}

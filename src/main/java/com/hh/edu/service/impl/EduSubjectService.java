package com.hh.edu.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduSubject;
import com.hh.system.bean.SystemFile;
import com.hh.system.service.impl.BaseService;
import com.hh.system.service.inf.IFileOper;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.MessageException;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.usersystem.bean.usersystem.UsUser;
import com.hh.usersystem.service.impl.LoginUserUtilService;

@Service
public class EduSubjectService extends BaseService<EduSubject> implements IFileOper{
	@Autowired
	private LoginUserUtilService loginUserService;

	@Override
	public PagingData<EduSubject> queryPagingData(EduSubject entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
		if (Check.isNoEmpty(entity.getType())) {
			paramInf.is("type", entity.getType());
		}
		if (Check.isNoEmpty(entity.getTitleType())) {
			paramInf.is("titleType", entity.getTitleType());
		}
		if (Check.isNoEmpty(entity.getText())) {
			paramInf.like("text", entity.getText());
		}
		UsUser user = loginUserService.findLoginUser();
		if (!"admin".equals(user.getRoleIds())) {
			paramInf.is("createUser", loginUserService.findUserId());
		}
		return super.queryPagingData( pageRange, paramInf);
	}

	@Override
	public EduSubject save(EduSubject entity) throws MessageException {
		if (checkOnly("text", entity)) {
			throw new MessageException("题目已存在！");
		}
		return super.save(entity);
	}

	public void doSetState(String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", Convert.strToList(ids));
		dao.updateEntity("update " + EduSubject.class.getName() + " o set o.state=1 where o.id in :id", map);
	}

	public Object queryPagingDataAll(EduSubject entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
		if (Check.isNoEmpty(entity.getType())) {
			paramInf.is("type", entity.getType());
		}
		if (Check.isNoEmpty(entity.getTitleType())) {
			paramInf.is("titleType", entity.getTitleType());
		}
		if (Check.isNoEmpty(entity.getText())) {
			paramInf.like("text", entity.getText());
		}
		paramInf.is("state", 1);
		return super.queryPagingData( pageRange, paramInf);
	}

	@Override
	public void fileOper(SystemFile systemFile) {
		int count = findCount(ParamFactory.getParamHb().or(
				ParamFactory.getParamHb().is("textpic", systemFile.getId())
						.is("textpic2", systemFile.getId()).is("textpic3", systemFile.getId())));
		if (count == 0) {
			systemFile.setStatus(1);
		}
	}
}

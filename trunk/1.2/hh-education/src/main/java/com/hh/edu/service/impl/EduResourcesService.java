package com.hh.edu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduResources;
import com.hh.edu.bean.EduSubject;
import com.hh.system.bean.SystemFile;
import com.hh.system.service.impl.BaseService;
import com.hh.system.service.inf.IFileOper;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.Json;
import com.hh.system.util.MessageException;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.usersystem.bean.usersystem.UsRole;
import com.hh.usersystem.bean.usersystem.UsUser;
import com.hh.usersystem.service.impl.LoginUserUtilService;

@Service
public class EduResourcesService extends BaseService<EduResources> implements IFileOper{
	@Autowired
	private LoginUserUtilService loginUserService;
	@Override
	public PagingData<EduResources> queryPagingData(EduResources entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
		if (Check.isNoEmpty(entity.getType())) {
			paramInf.is("type", entity.getType());
		}
		if (Check.isNoEmpty(entity.getText())) {
			paramInf.like("text", entity.getText());
		}
		UsUser user = loginUserService.findLoginUser();
		if (!"admin".equals(user.getRoleIds())) {
				paramInf.is("vcreate", loginUserService.findUserId());
			}
		return super.queryPagingData(entity, pageRange, paramInf);
	}
	public void doSetState(String ids) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("id", Convert.strToList(ids));
		dao.updateEntity("update " + EduResources.class.getName()
				+ " o set o.state=1 where o.id in :id", map);
	}
	@Override
	public EduResources save(EduResources entity) throws MessageException {
		List<Map<String,Object>> mapList = Json.toMapList(entity.getFiles());
		String text = "";
		for (Map<String, Object> map : mapList) {
			text+=Convert.toString(map.get("text"))+",";
		}
		if (text.length()>128) {
			text=text.substring(0, 127);
		}
		entity.setText(text);
		return super.save(entity);
	}

	public Object queryPagingDataAll(EduResources entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
		if (Check.isNoEmpty(entity.getType())) {
			paramInf.is("type", entity.getType());
		}
		if (Check.isNoEmpty(entity.getText())) {
			paramInf.like("text", entity.getText());
		}
		paramInf.is("state", 1);
		return super.queryPagingData(entity, pageRange, paramInf);
	}
	@Override
	public void fileOper(SystemFile systemFile) {
		int count = findCount(ParamFactory.getParamHb().like("files", systemFile.getId()));
		if (count == 0) {
			systemFile.setDestroy(1);
		}
	}
	
	
}

 package com.hh.edu.service.impl;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.MessageException;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.usersystem.bean.usersystem.UsRole;
import com.hh.usersystem.bean.usersystem.UsUser;
import com.hh.usersystem.service.impl.LoginUserUtilService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduSubject;

@Service
public class EduSubjectService extends BaseService<EduSubject> {
	@Autowired
	private LoginUserUtilService loginUserService;
	@Override
	public PagingData<EduSubject> queryPagingData(EduSubject entity,
			PageRange pageRange) {
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
		return super.queryPagingData(entity, pageRange,paramInf);
	}

	@Override
	public EduSubject save(EduSubject entity) throws MessageException {
		int as = 1;
		UsUser user = loginUserService.findLoginUser();
		List<UsRole> usRoles = user.getHhXtJsList();
		if (usRoles.size() == 1 && "student".equals(usRoles.get(0).getJssx())) {
			as=0;
		}
		entity.setState(as);
		return super.save(entity);
	}

	public void doSetState(String ids) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("id", Convert.strToList(ids));
		dao.updateEntity("update " + EduSubject.class.getName()
				+ " o set o.state=1 where o.id in :id", map);
	}
}
 
 package com.hh.edu.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.base.BaseServiceAction;
import com.hh.system.util.dto.ParamFactory;
import com.hh.edu.bean.EduSubject;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduSubjectService;

@SuppressWarnings("serial")
public class ActionSubject extends BaseServiceAction< EduSubject > {
	@Autowired
	private EduSubjectService edusubjectService;
	public BaseService<EduSubject> getService() {
		return edusubjectService;
	}
	
	public Object findTextById() {
		List<EduSubject> list = getService().queryList(ParamFactory.getParamHb().in("id", Convert.strToList(object.getId())));
		String ids = "";
		String texts = "";
		for (EduSubject eduSubject : list) {
			texts+=eduSubject.getText()+",";
			ids+=eduSubject.getId()+",";
		}
		if (Check.isNoEmpty(texts)) {
			texts=texts.substring(0,texts.length()-1);
			ids=ids.substring(0,ids.length()-1);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", ids);
		map.put("text", texts);
		map.put("object", list);
		return map;
	}
}
 
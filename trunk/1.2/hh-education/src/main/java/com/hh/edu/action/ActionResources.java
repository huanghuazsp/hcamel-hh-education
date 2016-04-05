 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduResources;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduResourcesService;

@SuppressWarnings("serial")
public class ActionResources extends BaseServiceAction< EduResources > {
	@Autowired
	private EduResourcesService eduresourcesService;
	public BaseService<EduResources> getService() {
		return eduresourcesService;
	}
}
 
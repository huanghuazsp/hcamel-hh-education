 package com.hh.edu.action.out;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduResources;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduResourcesService;

@SuppressWarnings("serial")
public class ActionOutResources extends BaseServiceAction< EduResources > {
	@Autowired
	private EduResourcesService eduresourcesService;
	public BaseService<EduResources> getService() {
		return eduresourcesService;
	}
	
	public Object queryPagingDataAll() {
		return eduresourcesService.queryPagingDataAll(object,
				this.getPageRange());
	}
}
 
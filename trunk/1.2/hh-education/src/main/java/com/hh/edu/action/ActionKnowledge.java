 package com.hh.edu.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.system.util.base.BaseServiceAction;
import com.hh.edu.bean.EduKnowledge;
import com.hh.system.service.impl.BaseService;
import com.hh.edu.service.impl.EduKnowledgeService;

@SuppressWarnings("serial")
public class ActionKnowledge extends BaseServiceAction< EduKnowledge > {
	@Autowired
	private EduKnowledgeService eduknowledgeService;
	public BaseService<EduKnowledge> getService() {
		return eduknowledgeService;
	}
}
 
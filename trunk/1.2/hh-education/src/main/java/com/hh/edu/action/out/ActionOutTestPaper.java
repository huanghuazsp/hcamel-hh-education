package com.hh.edu.action.out;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.edu.bean.EduTestPaper;
import com.hh.edu.service.impl.EduTestPaperService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionOutTestPaper extends BaseServiceAction<EduTestPaper> {

	private String titleType;
	@Autowired
	private EduTestPaperService edutestpaperService;

	public BaseService<EduTestPaper> getService() {
		return edutestpaperService;
	}

	public Object generate() {
		try {
			edutestpaperService.generate(object, titleType);
			return null;
		} catch (MessageException e) {
			return e;
		}

	}

	public String getTitleType() {
		return titleType;
	}

	public void setTitleType(String titleType) {
		this.titleType = titleType;
	}

}

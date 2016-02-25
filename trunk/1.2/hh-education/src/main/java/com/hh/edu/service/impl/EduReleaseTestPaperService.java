 package com.hh.edu.service.impl;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.BeanUtils;
import com.hh.system.util.MessageException;
import com.hh.system.util.date.DateFormat;

import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduReleaseTestPaper;

@Service
public class EduReleaseTestPaperService extends BaseService<EduReleaseTestPaper> {

	@Override
	public EduReleaseTestPaper save(EduReleaseTestPaper entity) throws MessageException {
		entity.setMc(entity.getText()+DateFormat.getDate());
		return super.save(entity);
	}
	
	
	
	
	
}
 
 package com.hh.edu.service.impl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Check;
import com.hh.system.util.MessageException;
import com.hh.system.util.date.DateFormat;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.usersystem.LoginUserServiceInf;

@Service
public class EduReleaseTestPaperService extends BaseService<EduReleaseTestPaper> {

	@Autowired
	private LoginUserServiceInf loginUserService;
	@Override
	public EduReleaseTestPaper save(EduReleaseTestPaper entity) throws MessageException {
		if (Check.isEmpty(entity.getMc())) {
			entity.setMc(entity.getText()+DateFormat.getDate());
		}
		return super.save(entity);
	}

	public PagingData<EduReleaseTestPaper> queryStartPagingData(EduReleaseTestPaper entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
			paramInf.like("userIds", loginUserService.findUserId());
		return super.queryPagingData(entity, pageRange,paramInf);
	}
	
	
}
 
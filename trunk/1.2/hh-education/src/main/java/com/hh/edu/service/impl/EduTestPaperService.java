 package com.hh.edu.service.impl;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduTestPaper;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.Check;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;

@Service
public class EduTestPaperService extends BaseService<EduTestPaper> {
	@Override
	public PagingData<EduTestPaper> queryPagingData(EduTestPaper entity,
			PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
		if (Check.isNoEmpty(entity.getType())) {
			paramInf.is("type", entity.getType());
		}
		if (Check.isNoEmpty(entity.getText())) {
			paramInf.like("text", entity.getText());
		}
		return super.queryPagingData(entity, pageRange,paramInf);
	}
}
 
 package com.hh.edu.service.impl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduReleaseSubject;
import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.edu.bean.EduSubject;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.BeanUtils;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.Json;
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
	
	@Autowired
	private EduSubjectService eduSubjectService;
	
	@Autowired
	private EduReleaseSubjectService eduReleaseSubjectService;
	
	@Override
	public EduReleaseTestPaper save(EduReleaseTestPaper entity) throws MessageException {
		if (Check.isEmpty(entity.getMc())) {
			entity.setMc(entity.getText()+DateFormat.getDate());
		}
		
		String dataitems = entity.getDataitems();
		List<Map<String,Object>> mapList = Json.toMapList(dataitems);
		
		List<String> subjectList = new ArrayList<String>();
		
		for (Map<String, Object> map : mapList) {
			String subjects = Convert.toString(map.get("subjects"));
			List<String> subjectList2 = Convert.strToList(subjects);
			subjectList.addAll(subjectList2);
		}
		List<EduSubject> eduSubjectList = eduSubjectService.queryListByIds(subjectList);
		
		
		super.save(entity);
		
		for (EduSubject eduSubject : eduSubjectList) {
			EduReleaseSubject eduReleaseSubject = new EduReleaseSubject();
			BeanUtils.copyProperties(eduReleaseSubject, eduSubject);
			BeanUtils.defautlPropertiesSetNull(eduReleaseSubject);
			eduReleaseSubject.setSubjectId(eduSubject.getId());
			eduReleaseSubject.setReleaseTestPaperId(entity.getId());
			eduReleaseSubjectService.save(eduReleaseSubject);
		}
		
		return entity;
	}

	public PagingData<EduReleaseTestPaper> queryStartPagingData(EduReleaseTestPaper entity, PageRange pageRange) {
		ParamInf paramInf = ParamFactory.getParamHb();
			paramInf.like("userIds", loginUserService.findUserId());
		return super.queryPagingData(entity, pageRange,paramInf);
	}

	@Override
	public void deleteByIds(List<String> deleteIds) {
		eduReleaseSubjectService.deleteByProperty("releaseTestPaperId", deleteIds);
		super.deleteByIds(deleteIds);
	}
	
	
	
}
 
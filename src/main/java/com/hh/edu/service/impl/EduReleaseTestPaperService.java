 package com.hh.edu.service.impl;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.edu.bean.EduReleaseSubject;
import com.hh.edu.bean.EduReleaseTestPaper;
import com.hh.edu.bean.EduSubject;
import com.hh.edu.bean.EduTestPaper;
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
	
	@Autowired
	private EduExaminationService eduExaminationService;
	
	@Autowired
	private EduTestPaperService eduTestPaperService;
	
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
		
		eduReleaseSubjectService.deleteByProperty("releaseTestPaperId", entity.getId());
		eduExaminationService.deleteByProperty("releaseTestPaperId", entity.getId());
		
		
		
//		EduTestPaper eduTestPaper=	eduTestPaperService.findObjectById(entity.getTestPaperId());
//		String dataitems = eduTestPaper.getDataitems();
//		List<Map<String,Object>> mapList = Json.toMapList(dataitems);
		
		Map<String, Integer> scoreMap = new HashMap<String, Integer>();
		for (Map<String, Object> map : mapList) {
			String subjects = Convert.toString(map.get("subjects"));
			int score = Convert.toInt(map.get("score"));
			List<String> subjectList2 = Convert.strToList(subjects);
			int score1 = score/subjectList2.size();
			for (String string : subjectList2) {
				scoreMap.put(string,score1 );
			}
		}
		
		int score = 0;
		for (EduSubject eduSubject : eduSubjectList) {
			EduReleaseSubject eduReleaseSubject = new EduReleaseSubject();
			BeanUtils.copyProperties(eduReleaseSubject, eduSubject);
			BeanUtils.defautlPropertiesSetNull(eduReleaseSubject);
			eduReleaseSubject.setSubjectId(eduSubject.getId());
			eduReleaseSubject.setReleaseTestPaperId(entity.getId());
			eduReleaseSubject.setScore(scoreMap.get(eduSubject.getId()));
			score+=eduReleaseSubject.getScore();
			eduReleaseSubjectService.save(eduReleaseSubject);
		}
		if (score!=100) {
			throw new MessageException("总分数不等于100不能发布");
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
		eduExaminationService.deleteByProperty("releaseTestPaperId", deleteIds);
		super.deleteByIds(deleteIds);
	}
	
	
	
}
 
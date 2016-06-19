package com.hh.edu.service.impl;

import java.util.ArrayList;
import java.util.UUID;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.system.util.StaticVar;
import com.hh.usersystem.bean.usersystem.SysMenu;
import com.hh.usersystem.util.steady.StaticProperties;

@Service
public class SetupInitializerEdu {
	public static void main(String[] args) {
		System.out.println(UUID.randomUUID());
		System.out.println(UUID.randomUUID());
		System.out.println(UUID.randomUUID());
	}
	
	@Autowired
	private EduResourcesService eduResourcesService;
	@Autowired
	private EduSubjectService eduSubjectService;
	@PostConstruct
	public void initialize() {
		SysMenu rootHhXtCd = new SysMenu(
				"841722e2-2498-447b-8f9e-c78dead5be74", "教育系统",
				"com.hh.global.NavigAtionWindow",
				"/hhcommon/images/icons/world/world.png", 0, 0);
		rootHhXtCd.setChildren(new ArrayList<SysMenu>());
		
		rootHhXtCd.getChildren().add(
				new SysMenu("7a291966-d38c-4c31-9bfa-a3c43df9556e", "开始考试",
						"jsp-edu-releasetestpaper-StartReleaseTestPaperList",
						"/hhcommon/images/icons/world/world.png", 0, 1));

//		rootHhXtCd.getChildren().add(
//				new SysMenu("f6d6f3bf-4865-469c-8ef6-7edc0881ab7d", "题目类型管理",
//						"jsp-edu-subjecttype-SubjectTypeList",
//						"/hhcommon/images/icons/world/world.png", 0, 1));
		
		rootHhXtCd.getChildren().add(
				new SysMenu("34467895-4196-4403-bb4f-5c67bbb9f3bd", "试卷类型管理",
						"jsp-edu-testpapertype-TestPaperTypeList",
						"/hhcommon/images/icons/world/world.png", 0, 1));
		
		rootHhXtCd.getChildren().add(
				new SysMenu("df696ccc-63b5-4ed3-94ad-67fe63600a17", "题目管理",
						"jsp-edu-subject-main",
						"/hhcommon/images/icons/world/world.png", 0, 1));
		
		rootHhXtCd.getChildren().add(
				new SysMenu("0763a83c-b039-4331-ac8c-945903f636a9", "试卷管理",
						"jsp-edu-testpaper-main",
						"/hhcommon/images/icons/world/world.png", 0, 1));
		
		rootHhXtCd.getChildren().add(
				new SysMenu("740ee788-6e6b-4f0f-9400-30047a3bda13", "已发布试卷",
						"jsp-edu-releasetestpaper-ReleaseTestPaperList",
						"/hhcommon/images/icons/world/world.png", 0, 1));
		
		rootHhXtCd.getChildren().add(
				new SysMenu("78b91fe0-adb6-4637-97e2-fccc1a1a4ad4", "资源共享",
						"jsp-edu-resources-main",
						"/hhcommon/images/icons/world/world.png", 0, 1));
		
		StaticProperties.hhXtCds.add(rootHhXtCd);
		StaticVar.fileOperMap.put("subject",eduSubjectService );
		StaticVar.fileOperMap.put("eduresources",eduResourcesService );
	}
}
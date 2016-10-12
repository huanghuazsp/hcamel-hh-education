package com.hh.edu.service.impl;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.system.util.StaticVar;
import com.hh.system.util.pk.PrimaryKey;
import com.hh.usersystem.bean.usersystem.SysMenu;
import com.hh.usersystem.bean.usersystem.SysOper;
import com.hh.usersystem.util.steady.StaticProperties;

@Service
public class SetupInitializer {
	public static void main(String[] args) {
		System.out.println(PrimaryKey.getUUID());
		System.out.println(PrimaryKey.getUUID());
		System.out.println(PrimaryKey.getUUID());
	}

	@Autowired
	private EduResourcesService eduResourcesService;
	@Autowired
	private EduSubjectService eduSubjectService;

	@PostConstruct
	public void initialize() {
		// SysMenu rootHhXtCd = new SysMenu("cYKHlLXmXOzx6khEe3x","教育系统",
		// "com.hh.global.NavigAtionWindow",
		// "/hhcommon/images/icons/world/world.png", 0, 0);
		// rootHhXtCd.setChildren(new ArrayList<SysMenu>());

		// rootHhXtCd.getChildren().add(
		// new SysMenu("eTA9zB0ieF7P7Jnc6lk","开始考试",
		// "jsp-edu-releasetestpaper-StartReleaseTestPaperList",
		// "/hhcommon/images/icons/world/world.png", 0, 1));

		// rootHhXtCd.getChildren().add(
		// new SysMenu("f6d6f3bf-4865-469c-8ef6-7edc0881ab7d", "题目类型管理",
		// "jsp-edu-subjecttype-SubjectTypeList",
		// "/hhcommon/images/icons/world/world.png", 0, 1));

		// rootHhXtCd.getChildren().add(
		// new SysMenu( "BIrgaEvXNwhhn5Ai2Zz","试卷类型管理",
		// "jsp-edu-testpapertype-TestPaperTypeList",
		// "/hhcommon/images/icons/world/world.png", 0, 1));
		//
		// rootHhXtCd.getChildren().add(
		// new SysMenu("DmUm7NqniCqhZvLAekh", "题目管理",
		// "jsp-edu-subject-main",
		// "/hhcommon/images/icons/world/world.png", 0,
		// 1).editMobileUrl("mobilejsp-edu-subject-SubjectList"));
		//
		// rootHhXtCd.getChildren().add(
		// new SysMenu( "rfkN1nKaz88oborDUy4","试卷管理",
		// "jsp-edu-testpaper-main",
		// "/hhcommon/images/icons/world/world.png", 0, 1));
		//
		// rootHhXtCd.getChildren().add(
		// new SysMenu("SaOSb1pfokoe9sldnnc","已发布试卷",
		// "jsp-edu-releasetestpaper-ReleaseTestPaperList",
		// "/hhcommon/images/icons/world/world.png", 0, 1));
		//
		// rootHhXtCd.getChildren().add(
		// new SysMenu( "QIsEoXVkneAmY38DikY","资源共享",
		// "jsp-edu-resources-main",
		// "/hhcommon/images/icons/world/world.png", 0, 1));
		//
		// StaticProperties.hhXtCds.add(rootHhXtCd);

		for (SysMenu hhXtCd : StaticProperties.sysMenuList) {
			if ("协同办公".equals(hhXtCd.getText())) {
				SysMenu sysMenu = new SysMenu("QIsEoXVkneAmY38DikY", "学习考试", "jsp-edu-main-main",
						"/hhcommon/images/extjsico/165518104.gif", 0, 1);
				hhXtCd.getChildren().add(sysMenu);

				StaticProperties.sysOperList.add(new SysOper("CBC1Awa57SZ26wpDTEC", "试卷管理", sysMenu));
				StaticProperties.sysOperList.add(new SysOper("DfAkOufuhTMj4rfpIq8", "类型管理", sysMenu));
				StaticProperties.sysOperList.add(new SysOper("8AQNhgmmgvkIKbZyHNk", "已发布试卷", sysMenu));

				break;
			}
		}

		StaticVar.fileOperMap.put("subject", eduSubjectService);
		StaticVar.fileOperMap.put("eduresources", eduResourcesService);
	}
}
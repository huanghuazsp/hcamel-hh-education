<%@page import="com.hh.system.util.SystemUtil"%>
<%@page import="com.hh.system.service.impl.BeanFactoryHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<title>表单设计</title>
<%=SystemUtil.getBaseJs("layout")%>
<script type="text/javascript">
	var emailMenu = {
			data : [ {
				text : '开始考试',
				img : '/hhcommon/images/extjsico/165518104.gif',
				url : 'jsp-edu-releasetestpaper-StartReleaseTestPaperList',
				onClick : onClick
			},{
				text : '类型管理',
				img : '/hhcommon/images/extjsico/165518104.gif',
				url : 'jsp-edu-testpapertype-TestPaperTypeList',
				onClick : onClick
			},{
				text : '题目管理',
				img : '/hhcommon/images/extjsico/165518104.gif',
				url : 'jsp-edu-subject-main',
				onClick : onClick
			},{
				text : '试卷管理',
				img : '/hhcommon/images/extjsico/165518104.gif',
				url : 'jsp-edu-testpaper-main',
				onClick : onClick
			},{
				text : '已发布试卷',
				img : '/hhcommon/images/extjsico/165518104.gif',
				url : 'jsp-edu-releasetestpaper-ReleaseTestPaperList',
				onClick : onClick
			},{
				text : '资源共享',
				img : '/hhcommon/images/extjsico/165518104.gif',
				url : 'jsp-edu-resources-main',
				onClick : onClick
			}]
	};
	
	function onClick(){
		$('#system').attr('src',this.url);
	}
	
	
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west',width:140">
			<span xtype=menu  configVar="emailMenu"></span>
		</div>
		<div style="overflow: visible;" id=centerdiv>
			<iframe id="system" name="system" width=100%
				height=100% frameborder=0 src="jsp-edu-subject-main"></iframe>
		</div>
	</div>
</body>
</html>
<%@page import="com.hh.system.util.date.DateFormat"%>
<%@page import="com.hh.edu.bean.EduTestPaper"%>
<%@page import="com.hh.system.util.dto.ParamFactory"%>
<%@page import="com.hh.system.util.dto.ParamInf"%>
<%@page import="com.hh.system.util.dto.PageRange"%>
<%@page import="com.hh.system.service.impl.BeanFactoryHelper"%>
<%@page import="com.hh.edu.service.impl.EduTestPaperService"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.pk.PrimaryKey"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>试卷</title>
<%=BaseSystemUtil.getBaseJs()%>
<%
	EduTestPaperService eduTestPaperService = BeanFactoryHelper.getBean(EduTestPaperService.class);
	PageRange pageRange = new PageRange(0,10);
	
	ParamInf paramInf = ParamFactory.getParamHb().is("type", "04e03feb-83e2-442b-afaf-58e90f80f7b9");
	List<EduTestPaper> eduTestPaperList_wl =  eduTestPaperService.queryList(paramInf, pageRange);
	
	ParamInf paramInf2 = ParamFactory.getParamHb().is("type", "47aae5d3-9cc7-49a9-9d46-9e6607f8fb56");
	List<EduTestPaper> eduTestPaperList_ls =  eduTestPaperService.queryList(paramInf2, pageRange);
	
	ParamInf paramInf3 = ParamFactory.getParamHb().is("type", "0a6eb45c-87a6-4c20-828f-81b8d36a3ec6");
	List<EduTestPaper> eduTestPaperList_sw =  eduTestPaperService.queryList(paramInf3, pageRange);
%>
<script type="text/javascript">
	function init() {
	}
</script>
<style>
body {
	min-width: 520px;
	padding: 10px;
}

.column {
	width: 50%;
	float: left;
}

.portlet {
	margin: 0 1em 1em 0;
}

.portlet-header {
	margin: 0.3em;
	padding-bottom: 4px;
	padding-left: 0.2em;
}

.portlet-header .ui-icon {
	float: right;
}

.portlet-content {
	padding: 0.4em;
}

.ui-sortable-placeholder {
	border: 1px dotted black;
	visibility: visible !important;
	height: 50px !important;
}

.ui-sortable-placeholder * {
	visibility: hidden;
}

#newlist{ list-style:none; padding:0;  margin-top:0px;}
#newlist li { margin-left:10px; margin-right:10px; border-bottom:1px dotted #c6c6c6; padding-top:15px; overflow:hidden; font-size:12px;}
#newlist li a { display:inline; font-size:12px; text-decoration:none; text-indent:10px; margin-right:10px;}
#newlist li span{ display:block; float:right; margin-right:5px; color: #bdacb3;}
a.tab_title:link { color: #5a5a5a; text-decoration:none;}

</style>
<script>
	$(function() {
		$(".column").sortable({
			connectWith : ".column"
		});

		$(".portlet").addClass(
				"ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
				.find(".portlet-header").addClass(
						"ui-widget-header ui-corner-all").prepend(
						"<span class='ui-icon ui-icon-minusthick'></span>")
				.end().find(".portlet-content");

		$(".portlet-header .ui-icon").click(
				function() {
					$(this).toggleClass("ui-icon-minusthick").toggleClass(
							"ui-icon-plusthick");
					$(this).parents(".portlet:first").find(".portlet-content")
							.toggle();
				});

		$(".column").disableSelection();
	});
</script>
</head>
<body>
	<div class="column">
		<div class="portlet">
			<div class="portlet-header">地理</div>
			<div class="portlet-content">
				<ul id="newlist">
					<% for(int i=0;i<eduTestPaperList_wl.size();i++){
						EduTestPaper eduTestPaper = eduTestPaperList_wl.get(i);
					%>
						<li><a class="tab_menu" href="#"></a> <a
						class="tab_title"  href="javascript:Request.openwin('outjsp-edu-web-preview?id=<%=eduTestPaper.getId()%>');"><%=eduTestPaper.getText() %></a><span><%=DateFormat.dateToStr(eduTestPaper.getDcreate(), "yyyy-MM-dd") %></span></li>
					<%}%>
				</ul>
			</div>
		</div>
	</div>
	<div class="column">
		<div class="portlet">
			<div class="portlet-header">历史</div>
			<ul id="newlist">
					<% for(int i=0;i<eduTestPaperList_ls.size();i++){
						EduTestPaper eduTestPaper = eduTestPaperList_ls.get(i);
					%>
						<li><a class="tab_menu" href="#"></a> <a
						class="tab_title" href="javascript:Request.openwin('outjsp-edu-web-preview?id=<%=eduTestPaper.getId()%>');"><%=eduTestPaper.getText() %></a><span><%=DateFormat.dateToStr(eduTestPaper.getDcreate(), "yyyy-MM-dd") %></span></li>
					<%}%>
				</ul>
		</div>
	</div>
	<div class="column">
		<div class="portlet">
			<div class="portlet-header">生物</div>
			<div class="portlet-content">
				<ul id="newlist">
				<% for(int i=0;i<eduTestPaperList_sw.size();i++){
						EduTestPaper eduTestPaper = eduTestPaperList_sw.get(i);
					%>
						<li><a class="tab_menu" href="#"></a> <a
						class="tab_title" href="javascript:Request.openwin('outjsp-edu-web-preview?id=<%=eduTestPaper.getId()%>');"><%=eduTestPaper.getText() %></a><span><%=DateFormat.dateToStr(eduTestPaper.getDcreate(), "yyyy-MM-dd") %></span></li>
					<%}%>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
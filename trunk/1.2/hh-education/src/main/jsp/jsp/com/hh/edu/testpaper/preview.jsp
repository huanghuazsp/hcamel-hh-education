<%@page import="com.hh.system.util.PrimaryKey"%>
<%@page import="com.hh.edu.bean.EduSubject"%>
<%@page import="com.hh.edu.service.impl.EduSubjectService"%>
<%@page import="com.hh.system.util.Json"%>
<%@page import="com.hh.edu.service.impl.EduTestPaperService"%>
<%@page import="com.hh.system.service.impl.BeanFactoryHelper"%>
<%@page import="com.hh.edu.bean.EduTestPaper"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>数据编辑</title>
<%=BaseSystemUtil.getBaseJs("checkform")%>
<%
	String id = request.getParameter("id");
	EduTestPaperService eduTestPaperService = BeanFactoryHelper.getBean(EduTestPaperService.class);
	
	EduSubjectService eduSubjectService = BeanFactoryHelper.getBean(EduSubjectService.class);
	
	EduTestPaper eduTestPaper = eduTestPaperService.findObjectById(id);
	String dataitems = eduTestPaper.getDataitems();
	List<Map<String,Object>> mapList = Json.toMapList(dataitems);
%>
<script type="text/javascript">
</script>
</head>
<body>
<table width=100% ><tr><td align=center>
	<div style="width:794px;text-align:left;">
	<br/><%=eduTestPaper.getHead() %><br/>
	<%
	for(int i =0;i<mapList.size();i++){
		Map<String,Object> map = mapList.get(i);
		String subjects = Convert.toString(map.get("subjects"));
		List<String> subjectList = Convert.strToList(subjects);
		List<EduSubject> eduSubjectList = eduSubjectService.queryListByIds(subjectList);
	%>
		<h3><%=((Convert.numberToChina(i+1)+"、"+map.get("title")).replaceAll("\n","<br>").replaceAll(" ","&nbsp;"))%></h3><br/>
		<%
		for(int j =0;j<eduSubjectList.size();j++){
			EduSubject eduSubject = eduSubjectList.get(j);
			String titleType = eduSubject.getTitleType();
			String type = "radio";
			if("check".equals(titleType)){
				type="checkbox";
			}
			String tmid  = eduSubject.getId();
		%><br/>
			<strong><%=(j+1)+"、"+eduSubject.getText() %></strong><br/><br/>
		<%
			if("check".equals(titleType) || "radio".equals(titleType)){
					String dataitemstr = eduSubject.getDataitems();
					List<Map<String,Object>> mapList2 = Json.toMapList(dataitemstr);
					for(int k =0;k<mapList2.size();k++){
						Map<String,Object> item = mapList2.get(k);
						String letter = Convert.letterToNumber(k+1);
						%>
						<div style="padding:3px;">&nbsp;&nbsp;<input name="<%=tmid %>" type="<%=type %>" id="<%=tmid+"_"+k %>" /><label for="<%=tmid+"_"+k %>"><%=letter %>.<%=item.get("text") %></label><br/></div>
						<%
					}
			}else if("shortAnswer".equals(titleType)){
				%>
				<textarea style="height:100px"></textarea>
				<%
			}else if("fillEmpty".equals(titleType)){
				String[] answers = Convert.toString(eduSubject.getAnswer()).split("、");
				String content = eduSubject.getContent();
				for(String str : answers){
					content = content.replace(str, "<input style='width:100px;' />");
				}
				%>
				&nbsp;&nbsp;<%=content %>
				<%
			}
		}
		%>
	<%}%>
	</div>
</td></tr></table>
</body>
</html>
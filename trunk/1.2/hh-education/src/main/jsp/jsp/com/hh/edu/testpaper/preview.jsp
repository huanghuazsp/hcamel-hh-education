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
<%=BaseSystemUtil.getBaseJs("layout","checkform")%>
<%
	String id = request.getParameter("id");
	EduTestPaperService eduTestPaperService = BeanFactoryHelper.getBean(EduTestPaperService.class);
	
	EduSubjectService eduSubjectService = BeanFactoryHelper.getBean(EduSubjectService.class);
	
	EduTestPaper eduTestPaper = eduTestPaperService.findObjectById(id);
	String dataitems = eduTestPaper.getDataitems();
	List<Map<String,Object>> mapList = Json.toMapList(dataitems);
%>
<script type="text/javascript">

var menuConfig = {
		
}

function init(){
	var dataList = [];
	$('[title=true]').each(function(){
		var bigtitle = $(this).attr('bigtitle');
		var text = $(this).text();
		var title = $(this).text();
		
		var subjectId = $(this).attr('subjectId');
		
		if(text&&text.length>7){
			text=text.substr(0,7);
		}
		text = text+'..';
		if(bigtitle){
			text = '<font color=red>'+text+'</font>';
		}
		dataList.push({
			'text': '<div title="'+title+'" subjectId="'+subjectId+'">'+text+'</div>',
			domId : $(this).attr('id'),
			onClick:function(){
				$('#centerdiv').animate({scrollTop:$('#centerdiv').scrollTop()+$('#'+this.domId).offset().top-20},500);
			}
		});
	});
	menuConfig.data=dataList;
	$('#menu').render();
	regEvent();
}


function regEvent(){
	$('[type=subject]').each(function(){
		var domDiv = $(this);
		var type = domDiv.attr('subjectType');
		if(type=='radio' || type=='check'){
			domDiv.find('input').click(function(){
				save();
			});
		}else if(type=='shortAnswer' ){
			domDiv.find('textarea').blur(function(){
				save();
			});
		}else if(type=='fillEmpty'){
			domDiv.find('input').blur(function(){
				save();
			});
		}
	});
}

function submit(){
	var objectMap =  bc();
	console.log(objectMap);
}

function save(){
	var objectMap =  bc();
	console.log(objectMap);
}

function bc(){
	var objectMap = {};
	$('[type=subject]').each(function(){
		var domDiv = $(this);
		var subjectId = domDiv.attr('subjectId');
		var type = domDiv.attr('subjectType');
		var valueStr = '';
		if(type=='radio'){
			valueStr = domDiv.find('input:radio:checked').val();
		}else if(type=='check'){
			var value = '';
			domDiv.find("input:checkbox:checked").each(function() {
						value += $(this).val() + ","
					})
			if (value != '') {
				value = value.substr(0, value.length - 1);
			}
			valueStr=value;
		}else if(type=='shortAnswer'){
			valueStr = domDiv.find('textarea').val();
		}else if(type=='fillEmpty'){
			var value ='';
			domDiv.find('input').each(function(){
				value += $(this).val() + ","
			});
			if (value != '') {
				value = value.substr(0, value.length - 1);
			}
			valueStr=value;
		}
		objectMap[subjectId] = valueStr;
	});
	return objectMap;
}
function all(){
	$('#menu').find('[subjectId]').each(function(){
		$(this).parents('[role=menuitem]').show();
	});
}
function wdt(){
	var objectMap =  bc();
	all();
	$('#menu').find('[subjectId]').each(function(){
		var value = objectMap[$(this).attr('subjectId')];
		if(value != null && value!=''){
			var as = true;
			var valueList = value.split(',');
			for(var i=0;i<valueList.length;i++){
				if(valueList[i] == null || valueList[i] ==  ''){
					as = false;
					break;
				}
			}
			if(as){
				$(this).parents('[role=menuitem]').hide();
			}
		}
	});
}
</script>
</head>
<body>

<div xtype="border_layout">
		<div config="render : 'west'  ,width:175 " id="leftDiv">
			<div xtype="toolbar" config="type:'head'" style="text-align:center;">
				<span xtype="button"
					config="onClick : all ,text : '所有'   "></span>
				<span xtype="button"
					config="onClick : wdt ,text : '未答题'   "></span>
			</div>
			<span xtype=menu  id="menu"  configVar="menuConfig"></span>
		</div>
		<div style="" id=centerdiv>

<div xtype="toolbar" config="type:'head'" style="text-align:center;">
	<span xtype="button"
		config="onClick : submit ,text : '交卷'   "></span>
</div>


<table width=100% ><tr><td align=center>
	<div style="width:794px;text-align:left;">
	<br/><%=eduTestPaper.getHead() %><br/>
	<%
	int aa = 1;
	for(int i =0;i<mapList.size();i++){
		Map<String,Object> map = mapList.get(i);
		String subjects = Convert.toString(map.get("subjects"));
		List<String> subjectList = Convert.strToList(subjects);
		List<EduSubject> eduSubjectList = eduSubjectService.queryListByIds(subjectList);
	%>
		<h3  id="<%=PrimaryKey.getPrimaryKeyUUID() %>"  title=true bigtitle=true><%=((Convert.numberToChina(i+1)+"、"+map.get("title")).replaceAll("\n","<br>").replaceAll(" ","&nbsp;"))%></h3><br/>
		<%
		for(int j =0;j<eduSubjectList.size();j++){
			EduSubject eduSubject = eduSubjectList.get(j);
			String titleType = eduSubject.getTitleType();
			String type = "radio";
			if("check".equals(titleType)){
				type="checkbox";
			}
			String tmid  = eduSubject.getId();
			if(!"fillEmpty".equals(titleType)){
		%><br/>
			<strong title=true  id="<%=PrimaryKey.getPrimaryKeyUUID() %>"  subjectId="<%=tmid%>" ><%=(aa)+"、"+eduSubject.getText() %></strong><br/><br/>
			<div type=subject subjectId="<%=tmid%>" subjectType="<%=titleType%>">
		<%
			aa++;
			}
			if("check".equals(titleType) || "radio".equals(titleType)){
					String dataitemstr = eduSubject.getDataitems();
					List<Map<String,Object>> mapList2 = Json.toMapList(dataitemstr);
					for(int k =0;k<mapList2.size();k++){
						Map<String,Object> item = mapList2.get(k);
						String letter = Convert.letterToNumber(k+1);
						%>
						<div style="padding:3px;">&nbsp;&nbsp;<input value=<%=k+1 %> name="<%=tmid %>" type="<%=type %>" id="<%=tmid+"_"+k %>" /><label for="<%=tmid+"_"+k %>"><%=letter %>.<%=item.get("text") %></label><br/></div>
						<%
					}
			}else if("shortAnswer".equals(titleType)){
				%>
				<textarea style="height:100px"></textarea>
				<%
			}else if("fillEmpty".equals(titleType)){
				String[] answers = Convert.toString(eduSubject.getAnswer()).split("、");
				String content = (aa)+"、"+eduSubject.getText();
				for(String str : answers){
					content = content.replace(str, "<input style='width:100px;' />");
				}
				%>
				<div type=subject subjectId="<%=tmid%>" subjectType="<%=titleType%>">
				<strong  title=true  id="<%=PrimaryKey.getPrimaryKeyUUID() %>"  subjectId="<%=tmid%>" ><%=content %></strong><br/><br/>
				<%aa++;
			} %></div><%
		}
		%>
	<%}%>
	</div>
</td></tr></table>


		</div>
	</div>
</body>
</html>
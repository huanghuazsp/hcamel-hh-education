<%@page import="com.hh.system.util.Check"%>
<%@page import="com.hh.edu.bean.EduReleaseSubject"%>
<%@page import="com.hh.edu.bean.BaseSubject"%>
<%@page import="com.hh.edu.service.impl.EduReleaseSubjectService"%>
<%@page import="com.hh.edu.service.impl.EduReleaseTestPaperService"%>
<%@page import="com.hh.edu.bean.BaseTestPaper"%>
<%@page import="com.hh.edu.bean.EduExamination"%>
<%@page import="com.hh.edu.service.impl.EduExaminationService"%>
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

	String exatype = request.getParameter("type");
	
	boolean exa = "exa".equals(exatype);

	EduTestPaperService eduTestPaperService = BeanFactoryHelper.getBean(EduTestPaperService.class);
	EduSubjectService eduSubjectService = BeanFactoryHelper.getBean(EduSubjectService.class);
	EduReleaseTestPaperService eduReleaseTestPaperService = BeanFactoryHelper.getBean(EduReleaseTestPaperService.class);
	EduReleaseSubjectService eduReleaseSubjectService = BeanFactoryHelper.getBean(EduReleaseSubjectService.class);
	
	EduExaminationService eduExaminationService = BeanFactoryHelper.getBean(EduExaminationService.class);
	EduExamination eduExamination = new EduExamination();
	if(exa){
		eduExamination.setReleaseTestPaperId(id);
		eduExamination = eduExaminationService.examination(eduExamination);
	}
	
	
	BaseTestPaper eduTestPaper = null;
	if(exa){
		eduTestPaper = eduReleaseTestPaperService.findObjectById(id);
	}else{
		eduTestPaper = eduTestPaperService.findObjectById(id);
	}
		
	String dataitems = eduTestPaper.getDataitems();
	List<Map<String,Object>> mapList = Json.toMapList(dataitems);
	
	
	
%>
<script type="text/javascript">
var eduExamination =  <%=Check.isEmpty(eduExamination.getAnswer()) ?"{}" : eduExamination.getAnswer()%>;
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
	
	<%
	if(exa){
	%>
	eduExaminationFun();
	<%
	}
	%>
	
}
<%
if(exa){
%>
function eduExaminationFun(){
	$('[type=subject]').each(function(){
		var span = $(this);
		var subjectId = span.attr('subjectId');
		var value =  eduExamination[subjectId];
		
		var type = span.attr('subjectType');
		if(type=='radio' ){
			span.find("input[type=radio]").prop("checked", false);
			var input = span.find("input[type=radio][value=" + value + "]");
			input.prop("checked", true);
		}else if(type=='check'){
			span.find("input[type=checkbox]").prop("checked", false);
			if (value) {
				value += '';
				var values = value.split(',');
				var text = '';
				for (var i = 0; i < values.length; i++) {
					var input = span.find("input[type=checkbox][value=" + values[i]
							+ "]");
					input.prop("checked", true);
					text += input.next('label').html() + ',';
				}
				if (text != '') {
					text = text.substr(0, text.length - 1);
					span.setConfig({
								text : text
							});
				}
			}
		}else if(type=='shortAnswer' ){
			span.find('textarea').val(value);
		}else if(type=='fillEmpty'){
			var inputs = span.find('input');
			if (value) {
				value += '';
				var values = value.split(',');
				var text = '';
				for (var i = 0; i < values.length; i++) {
					if(inputs.eq(i)){
						inputs.eq(i).val(values[i]);
					}
				}
			}
		}
	});
}
<%
}
%>



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
	<%
	if(exa){
	%>
	Dialog.confirm({
		message : '您确认要提交试卷',
		yes : function(){
			updateA(objectMap,'submit');
		}
	});
	<%
	}
	%>
}

function save(){
	var objectMap =  bc();
	<%
	if(exa){
	%>
	updateA(objectMap);
	<%
	}
	%>
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
		objectMap[subjectId] = valueStr || '';
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
<%
if(exa){
%>
function updateA(answer,submit){
	Request.request('edu-Examination-updateAnswer', {
		defaultMsg : false,
		data : {
			'releaseTestPaperId':'<%=id%>',
			'answer': BaseUtil.toString(answer),
			submitType : submit
		},
		callback : function(result) {
			//console.log(result);
		}
	});
}
<%
}
%>

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
		List<BaseSubject> eduSubjectList = new ArrayList<BaseSubject>();;
		if(exa){
			List<EduReleaseSubject> eduSubjectList1 = eduReleaseSubjectService.queryListByProperty("subjectId",subjectList);
			for(EduReleaseSubject subject : eduSubjectList1){
				eduSubjectList.add(subject);
			}
		}else{
			List<EduSubject> eduSubjectList1 = eduSubjectService.queryListByIds(subjectList);
			for(EduSubject subject : eduSubjectList1){
				eduSubjectList.add(subject);
			}
		}
	%>
		<h3  id="<%=PrimaryKey.getPrimaryKeyUUID() %>"  title=true bigtitle=true><%=((Convert.numberToChina(i+1)+"、"+map.get("title")).replaceAll("\n","<br>").replaceAll(" ","&nbsp;"))%></h3><br/>
		<%
		for(int j =0;j<eduSubjectList.size();j++){
			BaseSubject eduSubject = eduSubjectList.get(j);
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
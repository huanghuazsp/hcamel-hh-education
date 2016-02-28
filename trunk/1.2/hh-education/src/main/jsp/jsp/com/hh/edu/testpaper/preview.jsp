<%@page import="com.hh.system.util.MessageException"%>
<%@page import="com.hh.system.util.date.DateFormat"%>
<%@page import="com.hh.system.util.dto.ParamInf"%>
<%@page import="com.hh.system.util.dto.ParamFactory"%>
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
	
	String userId = request.getParameter("userId");
	
	boolean exa = "exa".equals(exatype);
	
	boolean view ="view".equals(exatype);
	
	boolean artificial = "artificial".equals(exatype) ;
	if(view){
		artificial = true;
	}

	EduTestPaperService eduTestPaperService = BeanFactoryHelper.getBean(EduTestPaperService.class);
	EduSubjectService eduSubjectService = BeanFactoryHelper.getBean(EduSubjectService.class);
	EduReleaseTestPaperService eduReleaseTestPaperService = BeanFactoryHelper.getBean(EduReleaseTestPaperService.class);
	EduReleaseSubjectService eduReleaseSubjectService = BeanFactoryHelper.getBean(EduReleaseSubjectService.class);
	
	EduExaminationService eduExaminationService = BeanFactoryHelper.getBean(EduExaminationService.class);
	EduExamination eduExamination = new EduExamination();
	if(exa || artificial){
		eduExamination.setReleaseTestPaperId(id);
		eduExamination = eduExaminationService.examination(eduExamination);
	}
	
	Map<String,Object> answermap = Json.toMap(eduExamination.getAnswer());
	
	Map<String,Object> artificialmap = Json.toMap(eduExamination.getArtificial());
	
	if( artificial && Check.isNoEmpty(userId)){
		eduExamination = eduExaminationService.findObject(ParamFactory.getParamHb()
				.is("releaseTestPaperId",id)
				.is("userId",userId));
	}
	
	
	BaseTestPaper eduTestPaper = null;
	if(exa || artificial){
		eduTestPaper = eduReleaseTestPaperService.findObjectById(id);
		long currTime = new Date().getTime();
		if(view){
			if (eduExamination.getOpenScore()!=1) {
					out.print("<table cellpadding='0' cellspacing='0' border='0' width='100%'	height='100%'>"
							+"<tr>"
							+"<td align='center' valign='middle'>"
								+"<table>"
									+"<tr>"
										+"<td><div class='hh_blue'"
												+"style='border-radius: 8px; -moz-border-radius: 8px; margin-top: 2px; padding: 10px 15px;'>"
												+"<table>"
													+"<tr>"
														+"<td width='50px'><div class='hh_img_blue'></div></td>"
														+"<td style='font-weight: bold; font-size: 25px;'>考试结果未发布不能查看结果"
														+"</td>"
													+"</tr>"
												+"</table>"
											+"</div></td>"
									+"</tr>"
								+"</table>"
							+"</td>"
						+"</tr>"
					+"</table>");
				return;
			}
		}
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

function setHeight(height){
	$('#centerdiv').height(height-35);
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
				$('#centerdiv').animate({scrollTop:$('#centerdiv').scrollTop()+$('#'+this.domId).offset().top-55},500);
			}
		});
	});
	menuConfig.data=dataList;
	$('#menu').render();
	regEvent();
	
	<%
	if(exa || artificial){
	%>
	eduExaminationFun();
	<%
	}
	%>
	
}
<%
if(exa || artificial){
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
<%
if( artificial){
%>
function artificial(){
	$.hh.validation.check('form', function(formData) {
		Request.request('edu-Examination-artificial', {
			data : {
				'releaseTestPaperId':'<%=id%>',
				'artificial' : BaseUtil.toString(formData)
			},
			callback : function(result) {
				
			}
		});
	});
}
<%
}%>
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
		<div>

<div xtype="toolbar" config="type:'head'" style="text-align:center;height:28px;vertical-align:middle;">
	<%
	if( artificial && !view){
	%>
	<span xtype="button" config="onClick : artificial ,text : '提交评分'   "></span>
	<%
	}else if(exa){
	%>
	<span xtype="button" config="onClick : submit ,text : '交卷'   "></span>
	<%
	}else if(view){
	%>
	<div style="margin-top:5px;">	<%=eduExamination.getUserName() %>您的成绩为：<%=eduExamination.getScore() %>,成绩发布时间为：<%=DateFormat.dateToStr(eduExamination.getOpenDate(), "yyyy-MM-dd HH:mm:ss")%></div>
	<%
	}
	%>
	
</div>

<div  id=centerdiv  style="overflow:auto;">
<form id="form" xtype="form">
<table width=100% ><tr><td align=center>
	<div style="width:794px;text-align:left;">
	<br/><%=eduTestPaper.getHead() %><br/>
	<%
	int aa = 1;
	for(int i =0;i<mapList.size();i++){
		Map<String,Object> map = mapList.get(i);
		String subjects = Convert.toString(map.get("subjects"));
		String score = Convert.toString(map.get("score"));
		List<String> subjectList = Convert.strToList(subjects);
		List<BaseSubject> eduSubjectList = new ArrayList<BaseSubject>();;
		if(exa|| artificial){
			List<EduReleaseSubject> eduSubjectList1 = eduReleaseSubjectService.queryList(ParamFactory.getParamHb().in("subjectId",subjectList).is("releaseTestPaperId",id));
			for(EduReleaseSubject subject : eduSubjectList1){
				eduSubjectList.add(subject);
			}
		}else{
			List<EduSubject> eduSubjectList1 = eduSubjectService.queryListByIds(subjectList);
			for(EduSubject subject : eduSubjectList1){
				eduSubjectList.add(subject);
			}
		}
		String titleMes = "（本大题共"+subjectList.size()+"小题，共"+score+"分）";
	%>
		<h3  id="<%=PrimaryKey.getPrimaryKeyUUID() %>"  title=true bigtitle=true><%=((Convert.numberToChina(i+1)+"、"+map.get("title")).replaceAll("\n","<br>").replaceAll(" ","&nbsp;"))+titleMes%></h3><br/>
		<%
		for(int j =0;j<eduSubjectList.size();j++){
			BaseSubject eduSubject = eduSubjectList.get(j);
			String titleType = eduSubject.getTitleType();
			String type = "radio";
			if("check".equals(titleType)){
				type="checkbox";
			}
			String tmid  = eduSubject.getId();
			
			String answer = "";
			String  scoreStr = "";
			if( artificial){
				String userAnswer  = Convert.toString(answermap.get(eduSubject.getId()));
				String color = "green";
				scoreStr="（"+eduSubject.getScore()+"分）";
				if("radio".equals(titleType)){
					answer = Convert.numberToLetter(Convert.toInt(eduSubject.getAnswer()));
					if(!userAnswer.equals(eduSubject.getAnswer())){
						color="red";
					}
				}else if("check".equals(titleType)){
					String[] answers = Convert.toString(eduSubject.getAnswer()).split(",");
					for(String str :answers ){
						answer += Convert.numberToLetter(Convert.toInt(str));
					}
					if(!userAnswer.equals(eduSubject.getAnswer())){
						color="red";
					}
				}else if("fillEmpty".equals(titleType)){
					answer = eduSubject.getAnswer();
					if (!userAnswer.equals(Convert.toString(eduSubject.getAnswer()).replaceAll("、", ","))) {
						color="red";
					}
				}else if("shortAnswer".equals(titleType)){
					answer = eduSubject.getAnswer();
				}
				if(Check.isNoEmpty(answer)){
					answer="<div >&nbsp;&nbsp;<font color='"+color+"'>正确答案："+answer+"</font></div>";
				}
				if("shortAnswer".equals(titleType)){
					String vv = Convert.toString(artificialmap.get(eduSubject.getId()));
					if(view){
						answer = "&nbsp;&nbsp;得分："+vv+"<br/>"+answer;
					}else{
						answer = "评分：<span xtype=text config='value: "+vv+",name : \""+eduSubject.getId()+"\",min : 0,required:true,integer : true ,max:"+eduSubject.getScore()+",width:100' ></span>"+answer;
					}
				}
			}
			
			if(!"fillEmpty".equals(titleType)){
		%><br/>
			<strong title=true  id="<%=PrimaryKey.getPrimaryKeyUUID() %>"  subjectId="<%=tmid%>" ><%=(aa)+"、"+eduSubject.getText() +scoreStr%></strong><br/><br/>
			<%=answer %>
			<div type=subject subjectId="<%=tmid%>" subjectType="<%=titleType%>">
		<%
			aa++;
			}
			if("check".equals(titleType) || "radio".equals(titleType)){
					String dataitemstr = eduSubject.getDataitems();
					List<Map<String,Object>> mapList2 = Json.toMapList(dataitemstr);
					for(int k =0;k<mapList2.size();k++){
						Map<String,Object> item = mapList2.get(k);
						String letter = Convert.numberToLetter(k+1);
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
				<%=answer %>
				<strong  title=true  id="<%=PrimaryKey.getPrimaryKeyUUID() %>"  subjectId="<%=tmid%>" ><%=content +scoreStr%></strong><br/><br/>
				<%aa++;
			} %></div><%
		}
		%>
	<%}%>
	</div>
</td></tr></table>
</form>
</div>
		</div>
	</div>
</body>
</html>
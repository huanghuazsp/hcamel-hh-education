<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=SystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=SystemUtil.getBaseJs("checkform", "date", "ueditor")%>
<%
	String type = Convert.toString(request.getParameter("type"));
	String typeName = Convert.toString(request.getParameter("typeName"));
%>
<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 800;
	var height = 600;

	var objectid = '<%=Convert.toString(request.getParameter("id"))%>';

	function save() {
		$.hh.validation.check('form', function(formData) {
			Request.request('edu-TestPaper-save', {
				data : formData,
				callback : function(result) {
					if (result.success!=false) {
						params.callback(formData);
						Dialog.close();
					}
				}
			});
		});
	}

	function findData() {
		if (objectid) {
			Request.request('edu-TestPaper-findObjectById', {
				data : {
					id : objectid
				},
				callback : function(result) {
					$('#form').setValue(result);
				}
			});
		}
	}
	function renderTitleType(titleType){
		if(titleType=='radio'){
			return '单选题';
		}else if(titleType=='check'){
			return '多选题';
		}else if(titleType=='shortAnswer'){
			return '简答题';
		}else if(titleType=='fillEmpty'){
			return '填空题';
		}
	}
	
	function queryHtml(type){
		return '<table xtype="form" id="queryForm" style="">'
							+'<tr>'
							+'<td xtype="label">类型：</td>'
							+'<td><span xtype="selectTree" config=" value:\''+type+'\', findTextAction :\'edu-TestPaperType-findObjectById\' , name : \'type\' ,url : \'edu-TestPaperType-queryTreeList\' "></span></td>'
							+'<td xtype="label">名称：</td>'
							+'<td><span xtype="text" config=" name : \'text\' ,enter: doQuery "></span></td>'
							+'<td style="width:100px;"><span	xtype="button" config="onClick: doQuery ,text:\'查询\' , itype :\'query\' "></span></td>'
						+'</tr>'
					+'</table>';
	}
	
	function renderstate(state){
		if(state==1){
			return '[已发布]';
		}else{
			return '[未发布]';
		}
	}
	var letter =  ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
	   			"P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
   	function renderTitle(value,data){
   		var text ='<strong>'+ data.text.replace(/\n/g, "<br />")+'</strong>'+'<br/>'+'<br/>';
   		if(data.textpic){
   			text +='<img alt="" src="system-File-download?params={id:\''+data.textpic+'\'}">';
   		}
   		if(data.textpic2){
   			text +='<img alt="" src="system-File-download?params={id:\''+data.textpic2+'\'}">';
   		}
   		if(data.textpic3){
   			text +='<img alt="" src="system-File-download?params={id:\''+data.textpic3+'\'}">';
   		}
   		var table =$( '<table style="width:100%;"></table>');
   		var tr = $('<tr></tr>');
   		var td = $('<td style="text-align:left;"></td>');
   		tr.append(td);
   		table.append(tr);
   		
   		var answerStr = '答案：';
   		if(data.titleType=='radio' || data.titleType=='check'){
   			var dataitems = $.hh.toObject(data.dataitems);
   			for(var i=0;i<dataitems.length;i++){
   				text += '<div style="padding:3px;">&nbsp;'+ letter[i]+ '.'+dataitems[i].text+'<br/></div>';
   			}
   			if(data.answer){
   				var answers = data.answer.split(',');
   				for(var i=0;i<answers.length;i++){
   					answerStr+=letter[answers[i]-1];
   				}
   			}
   		}else if(data.titleType=='fillEmpty'){
   			if(data.answer){
   					var  answers = data.answer.split("、");
   					for(var i=0;i<answers.length;i++){
   						text = text.replace(answers[i], "<input style='width:100px;' />");
   					}
   					answerStr+=data.answer;
   			}
   		}else if(data.titleType=='shortAnswer'){
   			if(data.answer){
   					answerStr+=data.answer;
   			}
   		}
   		
   		td.append(text);
   		
   		var tr1 = $('<tr style="display:none;" trid="'+data.id+'"></tr>');
   		var td1 = $('<td style="text-align:left;"></td>');
   		tr1.append(td1);
   		table.append(tr1);
   		td1.append('<strong  color=green>'+((answerStr||'').replace(/\n/g, "<br />"))+'</strong>');
   		
   		var tr2 = $('<tr></tr>');
   		var td2 = $('<td style="text-align:left;border-top: 1.0pt solid windowtext;"></td>');
   		tr2.append(td2);
   		table.append(tr2);
   		
   		var toolbar = renderstate(data.state);
   		td2.append(toolbar+'&nbsp;&nbsp;&nbsp;&nbsp;'+(data.createUserName || '')+'&nbsp;&nbsp;&nbsp;&nbsp;'+$.hh.formatDate(data.createTime || '','yyyy-MM-dd HH:mm:ss')+'&nbsp;&nbsp;<a href="javascript:viewAnswer(\''+data.id+'\')">查看答案</a>');
   		return table;
   	}
	
	var subjectConfig = {
			textarea :true,
			openWidth:800,
			many:true,
			findTextAction :'edu-Subject-findTextById' ,
			pageconfig:{
				queryHtml : queryHtml('<%=type%>'),
				url:'outedu-OutSubject-queryPagingDataAll' ,
				params:{type:'<%=type%>'},
				column : [
					{
						name : 'text' ,
						text : '题目',
						align:'left',
						render : renderTitle ,
						width : 500
					}
				]
			}
	};
	
	var tableitemConfig = {
		name : 'dataitems',
		required : true,
		trhtml : '<table width=100%>'
		+'<tr><td style="text-align:right;width:60px;">分数：</td><td><span xtype="text" valuekey="score" config=" integer : true  "></span></td></tr>'
		+'<tr><td style="text-align:right;width:60px;">大题名称：</td><td><span xtype="textarea" valuekey="title" configVar="  "></span></td></tr>'+
		'<tr><td style="text-align:right;width:60px;">题目：</td><td><span xtype="selectPageList" valuekey="subjects" configVar=" subjectConfig "></span></td></tr></table>'
	}

	function init() {
		$('#span_text').setValue('<%=Convert.toString(typeName)%>'+$.hh.formatDate($.hh.getDate()));
		findData();
	}
	function testpaperChange(data){
		if(data){
			subjectConfig.pageconfig.queryHtml=queryHtml(data.id);
			subjectConfig.pageconfig.params.type=data.id;
			
			$('#span_text').setValue(data.name+$.hh.formatDate($.hh.getDate()));
		}
	}
</script>
</head>
<body>
	<div xtype="hh_content">
		<form id="form" xtype="form" class="form">
			<span xtype="text" config=" hidden:true,name : 'id'"></span>
			<table xtype="form">
				<tr>
					<td xtype="label">学科：</td>
					<td><span id="node_span" xtype="selectTree"
						config=" onChange: testpaperChange , value:'<%=type%>' , name: 'type' , findTextAction : 'edu-TestPaperType-findObjectById' , url : 'edu-TestPaperType-queryTreeList' ,required :true "></span>
					</td>
				</tr>
				<tr>
					<td xtype="label">名称：</td>
					<td><span xtype="text" config=" name : 'text',required :true"></span></td>
				</tr>
				<!-- <tr>
					<td xtype="label">试卷抬头：</td>
					<td><span xtype="ckeditor" config="name: 'head' , height : 200 "></span></td>
				</tr> -->
				<tr id="tableitemtr">
					<td xtype="label">大题配置：</td>
					<td><span xtype="tableitem" configVar="tableitemConfig"></span></td>
				</tr>
				<tr>
					<td xtype="label">备注：</td>
					<td><span xtype="textarea" config=" name : 'remark' "></span></td>
				</tr>
			</table>
		</form>
	</div>
	<div xtype="toolbar">
		<span xtype="button" config="text:'保存' , onClick : save "></span> <span
			xtype="button" config="text:'取消' , onClick : Dialog.close "></span>
	</div>
</body>
</html>



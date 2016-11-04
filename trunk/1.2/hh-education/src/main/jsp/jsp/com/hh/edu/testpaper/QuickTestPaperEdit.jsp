<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=BaseSystemUtil.getBaseJs("checkform", "date")%>
<%
	String type = Convert.toString(request.getParameter("type"));
	String typeName = Convert.toString(request.getParameter("typeName"));
%>
<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 800;
	var height = 600;

	function save() {
		$.hh.validation.check('form', function(formData) {
			Request.request('edu-TestPaper-generate', {
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
	var subjectTypeConfig={
			value:'radio',
			data :[
				{id:'radio',text:'单选题'},
				{id:'check',text:'多选题'},
				{id:'fillEmpty',text:'填空题'},
				{id:'shortAnswer',text:'简答题'}
			]
	}
	var tableitemConfig = {
		name : 'dataitems',
		required : true,
		trhtml : '<table width=100%>'
		+'<tr><td style="text-align:right;width:60px;">题目类型：</td><td><span xtype="radio" valuekey="type" configVar=" subjectTypeConfig  "></span></td></tr>'
		+'<tr><td style="text-align:right;width:60px;">题目数量：</td><td><span xtype="text" valuekey="subjectCount" config=" integer : true,value:50  "></span></td></tr>'
		+'<tr><td style="text-align:right;width:60px;">分数总分：</td><td><span xtype="text" valuekey="score" config=" integer : true ,value:100 "></span></td></tr>'
	}
	function testpaperChange(data){
		if(data){
			$('#span_text').setValue(data.name+$.hh.formatDate($.hh.getDate()));
		}
	}
	function init() {
		$('#span_text').setValue('<%=Convert.toString(typeName)%>'+$.hh.formatDate($.hh.getDate()));
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
					<td><span xtype="text" config=" name : 'text',required :true  "></span></td>
				</tr>
				<tr id="tableitemtr">
					<td xtype="label">大题配置：</td>
					<td><span xtype="tableitem" configVar="tableitemConfig"></span></td>
				</tr>
			</table>
		</form>
	</div>
	<div xtype="toolbar">
		<span xtype="button" config="text:'生成' , onClick : save "></span> <span
			xtype="button" config="text:'取消' , onClick : Dialog.close "></span>
	</div>
</body>
</html>



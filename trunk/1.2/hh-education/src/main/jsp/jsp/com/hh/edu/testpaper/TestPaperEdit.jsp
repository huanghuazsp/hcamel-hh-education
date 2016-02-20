<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=BaseSystemUtil.getBaseJs("checkform","date","ckeditor")%>
<%
	String type =   Convert.toString(request.getParameter("type"));
%>
<script type="text/javascript">
	var params = BaseUtil.getIframeParams();
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
	
	var subjectConfig = {
			url:'edu-Subject-queryPagingData'
	};
	
	var tableitemConfig = {
		name : 'dataitems',
		required : true,
		trhtml : '<table width=100%><tr><td style="text-align:right;width:60px;">大题名称：</td><td><span xtype="textarea" valuekey="title" configVar="  "></span></td></tr>'+
		'<tr><td style="text-align:right;width:60px;">题目：</td><td><span xtype="selectPageList" valuekey="subjects" configVar=" subjectConfig "></span></td></tr></table>'
	}

	function init() {
		findData();
	}
</script>
</head>
<body>
	<div xtype="hh_content">
		<form id="form" xtype="form">
			<span xtype="text" config=" hidden:true,name : 'id'"></span>
			<table xtype="form">
				<tr>
					<td xtype="label">类型：</td>
					<td><span id="node_span" xtype="selectTree"
						config="  value:'<%=type %>' , name: 'type' , findTextAction : 'edu-TestPaperType-findObjectById' , url : 'edu-TestPaperType-queryTreeList' ,required :true "></span>
					</td>
				</tr>
				<tr>
					<td xtype="label">名称：</td>
					<td><span xtype="text" config=" name : 'text',required :true"></span></td>
				</tr>
				<tr>
					<td xtype="label">试卷抬头：</td>
					<td><span xtype="ckeditor" config="name: 'head' "></span></td>
				</tr>
				<tr id="tableitemtr">
					<td xtype="label">选择项：</td>
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

 
 
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=BaseSystemUtil.getBaseJs("checkform","date")%>

<script type="text/javascript">
	var params = BaseUtil.getIframeParams();
	var width = 600;
	var height = 450;

	var objectid = '<%=Convert.toString(request.getParameter("id"))%>';

	function save() {
		$.hh.validation.check('form', function(formData) {
			Request.request('edu-Subject-save', {
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
			Request.request('edu-Subject-findObjectById', {
				data : {
					id : objectid
				},
				callback : function(result) {
					$('#form').setValue(result);
				}
			});
		}
	}

	function init() {
		findData();
	}
	
	var textconfig = {
			blur:function(){
				console.log($('span_data').getValue());
			}
	};
	
	var tableitemConfig = {
		name : 'data',
		required : true,
		valueType : 'object',
		trhtml : '<table width=100%><tr><td><span xtype="text" valuekey="text" configVar=" textconfig "></span></td></tr></table>'
	}
</script>
</head>
<body>
	<div xtype="hh_content">
		<form id="form" xtype="form">
			<span xtype="text" config=" hidden:true,name : 'id'"></span>
			<table xtype="form">
				<tr>
					<td xtype="label">题目：</td>
					<td><span xtype="text" config=" name : 'title',required :true"></span></td>
				</tr>
				<tr>
					<td xtype="label">选择项：</td>
					<td><span xtype="tableitem" configVar="tableitemConfig"></span></td>
				</tr>
				<tr>
					<td xtype="label">答案：</td>
					<td><span  xtype="ridio" configVar=" name: 'answer' "></span></td>
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

 
 
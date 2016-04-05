<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=BaseSystemUtil.getBaseJs("checkform","date","fileUpload")%>
<%
	String type = Convert.toString(request.getParameter("type"));
%>
<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 600;
	var height = 450;

	var objectid = '<%=Convert.toString(request.getParameter("id"))%>';

	function save() {
		$.hh.validation.check('form', function(formData) {
			Request.request('edu-Resources-save', {
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
			Request.request('edu-Resources-findObjectById', {
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
						config="  value:'<%=type%>' , name: 'type' , findTextAction : 'edu-TestPaperType-findObjectById' , url : 'edu-TestPaperType-queryTreeList' ,required :true "></span>
					</td>
				</tr>
				<!-- <tr>
					<td xtype="label">名称：</td>
					<td><span xtype="text" config=" name : 'text',required :true"></span></td>
				</tr> -->
				<tr>
					<td xtype="label">资源：</td>
					<td><span config="'name':'files','type':'eduresources' "  xtype="fileUpload" ></span></td>
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

 
 
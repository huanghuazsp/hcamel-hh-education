<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=SystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=SystemUtil.getBaseJs("checkform","date")%>

<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 600;
	var height = 450;

	var objectid = '<%=Convert.toString(request.getParameter("id"))%>';
	var TestPaperObject = {};
	function save() {
		$.hh.validation.check('form', function(formData1) {
			var formData = {};
			$.extend(formData,TestPaperObject);
			$.extend(formData,formData1);
			var userData = $('#userIdsSpan').getValueData();
			if(userData){
				formData.userNames = $.hh.objsToStr(userData,'text');
			}
			formData.createTime=null;
			formData.updateTime=null;
			formData.order=null;
			formData.createUser=null;
			formData.orgid=null;
			formData.updateUser=null;
			Request.request('edu-ReleaseTestPaper-save', {
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
			Request.request('edu-ReleaseTestPaper-findObjectById', {
				data : {
					id : objectid
				},
				callback : function(result) {
					TestPaperObject = result;
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
		<form id="form" xtype="form" class="form">
			<span xtype="text" config=" hidden:true,name : 'id'"></span>
			<table xtype="form">
				<tr>
					<td xtype="label">试卷名称：</td>
					<td ><span xtype="text" config=" name : 'mc',required :true "></span></td>
				</tr>
				<tr>
					<td xtype="label">考试时间：</td>
					<td><span xtype="date" config=" name : 'startDate',required :true ,type:'datetime'"></span></td>
				</tr>
				<tr>
					<td xtype="label">时长（分钟）：</td>
					<td><span xtype="text" config=" name : 'WhenLong',required :true ,integer:true"></span></td>
				</tr>
				<tr>
					<td xtype="label">考试人员：</td>
					<td><span id="userIdsSpan" xtype="selectUser" config="required :true ,name: 'userIds' ,textarea:true,many:true "></span></td>
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

 
 
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=BaseSystemUtil.getBaseJs("checkform", "date", "ckeditor")%>
<%
	String type = Convert.toString(request.getParameter("type"));
%>
<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 800;
	var height = 600;

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
			formData.testPaperId=formData.id;
			formData.id='';
			formData.dcreate=null;
			formData.dupdate=null;
			formData.order=null;
			formData.vcreate=null;
			formData.vorgid=null;
			formData.vupdate=null;
			formData.state=0;
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
			Request.request('edu-TestPaper-findObjectById', {
				data : {
					id : objectid
				},
				callback : function(result) {
					TestPaperObject = result;
					var total = 0 ;
					var dataitems = $.hh.toObject(result.dataitems);
					for(var i=0;i < dataitems.length;i++){
						var data = dataitems[i];
						total+= $.hh.toInt(data.score);
					}
					if(total!=100){
						$('body').html('<table cellpadding="0" cellspacing="0" border="0" width="100%"	height="100%">'
								+'<tr>'
									+'<td align="center" valign="middle">'
										+'<table>'
											+'<tr>'
												+'<td><div class="hh_blue"'
														+'style="border-radius: 8px; -moz-border-radius: 8px; margin-top: 2px; padding: 10px 15px;">'
														+'<table>'
															+'<tr>'
																+'<td width="50px"><div class="hh_img_blue"></div></td>'
																+'<td style="font-weight: bold; font-size: 25px;">分数不等于100不能发布<a href="javascript:Dialog.close();">关闭</a>'
																+'</td>'
															+'</tr>'
														+'</table>'
													+'</div></td>'
											+'</tr>'
										+'</table>'
									+'</td>'
								+'</tr>'
							+'</table>');
					}else{
						$('#texttd').html(result.text);
					}
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
					<td id=texttd></td>
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
		<span xtype="button" config="text:'确定' , onClick : save "></span> <span
			xtype="button" config="text:'取消' , onClick : Dialog.close "></span>
	</div>
</body>
</html>



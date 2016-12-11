<%@page import="com.hh.system.util.Convert"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=SystemUtil.getBaseJs()%>

<script type="text/javascript">

	
	function doQuery() {
		$('#pagelist').loadData({
			params : $('#queryForm').getValue()
		});
	}
	
	function doEmail(){
			Request.request('edu-ReleaseTestPaper-emailRemind', {
				data : {
					id: '<%=Convert.toString(request.getParameter("id"))%>'
				},
				callback : function(result){
					if(result.success!=false){
						Dialog.okmsg('邮件提醒发送成功！');
					}
				}
			});
	}
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
			<span xtype="button"
			config="onClick: doEmail ,text:'发送邮件提醒参考人员'"></span>
	</div>
	<div id="pagelist" xtype="pagelist"
		config="  url: 'edu-ReleaseTestPaper-queryUserList?id=<%=Convert.toString(request.getParameter("id"))%>' ,column : [
		
		{
			name : 'text' ,
			text : '名称'
		},
		{
			name : 'vdzyj' ,
			text : '邮箱'
		}
	]">
	</div>
</body>
</html>
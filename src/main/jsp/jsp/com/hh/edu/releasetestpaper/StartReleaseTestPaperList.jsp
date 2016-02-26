<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=BaseSystemUtil.getBaseJs()%>

<script type="text/javascript">

	function doQuery() {
		$('#pagelist').loadData({
			params : $('#queryForm').getValue()
		});
	}
	function start(id){
		Request.request('edu-Examination-examination', {
			data : {
				'releaseTestPaperId':id
			},
			callback : function(result) {
				console.log(result);
			}
		});
	}
	function renderoper(value, row) {
		if(row.state==0){
			return '<a  href="javascript:start(\'' + value
			+ '\')" >开始考试</a>';
		}else if(row.state==2){
			return '未开始';
		}else if(row.state==3){
			return '已结束';
		}
	}
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		<!--  <span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span> --> 
	</div>
	<!-- <table xtype="form" id="queryForm" style="width:600px;">
		<tr>
			<td xtype="label">test：</td>
			<td><span xtype="text" config=" name : 'test'"></span></td>
		</tr>
	</table> -->
	<div id="pagelist" xtype="pagelist"
		config=" url: 'edu-ReleaseTestPaper-queryStartPagingData' ,column : [
		
		{
			name : 'mc' ,
			text : '名称'
		},{
			name : 'startDate' ,
			text : '考试开始时间',
			render:'datetime'
		},{
			name : 'id' ,
			text : '操作',
			width: '40',
			render : renderoper
		}
	]">
	</div>
</body>
</html>
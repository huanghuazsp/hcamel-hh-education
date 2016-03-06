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
		$.hh.addTab({
			id : 'ks'+id,
			text :  '考试',
			src : 'jsp-edu-testpaper-preview?type=exa&id=' +id
		});
	}
	function viewResult(id){
		$.hh.addTab({
			id : 'ks'+id,
			text :  '考试',
			src : 'jsp-edu-testpaper-preview?type=view&id=' +id
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
	function renderscore(value, row) {
		if(value!='未发布'){
			return '<a  href="javascript: viewResult(\'' + row.id
			+ '\')" >'+value+'</a>';
		}else{
			return value;
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
			text : '考卷名称'
		},{
			name : 'startDate' ,
			text : '考试开始时间',
			render:'datetime',
			width:120
		},{
			name : 'openDate' ,
			text : '成绩发布时间',
			render:'datetime',
			width:120
		},{
			name : 'score' ,
			text : '分数',
			width: '40',
			render : renderscore
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
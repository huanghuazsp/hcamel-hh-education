<%@page import="com.hh.system.util.Convert"%>
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
	function renderoper(value, row) {
		if((row.userName+'').indexOf('（缺考）')>-1){
			return "缺考";
		}
		if(row.openScore==1){
			return '<a  href="javascript: viewPage(\'' + row.userName
			+ '\',\'' + row.releaseTestPaperId
			+ '\',\'' + row.userId
			+ '\')" >查看试卷</a>';
		}else{
			return '<a  href="javascript: artificial(\'' + value
			+ '\',\'' + row.releaseTestPaperId
			+ '\',\'' + row.userId
			+ '\')" >人工评卷</a>';
		}
	}
	function renderopenScore(value, row) {
		return value==1?'已发布':'未发布';
	}
	function calculation(){
		Request.request('edu-Examination-calculation', {
			data : {
				'releaseTestPaperId':'<%=Convert.toString(request.getParameter("id"))%>'
			},
			callback : function(result) {
				doQuery();
			}
		});
	}
	function artificial(value,id,userId){
		BaseUtil.addTab({
			id : 'pj'+id+userId,
			text :  '评卷',
			src : 'jsp-edu-testpaper-preview?type=artificial&id=' +id +'&userId=' +userId
		});
	}
	function viewPage(value,id,userId){
		BaseUtil.addTab({
			id : 'cksj'+id+userId,
			text :  '查看试卷-'+value,
			src : 'jsp-edu-testpaper-preview?type=view&id=' +id +'&userId=' +userId
		});
	}
	
	function openScore(){
		Request.request('edu-Examination-openScore', {
			data : {
				'releaseTestPaperId':'<%=Convert.toString(request.getParameter("id"))%>'
			},
			callback : function(result) {
				doQuery();
			}
		});
	}
	
	function dataLoad(items){
		var j = 0;
		var total = items.length;
		
		var souceTotal = 0;
		
		for(var i =0;i<items.length;i++){
			var row = items[i];
			if((row.userName+'').indexOf('（缺考）')>-1){
				j++;
			}
			souceTotal+=row.score;
		}
		
		$('#remark').html('应参加考试人数<font color=red>'
				+total+'</font>人；实际参加考试人数<font color=red>'
				+(total-j)+'</font>人；缺考人数<font color=red>'
				+j+'</font>人；平均分：'+$.hh.formatText(souceTotal/total,'0.00')+'分；');
	}
	
	function doQuery() {
		$('#pagelist').loadData({
			params : $('#queryForm').getValue()
		});
	}
</script>
</head>
<body>
	<div  style="text-align:center;font-weight: bold; font-size: 25px;padding:10px;"><%=Convert.toString(request.getParameter("text"))%></div>
	<div id="remark" style="text-align:center;padding:10px;"></div>
	<div xtype="toolbar" config="type:'head'">
			<span xtype="button"
			config="onClick:calculation,text:'计算分数'"></span>
			<span xtype="button"
			config="onClick:openScore,text:'发布分数'"></span>
			<span xtype="button"
			config="onClick:doQuery,text:'刷新'"></span>
	</div>
	<div id="pagelist" xtype="pagelist"
		config=" dataLoad : dataLoad , url: 'edu-ReleaseTestPaper-queryTestResult?id=<%=Convert.toString(request.getParameter("id"))%>' ,column : [
		
		{
			name : 'userName' ,
			text : '名称'
		},{
			name : 'submitDate' ,
			text : '交卷时间',
			render:'datetime',
			width:  120
		},{
			name : 'calculationScore' ,
			text : '计算分数',
			width: '70'
		},{
			name : 'artificialDate' ,
			text : '人工评卷时间',
			render:'datetime',
			width:  120
		},{
			name : 'artificialScore' ,
			text : '人工分数',
			width: '70'
		},{
			name : 'score' ,
			text : '最终分数',
			width: '70'
		},{
			name : 'openScore' ,
			text : '发布',
			width: '50',
			render : renderopenScore
		},{
			name : 'id' ,
			text : '操作',
			width: '70',
			render : renderoper
		}
	]">
	</div>
</body>
</html>
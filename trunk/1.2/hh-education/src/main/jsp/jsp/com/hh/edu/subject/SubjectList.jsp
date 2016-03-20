<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=BaseSystemUtil.getBaseJs()%>

<script type="text/javascript">
	var type1 = '';
	function doDelete() {
		$.hh.pagelist.deleteData({
			pageid : 'pagelist',
			action : 'edu-Subject-deleteByIds'
		});
	}
	function doAddRadio(){
		doAdd('radio');
	}
	function doAddCheck(){
		doAdd('check');
	}
	function doAddShortAnswer(){
		doAdd('shortAnswer');
	}
	function doAddFillEmpty(){
		doAdd('fillEmpty');
	}
	function doAdd(type) {
		if(type){
			Dialog.open({
				url : 'jsp-edu-subject-SubjectEdit?titleType='+type+'&type='+type1,
				params : {
					callback : function() {
						$("#pagelist").loadData();
					}
				}
			});
		}
	}
	function doEdit() {
		$.hh.pagelist.callRow("pagelist", function(row) {
			Dialog.open({
				url : 'jsp-edu-subject-SubjectEdit?type='+type1,
				urlParams : {
					id : row.id
				},
				params : {
					callback : function() {
						$("#pagelist").loadData();
					}
				}
			});
		});
	}
	function iframeClick(data) {
		type1=data.id;
		$('#pagelist').loadData({
			params : {type:type1}
		});
	}
	function doQuery() {
		var params = $('#queryForm').getValue();
		params.type = type1;
		$('#pagelist').loadData({
			params : params
		});
	}
	
	function renderTitleType(titleType){
		if(titleType=='radio'){
			return '单选题';
		}else if(titleType=='check'){
			return '多选题';
		}else if(titleType=='shortAnswer'){
			return '简答题';
		}else if(titleType=='fillEmpty'){
			return '填空题';
		}
	}
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		<span xtype="button" config="onClick: doAddRadio ,text:'添加单选题' , itype :'add' "></span>
		<span xtype="button" config="onClick: doAddCheck ,text:'添加多选题' , itype :'add' "></span>
		<span xtype="button" config="onClick: doAddFillEmpty ,text:'添加填空题' , itype :'add' "></span>
		<span xtype="button" config="onClick: doAddShortAnswer ,text:'添加简答题' , itype :'add' "></span>
		<span xtype="button"
			config="onClick:doEdit,text:'修改' , itype :'edit' "></span> <span
			xtype="button" config="onClick:doDelete,text:'删除' , itype :'delete' "></span>
		<!--  <span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span> --> <span
			xtype="button"
			config="onClick: $.hh.pagelist.doUp , params:{ pageid :'pagelist',action:'edu-Subject-order'}  ,  icon : 'hh_up' "></span>
		<span xtype="button"
			config="onClick: $.hh.pagelist.doDown , params:{ pageid :'pagelist',action:'edu-Subject-order'} , icon : 'hh_down' "></span>
	</div>
	<!-- <table xtype="form" id="queryForm" style="width:600px;">
		<tr>
			<td xtype="label">test：</td>
			<td><span xtype="text" config=" name : 'test'"></span></td>
		</tr>
	</table> -->
	<div id="pagelist" xtype="pagelist"
		config=" url: 'edu-Subject-queryPagingData' ,column : [
		
		{
			name : 'titleType' ,
			text : '题型',
			render : renderTitleType,
			align:'center',
			width:80,
		},{
			name : 'text' ,
			text : '题目',
			align:'left',
			contentwidth:300
		},{
			name : 'answer' ,
			text : '答案',
			align:'center',
			contentwidth:100
		}
		
	]">
	</div>
</body>
</html>
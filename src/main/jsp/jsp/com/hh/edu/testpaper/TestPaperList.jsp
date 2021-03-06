<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=SystemUtil.getBaseJs()%>

<script type="text/javascript">
	var type1 = '';
	var typeName = '';
	function doDelete() {
		$.hh.pagelist.deleteData({
			pageid : 'pagelist',
			action : 'edu-TestPaper-deleteByIds'
		});
	}
	function doAdd() {
		Dialog.open({
			url : 'jsp-edu-testpaper-TestPaperEdit?type='+type1+'&typeName='+typeName,
			params : {
				callback : function() {
					$("#pagelist").loadData();
				}
			}
		});
	}
	function renderstate(state){
		if(state==1){
			return '[已发布]';
		}else{
			return '[未发布]';
		}
	}
	function doQuickAdd(){
		Dialog.open({
			url : 'jsp-edu-testpaper-QuickTestPaperEdit?type='+type1+'&typeName='+typeName,
			params : {
				callback : function() {
					$("#pagelist").loadData();
				}
			}
		});
	}
	function doSetState() {
		$.hh.pagelist.callRows( 'pagelist', function(rows) {
				var ids = $.hh.objsToStr(rows);
				var data = {};
				data.ids = ids;
				Request.request('edu-TestPaper-doSetState', {
					data : data
				}, function(result) {
					if (result.success != false) {
						$("#pagelist" ).loadData();
					}
				});
		});
		
	}
	function doEdit() {
		$.hh.pagelist.callRow("pagelist", function(row) {
			Dialog.open({
				url : 'jsp-edu-testpaper-TestPaperEdit?type='+type1,
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
	function doQuery() {
		$('#pagelist').loadData({
			params : $('#queryForm').getValue()
		});
	}
	function iframeClick(data) {
		type1=data.id;
		typeName=data.text;
		$('#pagelist').loadData({
			params : {type:type1}
		});
	}
	
	function preview(){
		$.hh.pagelist.callRow("pagelist", function(row) {
			$.hh.addTab({
				id : row.id,
				text :  '试卷预览',
				src : 'outjsp-edu-web-preview?selfTest=1&id=' +row.id
			});
		});
	}
	
	function release(){
		$.hh.pagelist.callRow("pagelist", function(row) {
			Dialog.open({
				url : 'jsp-edu-release-ReleaseEdit',
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
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		<span xtype="button" config="onClick:doAdd,text:'添加' , itype :'add' "></span>
		<span xtype="button" config="onClick: doQuickAdd ,text:'快速添加' , itype :'add' "></span>
		<span xtype="button"
			config="onClick:doEdit,text:'修改' , itype :'edit' "></span> <span
			xtype="button" config="onClick:doDelete,text:'删除' , itype :'delete' "></span>
		<!--  <span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span> --> <span
			xtype="button"
			config="onClick: $.hh.pagelist.doUp , params:{ pageid :'pagelist',action:'edu-TestPaper-order'}  ,  icon : 'hh_up' "></span>
		<span xtype="button"
			config="onClick: $.hh.pagelist.doDown , params:{ pageid :'pagelist',action:'edu-TestPaper-order'} , icon : 'hh_down' "></span>
		<span
			xtype="button" config="onClick: preview ,text:'预览'  "></span>
		<span
			xtype="button" config="onClick: release ,text:'开考'  "></span>
		<span xtype="button" config="onClick: doSetState ,text:'发布共享'  "></span>
	</div>
	<table xtype="form" id="queryForm" style="width:700px;">
		<tr>
			<td xtype="label">试卷名称：</td>
			<td><span xtype="text" config=" name : 'text' ,enter: doQuery "></span></td>
			<td><span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span></td>
		</tr>
	</table>
	<div id="pagelist" xtype="pagelist"
		config=" url: 'edu-TestPaper-queryPagingData' ,column : [
		
		{
			name : 'createUserName' ,
			text : '添加人',
			align:'center',
			width:80
		},{
			name : 'state' ,
			text : '状态',
			align:'center',
			width:80,
			render:renderstate
		},{
			name : 'createTime' ,
			text : '创建时间',
			align:'center',
			width:150,
			render :'datetime'
		},{
			name : 'text' ,
			text : '试卷名称'
		}
		
	]">
	</div>
</body>
</html>
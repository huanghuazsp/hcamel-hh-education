<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=BaseSystemUtil.getBaseJs()%>

<script type="text/javascript">
	function doDelete() {
		$.hh.pagelist.deleteData({
			pageid : 'pagelist',
			action : 'edu-Resources-deleteByIds'
		});
	}
	function doSetState() {
		$.hh.pagelist.callRows( 'pagelist', function(rows) {
				var ids = $.hh.objsToStr(rows);
				var data = {};
				data.ids = ids;
				Request.request('edu-Resources-doSetState', {
					data : data
				}, function(result) {
					if (result.success != false) {
						$("#pagelist" ).loadData();
					}
				});
		});
		
	}
	function doAdd() {
		Dialog.open({
			url : 'jsp-edu-resources-ResourcesEdit?type='+(type1||''),
			params : {
				callback : function() {
					$("#pagelist").loadData();
				}
			}
		});
	}
	function doEdit() {
		$.hh.pagelist.callRow("pagelist", function(row) {
			Dialog.open({
				url : 'jsp-edu-resources-ResourcesEdit?type='+type1,
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
	var type1 = null;
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
	function fileRender(value){
		var str = '';
		
		if(value){
			var fileList = $.hh.toObject(value);
			for(var i=0;i<fileList.length;i++){
				var data = fileList[i];
				str+=$.hh.property.getFileTypeIcon(data.fileType)+data.text+'&nbsp;&nbsp;<a href="javascript:Request.download(\''+data.id+'\');">下载</a>&nbsp;&nbsp;<a href="javascript:Request.viewFile(\''+data.id+'\');">查看</a><br>'
			}
		}
		return str;
	}
	function renderstate(state){
		if(state==1){
			return '[已发布]';
		}else{
			return '[未发布]';
		}
	}
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		<span xtype="button" config="onClick:doAdd,text:'添加' , itype :'add' "></span>
		<span xtype="button"
			config="onClick:doEdit,text:'修改' , itype :'edit' "></span> <span
			xtype="button" config="onClick:doDelete,text:'删除' , itype :'delete' "></span>
		<!--  <span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span> --> <span
			xtype="button"
			config="onClick: $.hh.pagelist.doUp , params:{ pageid :'pagelist',action:'edu-Resources-order'}  ,  icon : 'hh_up' "></span>
		<span xtype="button"
			config="onClick: $.hh.pagelist.doDown , params:{ pageid :'pagelist',action:'edu-Resources-order'} , icon : 'hh_down' "></span>
		<span xtype="button" config="onClick: doSetState ,text:'发布共享'  "></span>
	</div>
	<table xtype="form" id="queryForm" style="width:700px;">
		<tr>
			<td xtype="label">资源名称：</td>
			<td><span xtype="text" config=" name : 'text' ,enter: doQuery "></span></td>
			<td><span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span></td>
		</tr>
	</table>
	<div id="pagelist" xtype="pagelist"
		config=" url: 'edu-Resources-queryPagingData' ,column : [
		
		{
			name : 'vcreateName' ,
			text : '添加人',
			align:'center',
			width:80
		},{
			name : 'state' ,
			text : '状态',
			align:'center',
			width:80,
			render : renderstate
		},{
			name : 'dcreate' ,
			text : '创建时间',
			align:'center',
			width:150,
			render :'datetime'
		},{
			name : 'files' ,
			align:'left',
			text : '资源',
			render : fileRender
		}
		
	]">
	</div>
</body>
</html>
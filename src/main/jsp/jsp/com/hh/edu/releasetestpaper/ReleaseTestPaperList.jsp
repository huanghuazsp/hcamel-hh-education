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
			action : 'edu-ReleaseTestPaper-deleteByIds'
		});
	}
	function doAdd() {
		Dialog.open({
			url : 'jsp-edu-releasetestpaper-ReleaseTestPaperEdit',
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
				url : 'jsp-edu-releasetestpaper-ReleaseTestPaperEdit',
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
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		 <span xtype="button"
			config="onClick:doEdit,text:'修改' , itype :'edit' "></span>  <span
			xtype="button" config="onClick:doDelete,text:'删除' , itype :'delete' "></span>
		<!--  <span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span>  <span
			xtype="button"
			config="onClick: $.hh.pagelist.doUp , params:{ pageid :'pagelist',action:'edu-ReleaseTestPaper-order'}  ,  icon : 'hh_up' "></span>
		<span xtype="button"
			config="onClick: $.hh.pagelist.doDown , params:{ pageid :'pagelist',action:'edu-ReleaseTestPaper-order'} , icon : 'hh_down' "></span>-->
	</div>
	<!-- <table xtype="form" id="queryForm" style="width:600px;">
		<tr>
			<td xtype="label">test：</td>
			<td><span xtype="text" config=" name : 'test'"></span></td>
		</tr>
	</table> -->
	<div id="pagelist" xtype="pagelist"
		config=" url: 'edu-ReleaseTestPaper-queryPagingData' ,column : [
		
		{
			name : 'mc' ,
			text : '名称'
		},{
			name : 'startDate' ,
			text : '考试开始时间',
			render:'datetime'
		}
		
	]">
	</div>
</body>
</html>
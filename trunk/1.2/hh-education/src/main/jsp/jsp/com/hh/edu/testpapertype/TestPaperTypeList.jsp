<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%@page import="com.hh.system.util.pk.PrimaryKey"%>
<%=SystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=SystemUtil.getBaseJs("layout","ztree", "ztree_edit")%>
<%
	String iframeId = PrimaryKey.getUUID();
%>

<script type="text/javascript">
	var iframeId = '<%=iframeId%>';
	function doAdd() {
		$('#centerdiv').undisabled();
		var selectNode = $.hh.tree.getSelectNode('tree');
		var iframe = window.frames[iframeId];
		iframe.callback = function() {
			$.hh.tree.refresh('tree');
			$('#centerdiv').disabled('请选择要编辑的学段或者学科！');
		}
		if (selectNode) {
			iframe.newData({
				node : selectNode.id
			});
		} else {
			iframe.newData({});
		}
		return;
		Dialog.open({
			url : 'jsp-edu-testpapertype-TestPaperTypeEdit',
			params : {
				selectNode : selectNode,
				callback : function() {
					$.hh.tree.refresh('tree');
				}
			}
		});
	}
	function doEdit(treeNode) {
		Dialog.open({
			url : 'jsp-edu-testpapertype-TestPaperTypeEdit',
			params : {
				object : treeNode,
				callback : function() {
					$.hh.tree.refresh('tree');
				}
			}
		});
	}
	function doDelete(treeNode) {
		$.hh.tree.deleteData({
			pageid : 'tree',
			action : 'edu-TestPaperType-deleteTreeByIds',
			id : treeNode.id,
			callback : function(result) {
				if (result.success!=false) {
					$('#centerdiv').disabled('请选择要编辑的学段或者学科！');
				}
			}
		});
	}
	function treeClick(treeNode) {
		$('#centerdiv').undisabled();
		var iframe = window.frames[iframeId];
		iframe.callback = function(object) {
			treeNode.name = object.text;
			$.hh.tree.updateNode('tree', treeNode);
			$.hh.tree.getTree('tree').refresh();
		}
		iframe.findData(treeNode.id);
	}
	function init(){
		$('#centerdiv').disabled('请选择要编辑的学段或者学科！');
	}
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west'">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button" config="onClick: doAdd ,text:'添加'"></span> <span
					xtype="button"
					config="onClick: $.hh.tree.doUp , params:{treeid:'tree',action:'edu-TestPaperType-order'}  , textHidden : true,text:'上移' ,icon : 'hh_up' "></span>
				<span xtype="button"
					config="onClick: $.hh.tree.doDown , params:{treeid:'tree',action:'edu-TestPaperType-order'} , textHidden : true,text:'下移' ,icon : 'hh_down' "></span>
				<span xtype="button"
					config="onClick : $.hh.tree.refresh,text : '刷新' ,params: 'tree'  "></span>
			</div>
			<span xtype="tree"
				config=" id:'tree', url:'edu-TestPaperType-queryTreeList' ,remove: doDelete , onClick : treeClick  "></span>
		</div>
		<div style="overflow: visible;" id=centerdiv>
			<iframe id="<%=iframeId%>" name="<%=iframeId%>" width=100%
				height=100% frameborder=0 src="jsp-edu-testpapertype-TestPaperTypeEdit"></iframe>
		</div>
	</div>
</body>
</html>
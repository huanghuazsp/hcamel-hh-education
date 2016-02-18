<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.PrimaryKey"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=BaseSystemUtil.getBaseJs("layout","ztree", "ztree_edit")%>
<%String iframeId = PrimaryKey.getPrimaryKeyUUID();%>

<script type="text/javascript">
	var iframeId = '<%=iframeId%>';
	function doAdd() {
		$('#centerdiv').undisabled();
		var selectNode = $.hh.tree.getSelectNode('tree');
		var iframe = window.frames[iframeId];
		iframe.callback = function() {
			$.hh.tree.refresh('tree');
			$('#centerdiv').disabled('请选择要编辑的树节点或添加新的数据！');
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
			url : 'jsp-edu-knowledge-KnowledgeEdit',
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
			url : 'jsp-edu-knowledge-KnowledgeEdit',
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
			action : 'edu-Knowledge-deleteTreeByIds',
			id : treeNode.id,
			callback : function(result) {
				if (result.success) {
					$('#centerdiv').disabled('请选择要编辑的树节点或添加新的数据！');
				}
			}
		});
	}
	function treeClick(treeNode) {
		$('#centerdiv').undisabled();
		var iframe = window.frames[iframeId];
		iframe.callback = function(object) {
			treeNode.name = object.text;
			treeNode.isParent = object.leaf==1?0:1;
			$.hh.tree.updateNode('tree', treeNode);
			$.hh.tree.getTree('tree').refresh();
		}
		iframe.findData(treeNode.id);
	}
	
	function init(){
		$('#centerdiv').disabled('请选择要编辑的树节点或添加新的数据！');
	}
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west'">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button" config="onClick: doAdd ,text:'添加'"></span> <span
					xtype="button"
					config="onClick: $.hh.tree.doUp , params:{treeid:'tree',action:'edu-Knowledge-order'}  , textHidden : true,text:'上移' ,icon : 'hh_up' "></span>
				<span xtype="button"
					config="onClick: $.hh.tree.doDown , params:{treeid:'tree',action:'edu-Knowledge-order'} , textHidden : true,text:'下移' ,icon : 'hh_down' "></span>
				<span xtype="button"
					config="onClick : $.hh.tree.refresh,text : '刷新' ,params: 'tree'  "></span>
			</div>
			<span xtype="tree"
				config=" id:'tree', url:'edu-Knowledge-queryTreeList' ,remove: doDelete , onClick : treeClick  "></span>
		</div>
		<div style="overflow: visible;" id=centerdiv>
			<iframe id="<%=iframeId%>" name="<%=iframeId%>" width=100%
				height=100% frameborder=0 src="jsp-edu-knowledge-KnowledgeEdit"></iframe>
		</div>
	</div>
</body>
</html>
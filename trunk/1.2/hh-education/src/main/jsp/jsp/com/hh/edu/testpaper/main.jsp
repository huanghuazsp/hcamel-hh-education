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
	function treeClick(treeNode) {
		window.frames[iframeId].iframeClick(treeNode);
	}
	function init(){
	}
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west'">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button"
					config="onClick : $.hh.tree.refresh,text : '刷新' ,params: 'tree'  "></span>
			</div>
			<span xtype="tree"
				config=" id:'tree', url:'edu-TestPaperType-queryTestPagerTreeList' , onClick : treeClick  "></span>
		</div>
		<div style="overflow: visible;" id=centerdiv>
			<iframe id="<%=iframeId%>" name="<%=iframeId%>" width=100%
				height=100% frameborder=0 src="jsp-edu-testpaper-TestPaperList"></iframe>
		</div>
	</div>
</body>
</html>
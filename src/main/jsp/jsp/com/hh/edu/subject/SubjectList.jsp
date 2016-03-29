<%@page import="com.hh.system.util.SystemUtil"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=BaseSystemUtil.getBaseJs()+SystemUtil.getUser()%>

<script type="text/javascript">
	var type1 = '';
	function doDelete() {
		var as = true;
		
		$.hh.pagelist.callRows('pagelist', function(rows) {
			for(var i =0;i<rows.length;i++){
				if(rows[i].vcreate!=loginUser.id){
					as = false;
				}
			}
		});
		
		if(!((loginUser.hhXtJsList && loginUser.hhXtJsList.length==1 && loginUser.hhXtJsList[0].jssx=='student')) || as){
			$.hh.pagelist.deleteData({
				pageid : 'pagelist',
				action : 'edu-Subject-deleteByIds'
			});
		}else{
			Dialog.infomsg("您的权限只能删除本人题目！");
		}
		
	}
	function doSetState() {
		$.hh.pagelist.callRows( 'pagelist', function(rows) {
				var ids = $.hh.objsToStr(rows);
				var data = {};
				data.ids = ids;
				Request.request('edu-Subject-doSetState', {
					data : data
				}, function(result) {
					if (result.success != false) {
						$("#pagelist" ).loadData();
					}
				});
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
			if(!((loginUser.hhXtJsList && loginUser.hhXtJsList.length==1 && loginUser.hhXtJsList[0].jssx=='student' )) ||  row.vcreate==loginUser.id){
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
			}else{
				Dialog.infomsg("您的权限只能修改本人题目！");
			}
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
	
	function renderstate(state){
		if(state==1){
			return '学校题库';
		}else{
			return '个人题库';
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
		<span xtype="button" config="onClick: doSetState ,text:'转入学校题库'  "></span>
	</div>
	<table xtype="form" id="queryForm" style="width:700px;">
		<tr>
			<td xtype="label">题目名称：</td>
			<td><span xtype="text" config=" name : 'text' ,enter: doQuery "></span></td>
			<td xtype="label">题目类型：</td>
			<td><span xtype="combobox"
				config="name: 'titleType'  , data :[ {id:'radio',text:'单选题'} , {id:'check',text:'多选题'} , {id:'fillEmpty',text:'填空题'}  , {id:'shortAnswer',text:'简答题'}  ]"></span></td>
			<td><span
			xtype="button" config="onClick: doQuery ,text:'查询' , itype :'query' "></span></td>
		</tr>
	</table>
	<div id="pagelist" xtype="pagelist"
		config=" url: 'edu-Subject-queryPagingData' ,column : [
		
		{
			name : 'titleType' ,
			text : '题型',
			render : renderTitleType,
			align:'center',
			width:80,
		},{
			name : 'vcreateName' ,
			text : '添加人',
			align:'center',
			width:80,
		},{
			name : 'text' ,
			text : '题目',
			align:'left',
			width:'100%'
		},{
			name : 'answer' ,
			text : '答案',
			align:'center',
			width:80
		},{
			name : 'state' ,
			text : '状态',
			width: 55,
			render : renderstate
		}
		
	]">
	</div>
</body>
</html>
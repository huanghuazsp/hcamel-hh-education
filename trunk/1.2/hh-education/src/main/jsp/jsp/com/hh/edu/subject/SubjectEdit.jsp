<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%@page import="com.hh.system.util.Convert"%>
<%=SystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据编辑</title>
<%=SystemUtil.getBaseJs("checkform","date","ueditor")%>
<%
	String titleType =   request.getParameter("titleType");
	String type =   Convert.toString(request.getParameter("type"));
%>
<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 900;
	var height = 700;

	var objectid = '<%=Convert.toString(request.getParameter("id"))%>';

	function save() {
		$.hh.validation.check('form', function(formData) {
			formData.dataitems = $.hh.toString(formData.dataitems);
			Request.request('edu-Subject-save', {
				data : formData,
				callback : function(result) {
					if (result.success!=false) {
						params.callback(formData);
						Dialog.close();
					}
				}
			});
		});
	}
	
	function renderAnswer(titleType){
		
		if(titleType=='radio'){
			var span = $('<span id="daspan"  xtype="radio" config=" name: \'answer\' ,required :true "></span>');
			$('#answertd').append(span);
			span.render();
		}else if(titleType=='check'){
			var span = $('<span id="daspan"  xtype="checkbox" config=" name: \'answer\' ,required :true "></span>');
			$('#answertd').append(span);
			span.render();
		}else{
			$('#tableitemtr').hide();
			var span = $('<span id="daspan"  xtype="textarea" config=" name: \'answer\' ,required :true ,height:200 "></span>');
			$('#answertd').append(span);
			span.render();
			if(titleType=='fillEmpty'){
				$('#bz').html('例：<br/>题目：【家庭系统存在两种机制，即:\$\{平衡机制\}、\$\{改变机制\}】<br/>答案：\$\{平衡机制\}、\$\{改变机制\}<br/>这样【平衡机制】和【改变机制】就会作为这道题目的填空项');
				$('[name=answer]').height(150);
			}
		}
	}

	function findData() {
		if (objectid) {
			Request.request('edu-Subject-findObjectById', {
				data : {
					id : objectid
				},
				callback : function(result) {
					renderAnswer(result.titleType);
					$('#form').setValue(result);
				}
			});
		}else{
			var titleType = '<%=titleType%>';
			renderAnswer(titleType);
		}
	}

	function init() {
		findData();
	}
	
	function renderRadio(){
			var dataList = $('#span_dataitems').getValue();
			var itemList = [];
			for(var i=0;i<dataList.length;i++){
				var data = dataList[i];
				itemList.push({
					id : i+1,
					text : data.text
				});
			}
			$('#daspan').render({data:itemList});
	}
	
	var textconfig = {
			blur:renderRadio
	};
	
	var tableitemConfig = {
		name : 'dataitems',
		required : true,
		valueType : 'object',
		onChange : renderRadio,
		onSetValue : renderRadio,
		trhtml : '<table width=100%><tr><td><span xtype="textarea" valuekey="text" configVar=" textconfig "></span></td></tr></table>'
	}
	
	function typeChange(data){
		$('#span_knowledgePoint').setValue('');
		$('#span_knowledgePoint').setConfig({params:{'node' : data.id}});
	}
</script>
</head>
<body>
	<div xtype="hh_content">
		<form id="form" xtype="form" class="form">
			<span xtype="text" config=" hidden:true,name : 'id'"></span>
			<span xtype="text" config=" hidden:true,name : 'titleType' ,value:'<%=titleType%>' "></span>
			<div id="bz"></div>
			<table xtype="form">
				<tr>
					<td xtype="label">学科：</td>
					<td colspan="3"><span id="node_span" xtype="selectTree"
						config=" onChange:typeChange, value:'<%=type %>' , name: 'type' , findTextAction : 'edu-TestPaperType-findObjectById' , url : 'edu-TestPaperType-queryTypeTreeList' ,required :true "></span>
					</td>
				</tr>
				<tr>
					<td xtype="label">知识点：</td>
					<td colspan="3"><span xtype="selectTree"
						config=" name: 'knowledgePoint' , findTextAction : 'edu-TestPaperType-findObjectById' , url : 'edu-TestPaperType-queryKnowledgePointTreeList'  "></span>
					</td>
				</tr>
				<tr id="titletr">
					<td xtype="label"></td>
					<td colspan="3"><span xtype="ckeditor" config=" name : 'text',required :true , height : 100 , toolbar : [ 'Source', 'NewPage', 'Maximize',
											'Format',  '-',
											 'Bold', 'Italic',
											'Underline', 'Strike', 'Subscript',
											'Superscript', '-', 'RemoveFormat',
											'JustifyLeft', 'JustifyCenter',
											'JustifyRight', 'JustifyBlock',
											'SpecialChar']"></span></td>
				</tr>
				
				<tr id="tableitemtr">
					<td xtype="label">选择项：</td>
					<td colspan="3"><span xtype="tableitem" configVar="tableitemConfig"></span></td>
				</tr>
				<tr>
					<td xtype="label">答案：</td>
					<td id="answertd" colspan="3"></td>
				</tr>
				<tr id="titletr">
					<td xtype="label">题目图片：</td>
					<td>
					<span xtype="uploadpic" config=" type:'subject', name : 'textpic' ,width:200,height:200 "></span>
					</td>
					<td>
					<span xtype="uploadpic" config=" type:'subject',name : 'textpic2' ,width:200,height:200 "></span>
					</td>
					<td>
					<span xtype="uploadpic" config=" type:'subject',name : 'textpic3' ,width:200,height:200 "></span>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div xtype="toolbar">
		<span xtype="button" config="text:'保存' , onClick : save "></span> <span
			xtype="button" config="text:'取消' , onClick : Dialog.close "></span>
	</div>
</body>
</html>

 
 
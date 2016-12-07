<%@page import="com.hh.system.util.SysParam"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>

<html>
<head>
<title>数据列表</title>
<%=BaseSystemUtil.getMobileBaseJs()%>

<script type="text/javascript">
	var letter = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
			"M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y",
			"Z" ];
	function renderstate(state){
		if(state==1){
			return '[已发布]';
		}else{
			return '[未发布]';
		}
	}
	function renderTitle( data) {
		var text = '<strong>' + data.text.replace(/\n/g, "<br />")
				+ '</strong>' + '<br/>' + '<br/>';
		if (data.textpic) {
			text += '<img alt="" src="system-File-download?params={id:\''
					+ data.textpic + '\'}">';
		}
		if (data.textpic2) {
			text += '<img alt="" src="system-File-download?params={id:\''
					+ data.textpic2 + '\'}">';
		}
		if (data.textpic3) {
			text += '<img alt="" src="system-File-download?params={id:\''
					+ data.textpic3 + '\'}">';
		}
		var table = $('<table style="width:100%;"></table>');
		var tr = $('<tr></tr>');
		var td = $('<td style="text-align:left;"></td>');
		tr.append(td);
		table.append(tr);

		var answerStr = '答案：';
		if (data.titleType == 'radio' || data.titleType == 'check') {
			var dataitems = $.hh.toObject(data.dataitems);
			for (var i = 0; i < dataitems.length; i++) {
				text += '<div style="padding:3px;">&nbsp;' + letter[i] + '.'
						+ dataitems[i].text + '<br/></div>';
			}
			if (data.answer) {
				var answers = data.answer.split(',');
				for (var i = 0; i < answers.length; i++) {
					answerStr += letter[answers[i] - 1];
				}
			}
		} else if (data.titleType == 'fillEmpty') {
			if (data.answer) {
				var answers = data.answer.split("、");
				for (var i = 0; i < answers.length; i++) {
					text = text.replace(answers[i],
							"<input style='width:100px;' />");
				}
				answerStr += data.answer;
			}
		} else if (data.titleType == 'shortAnswer') {
			if (data.answer) {
				answerStr += data.answer;
			}
		}

		td.append(text);

		var tr1 = $('<tr style="display:none;" trid="'+data.id+'"></tr>');
		var td1 = $('<td style="text-align:left;"></td>');
		tr1.append(td1);
		table.append(tr1);
		td1.append('<strong color=green>' + ((answerStr || '').replace(/\n/g, "<br />"))
				+ '</strong>');

		var tr2 = $('<tr></tr>');
		var td2 = $('<td style="text-align:left;border-top: 1.0pt solid windowtext;"></td>');
		tr2.append(td2);
		table.append(tr2);

		var toolbar = renderstate(data.state);
		td2.append(toolbar + '&nbsp;&nbsp;'
				+ (data.createUserName || '') + '&nbsp;&nbsp;'
				+ $.hh.formatDate(data.createTime || '','yyyy-MM-dd HH:mm:ss')
				+ '&nbsp;&nbsp;<a href="javascript:viewAnswer(\'' + data.id
				+ '\')">查看答案</a>');
		return table;
	}
	function viewAnswer(id) {
		$('[trid=' + id + ']').show();
	}

	var list_config = {
		url : "edu-Subject-queryPagingData",
		itemRender : renderTitle,
		columns : [ {
			itemClick : function(data) {
				//console.log(data);
			}
		} ]
	};
</script>
</head>
<body>
	<%=SystemUtil.getMobileHead("[{text:'题目管理',url:'mobilejsp-edu-subject-SubjectList',img:'/hhcommon/images/extjsico/165518104.gif'}]") %>
		<div data-role="content">
			<span id="pagelist" xtype="pagelist" configVar="list_config"></span>
		</div>
	<%=SystemUtil.getMobileDown()%>
</body>
</html>
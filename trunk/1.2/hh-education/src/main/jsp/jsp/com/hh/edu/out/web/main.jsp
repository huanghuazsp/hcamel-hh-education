<%@page import="com.hh.usersystem.bean.usersystem.UsRole"%>
<%@page import="com.hh.usersystem.bean.usersystem.UsUser"%>
<%@page import="com.hh.edu.bean.EduSubject"%>
<%@page import="com.hh.edu.bean.EduTestPaperType"%>
<%@page import="com.hh.edu.service.impl.EduTestPaperTypeService"%>
<%@page import="com.hh.system.util.dto.ParamFactory"%>
<%@page import="com.hh.system.util.dto.ParamInf"%>
<%@page import="com.hh.system.service.impl.BeanFactoryHelper"%>
<%@page import="com.hh.edu.service.impl.EduSubjectService"%>
<%@page import="com.hh.edu.service.impl.EduTestPaperService"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.usersystem.bean.usersystem.UsOrganization"%>
<%@page import="com.hh.system.util.Check"%>
<%@page import="com.hh.system.util.SysParam"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="<%=SysParam.sysParam.getSysIcon2()%>" />
<title><%=SysParam.sysParam.getSysName()%></title>
<link rel="stylesheet" type="text/css" href="edu/Assets/css/reset.css"/>
<%=SystemUtil.getBaseJs()%>
<link id="jqueryuicss" rel="stylesheet" type="text/css" href="/hhcommon/opensource/jquery/jui/themes/start/jquery-ui.css" />
<!--幻灯片-->
<script type="text/javascript" src="edu/Assets/js/js_z.js"></script>
<link rel="stylesheet" type="text/css" href="edu/Assets/css/thems.css">
<!--幻灯片-->
<%
EduTestPaperTypeService eduTestPaperTypeService = BeanFactoryHelper.getBean(EduTestPaperTypeService.class);
EduSubjectService eduSubjectService = BeanFactoryHelper.getBean(EduSubjectService.class);
EduTestPaperService eduTestPaperService = BeanFactoryHelper.getBean(EduTestPaperService.class);

String sysImg = SysParam.sysParam.getSysImg2();
if (Check.isNoEmpty(sysImg)) {
	sysImg = "<img style='width:50px;height:50px;'src=" + sysImg + " />";
}
String type = request.getParameter("type");
if(Check.isEmpty(type)){
	type="subject";
}
List<EduTestPaperType> eduTestPaperTypelist = new ArrayList<EduTestPaperType>();
eduTestPaperTypelist = eduTestPaperTypeService.queryListByProperty("node", "100bada1-ba3e-4792-996b-809704397172");
if("subject".equals(type)){
	eduTestPaperTypeService.converSubjecttText(eduTestPaperTypelist,true);
}else if("testpaper".equals(type)){
	eduTestPaperTypeService.converTestPagerText(eduTestPaperTypelist,true);
}
	

String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
String headpic = "";
UsUser hhXtYh = null;
String objectId="";
if(session.getAttribute("loginuser")!=null){
hhXtYh = (UsUser) session.getAttribute("loginuser");
objectId=hhXtYh.getId();
headpic = hhXtYh.getHeadpic();

List<UsRole> hhXtJsList = hhXtYh.getHhXtJsList();
String jsTextStr = "";
for (UsRole hhXtJs : hhXtJsList) {
	jsTextStr += hhXtJs.getText() + ",";
}
if (!"".equals(jsTextStr)) {
	jsTextStr = "角色【" + jsTextStr.substring(0, jsTextStr.length() - 1) + "】";
}
String orgTextStr = "";
UsOrganization jg = hhXtYh.getOrg();
UsOrganization bm = hhXtYh.getDept();
UsOrganization gw = hhXtYh.getJob();
String str = "";
if (jg != null) {
	str += jg.getName() + "/";
}
if (bm != null) {
	str += bm.getName() + "/";
}
if (gw != null) {
	str += gw.getName() + "/";
}
if (Check.isNoEmpty(str)) {
	str = str.substring(0, str.length() - 1);
	orgTextStr = "所在部门【" + str + "】";
}
String textStr = "";
if (!"".equals(orgTextStr) && !"".equals(jsTextStr)) {
	textStr = jsTextStr + "<br/>" + orgTextStr;
} else {
	if (!"".equals(orgTextStr)) {
		textStr = orgTextStr;
	}
	if (!"".equals(jsTextStr)) {
		textStr = jsTextStr;
	}
}

if (Check.isNoEmpty(headpic) && !headpic.startsWith("/hhcomm")) {
	headpic = "system-File-download?system_open_page_file_form_params={id:'" + headpic + "'}";
}

if (Check.isNoEmpty(headpic)) {
	headpic = " <img id='headpicimg' onClick='updateUser()' style=\"border:1px solid #006894;cursor: pointer;width:50px;height:50px;\" width=\"50\"		height=\"50\"		src=\""
			+ headpic + "\" />";
} else {
	headpic = "<img id='headpicimg' onClick='updateUser()' style=\"border:1px solid #006894;cursor: pointer;width:50px;height:50px;\" width=\"50\"		height=\"50\"		src=\"/hhcommon/images/icons/user/100/no_on_line_user.jpg\" />";
}

}
%>
<script type="text/javascript">
var userId = '<%=objectId%>';
var sysName = '<%=SysParam.sysParam.getSysName()%>';
function updateUser() {
	Dialog.open({
		url : 'jsp-usersystem-user-useredit',
		params : {
			objectId : userId,
			systemmanagerhide : true,
			callback : function(data) {
				$.hh.timeout({
					callback : function() {
						document.location.reload();
					}
				});
			}
		}
	});
}

function login(){
	$.hh.timeout({callback : function() {		document.location.reload();	}});
}

function logout_click() {
	Dialog.confirm({
		message : '您确认要退出系统？',
		callback : function(result) {
			if (result == 1) {
				Request.href("usersystem-login-logoutMain");
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
var letter =  ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
		"P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
		
		
function renderTestPaper(value,data){
	return '<a target="_blank" href="outjsp-edu-web-preview?selfTest='+userId+'&id='+data.id+'">'+value+'</a>';
}	
function renderTestPaperOper(value,data){
	return '<a target="_blank" href="outjsp-edu-web-preview?selfTest='+userId+'&id='+data.id+'">进行测试</a>';
}	

function renderSelfTestExamination(value,data){
	return '<a target="_blank" href="outjsp-edu-web-preview?selfTest='+userId+'&id='+data.testPaperId+'">继续测试</a>';
}

function renderTitle(value,data){
	var text ='<strong>'+ data.text.replace(/\n/g, "<br />")+'</strong>'+'<br/>'+'<br/>';
	if(data.textpic){
		text +='<img alt="" src="system-File-download?system_open_page_file_form_params={id:\''+data.textpic+'\'}">';
	}
	if(data.textpic2){
		text +='<img alt="" src="system-File-download?system_open_page_file_form_params={id:\''+data.textpic2+'\'}">';
	}
	if(data.textpic3){
		text +='<img alt="" src="system-File-download?system_open_page_file_form_params={id:\''+data.textpic3+'\'}">';
	}
	var table =$( '<table style="width:100%;"></table>');
	var tr = $('<tr></tr>');
	var td = $('<td style="text-align:left;"></td>');
	tr.append(td);
	table.append(tr);
	
	var answerStr = '答案：';
	if(data.titleType=='radio' || data.titleType=='check'){
		var dataitems = $.hh.toObject(data.dataitems);
		for(var i=0;i<dataitems.length;i++){
			text += '<div style="padding:3px;">&nbsp;'+ letter[i]+ '.'+dataitems[i].text+'<br/></div>';
		}
		if(data.answer){
			var answers = data.answer.split(',');
			for(var i=0;i<answers.length;i++){
				answerStr+=letter[answers[i]-1];
			}
		}
	}else if(data.titleType=='fillEmpty'){
		if(data.answer){
				var  answers = data.answer.split("、");
				for(var i=0;i<answers.length;i++){
					text = text.replace(answers[i], "<input style='width:100px;' />");
				}
				answerStr+=data.answer;
		}
	}else if(data.titleType=='shortAnswer'){
		if(data.answer){
				answerStr+=data.answer;
		}
	}
	
	td.append(text);
	
	var tr1 = $('<tr style="display:none;" trid="'+data.id+'"></tr>');
	var td1 = $('<td style="text-align:left;"></td>');
	tr1.append(td1);
	table.append(tr1);
	td1.append('<strong>'+((answerStr||'').replace(/\n/g, "<br />"))+'</strong>');
	
	var tr2 = $('<tr></tr>');
	var td2 = $('<td style="text-align:left;border-top: 1.0pt solid windowtext;"></td>');
	tr2.append(td2);
	table.append(tr2);
	
	var toolbar = renderstate(data.state);
	td2.append(toolbar+'&nbsp;&nbsp;&nbsp;&nbsp;'+(data.vcreateName || '')+'&nbsp;&nbsp;&nbsp;&nbsp;'+$.hh.dateTimeToString(data.dcreate || '')+'&nbsp;&nbsp;<a href="javascript:viewAnswer(\''+data.id+'\')">查看答案</a>');
	return table;
}
function viewAnswer(id){
	$('[trid='+id+']').show();
}

function typeClick(type1){
	
	$('#pagelist').loadData({
		params : {type:type1}
	});
}
function search(){
	$('#pagelist').loadData({
		params : {text:$('#searchInput').val()}
	});
}

function fileRenderDownLoad(value,data){
	return '<a href="javascript:Request.download(\''+data.id+'\');">下载</a>';
}
function fileRender(value){
	var table = $('<table></table>');
	
	if(value){
		var fileList = $.hh.toObject(value);
		for(var i=0;i<fileList.length;i++){
			var data = fileList[i];
			var tr = $('<tr></tr>');
			var td = $('<td></td>');
			tr.append(td);
			table.append(tr);
			td.append('<a href="javascript:Request.download(\''+data.id+'\');">'+(data.text||'')+'</a>');
		}
	}
	return table;
}

$(function(){
	<%if(hhXtYh!=null){%>
	var mysetInterval = null;
	var mysetInterval2 = null;

	function loadData() {
		Request
				.request(
						'usersystem-System-loadDataTime',
						{
							doing : false,
							callback : function(result) {
								if (result.success != false == false
										|| result.sessionstatus == 'timeout') {
									clearInterval(mysetInterval);
								} else {
									var message_span = $('#message_span');
									var message = result.message;
									
									var onlineuser = result.onlineuser;
									
									if (message || onlineuser) {
										var messageText = '';
										
										if(onlineuser){
											messageText+='在线<font class=hh_green>'
												+ onlineuser.count
												+ '</font>人;';
										}
										if(message){
											messageText+='您有<font class=hh_red>'
												+ message.count
												+ '</font>条未读消息;';
										}
										
										message_span
												.render({
													'text' : messageText,
													params : message
												});
									}
									
									var allMessage = result.allMessage;
									if (allMessage) {
										try{
											if($.hh.property.mainWindow){
												$.hh.property.mainWindow.renderAllMessage(allMessage);
											}
										}catch(e){
											
										}
									}

									if ( message
											&& ( message.count > 0)) {
										if (mysetInterval2 == null) {
											mysetInterval2 = setInterval(
													function() {
														if (document.title == sysName) {
															document.title = "您有新的未读消息！！";
														} else {
															document.title = sysName;
														}
													}, 700);
										}
									} else {
										document.title = sysName;
										clearInterval(mysetInterval2);
										mysetInterval2 = null;
									}
								}
							}
						});
	}

	setTimeout(function() {
		loadData();
		mysetInterval = setInterval(loadData, 1000 * 60);
	}, 3000);
	
	
	<%
	}
	%>
	
})

function selftesting(){
	if(userId){
		Request.href('outjsp-edu-web-main?type=selftesting');
	}else{
		login();
	}
}

function selftestingHi(){
	if(userId){
		Request.href('outjsp-edu-web-main?type=selftestingHi');
	}else{
		login();
	}
}

function doQuickAdd(){
	Dialog.open({
		url : 'jsp-edu-testpaper-QuickTestPaperEdit',
		params : {
			callback : function() {
				$("#pagelist").loadData();
			}
		}
	});
}
function doAddTestPage() {
	Dialog.open({
		url : 'jsp-edu-testpaper-TestPaperEdit',
		params : {
			callback : function() {
				$("#pagelist").loadData();
			}
		}
	});
}
</script>
</head>
<body>
<!--头部-->
<div class="header">
	<div class="head_m clearfix">
        <div class="logo">
        <table width=600 >
			<tr>
				<td style="width:50px;"><%=sysImg%></td>
				<td style="width:260px;"><font
					style="font-size: 30px; font-weight: 200; padding: 0px 7px; text-shadow: 0 1px 0 #fff;" color=#0095CC><%=SysParam.sysParam.getSysName()%></font>
				</td>
				<%if(hhXtYh!=null){ %>
				<td style="width:40px;">
				</td>
				<td>
				<%=headpic %>
				</td>
				<td style="text-align: left;">欢迎您，<%=hhXtYh.getText()%>！</td>
				<%} %>
			</tr>
		</table>
        <!-- <img src="edu/Assets/images/logo.png" alt="彬之蓝"/> -->
        </div>
        <div class="head_mr" style="text-align">
        	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<%if(hhXtYh==null){ %>
        	<a href="javascript:login()"><font color=#0095CC>登陆</font></a>
        	<%}else{ %>
        	<a href="javascript:logout_click();"><font color=#0095CC>注销</font></a>
        	<%} %>
        	┊<a href="reg.jsp"><font color=#0095CC>注册</font></a>
        	┊<a href="webapp-desktop-jquerydesktop"><font color=#0095CC>进入后台</font></a>
        	</p>
            <div class="search">
            	<form action="" method="post">
                	<input id="searchInput" name="" type="text" placeholder="请输入搜索关键词">
                    <input name="" type=button class="s_btn" value="" onClick="search()" >
                </form>
            </div>
        </div>
    </div>
    <div class="nav clearfix">
    	<div class="nav_l">&nbsp;</div>
        <ul class="nav_m">
            <li <%="subject".equals(type) ?" class=now ":"" %> ><a href="outjsp-edu-web-main?type=subject">题库</a></li>
            <li <%="testpaper".equals(type) ?" class=now ":"" %>><a href="outjsp-edu-web-main?type=testpaper">试卷</a></li>
            <li <%="resources".equals(type) ?" class=now ":"" %>><a href="outjsp-edu-web-main?type=resources">资源库</a></li>
            <li <%="selftesting".equals(type) ?" class=now ":"" %>><a href="javascript:selftesting();">组卷自测</a></li>
            <li <%="selftestingHi".equals(type) ?" class=now ":"" %>><a href="javascript:selftestingHi();">自测存档</a></li>
            <!-- <li><a href="news.html">新闻中心</a></li>
            <li><a href="contact.html">联系我们</a></li>
            <li><a href="book.html">用户留言</a></li> -->
        </ul>
        <div class="nav_r">&nbsp;</div>
    </div>
</div>
<!--头部-->
<!--幻灯片-->
<!-- <div class="banner">
	<div id="inner">
        <div class="hot-event">
        	<div class="event-item" style="display: block;">
                <a target="_blank" href="" class="banner">
                    <img src="edu/Assets/upload/banner.jpg" class="photo" alt="彬之蓝" />
                </a>
            </div>
            <div class="event-item" style="display: none;">
                <a target="_blank" href="" class="banner">
                    <img src="edu/Assets/upload/banner.jpg" class="photo" alt="彬之蓝" />
                </a>
            </div>
            <div class="event-item" style="display: none;">
                <a target="_blank" href="" class="banner">
                    <img src="edu/Assets/upload/banner.jpg" class="photo" alt="彬之蓝" />
                </a>
            </div>
            <div class="event-item" style="display: none;">
                <a target="_blank" href="" class="banner">
                    <img src="edu/Assets/upload/banner.jpg" class="photo" alt="彬之蓝" />
                </a>
            </div>
            <div class="switch-tab">
                <a href="#" onClick="return false;" class="current">1</a>
                <a href="#" onClick="return false;">2</a>
                <a href="#" onClick="return false;">3</a>
                <a href="#" onClick="return false;">4</a>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $('#inner').nav({ t: 6000, a: 500 });
    </script>
</div> -->
<!--幻灯片-->
<div class="space_hx">&nbsp;</div>
<div class="i_main clearfix">
	<ul class="side_nav">
    	<!-- <li class="title f18 yelow">产品导航</li>
        <li><a href="">蓝牙音响方案</a></li>
        <li><a href="">智能小风扇系列产品</a></li>
        <li><a href="">自拍杆系列产品</a></li>
        <li><a href="">蓝牙音响闪灯方案</a></li> -->
        <%
        for(EduTestPaperType eduTestPaperType : eduTestPaperTypelist){
       	 %>
       	   <li><a href="javascript:typeClick('<%= eduTestPaperType.getId()%>')"><%= eduTestPaperType.getText()%></a></li>
       	 <%
        	}
        %>
    </ul>
    <div class="i_about">
    	<!-- <div class="i_about_h f18 yelow"><span>公司简介</span></div>
        <div class="i_about_m">
        	<img src="edu/Assets/upload/pic1.jpg" alt="公司简介" width="171" height="188"/>
            <p>深圳市彬之蓝科技有限公司创立于2007年，是一家集生产、开发，销售为一体的企业。专业研发和生产各种手机配件，蓝牙音响，移动电源类等，产品依靠专业水准的创新设计、优良的产品品质，值得信赖的服务，积极与客户沟通，赢得了广大客户的支持与好评，产品深受国内外市场的欢迎。 质量—我们建立了科学完善的质量管理体系。服务—我们与时俱进，不断提升员工综合素质，科技创新，用心想客户所想，做客户所做，我司的质量方针：质量第一，客户至上，精益求精，持续改进。 诚信—我们本着讲求信誉、恪守承诺的原则与客户共同发展</p>
            <p>我们将全力配合您的步伐，不断超越自我，相信在您的成就中一定能实现我们的美好未来！拥有完整、科学的质量管理体系，深圳市彬之蓝科技有限公司的诚信、实力和产品质量获得业界的认可。欢迎各界朋友莅临参观、指导和业务洽谈.</p>
        </div> -->
        <%
        if("subject".equals(type)){
        	 %>
        	 <div id="pagelist" xtype="pagelist"
				config=" url: 'outedu-OutSubject-queryPagingDataAll' ,title:false,column : [
				
				{
					name : 'text' ,
					text : '题目',
					align:'left',
					render : renderTitle ,
					widthAuto : true
				}
				
			]">
			</div>
        	 <%
        }else if("testpaper".equals(type)){
        	 %>
        	<div id="pagelist" xtype="pagelist"
			config=" url: 'outedu-OutTestPaper-queryPagingDataAll' ,column : [
				{
					name : 'dcreate' ,
					text : '创建时间',
					align:'center',
					width:150,
					render :'datetime'
				},{
					name : 'text' ,
					render : renderTestPaper ,
					text : '试卷名称'
				},{
					name : 'text1' ,
					render : renderTestPaperOper ,
					text : '操作',
					width : 60
				}
				
				
			]">
			</div>
        	 <%
        }else if("resources".equals(type)){
        	 %>
         	<div id="pagelist" xtype="pagelist"
					config=" url: 'outedu-OutResources-queryPagingDataAll' ,column : [
					
					{
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
					},{
						name : 'files1' ,
						align:'left',
						text : '操作',
						render : fileRenderDownLoad,
						width : 40
					}
					
				]">
				</div>

         	 <%
        }else if("selftesting".equals(type)){
       	 %>
       	 <div xtype="toolbar" config="type:'head'">
			<span xtype="button" config="onClick:doAddTestPage,text:'组卷' , itype :'add' "></span>
			<span xtype="button" config="onClick: doQuickAdd ,text:'快速组卷' , itype :'add' "></span>
		</div>
       	<div id="pagelist" xtype="pagelist"
			config=" url: 'edu-TestPaper-queryPagingData' ,column : [
				{
					name : 'dcreate' ,
					text : '创建时间',
					align:'center',
					width:150,
					render :'datetime'
				},{
					name : 'text' ,
					render : renderTestPaper ,
					text : '试卷名称'
				},{
					name : 'text1' ,
					render : renderTestPaperOper ,
					text : '操作',
					width : 60
				}
			]">
			</div>
       	 <%
       }else if("selftestingHi".equals(type)){
         	 %>
           	<div id="pagelist" xtype="pagelist"
    			config=" url: 'outedu-SelfTestExamination-queryPagingData' ,column : [
	    				{
						name : 'dcreate' ,
						text : '测试时间',
						align:'center',
						width:150,
						render :'datetime'
					},{
						name : 'testPaperName' ,
						text : '试卷名称'
					},{
						name : 'text1' ,
						render : renderSelfTestExamination ,
						text : '操作',
						width : 60
					}
    			]">
    			</div>
           	 <%
           }
        %>
		
		
    </div>
</div>
<div class="space_hx">&nbsp;</div>
<!-- <div class="pro_gd">
	<div id="marquee1" class="marqueeleft">
        <div class="mar_m clearfix">
            <ul id="marquee1_1">
                <li>
                    <a class="pic" href=""><img src="edu/Assets/upload/pic2.jpg" alt="产品名称" title="产品名称"/></a>
                </li>
                <li>
                    <a class="pic" href=""><img src="edu/Assets/upload/pic2.jpg" alt="产品名称" title="产品名称"/></a>
                </li>
                <li>
                    <a class="pic" href=""><img src="edu/Assets/upload/pic2.jpg" alt="产品名称" title="产品名称"/></a>
                </li>
                <li>
                    <a class="pic" href=""><img src="edu/Assets/upload/pic2.jpg" alt="产品名称" title="产品名称"/></a>
                </li>
                <li>
                    <a class="pic" href=""><img src="edu/Assets/upload/pic2.jpg" alt="产品名称" title="产品名称"/></a>
                </li>
                <li>
                    <a class="pic" href=""><img src="edu/Assets/upload/pic2.jpg" alt="产品名称" title="产品名称"/></a>
                </li>
                <li>
                    <a class="pic" href=""><img src="edu/Assets/upload/pic2.jpg" alt="产品名称" title="产品名称"/></a>
                </li>
            </ul>   
            <ul id="marquee1_2"></ul>
        </div>
    </div>
    <script type="text/javascript">marqueeStart(1, "left");</script>
</div> -->
<div class="space_hx">&nbsp;</div>
<div class="foot">
	版权所有：XXXXXXXXX
    <span>XXICP备XXXXXX</span>
</div>
<script language="javascript">
$(function(){
	
})
</script>
</body>
</html>
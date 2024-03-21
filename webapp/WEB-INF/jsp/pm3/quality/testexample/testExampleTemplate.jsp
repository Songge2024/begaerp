
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	String userid = userModel.getId().toString();
%>
<%
	//获取当前时间
	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();
	String time = simpleDateFormat.format(currentTime).toString();
	request.setAttribute("time", time);
%>
<aos:html title="测试用例模板导入管理" base="http" lib="ext,ueditor">
<aos:body>

</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="west" bodyBorder="1 1 0 0" collapsible="false" collapseMode="mini"
			split="false"  width="700" maxWidth="1000" >
			<aos:panel margin="1" layout="border" border="false">
				<aos:formpanel  region="north" layout="column" height="93" bodyBorder="0 0 0 0"  id="export_form_template">
					<%@ include file="testExampleSourceTemplate/selectSourceTemplateProject_form.jsp"%>
				</aos:formpanel>
				<aos:gridpanel id="export_example_template" anchor="100%" region="center" headerBorder="1 0 0 1" bodyBorder="1 0 1 1"
				 	title="选择需要导入的测试用例" url="testExampleService.getExportModule" forceFit="false" hidePagebar="true">
					<%@ include file="testExampleSourceTemplate/testExampleSourceTemplate_columns.jsp"%>
				</aos:gridpanel>
				<aos:panel region="west" headerBorder="1 1 1 0" bodyBorder="0 1 0 0" collapsible="false" collapseMode="mini"
					split="true"  width="200" maxWidth="500">
					<%@ include file="testExampleSourceTemplate/selectSourceTemplateModule.jsp"%>
				</aos:panel>
			</aos:panel>
		</aos:panel>
		
		<aos:panel region="center" bodyBorder="1 0 0 1" collapsible="false" collapseMode="mini"
			split="false"  width="700" maxWidth="1000">
			<aos:panel margin="1" layout="border" border="false">
				<aos:formpanel id="import_form_template" region="north" height="93" bodyBorder="0 0 1 0" layout="column" >
					<%@ include file="testExampleDemandTemplate/selectDemandTemplateProject_form.jsp"%>
				</aos:formpanel>

				<aos:gridpanel id="import_example_template" region="center" headerBorder="1 0 0 1" bodyBorder="1 0 0 1"  
					 forceFit="false" url="testExampleService.getImportModule" title="选择需要移除的测试用例" hidePagebar="true" >
					<%@ include file="testExampleDemandTemplate/testExampleDemandTemplate_columns.jsp"%>
				</aos:gridpanel>

				<aos:panel region="west" headerBorder="0 1 1 0" bodyBorder="0 1 0 0" collapsible="false" collapseMode="mini"
					split="true" width="200" maxWidth="500">
					<%@ include file="testExampleDemandTemplate/selectDemandTemplateModule.jsp"%>
				</aos:panel>
			</aos:panel>
		</aos:panel>
	</aos:viewport>
	
	<script type="text/javascript">
		//加载被导出的测试用例模板
		function export_module(){
			var proj_id = export_id_proj_name.value;
			if(AOS.empty(proj_id)){
				return;
			}
			var params = {proj_id : proj_id};
			export_example_template_store.getProxy().extraParams = params;
			export_example_template_store.loadPage(1);
		}
		
		function import_module(){
			var proj_id = import_id_proj_name.value;
			if(AOS.empty(proj_id)){
				return;
			}
			var params = {proj_id : proj_id};
			import_example_template_store.getProxy().extraParams = params;
			import_example_template_store.loadPage(1);
		}
	</script>
	
</aos:onready>


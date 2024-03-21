<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="demandAction_create_win" 
	title="新增re_demand_action"
	autoScroll="true"
>
	<aos:formpanel 
		id="demandAction_create_form"
	 	width="800"
	 	height="410"
	  	layout="column" 
	  	labelWidth="120"
	  	autoScroll="true"
	  	msgTarget="qtip"
	>
	<%@ include file="demandAction_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="demandAction_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#demandAction_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

<aos:window id="w_org_find" title="模块树[双击选择]" height="-60" layout="fit" autoScroll="true" onshow="t_org_find_refresh">
			<aos:treepanel id="t_org_find" singleClick="false" width="320" bodyBorder="0 0 0 0" url="projTypesService.getModuleDivideTreeData" rootVisible="false" onitemdblclick="t_org_find_select" />
</aos:window>

<aos:window id="demand_importExcle_win" title="导入测试用例">
	<aos:formpanel id="demand_importExcle_form" width="450" layout="anchor" labelWidth="70">
		<aos:filefield id="excel_file" name="excel_file" fieldLabel="文件路径"  buttonText="选择" labelWidth="60" allowBlank="false" />
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="demand_importExcle_save" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#demand_importExcle_win.hide();" text="关闭"   icon="close.png" />
	</aos:docked>
</aos:window>

<!-- 上传窗口 -->
<aos:window id="WBS_excel_win" title="上传窗口">
	<aos:formpanel id="WBS_excel_win_form" width="450" layout="anchor" labelWidth="120">
		<aos:filefield id="WBS_excel_file" name="WBS_excel_file" fieldLabel="文件路径" buttonText="选择"  labelWidth="100" allowBlank="false"/>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="WBS_excel_win_save" text="上传" icon="ok.png" />
		<aos:dockeditem onclick="#WBS_excel_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>



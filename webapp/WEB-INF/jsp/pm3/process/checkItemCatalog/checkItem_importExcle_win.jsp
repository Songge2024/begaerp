<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkItem_importExcle_win" 
	title="导入检查项"
>
	<aos:formpanel 
		id="importExcle_form" 
		width="450" 
		layout="anchor"
		labelWidth="70"
	>
		<aos:filefield id="excel_file" name="excel_file" fieldLabel="文件路径"   buttonText="选择" labelWidth="60" allowBlank="false" />
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkItem_importExcle_save" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkItem_importExcle_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>

<!-- 上传窗口 -->
<aos:window id="checkItem_excel_win" title="上传窗口">
	<aos:formpanel id="checkItem_excel_win_form" width="450" layout="anchor" labelWidth="120">
		<aos:filefield id="checkItem_excel_file" name="checkItem_excel_file" fieldLabel="文件路径" buttonText="选择"  labelWidth="100" allowBlank="false"/>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkItem_excel_win_save" text="上传" icon="ok.png" />
		<aos:dockeditem onclick="#checkItem_excel_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
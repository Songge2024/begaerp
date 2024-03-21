<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %> 
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	String userid = userModel.getId().toString();
%>
<aos:html title="增删改查" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="f_query"   labelWidth="70" header="false" region="north" border="false" anchor= "100%" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:combobox fieldLabel="项目名称" name="proj_id" editable="true" columnWidth="0.25" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" />
			<aos:combobox fieldLabel="会议方式" name="review_type"  columnWidth="0.25" >
				<aos:option value="1" display="现场会议" />
				<aos:option value="2" display="远程会议" />
				<aos:option value="3" display="其他" />
			</aos:combobox>
			<aos:combobox fieldLabel="会议类型" name="meeting_type"  columnWidth="0.25" >
				<aos:option value="1" display="项目周例会" />
				<aos:option value="2" display="评审会议" />
				<aos:option value="3" display="专题会议" />
				<aos:option value="4" display="其他" />
			</aos:combobox>
			<aos:textfield name="theme" fieldLabel="主题" columnWidth="0.2" />
			<aos:textfield name="attende_mans" fieldLabel="参与人" columnWidth="0.25" />
			<aos:hiddenfield name="create_name" fieldLabel="创建人" columnWidth="0.2" />
			<aos:datefield name="beginDate_" fieldLabel="开始时间" columnWidth="0.25"  onchange="changeweekDt"/>
			<aos:datefield name="endDate_" fieldLabel="结束时间" columnWidth="0.25"  onchange="changeweekDt" />
			<aos:dockeditem xtype="button" text="查询" onclick="g_account_query" icon="query.png" columnWidth="0.1" margin="0 0 10 10"/>
		    <aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(f_query);" icon="refresh.png" columnWidth="0.1"  margin="0 0 10 10"/>
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
		<aos:gridpanel id="g_account" autoScroll="true" url="filesManageService.page" forceFit="false" onrender="g_account_query" onitemdblclick="#w_account_u.show();" region="center">
			<aos:docked forceBoder="1 0 1 0"   >
				<aos:dockeditem xtype="tbtext" text="会议列表" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增" icon="add.png" onclick="w_account_onshow" />
				<aos:dockeditem text="总结" icon="edit.png" onclick="#w_account_over.show();" />
				<aos:dockeditem text="删除" icon="del.png" onclick="g_acount_del" />
				<aos:dockeditem text="修改" icon="edit.png" onclick="#w_account_u.show();" />
			    <aos:dockeditem text="发起" icon="ok.png" onclick="c_commit_count" />
			    <aos:dockeditem text="撤回" icon="down.png" onclick="recall_count" />
			    <aos:dockeditem xtype="tbseparator" />  
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="修改"  icon="edit.png" onclick="#w_account_u.show();" />
				<aos:menuitem text="删除" icon="del.png" onclick="g_acount_del" />
				<aos:menuitem text="总结" icon="edit.png" onclick="#w_account_over.show();" />
				<aos:menuitem text="发起" icon="ok.png" onclick="c_commit_count" />
				<aos:menuitem text="撤回" icon="down.png" onclick="recall_count" />
			</aos:menu>
			<aos:selmodel type="checkbox" mode="multi"  />
			<aos:plugins>
			</aos:plugins>
			<aos:column type="rowno"  />  
			<aos:column header="文档地址" dataIndex="file_addr" hidden="true"/>
			<aos:column header="评审ID" dataIndex="manage_id" hidden="true"/>
			<aos:column header="评审编码" dataIndex="manage_code" hidden="true"/>
			<aos:column header="参与人(外部)" dataIndex="attende_mans_out" hidden="true"/>
			<aos:column header="主持人" dataIndex="compere" hidden="true"/>
			<aos:column header="回复消息编码" dataIndex="opinion_code" hidden="true"/>
			<aos:column header="参与人员ID" dataIndex="attende_id" hidden="true"/>
			<aos:column header="评论开始时间" dataIndex="manage_begin_date" fixedWidth="100"  hidden="true"/>
			<aos:column header="发起人" dataIndex="initiator" hidden="true"/>
			<aos:column header="状态" dataIndex="state_flag" align="center" rendererFn="fn_balance_state_flag" width="100"/>
			<aos:column header="主题" celltip="true" dataIndex="theme" width="180" rendererFn="fn_files_manage"/>
			<aos:column header="会议方式" dataIndex="review_type" align="center" rendererFn="fn_balance_review_type" />
			<aos:column header="会议类型" dataIndex="meeting_type" align="center" rendererFn="fn_balance_meeting_type"/>
			<aos:column header="开始时间" dataIndex="begin_date" width="180" align="center"/>
			<aos:column header="结束时间" dataIndex="end_date" width="180"  align="center"/>
			<aos:column header="用时（天）" dataIndex="workload" width="180"  align="center"/>
			<aos:column header="参与人（内部）" dataIndex="attende_mans" align="center" width="150" celltip="true"/>
			<aos:column header="参与人（外部）" dataIndex="attende_mans_out" align="center" width="150" celltip="true"/>
			<aos:column header="会议说明"  dataIndex="file_note" width="280" align="left"/>
			<aos:column header="是否通过" dataIndex="pass_flag" width="100" align="center" rendererFn="fn_balance_pass_flag"/>
			<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true"/>
			<aos:column header="项目" dataIndex="proj_name" width="150" align="left"/>
			<aos:column header="主持人" dataIndex="name"  align="center"  width="100" />
			<aos:column header="发起人" dataIndex="initiator_id" align="center"  width="100"/>
			<aos:column header="评论结束时间" dataIndex="manage_end_date" fixedWidth="180" align="center"/>
		    <aos:column header="评审结果" dataIndex="result" rendererFn="fn_balance_result"  width="200" align="left"/>
		    <aos:column header="地点"  dataIndex="review_addre" width="100" />
		    <aos:column header="附件下载"  width="120" rendererFn="attachment_download" align="center"/>
		    <aos:column header="历史记录"  width="120" rendererFn="historical_record" align="center"/>
		    <aos:column header="备注" dataIndex="remarks"  width="280"/>
			<aos:column header="新增人ID" dataIndex="create_name"  hidden="true"/>
			<aos:column header="新增时间" dataIndex="create_time" type="date" format="Y-m-d" hidden="true"/>
	    </aos:gridpanel>
		    
		<%-- 上传窗口 --%>
		<aos:window id="excel_win" title="上传模版">
			<aos:formpanel id="excel_win_form" width="450" layout="anchor" labelWidth="120">
				<aos:filefield id="excel_file" name = "excel_file" fieldLabel="文件路径" buttonText="选择" labelWidth="100" allowBlank="false"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="excel_win_save_s" text="上传" icon="ok.png" />
				<aos:dockeditem onclick="#excel_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<%-- 附件窗口 --%>
		<aos:window id="w_account_upload" title="附件信息" width="800" layout="border" height="520" draggable="false" onshow="aosUpload_grid_query()" onhide="aosUpload_grid_onhide">
			<aos:formpanel id="query_form" layout="column" labelWidth="70" header="false"  height="0" border="false">
				<aos:hiddenfield  emptyText="评审附件关联字段" name="manin_id"   columnWidth="0.5"/>
			</aos:formpanel>
		    <aos:gridpanel id="aosUpload_grid" url="aosUploadService.page" onrender="aosUpload_grid_query" forceFit="true" region="center"  bodyBorder="1 0 1 0">
				<aos:menu>
					<aos:menuitem text="上传" onclick="#excel_win.show();" icon="add.png" />
					<aos:menuitem text="删除" onclick="card_grid_del" icon="del.png" />
					<aos:menuitem xtype="menuseparator" />
					<aos:menuitem text="刷新" onclick="#aosUpload_grid_store.reload();" icon="refresh.png" />
				</aos:menu>
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="附件信息" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="上传" icon="add.png" onclick="#excel_win.show();" />
					<aos:dockeditem text="删除" icon="del.png" onclick="card_grid_del" />
				</aos:docked>
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column type="rowno" />
				<aos:column header="编号" dataIndex="fileid" fixedWidth="100" hidden="true"/>
				<aos:column header="标题" dataIndex="title" width="100" />
				<aos:column header="文件访问路径" dataIndex="loadurl" celltip="true" hidden="true"/>
				<aos:column header="文件保存路径" dataIndex="path" celltip="true" fixedWidth="250" hidden="true"/>
				<aos:column header="文件大小(字节)" dataIndex="filesize" fixedWidth="150"/>
				<aos:column header="备注" dataIndex="remark" celltip="true" fixedWidth="150" hidden="true"/>
				<aos:column header="评审附件关联字段" dataIndex="manin_id" hidden="true"/>
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#w_account_upload.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<%-- 新增窗口 --%>
		<aos:window id="w_account" title="新增会议信息" width="1000" layout="anchor" autoScroll="true" height="500" draggable="false" onhide="w_account_onhide" onshow="w_account_on_show"   >
			<aos:formpanel id="f_account" msgTarget="qtip"  anchor="100% 100%"   columnWidth="1" layout="column"  labelWidth="85">
				<aos:hiddenfield name="manage_id" fieldLabel="会议id"/>
				<aos:hiddenfield name="fileid" fieldLabel="会议id"/>
				<aos:hiddenfield name="upload_state" fieldLabel="判断是否是新增窗口隐藏点击的是关闭按钮还是保存按钮" value="0"/>
				<aos:hiddenfield name="manage_code" fieldLabel="评审编码" columnWidth="1"/>
				<aos:textfield   fieldLabel="主题" name="theme" maxLength="255" allowBlank="false" margin="5" columnWidth="1"  />
				<aos:combobox fieldLabel="项目名称" name="proj_id" margin="5" allowBlank="false" editable="true" columnWidth="0.33" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" />
			    <aos:combobox  id="id_review_type"  name="review_type" fieldLabel="会议方式" allowBlank="false" margin="5"  columnWidth="0.33">
					<aos:option value="1" display="现场会议" />
					<aos:option value="2" display="远程会议" />
					<aos:option value="3" display="其他" />
			    </aos:combobox>
			    <aos:combobox fieldLabel="会议类型" name="meeting_type" allowBlank="false" columnWidth="0.33" margin="5">
					<aos:option value="1" display="项目周例会" />
					<aos:option value="2" display="评审会议" />
					<aos:option value="3" display="专题会议" />
					<aos:option value="4" display="其他" />
				</aos:combobox>
			    <aos:datetimefield   name="begin_date" fieldLabel="开始时间" editable="false" allowBlank="false" columnWidth="0.4" margin="5"/>
	            <aos:datetimefield name="end_date" fieldLabel="结束时间" editable="false" allowBlank="false" columnWidth="0.4" margin="5"/>
	            <aos:numberfield fieldLabel="消耗天数" name="workload" margin="5" columnWidth="0.2" editable="true" step="0.1" decimalPrecision="1"  minValue="0.1" maxValue="999" allowBlank="false"/>
<%-- 	            <aos:checkboxgroup   id="id_okManage"  onchange="fn_flag_m_onchange"   fieldLabel="在线会议" columns="[70]" columnWidth="0.12"> --%>
<%-- 					<aos:checkbox name="flag_m" boxLabel=""  inputValue="1"  /> --%>
<%-- 				</aos:checkboxgroup> --%>
	            <aos:datetimefield   id="id_manage_end_date" fieldLabel="评论结束时间" name="manage_end_date" onchange="fn_manage_chang"  allowBlank="true"  columnWidth="0.3" margin="5" />
			   	<aos:textfield fieldLabel="会议地点" name="review_addre" margin="5" columnWidth="1" maxLength="255" />
			    <aos:hiddenfield name="attende_id" />
	            <aos:triggerfield fieldLabel="参与人(内部)" name="name_desc" editable="false" allowBlank="false" trigger1Cls="x-form-search-trigger" margin="5" onTrigger1Click="w_account_find_show" columnWidth="1" />    
	            <aos:combobox id="id_compere" queryMode="local" typeAhead="true" forceSelection="true" fieldLabel="主持人" allowBlank="false" name="compere" editable="true" margin="5" columnWidth=".4" url="filesManageService.listComboBoxProjId"  />
	            <aos:textfield fieldLabel="参与人(外部)"   name="attende_mans_out"  labelWidth="75"  allowBlank="true"  margin="5"  maxLength="50" columnWidth="0.5"  />
	            <aos:dockeditem xtype="button" text="附件" onclick="#w_account_upload.show()"  columnWidth="0.1" margin="5"/>
	            <aos:fieldset title="会议说明"  columnWidth="1" margin="5">
			    	<aos:htmleditor name="file_note" columnWidth="1"  margin="5"/>
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="excel_win_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#w_account.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		 </aos:window>
		 
	    <%-- 	<%@ include file="/WEB-INF/jsp/public/public_bs_proj_teams_win.jsp"%> --%>
		<%-- 修改窗口 --%>
		<aos:window id="w_account_u" title="修改会议信息"  width="1000" layout="anchor" autoScroll="true" height="450"     
					draggable="false"   onshow="w_account_u_onshow"   onhide="w_account_u_onhide" >
			<aos:formpanel id="f_account_u" msgTarget="qtip"  anchor="100% 100%"   columnWidth="1" layout="column"  labelWidth="85">
				<aos:hiddenfield name="manage_id" fieldLabel="评审id"   />
				<aos:hiddenfield name="manage_code" fieldLabel="评审编码" />
				<aos:hiddenfield name="flag_values" fieldLabel="索引标记"   />
				<aos:textfield   fieldLabel="主题" name="theme"   allowBlank="false"  margin="5" columnWidth="1"  />
				<aos:combobox fieldLabel="项目名称" name="proj_id" margin="5" allowBlank="false" editable="true" columnWidth="0.33" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" />
				<aos:combobox  id="id_review_types"  name="review_type" fieldLabel="会议方式" allowBlank="false" margin="5"  columnWidth="0.33">
					<aos:option value="1" display="现场会议" />
					<aos:option value="2" display="远程会议" />
					<aos:option value="3" display="其他" />
				</aos:combobox>
				<aos:combobox fieldLabel="会议类型" name="meeting_type" allowBlank="false" columnWidth="0.33" margin="5">
					<aos:option value="1" display="项目周例会" />
					<aos:option value="2" display="评审会议" />
					<aos:option value="3" display="专题会议" />
					<aos:option value="4" display="其他" />
				</aos:combobox>
				<aos:datetimefield   name="begin_date" fieldLabel="开始时间" editable="false"  onchange="fn_judge_over" allowBlank="false" columnWidth="0.4" margin="5"/>
				<aos:datetimefield name="end_date"  fieldLabel="结束时间" editable="false"  onchange="fn_judge_over" allowBlank="false" columnWidth="0.4" margin="5"/>
				<aos:numberfield fieldLabel="消耗天数" name="workload" margin="5" columnWidth="0.2" editable="true" step="0.1" decimalPrecision="1"  minValue="0.1" maxValue="999" allowBlank="false"/>
<%-- 	          	<aos:checkboxgroup   id="id_okManages"  onchange="fn_flag_m_onchange_over"  fieldLabel="在线评审" columns="[70]" columnWidth="0.12"> --%>
<%-- 					<aos:checkbox  id="id_ok" name="flag_m" boxLabel=""  inputValue="1"  /> --%>
<%-- 				</aos:checkboxgroup> --%>
				<aos:datetimefield  id=  "id_manage_end_dates"     fieldLabel="评论结束时间"   name="manage_end_date"    allowBlank="true"  columnWidth="0.3" margin="5" />				
				<aos:textfield   fieldLabel=" 会议地点" name="review_addre"    margin="5" columnWidth="1" maxLength="255"  />
				<aos:hiddenfield name="attende_id" />
				<aos:triggerfield fieldLabel="参与人(内部)" name="name_desc"   allowBlank="false"  editable="false" trigger1Cls="x-form-search-trigger" margin="5"  onTrigger1Click="w_account_find_show" columnWidth="1" />
				<aos:combobox id="id_comperes" fieldLabel="主持人" selectOnFocus ="true" name="compere" editable="true" margin="5" columnWidth=".4" 
				       typeAhead="true" forceSelection="true" url="filesManageService.listComboBoxProjId"  />
				<aos:textfield   fieldLabel="参与人(外部)" name="attende_mans_out"   maxLength="50" labelWidth="75"  allowBlank="true"  margin="5" columnWidth="0.5"  />
				<aos:dockeditem xtype="button" text="附件" onclick="#w_account_upload.show()"  columnWidth="0.1" margin="5"/>
				<aos:fieldset title="会议说明"  columnWidth="1" margin="5">
					<aos:htmleditor name="file_note" columnWidth="1"  margin="5"   />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="f_account_update" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#w_account_u.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<%-- 评审结论 --%>
		<aos:window id="w_account_over" title="评审结论信息" width="1000" layout="anchor" autoScroll="true" height="500" draggable="false"  onshow="w_account_over_onshow">
				<aos:formpanel id="f_account_over" anchor="100% 100%" layout="anchor"  labelWidth="65">
					<aos:hiddenfield name="manage_id" fieldLabel="评审id"/>
					<aos:hiddenfield name="flag_values" fieldLabel="索引标记"/>
					<aos:hiddenfield name="initiator_id" fieldLabel="发起人"/>
					<aos:hiddenfield name="manage_code" fieldLabel="评审编码" />
					<aos:fieldset title="基础信息" columnWidth="1" margin="10">
						<aos:datetimefield name="begin_date" fieldLabel="开始时间" editable="false" readOnly="true" allowBlank="false" columnWidth="0.3" margin="5"/>
			            <aos:datetimefield name="end_date" fieldLabel="结束时间" editable="false" readOnly="true" allowBlank="false" columnWidth="0.3" margin="5"/>
			            <aos:textfield fieldLabel="主持人" name="name" readOnly="true"  margin="5" columnWidth=".4" />
			            <aos:textfield fieldLabel="参与人员" name="attende_mans" readOnly="true" allowBlank="true" margin="5" columnWidth="1"  />
		          	</aos:fieldset>
					<aos:fieldset title="评审意见"  columnWidth="1" margin="5">
				      	<aos:textfield name="pass_daitil" fieldLabel="汇总" columnWidth="1" labelWidth="45" margin="5"/>
						<aos:htmleditor name="opinion" columnWidth="1" margin="5"/>
					</aos:fieldset>
					<aos:fieldset title="评审结果 "  columnWidth="1" margin="5">
						<aos:radioboxgroup fieldLabel="是否通过" columns="[60,80]" columnWidth="0.5">
						<aos:radiobox name="pass_flag" boxLabel="不通过" inputValue="1" />
								<aos:radiobox name="pass_flag" boxLabel="通过" inputValue="2" />
						</aos:radioboxgroup>
						<aos:htmleditor name="result" columnWidth="1" margin="10" height="100"  />
					</aos:fieldset>
				</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="f_save_update" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#w_account_over.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		
		<%-- 通过这个弹窗表单演示再查询一次DB加载数据的方法 --%>
		<aos:window id="w_user" title="部门人员详情（双击）" width="1000" height="500" layout="border" onshow="w_user_onshow"   >
			<aos:gridpanel hidePagebar="true" id="g_aosuser" url="filesManageService.query_aos_user_corp" onitemdblclick="add_contract_grid" width="450" onrender="g_user_query" region="west" >
				<aos:docked forceBoder="0 0 1 0">
			    	<aos:triggerfield emptyText="姓名" id="id_name" onenterkey="g_user_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="g_user_query" width="180" />
		        	<aos:combobox id="search_principal_org" name="subordinate_departments" editable="false" width="150" queryMode="local" 
						url="filesManageService.listPrincipalOrg" emptyText="部门查询" onselect="fn_org"/>
		        </aos:docked> 
				<aos:selmodel type="row" mode="multi" />
				<aos:column type="rowno" width="30"/>
				<aos:column header="姓名" dataIndex="user_name" width="80"/>
				<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
				<aos:column header="所属组织" dataIndex="org_name" width="120" />
				<aos:column header="所属角色" dataIndex="role_name"  width="120" />
				<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
				<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80"  hidden="true"/>
				<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="80" hidden="true" />
			</aos:gridpanel>
			<aos:gridpanel id="g_aosuser_corp"   hidePagebar="true" url="filesManageService.query_aos_user" headerBorder="0 0 0 1"  bodyBorder="0 0 0 0" onitemdblclick="del_contract_grid"  width="450"  onrender="g_user_query_corp"  region="center" >
				<aos:docked forceBoder="0 0 1 0"   >
					<aos:checkbox boxLabel="常用联系人" id="id_top" onchange="g_aosuser_corp_query"  checked="false" value="false"/>
			    </aos:docked>
				<aos:selmodel type="row" mode="multi" />
				<aos:column type="rowno" width="30"/>
				<aos:column header="姓名" dataIndex="user_name" width="80"/>
				<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
				<aos:column header="所属组织" dataIndex="org_name" width="120" />
				<aos:column header="所属角色" dataIndex="role_name"  width="120" />
				<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
				<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80" hidden="true"/>
				<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="1000"  hidden="true"/>
			</aos:gridpanel>
			<aos:gridpanel id="top_grid" hidePagebar="true" width="450" url="filesManageService.topContactsPage" onitemdblclick="top_contract_grid" region="west" onrender="top_grid_query">
				<aos:docked forceBoder="0 0 1 0">
					<aos:triggerfield emptyText="常用联系人姓名查询" id="top_user_name" onenterkey="top_user_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="top_user_query" width="180" />
		        	<aos:combobox id="top_principal_org" name="subordinate_departments" editable="false" width="150" queryMode="local" 
						url="filesManageService.listPrincipalOrg" emptyText="常用联系人部门查询" onselect="top_org"/>
		        </aos:docked> 
				<aos:selmodel type="row" mode="multi" />
				<aos:column type="rowno" width="30"/>
				<aos:column header="姓名" dataIndex="user_name" width="80"/>
				<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
				<aos:column header="所属组织" dataIndex="org_name" width="120" />
				<aos:column header="所属角色" dataIndex="role_name"  width="120" />
				<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
				<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80"  hidden="true"/>
				<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="80" hidden="true" />
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="personnel_save()" text="保存数据" icon="ok.png" />
				<aos:dockeditem onclick="#w_user.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:window id="details_appendix" width="650" height="500"  title="会议附件详情窗口" onshow="details_appendix_grid_query">
			<aos:gridpanel id="details_appendix_grid" forceFit="false" border="true" url="filesManageService.meetingAttachmentPage" onrender="details_appendix_grid_query">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="文件列表"/>
					<aos:dockeditem xtype="tbseparator"/>
					<aos:dockeditem text="下载" icon="down.png" onclick="g_acount_down"/>
				</aos:docked>
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column type="rowno"/>
				<aos:column header="文件ID" dataIndex="fileid" width="100" hidden="true"/>
				<aos:column header="文件标题" dataIndex="title" fixedWidth="500" />
				<aos:column header="文件大小" dataIndex="filesize" fixedWidth="100" align="right" rendererFn="fn_gzldw"/>
				<aos:column header="备注" dataIndex="remark" width="100" hidden="true"/>
				<aos:column header="文件访问路径" dataIndex="loadurl" width="100" hidden="true"/>
				<aos:column header="评审附件关联字段" dataIndex="manin_id" width="100" hidden="true"/>
				<aos:column header="文件编码" dataIndex="manage_code" width="100" hidden="true"/>
				<aos:column header="文件存储相对路径" dataIndex="path" width="500" hidden="true"/>
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#details_appendix.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:window id="record_view" width="650" height="500"  title="历史记录详情窗口" onshow="filesLogs_query">
			<aos:gridpanel id="filesLogs_grid" url="filesManageLogsService.page" onrender="filesLogs_query" forceFit="true" region="center" bodyBorder="1 0 1 0">
				<aos:selmodel type="checkbox" mode="multi"/>
				<aos:column header="会议ID" dataIndex="manage_id" width="100" hidden="true"/>
				<aos:column header="序号" dataIndex="serial_no" width="80" />
				<aos:column header="描述" dataIndex="content" width="100" flex="1" />
				<aos:column header="时间" dataIndex="update_time" width="150" format="Y-m-d h:i:s"/>
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#record_view.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
	</aos:viewport>
<script type="text/javascript">
	//会议信息
	function details_appendix_grid_query(){
// 			var record = AOS.select(g_account,true)[0];
// 			console.log(record);
// 			var params = new Object();
//         	params.manin_id = record.data.manage_code;
       	var record = AOS.selectone(g_account, true);
       	var manage_code = record.data.manage_code;
		details_appendix_grid_store.getProxy().extraParams = {manin_id : manage_code};
		details_appendix_grid_store.loadPage(1);
	}
		
	//历史记录
	function filesLogs_query(){
		var record = AOS.selectone(g_account, true);
       	var manage_id = record.data.manage_id;
       	filesLogs_grid_store.getProxy().extraParams = {manage_id : manage_id};
       	filesLogs_grid_store.loadPage(1);
	}
	
    //新增窗口显示
    function  w_account_on_show(){
		id_manage_end_date.hide();
    }
    
	//线下禁用组键
	function fn_flag_m_onchange(){
		var flag_m=AOS.get('id_okManage').getValue().flag_m;
		if(flag_m==1){
			id_manage_end_date.show();
		}else{
			AOS.setValue('f_account.manage_end_date','');
			id_manage_end_date.hide();
		}
	}
	
	//线下禁用组键
	function fn_flag_m_onchange_over(){
	     var flag_m=AOS.get('id_okManages').getValue().flag_m;
	     if(flag_m==1){
		    id_manage_end_dates.show();
        	}else{
	     AOS.setValue('f_account_u.manage_end_date','');
		 id_manage_end_dates.hide();
	  }
    }
	//常用联系人组键
	function g_aosuser_corp_query(){
		var id_top = AOS.getValue('id_top');
		if(id_top == true){
			g_aosuser.hide();
			top_grid.show();
			top_grid_store.reload();
		}else{
			g_aosuser.show();
			top_grid.hide();
		}
	}
	
	//附件窗口隐藏
	function aosUpload_grid_onhide(){
		AOS.setValue('query_form.manin_id','');
		var params = AOS.getValue('query_form');
		aosUpload_grid_store.removeAll();
		var rows=aosUpload_grid.getStore().getCount();
		
	}
	
    //新增窗口隐藏
    function w_account_onhide(){
	   	var upload_state=AOS.getValue('f_account.upload_state');
	   	var manage_code=AOS.getValue('f_account.manage_code');
	   	if(upload_state==0){
	   		//删除选中的信息
			AOS.ajax({
				url : 'filesManageService.onhidedelete',
				params:{
					manage_code: manage_code
				},
				ok : function(data) {
					aosUpload_grid_store.reload();
				}
			});
	   	}
    }
    
    //修改隐藏
    function  w_account_u_onhide(){
		AOS.setValue('f_account_u.attende_id',null);
    }
    
	//组件显示的时候调用
	function  w_user_onshow(){
		var attende_id = AOS.getValue('f_account_u.attende_id');
		var params = AOS.getValue('id_name');
		var name = AOS.getValue('f_account_u.name_desc');
		if(!AOS.empty(name)){
			g_aosuser_corp_store.getProxy().extraParams = {id:attende_id}
			g_aosuser_corp_store.loadPage(1);
		}else{
			g_aosuser_corp_store.getProxy().extraParams = {id:"${user.id}"}
			g_aosuser_corp_store.loadPage(1);
		}
		g_aosuser_store.getProxy().extraParams = {id_name:params,id:attende_id};
		g_aosuser_store.loadPage(1);
	}

	//人员信息表信息
	function g_user_query(){
		var params = AOS.getValue('id_name');
		var param = AOS.getValue('search_principal_org');
		var attende_id = AOS.getValue('f_account_u.attende_id');
		g_aosuser_store.getProxy().extraParams = {id_name:params,subordinate_departments:param,id:attende_id};
		g_aosuser_store.loadPage(1);
	}
		 
	 //常用联系人信息查询
	 function top_user_query(){
		 var top_user_name = AOS.getValue('top_user_name');
		 var top_principal_org = AOS.getValue('top_principal_org');
		 var attende_id = AOS.getValue('f_account_u.attende_id');
		 top_grid_store.getProxy().extraParams = {
			 top_name : top_user_name,
			 top_org_name_id : top_principal_org,
			 user_id : attende_id
		 };
		 top_grid_store.loadPage(1);
	 }
		 
	//人员信息表信息
	function fn_org(){
		var params = AOS.getValue('search_principal_org');
		var param = AOS.getValue('id_name');
		var attende_id = AOS.getValue('f_account_u.attende_id');
		g_aosuser_store.getProxy().extraParams = {id_name:param,subordinate_departments:params,id:attende_id};
		g_aosuser_store.loadPage(1);
	}
		
	//常用联系人部门查询
	function top_org(){
		var top_user_name = AOS.getValue('top_user_name');
		 var top_principal_org = AOS.getValue('top_principal_org');
		 var attende_id = AOS.getValue('f_account_u.attende_id');
		 top_grid_store.getProxy().extraParams = {
			 top_name : top_user_name,
			 top_org_name_id : top_principal_org,
			 user_id : attende_id
		 };
		 top_grid_store.loadPage(1);
	}
		
	//常用联系人表刷新
	function top_grid_query(){
		var user_id = ${user.id};
		top_grid_store.getProxy().extraParams = {
	    	create_id : user_id
	    };
		top_grid_store.loadPage(1);
	}
		
	//临时窗口
	function g_user_query_corp(){
		var attende_id = AOS.getValue('f_account_u.attende_id');
		g_aosuser_corp_query();
		g_aosuser_corp_store.getProxy().extraParams = {id:attende_id}
		g_aosuser_corp_store.loadPage(1);
   }
	
	//添加选中的单条grid
	function add_contract_grid(me, record){
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid1Records = grid1.data.items;
		var grid2 = AOS.get('g_aosuser').store;
		var flag = true;
		Ext.each(grid1Records, function (grid1Record) {
			if(grid1Record.data.id == record.data.id){
				AOS.tip("该人员已存在，请勿重复添加!");
				flag = false;
				return;
			}
	    });
		if(flag){
			grid1.add(record);
			grid2.remove(record);
		}
	}
		
	//添加选中的常用联系人
	function top_contract_grid(me,record){
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid1Records = grid1.data.items;
		var grid3 = AOS.get('top_grid').store;
		var flag = true;
		Ext.each(grid1Records, function (grid1Record) {
			if(grid1Record.data.id == record.data.id){
				AOS.tip("该人员已存在，请勿重复添加!");
				flag = false;
				return;
			}
	    });
		if(flag){
			grid1.add(record);
			grid3.remove(record);
		}
	}
		
	//删除某条数据
	function del_contract_grid(me,record){
		var id_top = AOS.getValue('id_top');
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid2 = AOS.get('g_aosuser').store;
		var grid3 = AOS.get('top_grid').store;
		if(id_top == true){
			grid1.remove(record);
			grid3.add(record);
		}else{
			grid1.remove(record);
			grid2.add(record);
		}
	}
	
	//主持人下拉框选择(新增)
	id_compere.on("change",function(combox){
		combox.getStore().clearFilter();
		if(!AOS.empty(combox.getRawValue())){
			var on_query_firstLetter=pinyinUtil.getFirstLetter(combox.getRawValue()).toUpperCase();
			combox.getStore().filterBy(function(record) {
				var to_query_firstLetter= pinyinUtil.getFirstLetter(record.get("display"));
				return to_query_firstLetter.indexOf(on_query_firstLetter)!=-1;
			});
		}
		if (combox.store.getCount()) {
			combox.expand();
		} else {
			combox.collapse();
		}
	});
	
	//主持人下拉框选择（修改）
	id_comperes.on("change",function(combox){
		combox.getStore().clearFilter();
		if(!AOS.empty(combox.getRawValue())){
			var on_query_firstLetter=pinyinUtil.getFirstLetter(combox.getRawValue()).toUpperCase();
			combox.getStore().filterBy(function(record) {
				var to_query_firstLetter= pinyinUtil.getFirstLetter(record.get("display"));
				return to_query_firstLetter.indexOf(on_query_firstLetter)!=-1;
			});
		}
		if (combox.store.getCount()) {
			combox.expand();
		} else {
			combox.collapse();
		}
	});
       
	//用户名称保存
	function personnel_save(){
		g_aosuser_corp.getSelectionModel().selectAll();
		var select=AOS.selection(g_aosuser_corp,'id');
		var user_name=AOS.selection(g_aosuser_corp,'user_name');
		var attende_id=select.split(",");
		var user_name_=user_name.split(",");
		var attende_id_=[];
		var user_name_p=[];
		Ext.each(attende_id,function(item){
			if(!AOS.empty(item)){
				attende_id_.push(Number(item));
			};
		});
		Ext.each(user_name_,function(item){
			if(!AOS.empty(item)){
				user_name_p.push(item);
			};
		});
		AOS.setValue('f_account.attende_id',attende_id_);
		AOS.setValue('f_account.name_desc',user_name_p);
		
		AOS.setValue('f_account_u.attende_id',attende_id_);
		AOS.setValue('f_account_u.name_desc',user_name_p);
		w_user.hide();
	}
                 
     //性别值转换
	function fn_sex(value, metaData, record, rowIndex, colIndex,store) {
		if(value=='1'){
			value='男'
		}
		if(value=='2'){
			value='女'
		}
		if(value=='3'){
			value='未知'
		}
		return value
	}
        
	//用户状态值转换
	function fn_status(value, metaData, record, rowIndex, colIndex,store) {
		if(value=='1'){
			value='正常'
		}
		if(value=='2'){
			value='非正常'
		}
		return value
	}
		
	//用户类型值转换
	function fn_type(value, metaData, record, rowIndex, colIndex,store) {
		if(value=='1'){
			value='缺省'
		}
		return value
	}
		
	//弹出选择角色窗口
	function w_account_find_show() {
		w_user.show();
	}
		
	//删除选中的信息
	function card_grid_del(){
		var selection = AOS.selection(aosUpload_grid, 'fileid');
		if(AOS.empty(selection)){
			AOS.tip('删除前请先选中数据。');
			return;
		}
		var rows = AOS.rows(aosUpload_grid);
		var msg =  AOS.merge('确认要删除选中的{0}个信息吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'aosUploadService.delete',
				params:{
					fileid: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					aosUpload_grid_store.reload();
				}
			});
		});
	}
		
	//查询列表/分页
	function aosUpload_grid_query() {
		var  manage_id;
	         manage_id =AOS.getValue('f_account.manage_code');
		if( AOS.empty( manage_id)){
			 manage_id =AOS.getValue('f_account_u.manage_code');
		}
		AOS.setValue('query_form.manin_id',manage_id);
		var params = AOS.getValue('query_form');
		aosUpload_grid_store.getProxy().extraParams = params;
		aosUpload_grid_store.loadPage(1);
	}
		
	//上传保存
	function excel_win_save_s(){
		var manage_id;
		manage_id =AOS.getValue('f_account.manage_code');
		var fileid;
		fileid =AOS.getValue('f_account.fileid');
		if( AOS.empty(manage_id)){
			manage_id =AOS.getValue('f_account_u.manage_code');
		}
		var filenPath = AOS.getValue('excel_win_form.excel_file');
		fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
		if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png"){
			AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
			return;
		}
		excel_win_form.getForm().fileUpload = true;
		excel_win_form.getForm().submit({
			type : 'POST', 
			params:{manin_id:manage_id},
			url:'do.jhtml?router=aosUploadService.importFile&juid=${juid}',
			waitMsg:'文件上传中...',
			success: function(form, action) {
				AOS.tip(action.result.msg);
				excel_win.hide(); 
				aosUpload_grid_store.reload();
			},
			failure: function() {
				excel_win.hide();
				AOS.tip("文件上传失败！");
			} 
		});
	}
	
	//检索数据
	function fn_create_names_d(){
		var selectCom=Ext.getCmp('create_names').getValue();
		if(selectCom==1){
			AOS.setValue('f_query.create_name',${initiator})
			g_account_query();
		}else if(selectCom==2){
			AOS.setValue('f_query.create_name',null);
			g_account_query();
		}
	}
	
	//修改评审结束时间是否大于开始时间
	function fn_manage_over(){
		var begin_date=AOS.getValue('f_account_u.begin_date');
		var end_date =AOS.getValue('f_account_u.manage_end_date');
		var differ_date =AOS.getValue('f_account_u.workload');
		if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			AOS.setValue('f_account_u.manage_end_date','');
			AOS.tip("结束时间不能小于开始时间,请重新选择!");
			return;
		}else{
		//获取时间差
			AOS.ajax({
				params:{
					begin_date:begin_date,
					end_date:end_date
					},
				url : 'filesManageService.differDate',
				ok : function(data) {
					AOS.setValue('f_account_u.workload',data.appmsg);  
				}
			});
		}
	}
	
	//评审结束时间是否大于开始时间
	function fn_manage_chang(){
		var begin_date=AOS.getValue('f_account.begin_date');
		var end_date =AOS.getValue('f_account.manage_end_date');
		var differ_date =AOS.getValue('f_account.workload');
		if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			AOS.setValue('f_account.manage_end_date','');
			AOS.tip("结束时间不能小于开始时间,请重新选择!");
			return;
		}
	}
	
	//结束时间是否大于开始时间
	function fn_judge_chang(){
		var begin_date=AOS.getValue('f_account.begin_date');
		var end_date =AOS.getValue('f_account.end_date');
		var differ_date =AOS.getValue('f_account.workload');
		var review_type =AOS.get('id_review_type').getValue();
		var flag_m=AOS.get('id_okManage').getValue().flag_m;
		if(flag_m==1){
			AOS.setValue('f_account.manage_end_date',end_date);
		}
		if(!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
				AOS.setValue('f_account.end_date','');
				AOS.tip("结束时间不能小于开始时间,请重新选择!");
				return;
			}else{
				//获取时间差
				AOS.ajax({
					params:{
						begin_date : begin_date,
						end_date : end_date
						},
					url : 'filesManageService.differDate',
					ok : function(data){
						var workload = data.appmsg;
						var workload_= workload/24;
						AOS.setValue('f_account.workload',workload_);
					}
				});
			}
		}
	}
	
	//修改获取时间差
	function fn_judge_over(){
		var begin_date=AOS.getValue('f_account_u.begin_date');
		var end_date=AOS.getValue('f_account_u.end_date');
		if(!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			if(end_date<begin_date && !AOS.empty(begin_date) && !AOS.empty(end_date) ){
				AOS.setValue('f_account_u.end_date','');
				AOS.tip("结束时间不能小于开始时间,请重新选择!");
				return;
			}else{
				//获取时间差
				AOS.ajax({
					params:{ 
						begin_date:begin_date,
						end_date:end_date
						},
					url : 'filesManageService.differDate',
					ok : function(data) {
						var workload = data.appmsg;
						var workload_= workload/24;
						AOS.setValue('f_account_u.workload',workload_);  
					}
				});
			}
		}
	}
	
	//新增结束时间判断
	function changeweekDt(){
		var begin_date=AOS.getValue('f_query.beginDate_');
		var end_date=AOS.getValue('f_query.endDate_');
		if(end_date<begin_date  && !AOS.empty(begin_date) && !AOS.empty(end_date) ){
			AOS.setValue('f_query.endDate_','');
			AOS.tip("结束时间不能小于开始时间,请重新选择!");
			return;
		}
	}
	
	//修改保存数据
	function f_account_update(){
		var end_date=AOS.getValue('f_account_u.end_date');
		AOS.ajax({
			forms : f_account_u,
			url : 'filesManageService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				g_account_store.reload();
				w_account_u.hide();
			}
		});
	}
	
	//加载表格数据
	function g_account_query(value,mdate,record) {
		var params = AOS.getValue('f_query');
		g_account_store.getProxy().extraParams = params;
		g_account_store.loadPage(1);
	}
	
	//批量发起
	function c_commit_count(){
		var selection = AOS.selection(g_account, 'manage_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要发起评审的数据。');
			return;
		}
		AOS.confirm("数据发起后将不能修改!", function(btn){
			if(btn === 'cancel'){
			return;
			}
			AOS.ajax({
				url : 'filesManageService.ccommitCount',
				params:{
					aos_rows: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					g_account_store.reload();
				}
			});
		});
	}
	
	//撤回
	function recall_count(){
		var select = AOS.selectone(g_account);
		var selection = AOS.selection(g_account, 'manage_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要撤回评审的数据。');
			return;
		}
		if(select.data.state_flag == 1){
			AOS.tip('未发起的无法撤回');
			return;
		}
		var msg =  AOS.merge('是否要撤回选中的数据？');
		AOS.confirm(msg,function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url: "filesManageService.recall",
				params : {
					manage_id: selection,
					mang_id : select.data.manage_code
				},
				ok : function(data){
					g_account_store.reload();
				}
			});
		});
	}
	
	//监听修改窗口弹出
	function w_account_u_onshow(){
		var rows = AOS.rows(g_account);		
		if(rows != 1){
			AOS.tip('请选择一条需要修改的数据');
			w_account_u.hide();
			return;
		}
		var record = AOS.selectone(g_account, true);
		if(record.data.state_flag==2){
			w_account_u.hide();
			AOS.tip("已发起,不能修改");
			return;
		}
		if(record.data.state_flag==3){
			w_account_u.hide();
			AOS.tip("已关闭,不能修改");
			return;
		}
		var attende_id= record.data.attende_id;
		var review_type =record.data.review_type;
		var meeting_type = record.data.meeting_type;
		var compere=record.data.compere;
		var str=attende_id.replace("[","");
		var str_=str.replace("]","");
		var attende_id_ =str_.split(",");
		f_account_u.loadRecord(record);
		var number_=[];
		Ext.each(attende_id_,function(item){
			number_.push(Number(item)) ;
		});
		AOS.setValue('f_account_u.attende_id',number_);
		AOS.setValue('f_account_u.compere',compere);
		AOS.setValue('f_account_u.meeting_type',meeting_type+"");
		AOS.setValue('f_account_u.name_desc', record.data.attende_mans);
		AOS.setValue('f_account_u.review_type',review_type+""); 
		if(AOS.empty(AOS.getValue('f_account_u.manage_end_date'))){
			id_manage_end_dates.hide();
		}else{
			AOS.get('id_ok').setValue(true);
		}
	}
		
	//监听新增按钮
	function w_account_onshow(){
		AOS.reset(f_account);
		AOS.setValue('f_account_u.attende_id','');
		AOS.ajax({
			url : 'filesManageService.getMange_id',
			ok : function(data) {
				AOS.setValue('f_account.manage_code',data.appmsg)
			}
		});
		AOS.setValue('f_account.begin_date',new Date());
		w_account.show();
	}
	
	//监听总结窗口弹出
	function w_account_over_onshow(){
		//这里演示的是直接从表格行中加载数据，也可以发一个ajax请求查询数据(见misc1.jsp有相关用法)
		var record = AOS.selectone(g_account, true);
		var rows = AOS.rows(g_account);		
		if(rows != 1){
			AOS.tip('请选择一条需要总结的数据。');
			w_account_over.hide();
			return;
		}
		var initiator=record.data.initiator;
		if( record.data.state_flag==3){
			w_account_over.hide();
			AOS.tip("已关闭,请勿操作此功能!");
			return;
		}
		if( record.data.state_flag==1){
			w_account_over.hide();
			AOS.tip("未发起,请勿操作此功能!");
			return;
		}
		if(initiator==${initiator}){}else{
			w_account_over.hide();
			AOS.tip("非发起人,请勿操作此功能!");
			return;
		}
		f_account_over.loadRecord(record);
		AOS.ajax({
			params:{
				text_code:record.data.opinion_code
			},
			url:'filesManageService.getreplyNews',
			ok:function(data){
				AOS.setValue('f_account_over.opinion',data.resut);
				AOS.setValue('f_account_over.pass_daitil',data.pass_daitil);
			}
		});
	}
	
	//评审总结
	function f_save_update(){
		AOS.setValue('f_account_over.flag_values',"1");
		AOS.ajax({
			forms : f_account_over,
			url : 'filesManageService.update_over',
			ok : function(data) {
				AOS.tip(data.appmsg);
				g_account_store.reload();
				w_account_over.hide();
			}
		});
	}
			
	//新增保存
	function excel_win_save(){
		//当点击的是保存按钮赋值为1
		AOS.setValue('f_account.upload_state',1);
		if(AOS.valid(f_account)==false){
			return;
		};
		var str;
		var review_type=AOS.getValue('f_account.review_type') ;
		var end_date=AOS.getValue('f_account.end_date');
		var manage_end_date=AOS.getValue('f_account.manage_end_date');
		if(review_type==1){
			if(end_date >=manage_end_date){
				str=1;
			}
		}
		AOS.ajax({
			url:'do.jhtml?router=filesManageService.importFile',
			forms:f_account,
			ok : function(data) {
				AOS.tip(data.appmsg);
				w_account.hide(); 
				g_account_store.reload();
			}
		});         
	}
		
	//评论说明列渲染
	function fn_balance_file_note(value, metaData, record){
		var str= value.replace(/<div>/g, "");
		var str_= str.replace(/<br>/g, "");
		var _str_=str_.replace(/<\/div>/g, "");
		return _str_;
	}
	
	function fn_balance_pass_flag(value, metaData, record){
		var str;
		if (value == 1) {
				return "<span style='color:red; font-weight:bold'>未通过</span>";
		}
		if (value == 2) {
				return "<span style='color:green; font-weight:bold'>已通过</span>";
		}
		return str;
     }
	
	//评审状态列渲染
	function fn_balance_state_flag(value, metaData, record){
		var str;
		if (value == 1) {
				return "<span style='color:red; font-weight:bold'>草稿</span>";
		}
		if (value == 2) {
				return "<span style='color:green; font-weight:bold'>已发起</span>";
		}
		if (value == 3) {
				return "<span style='color:blue; font-weight:bold'>已关闭</span>";
		}
		return str;
     }
	
	//会议方式列渲染
	function fn_balance_review_type(value, metaData, record){
		if (value == 1) {
			return "<span>现场会议</span>";
		}
		if (value == 2) {
			return "<span>远程会议</span>";
		}
		if (value == 3) {
			return "<span>其它</span>";
		}
	}
	
	//会议类型渲染
	function fn_balance_meeting_type(value, metaData, record){
		if (value == 1) {
			return "<span>项目周例会</span>";
		}
		if (value == 2) {
			return "<span>评审会议</span>";
		}
		if (value == 3) {
			return "<span'>专题会议</span>";
		}
		if (value == 4) {
			return "<span>其它</span>";
		}
	}
		
	//参与人渲染列
	function fn_balance_attende_mans(value, metaData, record,a,b,c){
		return value;
	} 
		 
	//结论列渲染的时候进行处理
	function fn_balance_result(value, metaData, record) {
		var str= value.replace(/<div>/g, "");
		var str_= str.replace(/<br>/g, "");
		var _str_=str_.replace(/<\/div>/g, "");
		return _str_;
	}
	
	//获取数据表选择行的所有字段集合[JSON]
	function g_account_selected() {
		var selection = AOS.selectone(g_account);
		if (AOS.empty(selection)) {
			AOS.tip('请先选择表格行。');
			return;
		}
		AOS.tip(selection.data.attende_mans);
	}
	
	//删除账户信息
	function g_acount_del(){
		var selection = AOS.selection(g_account, 'manage_id');
		var select_create_name = AOS.selection(g_account, 'create_name').split(",");
		var select_state_flag = AOS.selection(g_account, 'state_flag').split(",");
		var flag;
		Ext.each(select_create_name,function(item){
			if(Number(item)!=${initiator} && item !=null &&  item !=''){
				flag=1;
				return false;
			}
		});
		Ext.each(select_state_flag,function(item){
			if(Number(item)==3){
				flag=1;
				return false;
			}
		});
		if(flag==1){
			AOS.tip('删除数据中存在已经关闭或者非创建人的数据!');
			return;
		}
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据。');
			return;
		}
		var rows = AOS.rows(g_account);
		var msg = AOS.merge('确认要删除选中的{0}条数据吗?', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
			return;
		}
			AOS.ajax({
				url : 'filesManageService.alldelete',
				params:{
					aos_rows: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					g_account_store.reload();
				}
			});
		});
	}
        
	//主题渲染
	function fn_files_manage(value, metaData, record){
		if(value != 0) {
			return '<a href="javascript:void(0);">' + record.data.theme + '</a>';
		}
		return value;
	}
	g_account.on("cellclick", function(grid, rowIndex, columnIndex, e){
		var record = AOS.selectone(g_account, true);
		if(AOS.empty(record) || record.length>1){
			AOS.tip('只能勾选一列查看会议详情。');
			return;
		}
		var select = AOS.selectone(g_account);
		if (columnIndex == 3 ) {
			if(select.data.state_flag == 1){
				AOS.tip('不能查看未发起的会议！');
				return;
			}else{
				var manage_id = record.data.manage_id;
				var manage_code = record.data.manage_code;
				window.open("do.jhtml?router=filesManageService.initMsgIdView&juid=${juid}&manage_id="+ manage_id
					+ "&manage_code=" + manage_code); 
			}
		}
	});
		
 	function attachment_download(value, metaData, record) {
		return '<input type="button" value="附件下载" metaData.style = "color:blue" class="cbtn" onclick="show_attachment_download();" />';
	} 
	 	
 	function historical_record(value, metaData, record) {
		return '<input type="button" value="查看" metaData.style = "color:blue" class="cbtn" onclick="show_historical_record();" />';
	} 
	 	
 	//kb
	function fn_gzldw(value,maction,record){
	    if(value==0){
            return value;
         }else{
	        return value+"<span style=' font-size:5px; color:green;'>KB</span>";
        }
	}
	 	
	//下载
	function g_acount_down(){
		var selection = AOS.selection(details_appendix_grid, 'fileid');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件!');
			return;
		}
		var rows = AOS.rows(details_appendix_grid);
		if(rows > 1){
			AOS.tip('请只选择一条需要下载的文件!');
			return;
		}
		var path = AOS.selection(details_appendix_grid, 'path');
		var title = AOS.selection(details_appendix_grid, 'title');
		var fileid = AOS.selection(details_appendix_grid, 'fileid');
		if(AOS.empty(selection)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		AOS.file('do.jhtml?router=filesManageService.downloadFile&juid=${juid}&path='+path+'&title='+title+'&fileid='+fileid);
	}
		
	//批量下载
	function g_zip_down(){
		var selection = AOS.selection(details_appendix_grid, 'fileid');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要批量打包下载的文件!');
			return;
		}
		var rows = AOS.rows(details_appendix_grid);
		var msg =  AOS.merge('确认要批量打包下载选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.file('do.jhtml?router=filesManageService.downloadFileByZip&juid=${juid}&&aos_rows='+selection);
		});
	}
	 	
	</script>
</aos:onready>
<script type="text/javascript">
	//项目详情显示窗口
	function show_attachment_download(){
		AOS.get("details_appendix").show();
	}
	//历史记录显示窗口
	function show_historical_record(){
		AOS.get("record_view").show();
	}
</script>

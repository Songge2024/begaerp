<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="team_id" fieldLabel="团队ID" />
	<aos:combobox fieldLabel="角色名称" name="trp_code" allowBlank="false" editable="false" columnWidth=".5"
				url="projCommonsService.listComboBoxData&cb_id=trp_code&cd_name=trp_name&cb_table=bs_proj_role_types"/>
	<aos:combobox fieldLabel="成员姓名" name="team_user_id" multiSelect="true" allowBlank="false" editable="false" columnWidth=".5" 
				url="projCommonsService.listComboBoxData&cb_id=id&cd_name=name&cb_table=aos_user&queryDate=id>0"/>
	<aos:datefield name="join_date" fieldLabel="加入时间" editable="false" columnWidth=".5" allowBlank="false"/>
	<aos:textfield name="jp_desc" fieldLabel="成员说明" allowBlank="true" columnWidth=".5" maxLength="200"/>

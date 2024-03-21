<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

     <aos:plugins>
		<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="1" />
	</aos:plugins>
	<aos:column header="团队ID" dataIndex="team_id" hidden="true" fixedWidth="100"/>
	<aos:column header="角色名称" dataIndex="trp_code" width="100" align="center" hidden="true"/>
	<aos:column header="角色名称" dataIndex="trp_name" width="100" align="center"/>
	<aos:column header="项目名称" dataIndex="proj_id" width="100" align="center" hidden="true"/>
	<aos:column header="项目名称" dataIndex="proj_name" width="100" align="center" hidden="true"/>
	<aos:column header="员工编号" dataIndex="team_user_id"  width="80" align="center"/>
	<aos:column header="成员姓名" dataIndex="team_user_name" width="100" align="center"/>
	<aos:column header="加入时间" dataIndex="join_date" width="115" type="date" format="Y-m-d" align="center"/>
	<aos:column header="任务确认人" dataIndex="develop_task_user_name" fixedWidth="100" align="center"   >
	        <aos:combobox allowBlank="false" url="projCommonsService.listComboBoxProjId"  name="develop_task_user"   id="task_grid_column_handler_user_id"  >
	        <aos:on fn="fn_task_user" event="select" />
	        </aos:combobox>
	</aos:column>
		<aos:column header="考核人" dataIndex="check_user_name" fixedWidth="100" align="center"   >
	      <aos:combobox allowBlank="false" url="userService.listComboBoxcheckUserId"  name="check_user_id"     >
		        <aos:on fn="fn_check_user" event="select" />
	        </aos:combobox>
	</aos:column>
	<aos:column header="成员说明" dataIndex="jp_desc" fixedWidth="100" hidden="true" align="left"/>
	

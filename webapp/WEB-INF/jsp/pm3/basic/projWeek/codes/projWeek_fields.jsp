<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="week_id" fieldLabel="项目周ID" columnWidth=".5"/>
	<aos:textfield name="week_name" fieldLabel="项目周名" allowBlank="false" maxLength="300" columnWidth=".5"/>
	<aos:hiddenfield name="proj_id" fieldLabel="项目名称"  columnWidth=".5"/>
	<aos:textfield name="proj_name" fieldLabel="项目名称"  readOnly="true" columnWidth=".5"/>
	<aos:hiddenfield name="begin_date" fieldLabel="开始时间" allowBlank="true" columnWidth=".5" readOnly="true"/>
	<aos:hiddenfield name="end_date" fieldLabel="结束时间" allowBlank="true" columnWidth=".5" readOnly="true"/>
	<aos:fieldset title="说明" >
			<aos:htmleditor name="comment"  allowBlank="true" 
			columnWidth="1" padding="5 5 5 5" />
		</aos:fieldset>
	<aos:hiddenfield name="create_user_id" fieldLabel="设计人" allowBlank="true"  columnWidth=".5"/>
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" columnWidth=".5"/>
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true"  columnWidth=".5"/>
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true" columnWidth=".5"/>
	<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true" columnWidth=".5"/>

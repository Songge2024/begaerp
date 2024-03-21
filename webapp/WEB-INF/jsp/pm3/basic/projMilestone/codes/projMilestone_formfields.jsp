<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:textfield name="proj_name" fieldLabel="项目名称"   readOnly="true"  columnWidth=".5"/>
	<aos:hiddenfield name="milest_id" fieldLabel="里程碑ID" />
	<aos:hiddenfield name="parent_id" fieldLabel="上级节点" allowBlank="true"/>
	<aos:hiddenfield name="parent_name" fieldLabel="上级节点" readOnly="true" allowBlank="false"  columnWidth=".5"/>
	<aos:hiddenfield name="milest_code" fieldLabel="里程碑编码" allowBlank="true" />
	<aos:textfield name="milest_name" fieldLabel="里程碑名称" readOnly="true" columnWidth=".5" />
		<aos:numberfield  name="plan_wastage" fieldLabel="计划天数"   readOnly="true" columnWidth=".5"/>
	<aos:numberfield  name="earned_value" fieldLabel="挣值(ev)"    readOnly="true" columnWidth=".5"/>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" />
	<aos:hiddenfield name="is_leaf" fieldLabel="是否叶子" allowBlank="true" />
	<aos:datefield  name="plan_begin_date"  fieldLabel="计划开始时间"  readOnly="true" columnWidth=".5" />
	<aos:datefield  name="plan_end_date"    fieldLabel="计划结束时间"  readOnly="true" editable="false"  columnWidth=".5"/>
	<aos:datefield name="real_begin_date"  fieldLabel="实际开始时间"  readOnly="true" columnWidth=".5" />
	<aos:datefield  name="real_end_date"    fieldLabel="实际结束时间" readOnly="true"  editable="false"  columnWidth=".5"/>
	<aos:numberfield  name="plan_jobamount" fieldLabel="计划工作量(人天)"    readOnly="true" columnWidth=".5"/>
	<aos:numberfield  name="real_jobamount" fieldLabel="实际工作量(人天)"    readOnly="true" columnWidth=".5"/>
	<aos:hiddenfield name="create_user_id" fieldLabel="创建人" allowBlank="true"  />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true" />
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true"/>
	<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true" value="0"  />
	


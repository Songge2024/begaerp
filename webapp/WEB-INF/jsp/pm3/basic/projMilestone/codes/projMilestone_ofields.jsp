<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:textfield name="proj_name" fieldLabel="项目名称" allowBlank="false" labelWidth="120" 
	readOnly="true" columnWidth="1" />
<aos:textfield name="milest_name" fieldLabel="里程碑名称" allowBlank="false" labelWidth="120"
	columnWidth=".5" />
	<aos:numberfield name="sort_no" fieldLabel="排列序号" minValue="1" allowBlank="false" labelWidth="120"
	minWidth="0" columnWidth=".5" maxValue="99999999" />
<aos:hiddenfield name="milest_id" fieldLabel="里程碑ID" />
<aos:hiddenfield name="weekday" fieldLabel="第几周" />
<aos:hiddenfield name="parent_id" fieldLabel="上级节点" allowBlank="true" />
<aos:hiddenfield name="milest_code" fieldLabel="里程碑编码" allowBlank="true" />
<aos:datefield name="plan_begin_date" fieldLabel="计划开始时间" labelWidth="120" 
	allowBlank="false" 
	 columnWidth=".5" />
<aos:datefield  name="plan_end_date" fieldLabel="计划结束时间" labelWidth="120"
	allowBlank="false" 
 columnWidth=".5" />
	<aos:numberfield  name="plan_jobamount" fieldLabel="计划工作量(人天)"    allowBlank="false"   columnWidth=".5" labelWidth="120"  minValue="0"/>
	<aos:numberfield  name="plan_wastage" fieldLabel="计划天数"  labelWidth="120"
	editable="false" readOnly="true"  step="1" decimalPrecision="1"
	 minValue="1" 
	columnWidth=".5" />
<aos:hiddenfield name="proj_id" fieldLabel="项目ID" />
<aos:hiddenfield name="is_leaf" fieldLabel="是否叶子" allowBlank="true" />
<aos:datefield  name="real_begin_date" allowBlank="false"  fieldLabel="实际开始时间"   columnWidth=".5" labelWidth="120" />
	<aos:datefield  name="real_end_date"  allowBlank="false"   fieldLabel="实际结束时间"    columnWidth=".5" labelWidth="120"/>
	 	<aos:numberfield  name="real_jobamount" allowBlank="false" onchange="countEv" fieldLabel="实际工作量(人天)"    columnWidth=".5" labelWidth="120" minValue="0"/>
	 	 <aos:numberfield  name="earned_value" fieldLabel="挣值(ev)"  readOnly="true" minValue="0" labelWidth="120" columnWidth=".5" emptyText="计划工作量/实际工作量"/>
<aos:hiddenfield name="create_user_id" fieldLabel="设计人"
	allowBlank="true" />
<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
<aos:hiddenfield name="update_user_id" fieldLabel="更新人"
	allowBlank="true" />
<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true" />
<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true"
	value="0" />
<aos:hiddenfield id="id_type" name="type" fieldLabel="是否周节点"
	allowBlank="true" value="0" />
<aos:fieldset title="说明" columnWidth="1" border="true" height="150">
	<aos:htmleditor name="comment" padding="5 5 5 5" columnWidth="1" />
</aos:fieldset>

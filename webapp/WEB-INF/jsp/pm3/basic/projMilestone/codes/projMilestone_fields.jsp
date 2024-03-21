<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:textfield name="proj_name" fieldLabel="项目名称" allowBlank="false"  readOnly="true"  columnWidth="1" labelWidth="120"/>
	<aos:hiddenfield name="milest_id" fieldLabel="里程碑ID" />
		<aos:hiddenfield name="weekday" fieldLabel="第几周" />
	<aos:hiddenfield name="parent_id" fieldLabel="上级节点" allowBlank="true"/>
	<aos:hiddenfield name="parent_name" fieldLabel="上级节点" />
	<aos:hiddenfield name="milest_code" fieldLabel="里程碑编码" allowBlank="true" />
	<aos:textfield name="milest_name" fieldLabel="里程碑名称" allowBlank="false"  columnWidth=".5" id="id_name" labelWidth="120"/>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" />
	<aos:hiddenfield name="is_leaf" fieldLabel="是否叶子" allowBlank="true" />
	  <aos:numberfield labelWidth="120" name="sort_no" fieldLabel="排列序号" minValue="1" minWidth="0" allowBlank="false" columnWidth=".5" maxValue="99999999" />
	<aos:datefield  labelWidth="120" id="b_date" name="plan_begin_date"  fieldLabel="计划开始时间" onselect="on_plan_wastage_begin_change" allowBlank="false"  columnWidth=".5" />
	<aos:datefield labelWidth="120"  id="e_date" name="plan_end_date"    fieldLabel="计划结束时间" onselect="on_plan_wastage_end_change" allowBlank="false" editable="false"  columnWidth=".5"/>
	<aos:numberfield labelWidth="120" name="plan_jobamount" fieldLabel="计划工作量(人天)"  allowBlank="false"   columnWidth=".5" minValue="0"/>
	<aos:numberfield id="id_nplan" name="plan_wastage" fieldLabel="计划天数"   step="1" decimalPrecision="1" labelWidth="120"
	  minValue="1"  editable="false" readOnly="true" columnWidth=".5"/>
<aos:datefield labelWidth="120" name="real_begin_date"  fieldLabel="实际开始时间"  hidden="true"   columnWidth=".5" />
	<aos:datefield labelWidth="120" name="real_end_date"    fieldLabel="实际结束时间"  hidden="true"  editable="false"  columnWidth=".5"/>
		<aos:numberfield labelWidth="120" name="real_jobamount" fieldLabel="实际工作量(人天)" hidden="true"    columnWidth=".5" minValue="0"/>
	 <aos:numberfield labelWidth="120" name="earned_value" fieldLabel="挣值(ev)"  hidden="true"   columnWidth=".5"/>
	<aos:hiddenfield name="create_user_id" fieldLabel="设计人" allowBlank="true"  />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true" />
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true"/>
	<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true" value="0"/>
	<aos:hiddenfield id="id_type" name="type" fieldLabel="是否周节点" allowBlank="true" value="0"/>
	<aos:fieldset title="说明" columnWidth="1" border="true">
			<aos:htmleditor name="comment" padding="5 5 5 5"
			columnWidth="1" />
	</aos:fieldset>


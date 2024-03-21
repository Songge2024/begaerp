<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="check_item_id" fieldLabel="检查单目录ID" />
	<aos:hiddenfield name="type_code" fieldLabel="项目类型ID" allowBlank="true" />
	<aos:hiddenfield name="check_cata_id" fieldLabel="检查单目录ID" allowBlank="true" />
	<aos:combobox fieldLabel="过程及产品" name="process_product" allowBlank="false"
		dicField="process_product" columnWidth="0.25" />
	<aos:combobox fieldLabel="问题等级" name="problem_level" allowBlank="false"
		dicField="problem_level" columnWidth="0.25" />
	<aos:textfield name="check_item_name" fieldLabel="检查单名称" allowBlank="false" maxLength="300"/>
	<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" msgTarget="qtip" emptyText="请填数字,如不填默认排序" allowDecimals="false" minValue="0" maxValue="2147483647"/>
	<aos:textfield name="remark" fieldLabel="备注" allowBlank="true" maxLength="300"/>
	<aos:hiddenfield name="create_user_id" fieldLabel="创建人" allowBlank="true" />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true"/>
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true" />
	<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true" />

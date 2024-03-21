<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="check_cata_id" fieldLabel="检查单目录ID" />
	<aos:hiddenfield name="type_code" fieldLabel="项目类型ID" allowBlank="true" />
	<aos:textfield name="check_cata_name" fieldLabel="检查项目录" allowBlank="false" maxLength="300"/>
	<aos:textfield name="remark" fieldLabel="备注" allowBlank="true" maxLength="300"/>
	<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" msgTarget="qtip" emptyText="请填数字,如不填默认排序" allowDecimals="false" minValue="0" maxValue="2147483647"/>
	<aos:hiddenfield name="create_user_id" fieldLabel="设计人" allowBlank="true" />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true" />
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true"/>
	<aos:hiddenfield name="state" fieldLabel="状态(1为启用，0为不启用）" allowBlank="true" />

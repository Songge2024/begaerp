<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="rootdir_id" fieldLabel="根目录ID" />
	<aos:textfield name="rootdir_name" fieldLabel="阶段名称" maxLength="150" allowBlank="false" msgTarget="qtip"/>
	<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" msgTarget="qtip" emptyText="请填数字,如不填默认排序" allowDecimals="false" minValue="0" maxValue="2147483647"/>

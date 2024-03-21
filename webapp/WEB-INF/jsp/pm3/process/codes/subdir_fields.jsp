<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="subdir_id" fieldLabel="子目录ID" />
	<aos:textfield name="subdir_name" fieldLabel="过程名称" maxLength="150" allowBlank="false" msgTarget="qtip"/>
	<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" emptyText="请填数字,如不填默认排序" allowDecimals="false" msgTarget="qtip" minValue="0" maxValue="2147483647"/>

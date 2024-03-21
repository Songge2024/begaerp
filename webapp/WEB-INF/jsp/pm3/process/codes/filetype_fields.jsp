<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="filetype_id" fieldLabel="文件类型ID" />
	<aos:textfield name="filetype_name" fieldLabel="文件名称"  maxLength="150" allowBlank="false" msgTarget="qtip"/>
	<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" msgTarget="qtip" emptyText="请填数字,如不填默认排序" allowDecimals="false" minValue="0" maxValue="2147483647"/>

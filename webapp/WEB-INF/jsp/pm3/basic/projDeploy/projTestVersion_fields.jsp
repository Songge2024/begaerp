<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="test_version_id" fieldLabel="测试版本号主键ID" />
	<aos:textfield name="test_version_number" fieldLabel="测试版本号" allowBlank="false" maxLength="300"/>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" allowBlank="false" />
	<aos:hiddenfield name="version_id" fieldLabel="所属项目版本号" allowBlank="false"/>
	<aos:textfield name="remark" fieldLabel="备注" allowBlank="true" maxLength="300"/>
	<aos:numberfield name="sortno" fieldLabel="排序号" allowBlank="true" msgTarget="qtip" emptyText="请填数字,如不填默认排序" allowDecimals="false" minValue="0" maxValue="2147483647"/>
	<aos:hiddenfield name="create_id" fieldLabel="创建人ID" allowBlank="true" />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_id" fieldLabel="修改人ID" allowBlank="true" />
	<aos:hiddenfield name="update_time" fieldLabel="修改时间" allowBlank="true" />
	<aos:hiddenfield name="state" fieldLabel="状态（1 有效 0 无效）" allowBlank="false" />

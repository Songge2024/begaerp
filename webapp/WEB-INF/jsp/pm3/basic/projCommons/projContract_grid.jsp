<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel
		id="contractFile_grid"
		columnWidth="0.5"
		border="false"
		flex="1"
		autoScroll="false"
		height="330"
		forceFit="false"
		url="contractFileService.page">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="上传文件信息" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="合同ID" dataIndex="ct_id" width="100" hidden="true"/>
			<aos:column header="路径" dataIndex="ct_file_path" width="100" hidden="true"/>
			<aos:column header="文件ID" dataIndex="ct_file_id" width="100" hidden="true"/>
			<aos:column header="文件标题" dataIndex="ct_file_title" width="200" />
			<aos:column header="大小" dataIndex="ct_file_size" width="100" align="center"/>
			<aos:column header="上传人" dataIndex="create_user_name" width="150" align="center"/>
			<aos:column header="上传时间" dataIndex="create_time" width="150" align="center"/>
			<aos:column header="上传文件备注" dataIndex="ct_file_remark" width="150" />
		</aos:gridpanel>
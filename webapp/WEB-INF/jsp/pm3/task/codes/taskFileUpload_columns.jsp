<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="文件类型" dataIndex="task_file_type" rendererField="task_file_type" width="150" align="center"/>
	<aos:column header="上传文件标题" dataIndex="file_title" width="400" />
	<aos:column header="上传人" dataIndex="create_user_name" width="120"/>
	<aos:column header="上传文件大小" dataIndex="file_size" width="100" align="right"/>
	<aos:column header="任务ID" dataIndex="task_id" width="200" hidden="true"/>
	<aos:column header="任务名称" dataIndex="task_name" width="300" />
	<aos:column header="项目id" dataIndex="proj_id" width="100"  hidden="true"/>
	<aos:column header="项目名称" dataIndex="proj_name" width="200"  hidden="true"/>
	<aos:column header="上传时间" dataIndex="create_time" width="150"  align="center"/>
	
	
	<aos:column header="文件ID" dataIndex="file_id" width="150" hidden="true"/>
	<aos:column header="文件编码" dataIndex="file_code" width="150" hidden="true"/>
	<aos:column header="排序号" dataIndex="sortno" width="100" hidden="true" />
	<aos:column header="状态" dataIndex="state" width="100" hidden="true"/>
	<aos:column header="创建人" dataIndex="create_user_id" width="120" hidden="true"/>
	<aos:column header="上传文件路径" dataIndex="file_path" width="100" hidden="true"/>
	<aos:column header="上传文件URL" dataIndex="file_url" width="100"  hidden="true" />
	<aos:column header="上传文件备注" dataIndex="file_remark" width="100" hidden="true" />

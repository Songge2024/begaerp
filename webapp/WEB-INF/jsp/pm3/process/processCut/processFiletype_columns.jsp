<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

	<aos:column header="文件类型ID" dataIndex="proc_filetype_id" width="100" hidden="true" align ="center"/>
	<aos:column header="过程阶段id" dataIndex="process_id" width="100" hidden="true" align ="center"/>
	<aos:column header="项目id" dataIndex="proj_id" width="100" hidden="true" align ="center"/>
	<aos:column header="活动Id" dataIndex="subdir_id" width="100" hidden="true" align ="center"/>
	<aos:column header="输出文档名称ID" dataIndex="filetype_id" width="100" hidden="true" align ="center"/>
	<aos:column header="输出文档名称" dataIndex="proc_filetype_name" width="250" />
	<%-- <aos:column header="排序号" dataIndex="sort_no" width="50" align ="center"> 
	<aos:textfield/>
	</aos:column>--%>
	<aos:column header="是否必须文件 " dataIndex="file_state"  type="check" width="100" align ="center"/>
	<aos:column header="创建人id" dataIndex="create_user_id" width="100" align ="center" hidden="true" />
	<aos:column header="创建人" dataIndex="create_user_name" width="100" align ="center"  hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" type="date" format="Y-m-d"  hidden="true" align ="center"/>
	<aos:column header="状态" dataIndex="state" width="100" hidden="true" align ="center"/>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="项目版本号ID" dataIndex="version_id"  width="100" hidden="true"/>
	<aos:column header="项目版本号" dataIndex="version_number" width="140" />
	<aos:column header="状态" dataIndex="state" width="60"  rendererFn="fn_state_render"/>
	<aos:column header="项目ID" dataIndex="proj_id"  width="100" hidden="true"/>
	<aos:column header="排序号" dataIndex="sortno" width="53" />
	<aos:column header="备注" dataIndex="remark" width="160" />
	<aos:column header="创建人ID" dataIndex="create_id" width="100" hidden="true"/>
	<aos:column header="创建人" dataIndex="create_name" width="53" />
	<aos:column header="创建时间" dataIndex="create_time" width="100" />
	<aos:column header="修改人ID" dataIndex="update_id" width="60" hidden="true"/>
	<aos:column header="修改人" dataIndex="update_name" width="53" />
	<aos:column header="修改时间" dataIndex="update_time" width="100" />
	
	<script type="text/javascript">
		function fn_state_render(value, metaData, record){
			if(value == '0'){
				metaData.style = 'color:#CC0000';
				return '未启用';
			}else{
				metaData.style = 'color:green';
				return '已启用';
			}
		}
	</script>

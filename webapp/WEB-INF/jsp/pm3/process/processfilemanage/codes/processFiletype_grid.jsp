<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel id="processFiletype_grid"
	url="processFiletypeService.byProcPage" forceFit="true"
	onitemclick="processFileUpload_query"
	region="center" bodyBorder="1 0 1 0">
	<aos:menuitem text="刷新" onclick="#processFiletype_grid_store.reload();" icon="refresh.png" />
	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="文件类型列表" />
	</aos:docked>
	<aos:column type="rowno" />
	<aos:column header="文件类型" dataIndex="proc_filetype_name" width="180" />
	<aos:column header="必须 " dataIndex="file_state" width="60" align="center" rendererFn="fn_flow_render"/>
	<aos:column header="已上传 " dataIndex="file_num" width="60" align="right"/>
	
	<aos:column header="所属过程" dataIndex="process_id" width="100" hidden="true"/>
	<aos:column header="项目ID" dataIndex="proj_id" width="100"  hidden="true"/>
	<aos:column header="文件类型ID主键" dataIndex="proc_filetype_id" width="100" hidden="true"/>
	<aos:column header="排序号" dataIndex="sort_no" width="100" hidden="true"/>
</aos:gridpanel>

<script type="text/javascript">

	//文件类型查询
	function processFiletype_query() {
		//获取项目ID
		var proj_id = id_proj_name.getValue();
		if(AOS.empty(proj_id)){ 
			return; 
		}
		var params = { proj_id : proj_id };
		
		//获取项目过程树节点
		var record = AOS.selectone(process_module);
		if(!AOS.empty(record)){
	 		params.tree_param = record.raw.id;
		}
		processFiletype_grid_store.getProxy().extraParams = params;
	    processFiletype_grid_store.loadPage(1,{
	    	callback : function(records) {
	    		filetypeCombo_query(AOS.recordsToArray(records), false); //加载上传窗口的combox
		}});
	  	//加载文件列表
		processFileUploadByProc_query();
	}
	
	function fn_flow_render(value, metaData, record) {
		if (value == '1') {
			metaData.style = 'color:#CC0000';
			return '是';
			
		} else if (value == '0') {
			metaData.style = 'color:green';
			return '否';
		} else {
			metaData.style = 'color:#CC0000';
			return '未知';
		}
	}	
</script>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:docked forceBoder="1 0 1 0" id="process_projecy_dock">
		<aos:dockeditem xtype="tbtext" text="项目列表" />
		<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="250" />
		<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
	</aos:docked>
	<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目基本信息"/>
	</aos:docked>
	<aos:formpanel 
		id="process_project_form"
		width="100"
	  	layout="column" 
	  	labelWidth="100">
	<%@ include file="processProject_fields.jsp"%>
	</aos:formpanel>
	
<script type="text/javascript">


 function fn_focus(queryPlan){/*  
	//id_proj_name_store.reload();
	var query=queryPlan.query;
	var combox=queryPlan.combo;
	combox.getStore().clearFilter();
	if(AOS.empty(query))return false;
	if(query.length<2)return false;
	var query_firstLetter=pinyinUtil.getFirstLetter(query).toUpperCase();
	combox.getStore().filterBy(function(record){
		var text_firstLetter=pinyinUtil.getFirstLetter(record.get("display"));
		return (text_firstLetter.indexOf(query_firstLetter)!=-1);
		
	});  */
}
 
/*  process_projecy_dock.down("combobox").on("beforequery",function(queryPlan){
	var query=queryPlan.query;
	var combox=queryPlan.combo;
	combox.getStore().clearFilter();
	if(AOS.empty(query))return false;
	if(query.length<2)return false;
	var query_firstLetter=pinyinUtil.getFirstLetter(query).toUpperCase();
	combox.getStore().filterBy(function(record){
		var text_firstLetter=pinyinUtil.getFirstLetter(record.get("display"));
		return (text_firstLetter.indexOf(query_firstLetter)!=-1);
		
	});
});  */

//项目选择
function proj_onselect(){
	var proj_id = id_proj_name.getValue();
	AOS.ajax({
			params:{proj_id : proj_id},
	        url: 'processService.loadFormInfo',
	        ok: function (data) {
	           AOS.setValues(process_project_form,data);
	           }
	        });
	processCut_grid_store.load({
		params:{
			proj_id : proj_id
		},
		callback : function(data) {
			if(data[0].childNodes.length==0){
        		var params ={ proj_id : -1 };
				 //processCut_grid_store.getProxy().extraParams = params;
				// processCut_grid_store.loadPage(1);
		         processCutFiletype_grid_store.getProxy().extraParams = params;
		         processCutFiletype_grid_store.loadPage();
	       	//AOS.enables(process_project_form,'templet_id');
	       	AOS.edits(process_project_form,'templet_id');
        	AOS.tip("该项目还没有进行过程裁剪,请先进行过程裁剪!");
        	return;
        	}
		//	AOS.disables(process_project_form,'templet_id');
			AOS.reads(process_project_form,'templet_id');
			processCut_grid.getSelectionModel().select(processCut_grid.getRootNode());
			var params ={ proj_id : proj_id };
			processCutFiletype_grid_store.getProxy().extraParams = params;
		    processCutFiletype_grid_store.loadPage(1); 
		   // process_query();
		}
	});
	
	
/* 	AOS.ajax({
			params:{proj_id : proj_id},
	        url: 'processService.loadGridInfo',
	        ok: function (data) {
	        	if(data.total==0){
	        		var params ={ proj_id : -1 };
					 processCut_grid_store.getProxy().extraParams = params;
					 processCut_grid_store.loadPage(1);
			         processCutFiletype_grid_store.getProxy().extraParams = params;
			         processCutFiletype_grid_store.loadPage();
		       	AOS.enables(process_project_form,'templet_id');
	        	AOS.tip("该项目还没有进行过程裁剪,请先进行过程裁剪!");
	        	return;
	        	}
	           AOS.disables(process_project_form,'templet_id');
	          // mergeGrid();
	            var params ={ proj_id : proj_id };
				 processCut_grid_store.getProxy().extraParams = params;
				// processCut_grid_store.setFeatures='grouping';
				 processCut_grid_store.groupField='rootdir_name';
		//		 processCut_grid_store.getGroupField='rootdir_name';
		//		 processCut_grid_store.isGrouped();
				 processCut_grid_store.loadPage(1);
				 
					
				 
				
		         processCutFiletype_grid_store.getProxy().extraParams = params;
		         processCutFiletype_grid_store.loadPage(1); 
	           }
	        });  */
	 
	
}

function tree_grid_refresh() {
	//获取选中的项目ID
	
	
	//加载文件类型列表
	
	
}



</script>
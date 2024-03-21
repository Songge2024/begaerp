<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:treepanel id="process_module" region="west" bodyBorder="0 1 0 0" singleClick="false" rootVisible="false"
	url="processFileUploadService.getProcessListTreeData" onitemclick="processFiletype_query">

	<aos:docked>
		<aos:dockeditem xtype="tbtext" text="选择项目:" />
			<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" 
				trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="220" />
			<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
	</aos:docked>
	<aos:docked >
			<aos:dockeditem xtype="tbtext" text="过程列表树" />
			<aos:dockeditem xtype="tbfill" />
	</aos:docked>
	<aos:menu>
		<aos:menuitem text="刷新" onclick="#processFileUpload_grid_store.reload();" icon="refresh.png" />
	</aos:menu>
</aos:treepanel>

<script type="text/javascript">	

	//根据选择项目名称刷新树和grid
	function tree_grid_refresh() {
		//获取选中的项目ID
		var proj_id = id_proj_name.getValue();
		if(AOS.empty(proj_id)){
			return;
		}
		process_module_store.load({
			params:{
				proj_id : proj_id
			},
			callback : function() {
				process_module.getSelectionModel().select(process_module.getRootNode());
			}
		});
		
		//加载文件类型列表
		processFiletype_query();
		
	}
		
	//弹出选择上级模块窗口
	  function proj_tree_show() {
	  	w_org_find.show();
	  }
	
	//项目文档管理自动选择默认项目
	window.onload = function(){
    	 var proj_id = '${proj_id}';
		 var proj_name = '${proj_name}';
		 if(proj_id !=null && proj_id!=''){
	    		AOS.setValue('id_proj_name',proj_id);
	    		AOS.setValue('tree_proj_name',proj_name);
	    		tree_grid_refresh();
		 }
     }
	
	//项目文档管理单击选择项目
	  function t_org_find_select() {
	  	var record = AOS.selectone(t_org_find);
	  	if(record.raw.a=="1"){
	  	AOS.setValue('id_proj_name',record.raw.id);
	  	AOS.setValue('tree_proj_name',record.raw.text);
		tree_grid_refresh();
		w_org_find.hide();
	 	 }else{
			AOS.tip("请选择项目!");
			return;
			//w_org_find.hide();
		}
	  }
	  
	  
		/*  //默认选中第一个项目
		window.onload = function combobox_select(){
			var record = t_org_find;
			var arr = record.store.tree.root.childNodes;
			if(arr.length >0){
				var proj_id = arr[0].raw.id;
				var porj_name = arr[0].raw.text;
				AOS.get('id_proj_name').setValue(proj_id);
				AOS.get('tree_proj_name').setValue(porj_name);
				var value = AOS.get('id_proj_name').store.getAt(0).raw.value;
				AOS.get('id_proj_name').setValue(value);
			}
			
		}
 */
</script>
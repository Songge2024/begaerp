<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked>
<aos:dockeditem xtype="tbtext" text="选择项目:"/>
<%-- <aos:combobox id="id_proj_name" 
			  dicField="proj_name" 
			  emptyText="项目名称"
			  selectAll="true" 
			  width="500" 
			  allowBlank="false" 
			  url="projCommonsService.listComboBoxUerid" 
			  onchange="form_refresh"/> --%>
			  <aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="250" />
			 <aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			  </aos:docked>
			

<script>
	function form_refresh(){
		var proj_id = id_proj_name.getValue();
		if(AOS.empty(proj_id)){
			return;
		}
		AOS.reset(checkCount_query);
		id_check_name_store.getProxy().extraParams={
			 proj_id : proj_id 
		};
		id_check_name_store.load();
		id_check_user_id_store.getProxy().extraParams={
			 proj_id : proj_id 
		};
		id_check_user_id_store.load();
		checkMainCount_grid_store.getProxy().extraParams={
			 proj_id : proj_id 
		};
		checkMainCount_grid.getStore().loadPage(1);
	}
	//设置默认项目
	window.onload = function(){
		  var proj_id = '${proj_id}';
		  var proj_name = '${proj_name}';
    	  if(proj_id !=null && proj_id!=''){
    		AOS.setValue('id_proj_name',proj_id);
    		AOS.setValue('tree_proj_name',proj_name);
    		form_refresh();
    	  }}
    	  
    //点击选择项目
	function t_org_find_select() {
	  	var record = AOS.selectone(t_org_find);
	  	if(record.raw.a=="1"){
	  	AOS.setValue('id_proj_name',record.raw.id);
	  	AOS.setValue('tree_proj_name',record.raw.text);
	  	form_refresh();
		w_org_find.hide();
	  	}else{
			AOS.tip("请选择项目!");
			return;
			//w_org_find.hide();
		}
		
	  }
	
	//弹出选择上级模块窗口
	  function proj_tree_show() {
	  	w_org_find.show();
	  }


	/* //默认选中第一个项目
	window.onload = function combobox_select(){
		var value = AOS.get('id_proj_name').store.getAt(0).raw.value;
		AOS.get('id_proj_name').setValue(value);
	} */
	
	
</script>
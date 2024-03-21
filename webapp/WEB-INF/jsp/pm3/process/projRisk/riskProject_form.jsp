<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="项目列表" />
	<%-- 	<aos:combobox  id="id_proj_name" emptyText="项目名称"  queryMode="local"
		editable="true" 
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true"  width="300" allowBlank="false"
		 url="projCommonsService.listComboBoxUerid"  onselect="proj_onselect"/> --%>
			 <aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="250" />
			 <aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
	</aos:docked>
	<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目基本信息"/>
	</aos:docked>
	<aos:formpanel 
		id="risk_project_form"
		width="100"
	  	layout="column" 
	  	labelWidth="100">
	<%@ include file="riskProject_fields.jsp"%>
	</aos:formpanel>
	
	
<script type="text/javascript">

/* window.onload = function combobox_select(){
	
	
	var record = t_org_find;
	var arr = record.store.tree.root.childNodes;
	if(arr.length > 0){
		var proj_id = arr[0].raw.id;
		var porj_name = arr[0].raw.text;
		AOS.get('id_proj_name').setValue(proj_id);
		AOS.get('tree_proj_name').setValue(porj_name);
	//	var value = AOS.get('id_proj_name').getValue();
		//AOS.get('id_proj_name').setValue(value);
		AOS.ajax({
			params:{proj_id : arr[0].raw.id},
	        url: 'processService.loadFormInfo',
	        ok: function (data) {
	           AOS.setValues(risk_project_form,data);
	           }
	        });
		 riskList_grid_store.getProxy().extraParams = {
			 proj_id : arr[0].raw.id
		    	
		   };
		 riskList_grid_store.loadPage(1);
	}

} */
//项目选择
function proj_onselect(){
	var proj_id = id_proj_name.getValue();
		AOS.ajax({
			params:{proj_id : proj_id},
	        url: 'processService.loadFormInfo',
	        ok: function (data) {
	           AOS.setValues(risk_project_form,data);
	           }
	        });
		
	//var proj_id = AOS.getValue('id_proj_name');
		 riskList_grid_store.getProxy().extraParams = {
			 proj_id : proj_id
		    	//ahtor:params.keyWords,
		    	//press:params.keyWords
		   };
		  riskList_grid_store.loadPage(1);
}

//项目风险跟踪自动选择默认项目
window.onload = function(){
		  var proj_id = '${proj_id}';
		  var proj_name = '${proj_name}';
    	  if(proj_id !=null && proj_id!=''){
    		AOS.setValue('id_proj_name',proj_id);
    		AOS.setValue('tree_proj_name',proj_name);
	
    		proj_onselect();
			}
	}
//单击选择项目
function t_org_find_select() {
  	var record = AOS.selectone(t_org_find);
  	if(record.raw.a=="1"){
  	AOS.setValue('id_proj_name',record.raw.id);
  	AOS.setValue('tree_proj_name',record.raw.text);
  	proj_onselect();
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




</script>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:formpanel  id="projCommons_form" region="north"  bodyBorder="0 0 1 0" height="-350" >		
		<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="项目信息" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:combobox  id="id_proj_name"  emptyText="项目名称" onselect="proj_onselect" margin="0 5 0 0"
					 width="400" allowBlank="false" 
					 url="projCommonsService.listComboBoxUerid"/>
	</aos:docked>
	<%@ include file="projCommons_fields.jsp"%>
	</aos:formpanel>
	<script type="text/javascript">
	
	//项目选择
	function proj_onselect(obj){
		var proj_id = obj.getValue();
		//AOS.reset(projCommons_form);
	 	AOS.ajax({
	 			params:{proj_id : proj_id},
		        url: 'contractPayInfoService.loadFormInfo',
		        ok: function (data) {
		           AOS.setValues(projCommons_form,data);
		           }
		        });
					var params = {proj_id : proj_id};
		        	projContract1_grid_store.getProxy().extraParams = params;
		        	projContract1_grid_store.loadPage(1);
		        	
		        	contractStage1_grid_store.getProxy().extraParams = params;
		        	contractStage1_grid_store.loadPage(1);
		        	var params1 = {proj_id : -1};
		        	contractPayInfo_grid_store.getProxy().extraParams = params1;
		        	contractPayInfo_grid_store.loadPage(1); 
	}
</script>
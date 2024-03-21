<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:combobox  id="templet_id"  name="templet_id" columnWidth="0.33" width="400" fieldLabel="过程模板" emptyText="模板名称"  
		editable="true"
	 	queryMode="local"
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true" 
		url="processService.listComboBoxTemletData" 
		onselect="projectTemplet_onselect"/>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID"/>
	<aos:textfield name="proj_name" fieldLabel="项目名称" columnWidth="0.33" readOnly="true"/>
	<aos:hiddenfield name="type_code" columnWidth="0.33" fieldLabel="项目类型id"/>
	<aos:textfield name="type_code_name" columnWidth="0.33" fieldLabel="项目类型" readOnly="true" />
	<aos:textfield name="pm_user_name" columnWidth="0.33" fieldLabel="项目经理" readOnly="true" />
	<aos:textfield name="pm2_user_name" columnWidth="0.33" fieldLabel="开发经理" readOnly="true"/>
	<aos:textfield name="client_name" columnWidth="0.33" fieldLabel="客户名称" readOnly="true"/>
	<aos:textfield name="client_address" columnWidth="0.33" fieldLabel="客户地址" readOnly="true" />
	<aos:textfield name="begin_date" columnWidth="0.33" fieldLabel="启动时间" readOnly="true"/>
	<aos:combobox name = "state" columnWidth="0.33" fieldLabel="项目状态" dicField="global_state" readOnly="true" />
	<script type="text/javascript">
	//过程选择
	function projectTemplet_onselect(obj){
		var templet_id = obj.getValue();
		var proj_id = AOS.getValue('process_project_form.proj_id');
		if(proj_id==''){
			AOS.info('请先选择一个项目!');
			return;
		}
		var msg =  AOS.merge('是否要选择此模板作为该项目的模板!');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
		//		AOS.tip('操作被取消。');
				return;
			}
			AOS.ajax({
				url : 'processService.saveProcessCut',
				params:{
					templet_id: templet_id,
					proj_id : proj_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					AOS.hides(process_project_form,'templet_id');
					var params ={ proj_id : proj_id };
					// processCut_grid_store.getProxy().extraParams = params;
					// processCut_grid_store.loadPage(1);
					 processCut_grid_store.reload();
			         processCutFiletype_grid_store.getProxy().extraParams = params;
			         processCutFiletype_grid_store.loadPage();
			        
				}
			});
		});
	}
	</script>
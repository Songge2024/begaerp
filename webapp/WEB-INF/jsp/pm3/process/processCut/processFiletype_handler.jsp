<%@ page contentType="text/html; charset=utf-8"%>

//加载
function process_query(obj) {
			var params = {};
		 	var proj_id = obj.value;
		 	params.proj_id = proj_id;
			processCut_grid_store.getProxy().extraParams = params;
	     processCut_grid_store.loadPage(1);
	}
		//弹出选择上级模块窗口
			  function proj_tree_show() {
			  	w_org_find.show();
			  }
			  
			  //项目过程裁剪自动加载默认项目
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
			  //刷新上级模块树
				function t_org_find_refresh() {
					var proj_id = id_proj_name.getValue();
					var refreshnode = t_org_find.getRootNode();
					t_org_find_store.load({
						params:{
							proj_id : proj_id
						},
						callback : function() {
							//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
							refreshnode.collapse();
							refreshnode.expand();
						}
					});
				}

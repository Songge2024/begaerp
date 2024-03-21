<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0" id="task_user_docked">
	<aos:dockeditem xtype="tbtext" text="我的任务信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem xtype="tbtext" text="选择项目" />
	<%-- <aos:combobox 
		fieldLabel="选择项目" 
		labelAlign="right" 
		name="proj_id" 
		width="200"
		editable="true"
		json="[]"
		queryMode="local"
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true"
		onselect="task_docked_project_combobox_select"	
		labelWidth="65"
	/> --%>
	<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show1" width="250" />
	<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
    <aos:dockeditem xtype="tbfill" />
    <aos:combobox id="id_task_state" name="task_state" value="1000" onselect="select_task_state" width="120">
		<aos:option value="all" display="所有" />
		<aos:option value="1000" display="未关闭" />
		<aos:option value="1002" display="已发布" />
		<aos:option value="1003" display="已接收"/>
		<aos:option value="1004" display="已完成" />
		<aos:option value="1005" display="已关闭" />
		<aos:option value="1007" display="已暂停"/>
	</aos:combobox>
	
    <aos:dockeditem text="所有"  icon="app_columns.png"	onclick="task_grid_docked_select_all_button_click" hidden="true"/>
	<aos:dockeditem text="未关闭" icon="task1.png"	onclick="task_grid_docked_select_not_close_button_click" hidden="true"/>
	<aos:dockeditem text="已发布" icon="go.gif"	onclick="task_grid_docked_select_publish_button_click" hidden="true"/>
	<aos:dockeditem text="已接收" icon="ok.png" onclick="task_grid_docked_select_receive_button_click" hidden="true"/>
	<aos:dockeditem text="已完成" icon="task_finish.png"	 onclick="task_grid_docked_select_finish_button_click" hidden="true"/>
	<aos:dockeditem text="已关闭" icon="close.png" onclick="task_grid_docked_select_close_button_click" hidden="true"/>
	<aos:dockeditem text="日历" 	onclick="task_grid_docked_select_calendar_button_click" hidden="true"/>
	<aos:dockeditem text="看板" 	onclick="task_grid_docked_select_board_button_click" hidden="true"/>
</aos:docked>

<aos:window id="w_org_find1" x="0" y="30" title="项目树[单击选择]" height="-30" width="410" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="t_org_find1" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select1" />
</aos:window>
<script type="text/javascript">
     //选择任务
     function select_task_state(){
    	 var task_state = id_task_state.getValue();
    	 var proj_id = id_proj_name.getValue();
    	 //var proj_id ='';
    	 //选择所有
    	 if(task_state =='all'){
    		 task_state = '1001,1002,1003,1004,1005,1007';
    	 }
    	 //选择未关闭的
    	 if(task_state == '1000'){
    		 task_state = '1001,1002,1003,1004,1007';
    	 }
    	 
    	 CurrentTaskGrid.reload({
 			proj_id: proj_id,
 			states: task_state
 		 });
     }
     
     function proj_name_query(){
			var proj_name = AOS.getValue('proj_name');
			t_org_find1_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
     
	//初始化项目下拉选择
	/* CurrentTaskPage.on("userProjectsReady", function(page, projects) {
		projects.unshift({display:'所有项目',value:''});
		task_user_docked.down("combobox").getStore().loadData(projects);
	});
	task_user_docked.down("combobox").on("change",function(combox){
		combox.getStore().clearFilter();
		if(!AOS.empty(combox.getRawValue())){
			var on_query_firstLetter=pinyinUtil.getFirstLetter(combox.getRawValue()).toUpperCase();
			combox.getStore().filterBy(function(record) {
				var to_query_firstLetter= pinyinUtil.getFirstLetter(record.get("display"));
				return to_query_firstLetter.indexOf(on_query_firstLetter)!=-1;
			});
		}
		if (combox.store.getCount()) {
			combox.expand();
        } else {
        	combox.collapse();
        }
	}); */
	//选择项目价值项目任务
	function task_docked_project_combobox_select(){
		var proj_id = id_proj_name.getValue();
		/* if (AOS.empty(records)) {
			AOS.tip("请选择一个项目");
			return;
		}
		record = records[0];
		var proj_id = record.get("value"); */
		var task_state = id_task_state.getValue();
		//选择所有
	   	if(task_state =='all'){
	   		task_state = '1001,1002,1003,1004,1005,1007';
	   	} 
	   	//选择未关闭的
	    if(task_state == '1000'){
	   		task_state = '1001,1002,1003,1004,1007';
	    }
		CurrentTaskPage.initParams({proj_id:proj_id});
		CurrentTaskGrid.initParams({proj_id:proj_id});
		CurrentTaskGrid.reload({
			//states:"1001,1002,1003,1004"
			states: task_state,
			proj_id: proj_id
		});
		/* //基础数据准备完成后执行加载
		CurrentTaskPage.on("ready", function() {
			
		}); */
	}
	//查询所有状态任务
	function task_grid_docked_select_all_button_click(){
		//使用者参数配置
		CurrentTaskGrid.reload({
			proj_id:'',
			states:"1002,1003,1004,1005"
		});
	}
	//查询已发布的任务
	function task_grid_docked_select_publish_button_click(){
		CurrentTaskGrid.reload({
			states:"1002"
		});
	}
	//查询已接收任务
	function task_grid_docked_select_receive_button_click(){
		CurrentTaskGrid.reload({
			states:"1003"
		});
	}
	//查询已完成的任务
	function task_grid_docked_select_finish_button_click(){
		CurrentTaskGrid.reload({
			states:"1004"
		});
	}
	//查询已关闭的任务
	function task_grid_docked_select_close_button_click(){
		CurrentTaskGrid.reload({
			states:"1005"
		});
	}
	//查询未关闭的任务
	function task_grid_docked_select_not_close_button_click(){
		CurrentTaskGrid.reload({
			states:"1001,1002,1003,1004"
		});
	}
	//日历模式查看任务
	function task_grid_docked_select_calendar_button_click(){
	
	}
	//看板模式查看任务
	function task_grid_docked_select_board_button_click(){
	
	}
	 function proj_tree_show1() {
		  	w_org_find1.show();
		  }
	 
	function t_org_find_select1() {
		var record = AOS.selectone(t_org_find1);
	//	AOS.tip(record.raw.a);
		if(record.raw.a== "true" || record.raw.a == "1"){
		AOS.setValue('id_proj_name',record.raw.id);
		AOS.setValue('tree_proj_name',record.raw.text);
		task_docked_project_combobox_select();
		w_org_find1.hide();
		}else{
			AOS.tip("请选择项目!");
			return;
			//w_org_find.hide();
		}
	}
	
	//自动加载默认项目
	window.onload = function() {
		
		var proj_id = '${proj_id}';
		var proj_name = '${proj_name}';
		AOS.setValue('id_proj_name',proj_id);
		AOS.setValue('tree_proj_name',proj_name);
		task_docked_project_combobox_select();
		id_task_state.setValue('1000');
	}
</script>


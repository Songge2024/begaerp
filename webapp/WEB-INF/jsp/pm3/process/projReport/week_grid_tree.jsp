<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked>
	<%-- <aos:combobox id="pm_proj_id" dicField="proj_name" emptyText="请选择项目"
		selectAll="true" width="300" allowBlank="false"
		onselect="proj_onselect" url="projCommonsService.listComboBoxUerid" /> --%>
	<aos:triggerfield id="tree_proj_name" name="tree_proj_name"
		editable="false" trigger1Cls="x-form-search-trigger"
		onTrigger1Click="proj_tree_show" width="280" />
	<aos:hiddenfield id="id_proj_name" name="id_proj_name" />
</aos:docked>

<aos:gridpanel id="week_grid" url="weekService.page" forceFit="true"
	onitemclick="week_grid_select" region="center" bodyBorder="1 0 1 0">
	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="项目周报列表" />
	</aos:docked>
	<!-- 隐藏的内容 -->
	<aos:column header="周报ID" dataIndex="week_id" hidden="true" />
	<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
	<aos:column header="项目ID" dataIndex="proj_id" hidden="true"
		fixedWidth="80" />
	<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280"
		hidden="true" />
	<!-- 显示内容 -->
	<aos:column header="项目周" dataIndex="task_plan_num" fixedWidth="80" />
	<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="120"
		type="date" format="Y-m-d" width="100" align="center" />
	<aos:column header="结束时间" dataIndex="end_date" fixedWidth="120"
		type="date" format="Y-m-d" width="100" align="center" />
</aos:gridpanel>

<script type="text/javascript">
     //项目汇报自动选择默认项目
     window.onload = function(){
    	 var proj_id = '${proj_id}';
		 var proj_name = '${proj_name}';
		 if(proj_id !=null && proj_id!=''){
	    		AOS.setValue('id_proj_name',proj_id);
	    		AOS.setValue('tree_proj_name',proj_name);
		 }
		 proj_onselect();
     }
    //项目汇报点击选择项目
	function t_org_find_select() {
		var record = AOS.selectone(t_org_find);
		if(record.raw.a=="1"){
		AOS.setValue('id_proj_name', record.raw.id);
		AOS.setValue('tree_proj_name', record.raw.text);
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

	//项目选择
	function proj_onselect() {
		var proj_id = id_proj_name.getValue();
		process_project_form.form.reset();
		week_detail_form.form.reset();
		//加载项目基本信息项
		AOS.ajax({
			params : {
				proj_id : proj_id
			},
			url : 'processService.loadFormInfo',
			ok : function(data) {
				AOS.setValues(process_project_form, data);
			}
		});
		//项目周报列表刷新
		var params = new Object();
		params.proj_id = proj_id;
		week_grid_store.getProxy().extraParams = params;
		week_grid_store.loadPage(1);

		//项目人员加载
		AOS.ajax({
			params : {
				proj_id : proj_id
			},
			url : 'projReportService.loadPorjPersonInfo',
			ok : function(data) {
				AOS.setValues(process_project_form, data);
			}
		});
	}

	//周报列表单击事件
	function week_grid_select() {
		var record = AOS.selectone(week_grid, true);
		var proj_id = AOS.getValue('process_project_form.proj_id');
		var week_name = record.data.task_plan_num;
		var weekid = record.data.week_id;
		AOS.setValue("process_project_form.week_name", proj_name.getValue()
				+ week_name + "项目周报");
		//项目基本信息加载
		AOS.ajax({
			params : {
				proj_id : proj_id,
				week_id : weekid
			},
			url : 'projReportService.loadFormInfo',
			ok : function(data) {
				AOS.setValues(process_project_form, data);
				AOS.setValue("process_project_form.demand_deal_num",
						data.demand_add_num - data.demand_fin_num);
				AOS.setValue("process_project_form.task_deal_num",
						data.task_add_num - data.task_fin_num);
				AOS.setValue("process_project_form.bug_deal_num",
						data.bug_add_num - data.bug_fin_num);
			}
		});
		//周报详情加载
		AOS.ajax({
			params : {
				test_code : record.data.test_code,
				week_id : record.data.week_id
			},
			url : 'projReportService.loadWeekDetailInfo',
			ok : function(data) {
				AOS.setValues(week_detail_form, data);
			}
		});

		//周报明细加载
		var params = new Object();
		params.test_code = record.data.test_code;
		params.proj_id = record.data.proj_id;
		//本周任务详情加载
		week_detail_grid_store.getProxy().extraParams = params;
		week_detail_grid_store.loadPage(1);
		//下周工作计划
		nextweek_work_plan_store.getProxy().extraParams = params;
		nextweek_work_plan_store.loadPage(1);
		//工时加载
		work_hours_store.getProxy().extraParams = params;
		work_hours_store.loadPage(1);

	}
</script>
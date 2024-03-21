<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="ta_week_report" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:tabpanel tabPosition="top" id="id_tabpanel" region="center"
			bodyBorder="0 0 0 0" margin="0 0 2 0">
			<aos:tab id="task_" title="任务一览表" layout="border" autoScroll="false">
				<aos:panel region="north" width="350" bodyBorder="0 1 0 0">
					<aos:formpanel id="query_task_num" labelWidth="70" header="false"
						region="north" border="false" anchor="100%">
						<aos:docked forceBoder="0 0 1 0">
							<aos:dockeditem xtype="tbtext" text="查询条件" />
						</aos:docked>
						<aos:textfield fieldLabel="编号" name="id" margin="0 0 0 -40"
							columnWidth="0.14" />
						<aos:textfield fieldLabel="姓名" name="name" margin="0 0 0 -40"
							columnWidth="0.14" />
						<aos:checkboxgroup id="id_okManage" onchange="task_onchange"
							fieldLabel="没有任务" columns="[70]" columnWidth="0.12">
							<aos:checkbox name="flag_m" boxLabel="" inputValue="1" />
						</aos:checkboxgroup>
						<aos:dockeditem xtype="button" text="查询" onclick="proj_task_query"
							icon="query.png" columnWidth="0.15" margin="0 0 10 100" />
						<aos:dockeditem xtype="button" text="重置"
							onclick="AOS.reset(query_task_num);" icon="refresh.png"
							columnWidth="0.07" margin="0 0 10 10" />
						<aos:dockeditem xtype="tbfill" />
					</aos:formpanel>
				</aos:panel>
				<aos:gridpanel id="proj_task_grid" url="projTaskService.projTask"
					onitemclick="action_tab_db" onrender="proj_task_query"
					region="center">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" />
					</aos:docked>
					<aos:column type="rowno" />
					<aos:column header="编号" dataIndex="id" fixedWidth="80"
						align="center" />
					<aos:column header="姓名" dataIndex="name" fixedWidth="120"
						align="center" />
					<aos:column header="项目角色" dataIndex="display" fixedWidth="380"
						align="left" />
					<aos:column header="当前任务数" dataIndex="num" fixedWidth="80"
						align="center" />
					<aos:column header="未接受任务数 " dataIndex="yfb_task" fixedWidth="100"
						align="center" />
					<aos:column header="进行中任务数" dataIndex="yzs_task" fixedWidth="100"
						align="center" />
					<aos:column header="操作" rendererFn="task_xq" hidden="true"
						fixedWidth="180" align="center" />
				</aos:gridpanel>
			</aos:tab>
			<aos:tab id="task_xqs" title="任务详情" layout="border"
				autoScroll="false">
				<aos:panel region="north" width="350" bodyBorder="0 1 0 0">
					<aos:formpanel id="query_task_hz" labelWidth="70" header="false"
						region="north" border="false" anchor="100%">
						<aos:docked forceBoder="0 0 1 0">
							<aos:dockeditem xtype="tbtext" text="查询条件" />
						</aos:docked>
						<aos:combobox fieldLabel="日期" name="main_time" columnWidth="0.14"
							margin="0 -10 0 -40" onselect="fn_change">
							<aos:option value="4" display="当天" />
							<aos:option value="1" display="本周" />
							<aos:option value="2" display="本月" />
							<aos:option value="3" display="本年" />
						</aos:combobox>
						<aos:datefield name="plan_begin_time" fieldLabel="开始时间"
							format="Y-m-d " columnWidth="0.18" editable="false"
							margin="0 -10 0 0" />
						<aos:datefield name="plan_end_time" fieldLabel="结束时间"
							format="Y-m-d " columnWidth="0.18" editable="false"
							margin="0 0 0 0" />
						<aos:hiddenfield fieldLabel="编号" name="id" columnWidth="0.14" />
						<aos:dockeditem xtype="button" text="查询" onclick="t_task_query"
							icon="query.png" columnWidth="0.16" margin="0 0 10 100" />
						<aos:dockeditem xtype="button" text="重置"
							onclick="AOS.reset(query_week_hz);" icon="refresh.png"
							hidden="true" columnWidth="0.07" margin="0 0 10 10" />
						<aos:dockeditem xtype="tbfill" />
					</aos:formpanel>
				</aos:panel>
				<aos:gridpanel id="task_grid" url="projTaskService.projTasks"
					region="center">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" />
					</aos:docked>
					<aos:column type="rowno" />
					<aos:column header="编号" dataIndex="id" fixedWidth="80" hidden="true"
						align="center" />
					<aos:column header="姓名" dataIndex="name" fixedWidth="100"
						align="center" >
						<aos:textfield allowBlank="false" /> 
					</aos:column>
					<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="220"
						align="left" />
					<aos:column header="当前任务" dataIndex="task_name" fixedWidth="280"
						celltip="true" align="left" />
					<aos:column header="是否逾期" dataIndex="overdue" rendererFn="o_fn" fixedWidth="80"
						align="center" />
					<aos:column header="计划开始时间" dataIndex="plan_begin_time"
						fixedWidth="180" align="center" />
					<aos:column header="实际开始时间" dataIndex="real_begin_time"
						fixedWidth="180" align="center" />
					<aos:column header="已持续天数" dataIndex="days" fixedWidth="100"
						align="center" />
					<aos:column header="计划结束时间" dataIndex="plan_end_time"
						fixedWidth="180" align="center" />
					<aos:column header="实际结束时间" dataIndex="real_end_time"
						fixedWidth="180" align="center" />
				</aos:gridpanel>
			</aos:tab>
			<%-- <aos:window id="task_num_win" title="任务详情"  width="1000" height="480">
				<aos:gridpanel id="task_grid" url="projTaskService.projTasks"
			onrender="task_click" region="center">
			<aos:column type="rowno" />
			<aos:column header="编号" dataIndex="id" fixedWidth="80" align="center"
				rendererFn="id" />
			<aos:column header="姓名" dataIndex="name" fixedWidth="120"
				rendererFn="name" align="center" />
			<aos:column header="当前任务" dataIndex="task_name" fixedWidth="380"
				celltip="true" align="left" />
				<aos:column header="是否逾期" dataIndex="overdue" fixedWidth="80"
				rendererFn="overdue" align="center" />
			<aos:column header="计划开始时间" dataIndex="plan_begin_time"
				fixedWidth="180" rendererFn="plan_begin_time" align="center" />
			<aos:column header="实际开始时间" dataIndex="real_begin_time"
				fixedWidth="180" rendererFn="real_begin_time" align="center" />
			<aos:column header="已持续天数" dataIndex="days" fixedWidth="100"
				rendererFn="days" align="center" />
			<aos:column header="计划结束时间" dataIndex="plan_end_time"
				rendererFn="plan_end_time" fixedWidth="180" align="center" />
			<aos:column header="实际结束时间" dataIndex="real_end_time"
				rendererFn="real_end_time" fixedWidth="180" align="center" />
		</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="#task_num_win.hide();" text="关闭"
			icon="close.png" />
		</aos:docked>
	</aos:window>--%>
		</aos:tabpanel>
	</aos:viewport>
	<script type="text/javascript">
	
	//监听行编辑事件
	function fn_edit(editor, e) {
		if (!e.record.dirty) {
			AOS.tip('数据没变化，保存取消。');
			return;
		}
		
	}
	//触发编辑前事件
	function fn_beforeedit(obj, e) {
		var editing = task_grid.getPlugin('id_plugin');
		var rowEditor = editing.getEditor();
		//这行是修复行编辑的一个bug，当数据校验时候如果初始时数据不合法，则数据纠正后保存按钮也不能用的bug。
		rowEditor.on('fieldvaliditychange', rowEditor.onFieldChange,
				rowEditor);
	}
	
	
		//表格数据

		function t_task_query() {
			var date_ = '${plan_begin_time}';
			var date1_ = '${plan_end_time}';
			var params = AOS.getValue('query_task_hz');
			task_grid_store.getProxy().extraParams = params;
			task_grid_store.loadPage(1);
		}
		function proj_task_query() {
			var date_ = '${plan_begin_time}';
			var date1_ = '${plan_end_time}';
			var params = AOS.getValue('query_task_num');
			proj_task_grid_store.getProxy().extraParams = params;
			proj_task_grid_store.loadPage(1);
		}
		function task_num_query() {
			var params = AOS.getValue('query_task_hz');
			task_grid_store.getProxy().extraParams = params;
			task_grid_store.loadPage(1);
		}
		function task_onchange() {
			var flag_m = AOS.getValue('query_task_num.flag_m');
			if (flag_m == 1) {
				proj_task_grid_store.reload({
					params : {
						flag_m : flag_m
					}
				});
			} else {
				proj_task_query();
			}
			//AOS.reset(query_week_hz);

		}

		//列表双击跳转
		function action_tab_db(me, record) {
			var id = record.data.id;
			AOS.ajax({
				params : {
					id : id
				},
				url : 'projTaskService.actionTabDb',
				ok : function(data) {
					AOS.setValue('query_task_hz.id', data.id);
					var params = AOS.getValue('query_task_hz');
					task_grid_store.getProxy().extraParams = params;
					task_grid_store.reload(1);
					id_tabpanel.setActiveTab(1);
				}
			});
		}

		//个人任务
		function task_click() {
			var select = AOS.select(proj_task_grid, 'id');
			var id = select[0].data.id;
			task_grid_store.reload({
				params : {
					id : id
				}
			});
		}

		function task_xq(value, metaData, record) {
			return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn"   onclick="show_task();" />';
		}

		function id(value, metaData, record) {
			return '<p style="width: 100%;text-align: center;">'
					+ record.data.id + '</p>';
		}
		function name(value, metaData, record) {
			return '<p style="width: 100%;text-align: center;">'
					+ record.data.name + '</p>';
		}
		function task_name(value, metaData, record) {
			return '<p style="width: 100%;display: block;text-align: center;">'
					+ record.data.task_name + '</p>';
		}
		function plan_begin_time(value, metaData, record) {
			return '<p style="width: 100%;display: block;text-align: center;">'
					+ record.data.plan_begin_time + '</p>';
		}
		function real_begin_time(value, metaData, record) {
			return '<p style="width: 100%;display: block;text-align: center;">'
					+ record.data.real_begin_time + '</p>';
		}
		function days(value, metaData, record) {
			return '<p style="width: 100%;display: block;text-align: center;">'
					+ record.data.days + '</p>';
		}
		function plan_end_time(value, metaData, record) {

			return '<p style="width: 100%;display: block;text-align: center;">'
					+ record.data.plan_end_time + '</p>';
		}
		function real_end_time(value, metaData, record) {

			return '<p style="width: 100%;display: block;text-align: center;">'
					+ record.data.real_end_time + '</p>';
		}
		function overdue(value, metaData, record) {
			return '<p style="text-align: center;">' + record.data.overdue
					+ '</p>';
		}
		
		function o_fn(value, metaData, record) {
			if (value == '是') {
				return "<span style='color:red; font-weight:bold'>是</span>";
			}
			else{
				return "<span style='color:green; font-weight:bold'>否</span>";
			}
			return value;
		}
		//查询时间段改变
		function fn_change(obj) {
			var val = obj.getValue();
			var date_ = '${plan_begin_time}';
			var date1_ = '${plan_end_time}';
			var today_date_ = '${today_date}';
			var year_begin_date_ = '${year_begin_date}';
			var year_end_date_ = '${year_end_date}';
			var recently_begin_date_ = '${recently_begin_date}';
			var recently_end_date_ = '${recently_end_date}';
			var week_begin_date_ = '${week_begin_date}';
			var week_end_date_ = '${week_end_date}';
			if (val == "1") {
				AOS.setValue('query_task_hz.plan_begin_time', week_begin_date_);
				AOS.setValue('query_task_hz.plan_end_time', week_end_date_);
			} else if (val == "2") {
				AOS.setValue('query_task_hz.plan_begin_time', date_);
				AOS.setValue('query_task_hz.plan_end_time', date1_);
			} else if (val == "3") {
				AOS.setValue('query_task_hz.plan_begin_time', year_begin_date_);
				AOS.setValue('query_task_hz.plan_end_time', year_end_date_);

			} else if (val == "4") {
				AOS.setValue('query_task_hz.plan_begin_time', today_date_);
				AOS.setValue('query_task_hz.plan_end_time', today_date_);

			}

			var params = AOS.getValue('query_task_hz');
			task_grid_store.getProxy().extraParams = params;
			task_grid_store.loadPage(1);
		}
	</script>
</aos:onready>
<script type="text/javascript">

//项目详情显示窗口
function show_task(){
		AOS.get("task_num_win").show();
		
}
</script>
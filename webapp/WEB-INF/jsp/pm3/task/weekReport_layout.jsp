<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="周报汇总" base="http" lib="ext" >
<link rel="stylesheet" type="text/css" href="${cxt}/static/css/modules/bootstrap.min.css" />

<aos:body>
	<style>
.editormd-html-preview {
	width: 90%;
	height: auto;
	margin: 0 auto;
}
</style>
	<div id="week_list" style="width: 100%; height: 100%; border: 0;">
		<iframe id="iframe_main" style="border: 0; width: 100%; height: 100%"
			src=""></iframe>
	</div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="query_form" layout="column" labelWidth="70"
			header="false" region="north" border="false">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:combobox fieldLabel="项目周" id="week"  name="task_plan_num"  
				editable="false" columnWidth="0.13" url="weekService.listWeek" onselect="query_button_click" />
		        <aos:datefield name="begin_date" fieldLabel="开始时间" format="Y-m-d "
					columnWidth="0.2" editable="false" margin="0 -10 0 0" onchange="changeweekBdt" />
				<aos:datefield name="end_date" fieldLabel="结束时间" format="Y-m-d "
					columnWidth="0.2" editable="false" margin="0 -10 0 0" onchange="changeweekBdt" />
			<aos:dockeditem xtype="button" text="查询" margin="0 10 0 60"
				onclick="query_button_click" icon="query.png" />
			<aos:dockeditem xtype="button" text="重置" margin="0 10 0 0"
				onclick="AOS.reset(query_form);" icon="refresh.png" />
		
		</aos:formpanel>
	<aos:treepanel id="public_tree"  title="项目列表" singleClick="false" collapsible="true"    columnLines="true" 
	    split="true" region="west"   width="280" 
		cascade="true" rootVisible="false"
	    url="weekReportService.my_project_tree"
	    border="true" onitemclick="on_public_tree"     >
	  
	</aos:treepanel> 
				<aos:gridpanel id="g_account_week" url="weekService.page1"
					onrender="g_week_query" region="center">
					<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="周报列表" />
				<aos:dockeditem xtype="tbseparator" />
	        	<aos:dockeditem text="周报详情" icon="query.png" onclick="fn_click_projWeek" />
			</aos:docked>
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:menu>
	        	      <aos:menuitem text="周报详情" icon="query.png" onclick="fn_click_projWeek" />
                   </aos:menu>
					<aos:column type="rowno" />
					<!-- 隐藏的内容 -->
					<aos:column header="周报ID" dataIndex="week_id" hidden="true" />
					<!-- 显示内容 -->
					<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
					<aos:column header="项目ID" dataIndex="proj_id" hidden="true"
						fixedWidth="80" />
					<aos:column header="项目名称" dataIndex="proj_name"
						rendererFn="proj_name" fixedWidth="280" />
					<aos:column header="状态" dataIndex="flag" rendererFn="flag"
						fixedWidth="100" align="center" />
					<aos:column header="项目周" dataIndex="task_plan_num" fixedWidth="80"
					rendererFn="task_plan_num"   />
					<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="140"
						type="date" format="Y-m-d" width="100" align="center" />
					<aos:column header="结束时间" dataIndex="end_date" fixedWidth="140"
						type="date" format="Y-m-d" width="100" align="center" />
					<aos:column header="测试组长" dataIndex="test_leader" hidden="true"
						fixedWidth="100" align="center" />
					<aos:column header="创建人" dataIndex="add_name" fixedWidth="100"
						align="center" />
					<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150"
						align="center" />
		            	<aos:column header="提交时间" dataIndex="commit_time" fixedWidth="150"
						align="center" />
					<aos:column header="任务数量" dataIndex="task_plan_num"
						fixedWidth="150" hidden="true" align="center" />
					<aos:column header="周报类型" dataIndex="type" fixedWidth="150"
						hidden="true" align="center" />
					<aos:column header="备注" dataIndex="solve" align="center"
						hidden="true" />
					<aos:column header="对外情况说明" dataIndex="description" align="center"
						hidden="true" />
					<aos:window id="w_option" title="意见"  autoScroll="true"
				 height="400" width="600">
					<aos:formpanel id="f_option" height="400"  width="600" 
							  labelWidth="70">
					<aos:fieldset title="意见" labelWidth="85" columnWidth="1">
								<aos:htmleditor name="opiniontion" columnWidth="1" height="280" 
									allowBlank="false" msgTarget="qtip" margin="3" />
					</aos:fieldset>
					</aos:formpanel>
							<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem text="保存" icon="redo.png" onclick="fn_option" />
							<aos:dockeditem onclick="#w_option.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					<aos:window id="week_win" title="周报详情" onshow="week_click" autoScroll="true"
					layout="border"  height="480" width="1155">
					<aos:panel region="north" width="350" bodyBorder="0 1 0 0">
						<aos:formpanel id="f_query_d" region="center"
							anchor="100% 50%"  labelWidth="70">
							<aos:datefield name="begin_date" fieldLabel="开始时间"
								readOnly="true"    columnWidth="0.5"  />
							<aos:datefield name="end_date" fieldLabel="结束时间"
							readOnly="true"	  columnWidth="0.5" />
							<aos:hiddenfield fieldLabel="项目ID" name="proj_id" />
							<aos:hiddenfield fieldLabel="项目名称" name="proj_name" />
							<aos:hiddenfield fieldLabel="项目周" name="task_plan_num" />
							<aos:textareafield  name="solve" fieldLabel="内部总结:" height="120"
								 msgTarget="qtip" columnWidth="0.5" />
							<aos:textareafield  name="description" height="120" 
								fieldLabel="对外沟通:"  msgTarget="qtip"
								columnWidth="0.5" />
							<aos:hiddenfield name="test_code" />
							<aos:dockeditem xtype="tbfill" />
								</aos:formpanel>
							</aos:panel>
							
							<aos:tabpanel layout="vbox " anchor="100% 50%"  region="center"  tabBarHeight="22"  tabPosition="top"  >
							<aos:tab title="本周完成情况" >
							<aos:gridpanel id="g_account" url="weekReportService.page" region="center"
								hidePagebar="true" onrender="weeks_query"  anchor="100% 50%" >
							
								<aos:column type="rowno" />
								<!-- 隐藏的内容 -->
								<aos:column header="周报ID" dataIndex="id" hidden="true" />
								<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
								<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
								<aos:column header="排序号" dataIndex="no" hidden="true" />
								<aos:column header="项目名称" dataIndex="proj_name" hidden="true"
									align="left" />
								<aos:column header="周报名称" dataIndex="week_name" hidden="true"
									align="left" />
								<aos:column header="项目周" dataIndex="task_plan_num" hidden="true"
									align="center" />
								<!-- 显示内容 -->
								<aos:column header="任务状态" dataIndex="week_flag"  rendererFn="fn_week_plan"
									align="center"  width="100"  hidden="true" />
								<aos:column header="任务类型" dataIndex="week_class" rendererField="week_classs" celltip="true" width="100"
							align="center"  />
								<aos:column header="任务描述" dataIndex="remarks" width="500"
									align="left" />
								<aos:column header="负责人" dataIndex="owner_name" width="120"
									align="center" />
								<aos:column header="计划开始时间" dataIndex="begin_date" hidden="true"
									type="date" format="Y-m-d" width="100" />
								<aos:column header="计划结束时间" dataIndex="end_date" hidden="true"
									type="date" format="Y-m-d" width="100" />
								<aos:column header="实际完成时间" dataIndex="finish_time" type="date"
									format="Y-m-d" fixedWidth="100" />
								<aos:column header="完成情况" dataIndex="finish_cond" width="100" rendererFn="fn_cond"
									align="center">
									<aos:combobox name="finish_cond" allowBlank="false">
										<aos:option value="已完成" display="已完成" />
										<aos:option value="未完成" display="未完成" />
									</aos:combobox>
								</aos:column>
								<aos:column header="任务偏差分析及解决措施" dataIndex="descc" width="400">
								</aos:column>
								<aos:column header="对内情况说明" dataIndex="solve" hidden="true"
									fixedWidth="100">
									<aos:textfield allowBlank="false" />
								</aos:column>
								<aos:column header="对外情况说明" dataIndex="description"
									hidden="true" fixedWidth="100">
									<aos:textfield allowBlank="false" />
								</aos:column>
							</aos:gridpanel>
							</aos:tab>
							
					<aos:tab title="下周工作计划"> 
					<aos:gridpanel id="work_plan" url="weekReportService.work_plan_count"   hidePagebar="true"
						 anchor="100% 100%"  onrender="weeks_query" >
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" />
						<!-- 隐藏的内容 -->
						<aos:column header="周报ID" dataIndex="id" hidden="true" />
						<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
						<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
						<aos:column header="项目名称" dataIndex="proj_name" hidden="true"
							align="left" />
						<aos:column header="周报名称" dataIndex="week_name" hidden="true"
							align="left" />
						<aos:column header="项目周" dataIndex="task_plan_num" hidden="true"
							align="center" />
						<!-- 显示内容 -->
						<aos:column header="任务类型" dataIndex="week_class" rendererField="week_classs" celltip="true" width="80"
							align="center"  />
						<aos:column header="任务描述" dataIndex="remarks" celltip="true" width="500" 
							align="left" />
						<aos:column header="负责人id" dataIndex="owner_id" width="120" hidden="true"
							align="center" />
						<aos:column header="资源配置要求" dataIndex="owner_name" width="120"  celltip="true"
							align="center" />
						<aos:column header="计划开始时间" dataIndex="begin_date" 
							type="date" format="Y-m-d" width="100" />
						<aos:column header="计划结束时间" dataIndex="end_date" 
							type="date" format="Y-m-d" width="100" />
					</aos:gridpanel>
							</aos:tab>
							</aos:tabpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem text="打回" icon="redo.png" onclick="fn_update" />
							<aos:dockeditem onclick="#week_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					
					
				</aos:gridpanel>
	</aos:viewport>
	<script type="text/javascript">
	//任务状态
	function  fn_week_plan(value, metaData, record){
		if (value == '1') {
			return "<span style='color:green; font-weight:bold'>本周</span>";
		}
		if (value == '2') {
			return "<span style='color:green; font-weight:bold'>下周</span>";
		}
		return value;
	}
	//下周工作计划（任务类型）
	function work_plan_type(value, metaData, record) {
		if (value == '1') {
			return "<span  font-weight:bold'>交流沟通</span>";
		}
		if (value == '2') {
			return "<span  font-weight:bold'>成果输出</span>";
		}
		if (value == '3') {
			return "<span  font-weight:bold'>需求响应</span>";
		}
		if (value == '4') {
			return "<span  font-weight:bold'>测试与缺陷</span>";
		}
		if (value == '5') {
			return "<span  font-weight:bold'>其他</span>";
		}
	}
	//退回 意见
	function fn_option(){
		var select = AOS.select(g_account_week, 'week_id');
		var opiniontion = AOS.getValue('f_option.opiniontion');
		var week_id = select[0].data.week_id;
		var record = AOS.selectone(AOS.get('g_account_week'));
		var task_plan_num = record.data.task_plan_num
		var proj_id = record.data.proj_id
		var proj_name = record.data.proj_name
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		AOS.ajax({
			url : 'weekReportService.state_update',
			params:{
				week_id:week_id,
				opiniontion:opiniontion
			},
			ok : function(data) {
				AOS.tip("数据打回成功！");
				AOS.get('w_option').hide();
				AOS.get('week_win').hide();
				AOS.get('g_account_week').getStore().reload();
				var  token=data.appmsg;
				var count="{\"proj_id\":\""+proj_id+"\","+"\"proj_name\":\""+proj_name+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}打回"+
					task_plan_num+"项目周报\","+"\"createTime\":\""+createTime+"\"}";
				var title="项目周报"; 
				mesVO={
						 "title"  : title, 
						 "content": count,
						 "extras": {proj_id,proj_name,createTime,sedTime},
						 "mesGroup": "CHANNEL",
				     }
				AOS.weekSend(token,mesVO);
			}
		  });
		}

	//退回
	function fn_update(){
		AOS.get('w_option').show();
		AOS.setValue('f_option.opiniontion','');
		}
	
	//时间判断
	function changeweekBdt(){
		  var begin_date=AOS.getValue('query_form.begin_date');
		  var end_date=AOS.getValue('query_form.end_date');
		  if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			  AOS.setValue('query_form.end_date',null);
    		  AOS.tip("结束时间不能小于开始时间,请重新选择!");
    		  return;
		}
	}
	
	//加载表格数据
	function g_week_query() {
		AOS.setValue('query_form.end_date',new Date());
		var end_date=AOS.getValue('query_form.end_date');
		var begin_date=AOS.getValue('query_form.begin_date');
    	AOS.ajax({
			params:{
				end_date : end_date,
				begin_date : begin_date
			},
			url : 'weeklyDetailService.changeweekDates',
			ok : function(data) {
				 AOS.setValue('query_form.begin_date',data.getDate);
				 var params = AOS.getValue('query_form');
					g_account_week_store.getProxy().extraParams = params;
					g_account_week_store.loadPage(1);
			}
         });
	
	}

	
	//默认选中第一个项目
/**	window.onload = function combobox_select(){
		var value = AOS.get('proj').store.getAt(0).raw.value;
		AOS.get('proj').setValue(value);
		g_week_query();
	}
	*/
	
	
	//项目树点击方法
	function on_public_tree(view, record, node, item, e) {
		var params = new Object();
		var begin_date=AOS.getValue('query_form.begin_date');
		var end_date=AOS.getValue('query_form.end_date');
		
		var a = AOS.empty(record) ? "" : record.raw.a;
		/* 
		if(a=='0'){
			//AOS.tip('请先选择项目');
		return;
		} */
		var proj_id=record.raw.id;
		var proj_id_=String(proj_id);
		week_store.getProxy().extraParams = {
			proj_id : proj_id_,
			begin_date:begin_date,
			end_date:end_date
		};
		week_store.loadPage(1);
				params.proj_id= String(record.data.id);
				params.begin_date=begin_date;
				params.end_date=end_date;
			g_account_week_store.getProxy().extraParams = params;
			g_account_week_store.loadPage(1);	
	}
	
	function query_button_click() {
		var select = AOS.selectone(public_tree,true);
		var proj_id = AOS.empty(select) ? "" : select.raw.id;
		var proj_id_=String(proj_id);
		var begin_date=AOS.getValue('query_form.begin_date');
		var end_date=AOS.getValue('query_form.end_date');
		var task_plan_num=AOS.getValue('query_form.task_plan_num');
		
		g_account_week_store.getProxy().extraParams = {
			proj_id : proj_id_,
			begin_date:begin_date,
			end_date:end_date,
			task_plan_num:task_plan_num
		};
		g_account_week_store.loadPage(1);
		public_tree_store.getProxy().extraParams = {
		};
		public_tree_store.load();
}
	
	
	//查询时间段改变
	function fn_change(obj){
	  var val = obj.getValue();
	  var date_ = '${begin_date}';
	  var date1_ = '${end_date}';
      var year_begin_date_ = '${year_begin_date}';
	  var year_end_date_ = '${year_end_date}';
	  var recently_begin_date_ = '${recently_begin_date}';
	  var recently_end_date_ = '${recently_end_date}';
	  var week_begin_date_ = '${week_begin_date}';
	  var week_end_date_ = '${week_end_date}';
	  if(val =="1"){
		  AOS.setValue('query_week_hz.begin_date',week_begin_date_);
			AOS.setValue('query_week_hz.end_date',week_end_date_);	
		    }else if(val =="2"){
		    	 AOS.setValue('query_week_hz.begin_date',date_);
		 		AOS.setValue('query_week_hz.end_date',date1_); 
		    }else if (val =="3"){
		    	AOS.setValue('query_week_hz.begin_date',recently_begin_date_);
				AOS.setValue('query_week_hz.end_date',recently_end_date_);
		    }else if(val =="4"){
		    	AOS.setValue('query_week_hz.begin_date',year_begin_date_);
				AOS.setValue('query_week_hz.end_date',year_end_date_);	
		    	
		    }
	    var params = AOS.getValue('query_week_hz');
	    week_list_store.getProxy().extraParams = params;
	    week_list_store.loadPage(1);
	}
	<%--function g__weeks_query() {
		var date_ = '${week_begin_date}';
		var date1_ = '${week_end_date}';
		AOS.setValue('query_week_hz.main_time','1');
		AOS.setValue('query_week_hz.begin_date',date_);
		AOS.setValue('query_week_hz.end_date',date1_);
		var params = AOS.getValue('query_week_hz');
		account_week_hz_store.getProxy().extraParams = params;
		account_week_hz_store.loadPage(1);
	}
	function week_query() {
		var params = AOS.getValue('query_week_hz');
		
	}
	function proj_week(value, metaData, record) {
		return '<input type="button" value="查看" metaData.style = "color:blue" class="cbtn"   onclick="show_proj();" />';
	}
	
	--%>
	
	function flag(value, metaData, record) {
		if (value == '1') {
			return "<span style='color:green; font-weight:bold'>已提交</span>";
		}
		else{
			return "<span style='color:red; font-weight:bold'>草稿</span>";
		}
		return value;
	}
	
	function fn_cond(value, metaData, record) {
		if (value == '已完成') {
			return "<span style='color:green; font-weight:bold'>已完成</span>";
		}
		else{
			return "<span style='color:red; font-weight:bold'>未完成</span>";
		}
		return value;
	}
	
	<%--window.onload = function(){
		//加载表格数据
			var add_name = '${id}';
			AOS.setValue('query_form.add_name',add_name);
			query_button_click();
	}
	--%>
	
	//按钮列转换
	function proj_name(value, metaData, record) {
		return '<a href="javascript:void(0);">' + record.data.proj_name +  '</a>' ;
	}
	function task_plan_num(value, metaData, record) {
		return '<a href="javascript:void(0);">' + record.data.task_plan_num +  '</a>' ;
	}
	g_account_week.on("cellclick", function(grid, rowIndex, columnIndex, e) {
		if (columnIndex == 2 ) {
			AOS.get('week_win').show();
		}
		if (columnIndex == 4 ) {
			var select = AOS.select(g_account_week,'test_code');
			var arrayTcod=[];
			Ext.each(select,function(item){
				console.log(item.data.test_code);
				arrayTcod.push(item.data.test_code);
			});
			console.log(arrayTcod);
			 window.open('do.jhtml?router=weekService.init1&juid=${juid}&test_code='+arrayTcod);		
		} 
	});
	//项目详情
	function fn_click_projWeek(){
		var select = AOS.select(g_account_week);
		var arrayTcod=[];
		Ext.each(select,function(item){
			console.log(item.data.test_code);
			arrayTcod.push(item.data.test_code);
		});
		 window.open('do.jhtml?router=weekService.init1&juid=${juid}&test_code='+arrayTcod);		
	  } 
	
	//周报详情
	function week_click(){
		var select = AOS.select(g_account_week, 'test_code');
		var test_code = select[0].data.test_code;
		var begin_date = select[0].data.begin_date;
		var end_date = select[0].data.end_date;
		var solve = select[0].data.solve;
		var description = select[0].data.description;
		AOS.setValue('f_query_d.begin_date',begin_date);
		AOS.setValue('f_query_d.end_date',end_date);
		AOS.setValue('f_query_d.solve',solve);
		AOS.setValue('f_query_d.description',description);
		g_account_store.reload({
							params:{
								test_code : test_code,
								}
						});
	    work_plan_store.reload({
				params:{
					test_code : test_code,
					}
			});
	      }
	function weeks_query() {
		var select = AOS.select(g_account_week, 'test_code');
		var test_code = select[0].data.test_code;
		g_account_store.getProxy().extraParams = {test_code:test_code};
		g_account_store.loadPage(1);
		work_plan_store.getProxy().extraParams = {test_code:test_code};
		work_plan_store.loadPage(1);
	}
	
	
	</script>
</aos:onready>

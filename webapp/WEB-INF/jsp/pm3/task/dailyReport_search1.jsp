<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="aos.framework.web.router.HttpModel"%>

<aos:html title="日报" base="http" lib="ext">
	<aos:body>
		<div id="theme_list" style="width:100% ; height: 100%;border: 0;"  >
				<iframe id="iframe_main" style="border: 0;width:100% ; height: 100%" src=""></iframe>
		</div>
	</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="query_form" layout="column" labelWidth="70" header="false" region="north" border="false">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="日报汇总查阅" />
			</aos:docked>
			<aos:textfield name="name" fieldLabel="日报名称" columnWidth="0.21" />
			<aos:hiddenfield name="update_user_id" fieldLabel="修改人" />
			<aos:combobox fieldLabel="日期" name="main_time" columnWidth="0.16" margin="0 -20 0 -40"	onselect="fn_change"  >
				<aos:option value="当天" display="当天" />
				<aos:option value="本周" display="本周" />
				<aos:option value="本月" display="本月" />
				<aos:option value="最近一月" display="最近一月" />
				<aos:option value="本年" display="本年" />
				<aos:option value="自定义" display="自定义" />
			</aos:combobox>
			<aos:datefield name="begin_time" fieldLabel="从" editable="false" margin="0 -20 0 -30"	columnWidth="0.16" />
			<aos:datefield name="end_time" fieldLabel="到" editable="false" margin="0 -20 0 -30"	columnWidth="0.16" />
            <aos:hiddenfield name="state" fieldLabel="状态" value="1002" />
            <aos:combobox fieldLabel="项目组"  id="proj" name="proj_id" editable="false"  columnWidth="0.30"  onselect="proj_id_change"
					url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" />
			<aos:dockeditem xtype="button" text="查询" margin="0 10 0 60" onclick="#query_button_click();" icon="query.png" />
			<aos:dockeditem xtype="button" text="重置" margin="0 10 0 0" onclick="AOS.reset(query_form);" icon="refresh.png" />
		    <aos:dockeditem xtype="button" text="所有人日报" margin="0 10 0 0" onclick="#book_grid1_query_all();" icon="query.png" />
		</aos:formpanel>
	
		<aos:panel region="west"  bodyBorder="2 1 2 1" width="260" > 
			<aos:tab title="员工日报总览" closable="false"  id="task_all" region="center"  layout="border" margin="0 0 0 0"  >
			   	<aos:gridpanel  height="20" id="book_grid1"
						url="dailyReportService.page_sum" onrender="book_grid1_query_self" region="center"
						onitemclick="book_grid1_onitemclick">
						<aos:column header="行号" type="rowno" fixedWidth="40" hidden="true"  />
						<aos:column header="编码" dataIndex="update_user_id" fixedWidth="50"  />
						<aos:column header="日报时间" dataIndex="daily_time" type="date"
						id="book_grid2"	format="Y-m-d " fixedWidth="100" align="center" hidden="true" />
						<aos:column header="姓名" dataIndex="daily_name" align="center" />
						<aos:column header="总数" dataIndex="sum" fixedWidth="80"
							align="center" />
						<aos:column header="日报内容原" dataIndex="descc" fixedWidth="450"
							hidden="true" />
						<aos:column header="日报内容" dataIndex="desccc" hidden="true" />
						<aos:column header="日报描述" dataIndex="remark" fixedWidth="200"
							hidden="true" />
				</aos:gridpanel>
			</aos:tab>
		</aos:panel>
			        
		<aos:panel  region="center"  bodyBorder="2 1 2 1">  
			<aos:tabpanel tabPosition = "top" id="id_tabpanel" region="center" bodyBorder="0 0 0 0" margin="-5 0 0 -3">
				<aos:tab title="日报列表" closable="false"  id="task_view" region="center"  layout="border">
					<aos:gridpanel  height="20" id="book_grid" url="dailyReportService.page3" 
									onrender="book_grid_query" onitemdblclick="#w_account3_show();" region="center">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="日报列表" />
							<aos:dockeditem xtype="tbseparator" />
							<aos:dockeditem text="我的日报" icon="app_columns.png" onclick="book_grid_select_mine" />
							<aos:dockeditem xtype="button" text="导出" onclick="fn_export_excel" icon="icon70.png" />
						</aos:docked>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column header="行号" type="rowno" fixedWidth="40" />
						<aos:column header="日报编码" dataIndex="id" hidden="true" />
						<aos:column header="日报时间" dataIndex="daily_time" type="date" format="Y-m-d " fixedWidth="100" align="center" />
						<aos:column header="星期" dataIndex="week_day" fixedWidth="60" align="center" />
						<aos:column header="日报名称" dataIndex="name" fixedWidth="250" />
						<aos:column header="日报内容原" dataIndex="descc" fixedWidth="450" hidden="true" />
						<aos:column header="日报内容" dataIndex="desccc" />
						<aos:column header="日报描述" dataIndex="remark" fixedWidth="200" hidden="true" />
						<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="50" hidden="true" />
						<aos:column header="提交时间" dataIndex="update_time" type="date" format="Y-m-d H:i:s" fixedWidth="140" align="center" />
						<aos:column header="状态" dataIndex="state" rendererFn="flag" fixedWidth="60" align="center" hidden="true"  />
					</aos:gridpanel>
				</aos:tab>
					
				<aos:tab title="日报详情" closable="false" html="" id="daily_details" ></aos:tab>	
			</aos:tabpanel>
		</aos:panel>
	
		<%-- 查看日报 --%>
		<aos:window id="w_account3" title="查看日报详情" onshow="#w_account3_onshow();fn_reads2();">
			<aos:formpanel id="f_account3" height="430" width="1000" center="true" layout="anchor" labelWidth="70">
				<%-- 更新时的隐藏变量(主键) --%>
				<aos:numberfield name="id" fieldLabel="日报编码" hidden="true" />
				<aos:textfield name="name" fieldLabel="日报名称" margin="5 10 5 0" />
				<aos:datefield name="daily_time" fieldLabel="日报时间" editable="false" margin="5 10 5 0" />
				<aos:textfield name="update_user_id" fieldLabel="修&nbsp&nbsp改&nbsp人"  margin="5 10 5 0"/>
				<aos:datetimefield name="update_time" fieldLabel="修改时间" margin="5 10 5 0" editable="false" />
				<aos:textfield name="state" fieldLabel="日报状态"  margin="5 10 5 0"/>
				<aos:hiddenfield name="remark" fieldLabel="日报描述" margin="5 10 5 0"/>
				<aos:fieldset title="日报内容" labelWidth="70" margin="5 10 0 17" border="true">
					<aos:htmleditor name="descc" allowBlank="false"  margin="0 0 -5 0" width="1000" height="218" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer" margin="0 120 0 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#w_account3.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
	
	</aos:viewport>

	<script type="text/javascript">
		function query_button_click(){
			var active_tab_id=id_tabpanel.getActiveTab( ).getId();
			if(active_tab_id=='daily_details'){
				daily_details_query();
				book_grid1_query2();
			}else{
				book_grid_store.loadPage(1);
				book_grid1_query2();
			}
		}
		
		daily_details.on("activate",function(){
			daily_details_query();
		});
		
		task_view.on("activate",function(){
			book_grid_query1();
		});
		
		book_grid.getStore().on("beforeload",function(){
			var params=query_form.getValues();
			book_grid_store.getProxy().extraParams = params;
			return true;
		});
		
		function daily_details_query(){
			
			var params=query_form.getValues(); 
			/* {
				name:123,
				begin_time:456
			} */
			
			var src='do.jhtml?router=dailyReportService.fn_select_all&juid=${juid}';
			for(var pro in params){
				src+='&'+pro+'='+params[pro];
			}
			//src="$name=123&begin_time=456"
			daily_details.update('<iframe style="border: 0;width:100% ; height: 100%" src="'+src+'"></iframe>');
		}
		
		function book_grid1_onitemclick(){
			var selection = AOS.selection(book_grid1, 'update_user_id').replace(",","");
			AOS.setValue('query_form.update_user_id',selection);
			daily_details_query();
			book_grid_store.loadPage(1);
		}
		
		//去除项目组下拉框的标签
		function proj_id_change(){	
            AOS.get('proj').setRawValue(AOS.get('proj').lastSelection[0].raw.display.replace('<nobr>','').replace('</nobr>',''));   
		}
		
		
		//加载表格数据
		function book_grid_query() {
			var date_ = '${begin_date}';
			var date1_ = '${end_date}';	
			AOS.setValue('query_form.begin_time',date_);
			AOS.setValue('query_form.end_time',date1_);
			var params = AOS.getValue('query_form');
			book_grid_store.getProxy().extraParams = params;
			book_grid_store.loadPage(1);
		}
		
		//自定义查询
		function book_grid_query1() {
			var params = AOS.getValue('query_form');
			book_grid_store.getProxy().extraParams = params;
			book_grid_store.loadPage(1);
		}
		
		//自定义查询  
		function book_grid1_query2() {
			var params = AOS.getValue('query_form');
			book_grid1_store.getProxy().extraParams = params;
			book_grid1_store.loadPage(1);
		}
		
		//登录的时候自动加载
		function book_grid1_query_self() {
			
			var date_ = '${begin_date}';
			var date1_ = '${end_date}';	
			AOS.setValue('query_form.begin_time',date_);
			AOS.setValue('query_form.end_time',date1_);
			var params = AOS.getValue('query_form');
			book_grid1_store.getProxy().extraParams = params;
			book_grid1_store.loadPage(1);
		}
		
		//查询所有的
		function book_grid1_query_all() {
			AOS.setValue('query_form.update_user_id','');
			query_button_click();
		}
		
		//自定义查询
		function book_grid3_query3() {
			var params = AOS.getValue('query_form');
			book_grid3_store.getProxy().extraParams = params;
			book_grid3_store.loadPage(1);
		}
		
		//查询我的日报
		function book_grid_select_mine(){
				//AOS.reset(query_form);
				var id_ = '${id}';
				AOS.setValue('query_form.update_user_id',id_);
				var params = AOS.getValue('query_form');
				book_grid_store.getProxy().extraParams = params;
				book_grid_store.loadPage(1);
		}
		
		//查询时间段改变
		function fn_change(obj){
		  var val = obj.getValue();
		  var date_ = '${begin_date}';
		  var date1_ = '${end_date}';
		  var today_date_ = '${today_date}';
	      var year_begin_date_ = '${year_begin_date}';
		  var year_end_date_ = '${year_end_date}';
		  var recently_begin_date_ = '${recently_begin_date}';
		  var recently_end_date_ = '${recently_end_date}';
		  var week_begin_date_ = '${week_begin_date}';
		  var week_end_date_ = '${week_end_date}';
		  if(val =="本月"){
		    AOS.setValue('query_form.begin_time',date_);
			AOS.setValue('query_form.end_time',date1_); 
		  }else if (val =="当天")
			  {AOS.setValue('query_form.begin_time',today_date_);
				AOS.setValue('query_form.end_time',today_date_); 
			    }else if (val == "自定义"){
			    	AOS.setValue('query_form.begin_time',"");
			    	AOS.setValue('query_form.end_time',""); 
			    }else if(val =="本年"){
			    	AOS.setValue('query_form.begin_time',year_begin_date_);
					AOS.setValue('query_form.end_time',year_end_date_);	
			    }else if(val =="最近一月"){
			    	AOS.setValue('query_form.begin_time',recently_begin_date_);
					AOS.setValue('query_form.end_time',recently_end_date_);
			    }else if (val =="本周"){
			    	AOS.setValue('query_form.begin_time',week_begin_date_);
					AOS.setValue('query_form.end_time',week_end_date_);	
			    }
		   
			//book_grid_store.loadPage(1);
			query_button_click();
		}
	
		//导出excel
		function fn_export_excel(){
			//juid需要再这个页面的初始化方法中赋值,这里才引用得到
			//httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
			var selection = AOS.selection(book_grid,'id');
			if(selection == null || selection.length ==0){
				AOS.tip("请选择需要导出的日报！");
			}else{
			AOS.file('do.jhtml?router=dailyReportService.exportExcel&juid=${juid}&selection='+selection);
		}}
		
		
		
		//打开选中的日报
		function fn_select_all(){
			var selection = AOS.selection(book_grid,'id');
			var proj_id_ = AOS.getValue('query_form.proj_id');
			var proj_name_ = AOS.get('proj').rawValue;
			AOS.tip(proj_name_);
			window.open('do.jhtml?router=dailyReportService.fn_select_all&juid=${juid}&selection='+selection+'&aaa='+proj_name_);
		}

		//查看界面只读方法
		function fn_reads2(){
			AOS.reads(f_account3,'name,daily_time,update_user_id,update_user_time,state,remark,descc');
		}

		//监听浏览窗口弹出
		function w_account3_onshow(){
			//这里演示的是直接从表格行中加载数据，也可以发一个ajax请求查询数据(见misc1.jsp有相关用法)
			var record = AOS.selectone(book_grid, true);
			f_account3.loadRecord(record);
			var show_name = AOS.getValue('f_account3.name');
			var i2 = show_name.indexOf("(");
			var name__ = show_name.substring(5, i2);
			AOS.setValue('f_account3.update_user_id',name__);
			var state = AOS.getValue('f_account3.state');
			if(state == 1002){
				AOS.setValue('f_account3.state','提交'); 
			}else{
				AOS.setValue('f_account3.state','草稿');
			}
		}
	
	</script>
</aos:onready>

<script type="text/javascript">
	//打开浏览窗口
	function w_account3_show(){
		AOS.get('w_account3').show();
	}
	
	
	//导出excel
	function fn_excel(){
		//juid需要再这个页面的初始化方法中赋值,这里才引用得到
		//httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		var record = AOS.selectone(AOS.get('book_grid'));
		AOS.file('do.jhtml?router=dailyReportService.exportExcel1&juid=${juid}&id='+record.data.id);
	}
	
	//改变颜色
	function flag(value, metaData, record) {
		if (value == '1002') {
			return "<span style='color:green; font-weight:bold'>提交</span>";
		}
		else{
			return "<span style='color:red; font-weight:bold'>草稿</span>";
		}
		return value;
	}

</script>


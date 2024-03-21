	<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="aos.framework.web.router.HttpModel"%>

<!-- 获取当前时间 -->
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
	Date date = new Date();
	String date1 = format.format(date);
	String date2 = format1.format(date);
	String name1 = "我的工作日报_" + format1.format(date);
%>

<aos:html title="日报" base="http" lib="ext">
<aos:body>
<div id="theme_list" style="width:100% ; height: 100%; border: 0;"  >
		<iframe id="iframe_main"  style="border: 0; width:100% ; height: 100%" src=""></iframe>
	</div>
</aos:body>
</aos:html>


<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="query_form" layout="column" labelWidth="70"
			header="false" region="north" border="false">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="管理我的日报" />
			</aos:docked>
			<aos:textfield name="name" fieldLabel="日报名称" columnWidth="0.21" />
			<aos:hiddenfield name="update_user_id" fieldLabel="修改人" />
			<aos:combobox fieldLabel="日期" margin="0 -20 0 -30" name="main_time" columnWidth="0.18"
				onselect="fn_change">
				<aos:option value="当天" display="当天" />
				<aos:option value="本周" display="本周" />
				<aos:option value="本月" display="本月" />
				<aos:option value="最近一月" display="最近一月" />
				<aos:option value="本年" display="本年" />
				<aos:option value="自定义" display="自定义" />
			</aos:combobox>
			<aos:datefield name="begin_time"  margin="0 -20 0 -20" fieldLabel="从" editable="false"
				columnWidth="0.18" />
			<aos:datefield name="end_time" margin="0 -20 0 -20"  fieldLabel="到" editable="false"
				columnWidth="0.18" />
			<aos:combobox fieldLabel="日报状态" margin="0 20 0 20" name="state" columnWidth="0.25"
				emptyText="">
				<aos:option value="1001" display="草稿" />
				<aos:option value="1002" display="提交" />
			</aos:combobox>
			<aos:dockeditem xtype="button" text="查询" onclick="query_button_click"
				margin="0 10 0 50" icon="query.png" />
			<aos:dockeditem xtype="button" text="重置"
				onclick="AOS.reset(query_form);" margin="0 40 0 2"
				icon="refresh.png" />

		</aos:formpanel>

     <aos:tabpanel 	tabPosition = "top"  
	 id="id_tabpanel" region="center" bodyBorder="0 0 0 0" margin="0 0 2 0">
	<aos:tab title="日报列表" closable="false" id="task_view">
		<aos:gridpanel  height="20" id="book_grid"
			url="dailyReportService.page" onrender="book_grid_query"
			onitemdblclick="#w_account2_show();" region="center">
			<aos:menu>
				<aos:menuitem text="查看" onclick="w_account3_show();" icon="query.png" />
				<aos:menuitem text="新增" onclick="#book_win.show();AOS.reset(book_form);" icon="add.png" />
				<aos:menuitem text="修改" onclick="w_account2_show();" icon="edit.png" />
				<aos:menuitem text="提交" onclick="fn_submit" icon="up2.png" />
				<aos:menuitem text="删除" onclick="fn_del" icon="del.png" />
			</aos:menu>
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="个人日报" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="查看" onclick="w_account3_show();"
					icon="query.png" />
				<aos:dockeditem text="新增" icon="add.png"
					onclick="#book_win.show();AOS.reset(book_form);" />
				<aos:dockeditem text="修改" icon="edit.png"
					onclick="#w_account2_show();" />
				<aos:dockeditem text="删除" icon="del.png" onclick="g_acount_del" />
				<aos:dockeditem text="提交" onclick="fn_submit" icon="up2.png" />
				<aos:dockeditem xtype="button" text="导出" onclick="fn_export_excel"
					icon="icon70.png" />
			</aos:docked>

			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column header="行号" type="rowno" fixedWidth="40" />
			<aos:column header="日报编码" dataIndex="id" hidden="true" />
			<aos:column header="日报时间" dataIndex="daily_time" type="date"
				format="Y-m-d " fixedWidth="100" align="center" />
			<aos:column header="星期" dataIndex="week_day" fixedWidth="60"
				align="center" />
			<aos:column header="日报名称" dataIndex="name" fixedWidth="250" />
			<aos:column header="日报内容原" dataIndex="descc" fixedWidth="450"
				hidden="true" />
			<aos:column header="日报内容" dataIndex="desccc" />
			<aos:column header="日报描述" dataIndex="remark" fixedWidth="200"
				hidden="true" />
			<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="50"
				hidden="true" />
			<aos:column header="修改/提交时间" dataIndex="update_time" type="date"
				format="Y-m-d H:i:s" fixedWidth="140" align="center" />
			<aos:column header="状态" dataIndex="state" rendererFn="flag"
				fixedWidth="60" align="center" />
		</aos:gridpanel>
     </aos:tab>
	 <aos:tab title="日报详情" closable="false" html="" id="daily_details" ></aos:tab>
	</aos:tabpanel>
	
		<%-- 新增窗口 --%>
		<aos:window id="book_win" title="新增日报"   >
		
			<aos:formpanel id="book_form" height="430" width="1000" center="true" onshow="reads();"
				 labelWidth="70">
				<aos:numberfield name="id" fieldLabel="日报编码" hidden="true" />
				<aos:textfield name="name"  fieldLabel="日报名称" readOnly="true" minWidth="370" value="${a1}" margin="5 193 5 0" />
				<aos:datefield name="daily_time"  fieldLabel="日报时间" allowBlank="false"  minWidth="370" margin="5 0 5 30" onchange="f_account_get1"
			      editable="false" value="<%=date1%>" />
				<aos:hiddenfield name="daily_time1" fieldLabel="字符串类型时间"
					disabled="true" value="<%=date2%>"   />
				<aos:hiddenfield name="update_user_id"
					fieldLabel="修&nbsp&nbsp改&nbsp人" />
				<aos:hiddenfield name="state" fieldLabel="状态" disabled="true"
					value="1001" />
				<aos:hiddenfield name="remark" fieldLabel="日报描述"  margin="5 10 5 0" />
				<aos:fieldset title="日报内容"  margin="5 10 0 17"  minWidth="950"
					border="true">
					<aos:htmleditor  name="descc" allowBlank="false" width="950"  
						height="353" margin="0 0 -5 0" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer" margin="0 20 0 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="f_account_get1" text="生成日报"  margin="0 8 0 0" iconVec="fa-refresh" />
				<aos:dockeditem onclick="f_account_save" text="草稿" margin="0 8 0 0" icon="ok.png" />
				<aos:dockeditem onclick="f_account_save_submit" text="提交" margin="0 8 0 0" icon="up2.png" />
				<aos:dockeditem onclick="#book_win.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>

		<%-- 修改日报 --%>
		<aos:window id="w_account2" title="修改日报"
			onshow="#w_account2_onshow();fn_reads1();">
			<aos:formpanel id="f_account2" height="430" width="1000" center="true"
		    labelWidth="70">
				<%-- 更新时的隐藏变量(主键) --%>
				<aos:numberfield name="id" fieldLabel="日报编码" hidden="true" />
				<aos:textfield name="name"  fieldLabel="日报名称" readOnly="true" minWidth="370" value="${a1}" margin="5 193 5 0" />
				<aos:datefield name="daily_time" hideTrigger="true" minWidth="370" margin="5 0 5 30" readOnly="true" fieldLabel="日报时间" editable="false" />
				<aos:hiddenfield name="update_user_id" fieldLabel="修&nbsp&nbsp改&nbsp人"  />
				<aos:hiddenfield name="state" fieldLabel="状态"  />
				<aos:hiddenfield name="remark" fieldLabel="日报描述" margin="5 10 5 0" />
				<aos:fieldset title="日报内容"  labelWidth="70" margin="5 10 0 17"  minWidth="950"
					border="true">
					<aos:htmleditor name="descc" allowBlank="false"  margin="0 0 -5 0" width="1000"
						height="350"  />
				</aos:fieldset>    
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer" margin="0 20 0 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="f_account_get2" text="刷新日报"  margin="0 8 0 0" iconVec="fa-refresh" />
				<aos:dockeditem onclick="f_account2_update" text="草稿" margin="0 8 0 0" icon="ok.png" />
				<aos:dockeditem onclick="f_account_update_submit" text="提交" margin="0 8 0 0" icon="up2.png" />
				<aos:dockeditem onclick="#w_account2.hide();" text="取消" icon="close.png" />
			</aos:docked>
		</aos:window>

		<%-- 查看日报 --%>
		<aos:window id="w_account3" title="查看日报详情"
			onshow="#w_account3_onshow();fn_reads2();">
			<aos:formpanel id="f_account3" height="430" width="1000" center="true"
				 labelWidth="70">
				<%-- 更新时的隐藏变量(主键) --%>
				<aos:numberfield name="id" fieldLabel="日报编码" hidden="true" />
				<aos:textfield name="name" fieldLabel="日报名称" margin="5 50 5 0" readOnly="true" minWidth="450" />
				<aos:textfield name="update_user_id" fieldLabel="修&nbsp&nbsp改&nbsp人" readOnly="true" margin="5 50 5 0" minWidth="200" maxWidth="200" />
				<aos:textfield name="state" fieldLabel="日报状态" margin="5 10 5 0" readOnly="true" minWidth="200" maxWidth="200" />
				<aos:datefield name="daily_time" fieldLabel="日报时间" editable="false" readOnly="true" margin="5 50 5 0"  minWidth="450" />
				<aos:datetimefield name="update_time" fieldLabel="修改时间" minWidth="450" hideTrigger="true"	readOnly="true" editable="false" margin="5 0 5 0" />
				<aos:hiddenfield name="remark" fieldLabel="日报描述" margin="5 10 5 0" />
				<aos:fieldset title="日报内容" labelWidth="70" margin="5 10 0 17" minWidth="950"
					border="true">
					<aos:htmleditor name="descc" allowBlank="false"  margin="0 0 -5 0" width="1000"
						height="310" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer" margin="0 20 0 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#w_account3.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>

	</aos:viewport>
	<script type="text/javascript">
	
	var htmleditor=book_form.down("htmleditor[name='descc']");
	var select=book_form.down("htmleditor[name='descc']").getToolbar().down("component[itemId=fontSelect]");
	console.log(select);
	console.log(select.renderTpl.owner);
	//console.log(select.renderTpl.owner.container.dom.firstChild.innerHTML);
	//select.selectEl.dom.value="宋体";
	select.fireEvent("change");
	
	function query_button_click(){
		var id_ = '${id}';
		AOS.setValue('query_form.update_user_id',id_);
		var params = AOS.getValue('query_form');
		book_grid_store.getProxy().extraParams = params;
		var active_tab_id=id_tabpanel.getActiveTab( ).getId();
		if(active_tab_id=='daily_details'){
			daily_details_query();
		}else{
		
			book_grid_store.loadPage(1);
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
		
		var src='do.jhtml?router=dailyReportService.fn_select_all1&juid=${juid}';
		for(var pro in params){
			src+='&'+pro+'='+params[pro];
		}
		//src="$name=123&begin_time=456"
		daily_details.update('<iframe style="border: 0;width:100% ; height: 100%" src="'+src+'"></iframe>');
	}
	
		//加载表格数据
		function book_grid_query() {
			var date_ = '${begin_date}';
			var date1_ = '${end_date}';
			AOS.setValue('query_form.begin_time',date_);
			AOS.setValue('query_form.end_time',date1_);
			var id_ = '${id}';
			AOS.setValue('query_form.update_user_id',id_);
			var params = AOS.getValue('query_form');
			book_grid_store.getProxy().extraParams = params;
			book_grid_store.loadPage(1);
		}
		
		//自定义查询
		function book_grid_query1() {
			var id_ = '${id}';
			AOS.setValue('query_form.update_user_id',id_);
			var params = AOS.getValue('query_form');
			book_grid_store.getProxy().extraParams = params;
			book_grid_store.loadPage(1);
		}
	//查询我的日报
	function book_grid_select_mine(){
			AOS.reset(query_form);
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
	    var id_ = '${id}';
		AOS.setValue('query_form.update_user_id',id_);
	    var params = AOS.getValue('query_form');
		book_grid_store.getProxy().extraParams = params;
		book_grid_store.loadPage(1);
	}
	//自动获取任务
	function f_account_get1(){
		var daily_time_ =AOS.getValue('book_form.daily_time');
		var y = daily_time_.getFullYear();  
	    var m = daily_time_.getMonth() + 1;  
	    m = m < 10 ? '0' + m : m;  
	    var d = daily_time_.getDate();  
	    d = d < 10 ? ('0' + d) : d;
		var daily_time__=y+m+d;
		var name_='${name_report}';
		AOS.setValue("book_form.name",name_+daily_time__);
		
		var id_ = '${id}';
		AOS.setValue('book_form.update_user_id',id_);
		
		AOS.ajax({
			forms : book_form,
			url : 'dailyReportService.f_get1',
			ok : function(data) {
				if(data.appmsg == "骉驫"){
					AOS.setValue('book_form.descc','');
					AOS.tip('没有获取到您该日的工作内容，请核实！');
				}else if(data.appmsg == "您该日已存在一条日报记录！"){
					AOS.setValue('book_form.descc','');
					AOS.tip('您该日已存在一条日报记录！');
				}else{
				AOS.setValue('book_form.descc',data.appmsg);
				}
			}
	});
	}
	
	//重新获取任务 
	function f_account_get2(){
		var msg =  "重新获取任务将删除自己编写日报内容部分，是否继续？";
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			var daily_time_ =AOS.getValue('f_account2.daily_time');
			var y = daily_time_.getFullYear();  
		    var m = daily_time_.getMonth() + 1;  
		    m = m < 10 ? '0' + m : m;  
		    var d = daily_time_.getDate();  
		    d = d < 10 ? ('0' + d) : d;
			var daily_time__=y+m+d;
			var name_='${name_report}';
			AOS.setValue("f_account2.name",name_+daily_time__);
			AOS.ajax({
				forms : f_account2,
				url : 'dailyReportService.f_get1',
				ok : function(data) {
					if(data.appmsg == "骉驫"){
						AOS.setValue('f_account2.descc',"");
						AOS.tip('没有获取到您正在进行的任务，如有误，请取消保存！');
					}else if(data.appmsg == "您该日已存在一条日报记录！"){
						AOS.setValue('book_form.descc','');
						AOS.tip('您该日已存在一条日报记录！');
					}else{
					AOS.setValue('f_account2.descc',data.appmsg);
					}
				}
		});
	})}
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
		
		//新增界面只读方法
		function fn_reads(){
			
			AOS.reads(book_form,'name');
		}
		
		//修改界面只读方法
		function fn_reads1(){
			AOS.reads(f_account2,'name,daily_time');
		}
		//查看界面只读方法
		function fn_reads2(){
			AOS.reads(f_account3,'name,daily_time,update_user_id,update_user_time,state,remark,descc');
		}
		//新增保存
		function f_account_save(){
		var descc1  =AOS.getValue('book_form.descc');
				AOS.ajax({
					forms : book_form,
					url : 'dailyReportService.create',
					ok : function(data) {
						 AOS.tip(data.appmsg);
						book_grid_store.reload();
						if(!AOS.empty(descc1) && descc1.length >10 && data.appmsg !="您该日已存在一条日报记录！"){
							book_win.hide();	
						}
					}
			});
				
		}
		
		//新增日报保存并提交
		function f_account_save_submit(){
			var descc2  =AOS.getValue('book_form.descc');
			var msg =  "提交后将不能进行任何操作，请谨慎选择！";
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					forms : book_form,
					url : 'dailyReportService.create_submit',
					ok : function(data) {
						 AOS.tip(data.appmsg);
						book_grid_store.reload();
						if(!AOS.empty(descc2) && descc2.length >10&& data.appmsg !="您该日已存在一条日报记录！"){
							book_win.hide();}
					}
			});					
		})}
		
		//修改日报保存并提交
		function f_account_update_submit(){
			var descc  =AOS.getValue('f_account2.descc');
			var msg =  "提交后将不能进行任何操作，请谨慎选择！";
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					forms : f_account2,
					url : 'dailyReportService.update_submit',
					ok : function(data) {
						 AOS.tip(data.appmsg);
						book_grid_store.reload();
						if(!AOS.empty(descc) && descc.length >10&& data.appmsg !="您该日已存在一条日报记录！"){
							w_account2.hide();}
					}
			});					
		})}
		
		
		//监听修改窗口弹出
		function w_account2_onshow(){
			//这里演示的是直接从表格行中加载数据，也可以发一个ajax请求查询数据(见misc1.jsp有相关用法)
			//var records = AOS.select(book_grid, true);
			//f_account2.loadRecord(record);
			var records = AOS.select(book_grid);
			var record = records[0];
			if(AOS.empty(records)||records.length>1){
						AOS.tip('请选择一条需要修改的数据！');
						return;   
				}
		   f_account2.loadRecord(record);
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
		
		//修改日报保存
		function f_account2_update(){
			var descc2  =AOS.getValue('f_account2.descc');
				AOS.ajax({
					forms : f_account2,
					url : 'dailyReportService.update',
					ok : function(data) {
						AOS.tip(data.appmsg);
						book_grid_store.reload();
						if(!AOS.empty(descc2) && descc2.length >10 && data.appmsg !="您该日已存在一条日报记录！"){
						w_account2.hide();
						}
					}
			});
		}
		
		//删除日报信息
	 	function g_acount_del(){
				var selection = AOS.selection(book_grid, 'id');
				var record = AOS.select(book_grid);
				if(AOS.empty(selection)){
					AOS.tip('请选择需要删除的数据!');
					return;
				}
				for(var i=0;i<record.length;i++){
					if(record[i].data.state=="1002"){
						AOS.tip('您选中的日报包含已提交日报！');
						return;
					}
				}
				var rows = AOS.rows(book_grid);
				var msg =  AOS.merge('确认要删除选中的{0}条日报吗？', rows);
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						return;
					}
					AOS.ajax({
						url : 'dailyReportService.deletes',
						params:{
							aos_rows: selection
						},
						ok : function(data) {
							AOS.tip(data.appmsg);
							book_grid_store.reload();
						}
						
					});
				});
			}
		
	</script>
</aos:onready>

<script type="text/javascript">

//打开修改日报窗口
function w_account2_show(){
	var records = AOS.select(AOS.get('book_grid'));
	var record = AOS.select(AOS.get('book_grid'))[0];
	if(AOS.empty(records)||records.length>1){
		AOS.tip('请选择一条需要修改的数据！');
		return;   
}if(record.data.state ==='1002'){
		AOS.tip('已提交日报禁止修改。');
		return;
	}else{
		AOS.get('w_account2').show();
	}
}

//打开浏览窗口
function w_account3_show(){
	var records = AOS.select(AOS.get('book_grid'));
	var record = AOS.select(AOS.get('book_grid'))[0];
	if(AOS.empty(records)||records.length>1){
		AOS.tip('请选择一条需要查看的数据！');
		return;   
}
	AOS.get('w_account3').show();
}

//删除单条日报
function fn_del(){
	var record = AOS.selectone(AOS.get('book_grid'));
	if(record.data.state ==='1002'){
		AOS.tip('已提交日报禁止删除。');
		return;
	}else{
	//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
	var record = AOS.selectone(AOS.get('book_grid'));
	var msg =  AOS.merge('确认要删除账户【{0}】吗？', record.data.name);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'dailyReportService.delete',
			params:{
				id: record.data.id
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				AOS.get('book_grid').getStore().reload();
			}
		});
	});
}}

//导出excel
function fn_excel(){
	//juid需要再这个页面的初始化方法中赋值,这里才引用得到
	//httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
	var record = AOS.selectone(AOS.get('book_grid'));
	AOS.file('do.jhtml?router=dailyReportService.exportExcel1&juid=${juid}&id='+record.data.id);
}

function fn_submit(){
	//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
	var record = AOS.selectone(AOS.get('book_grid'));
	if(record.data.state ==='1002'){
		AOS.tip('该日报已提交。');
		return;
	}else{
	var record = AOS.selectone(AOS.get('book_grid'));
	var msg =  AOS.merge('确认要提交日报【{0}】吗？', record.data.name);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'dailyReportService.submit',
			params:{
				id: record.data.id
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				AOS.get('book_grid').getStore().reload();
			}
		});
	});
}}

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


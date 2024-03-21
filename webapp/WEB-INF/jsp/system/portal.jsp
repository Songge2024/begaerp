<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="aos.framework.web.router.HttpModel"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<!-- 获取当前时间 -->
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat sys = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat monthdate = new SimpleDateFormat("yyyy-MM");
	Date date = new Date();
	String mdate=monthdate.format(date);
	String date1 = format.format(date);
	String date2 = format1.format(date);
	String sysdate = sys.format(date);
	String name1 = "我的工作日报_" + format1.format(date);
	request.setAttribute("sysdate", sysdate);
	request.setAttribute("create_time", mdate);
%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	int userid = userModel.getId();
%>
<aos:html title="欢迎" base="http" lib="ext,echart">
<link rel="stylesheet" type="text/css" href="${cxt}/static/weblib/buttons/css/buttons.css" />
<link rel="stylesheet" type="text/javascript" href="${cxt}/static/weblib/buttons/js/buttons.js" />
</aos:html>
<aos:body >
<div id='page_refresh' onclick="refresh()"></div>
<div id="div_tips" class="x-hidden" style="line-height: 22px; margin-right: 10px;font-size: 12px;" >
		<ul>
			<li style="color:blue;font-weight:bold ">已接收：<span id="id_yjs" >${yjs}</span> 个</li>
			<li style="color:red;font-weight:bold ">已完成：<span id="id_ywc" >${ywc}</span> 个</li>
			<li style="color:gray;font-weight:bold ">已关闭：<span id="id_ygb" >${ygb}</span> 个</li>
			<li style="font-weight:bold ">总计划工作量：<span id="id_jhgzl" >${jhgzl}</span> 人天</li>
			<li style="font-weight:bold ">总实际工作量：<span id="id_sjgzl" >${sjgzl}</span> 人天</li>
		</ul>
	</div>
</aos:body>
<aos:onready>
    <aos:viewport layout="hbox" >
        <aos:layout type="hbox" align="stretch"/>
		<aos:formpanel id="date" width="0" height="0">
			<aos:hiddenfield fieldLabel="日期" name="daily_date"/>
		</aos:formpanel>
        <aos:panel flex="7" layout="anchor">
            <aos:gridpanel id="toDoTaskGrid"  hidePagebar="true" anchor="100% 50%" forceFit="true" border="0 1 0 0"
                           url="projCommonsService.queryToDoTask" onrender="query_to_do_task" onitemdblclick="onwindows_toDo">
                <aos:docked forceBoder="0 1 1 1" layout="border" >
                    <aos:dockeditem  text="<b>我的待办</b>"    tooltip="刷新" onclick="queryAll" iconVec="fa-refresh" region="west"/>
                    <aos:dockeditem text="保存数据" icon="save.png" onclick="saveData2" region="east" margin="5 0 0 0"/>
                    	<aos:button  icon="filter.png" region="east" margin="5 0 0 0" >
							<aos:menu plain="true" >
								<aos:menuitem text="全部" icon="icon152.png"  onclick="queryAll"/>
								<aos:menuitem text="任务" icon="task_list.png"  onclick="queryTask"/>
								<aos:menuitem text="缺陷" icon="bug.png"  onclick="queryBug"/>
								<aos:menuitem text="评审" icon="vcard.png"  onclick="queryPins"/>
							</aos:menu>
						</aos:button>
                </aos:docked>
                <aos:plugins>
					<aos:editing id="id_plugin111" ptype="cellediting" clicksToEdit="1" />
				</aos:plugins>
                <aos:column header="类型" dataIndex="type_name" width="30"  rendererFn="toPic"  align="center"/>
                  <aos:column header="类型" dataIndex="type_code"    hidden="true"/>
                <aos:column header="待办任务" dataIndex="to_do_name" width="400" />
                  <aos:column header="编码" dataIndex="code"  hidden="true"/>
                    <aos:column header="项目id" dataIndex="proj_id" hidden="true" />
                <aos:column header="开始时间/发现时间" dataIndex="plan_begin_time" width="150" align="center"/>
                <aos:column header="状态" dataIndex="state" rendererFn="state_Fn_render" width="100" align="center"/>
                <aos:column header="完成比例（%）" dataIndex="percent" width="100" align="center" rendererFn="percent_render" >
                	<aos:numberfield allowBlank="false" maxValue="100" minValue="0" />
                </aos:column>
            </aos:gridpanel>
            <aos:panel anchor="100% 50%" layout="hbox" >
                <aos:layout type="hbox" align="stretch"/>
                <aos:treepanel id="my_project_tree" flex="4" rootExpanded="true" rootVisible="false" border="true"
                               singleClick="false" url="projCommonsService.my_project_tree"   onselectionchange="my_project_tree_setmenu"
                              onitemclick="on_public_tree" autoScroll="true">
                    <aos:docked forceBoder="1 1 0 0" >
                        <aos:dockeditem  text="<b>我的项目(点击右键设置当前项目)</b>" iconVec="fa-refresh" onclick="#my_project_tree_store.reload();" tooltip="刷新"/>
                    </aos:docked>
                    <aos:menu bodyPadding="false" border="false"  >
	                <aos:menuitem text="设置为当前项目"  onclick="set_default_project"  id="set_default_project_button" icon="add2.png" />
	                <aos:menuitem text="取消当前项目"  onclick="delect_default_project"  id="delect_default_project_button" icon="del2.png" />
                    </aos:menu>
                </aos:treepanel>
                <aos:panel flex="6" border="true" layout="anchor">
                    <aos:formpanel id="project_information_form" onrender="readsForm" layout="column" autoScroll="false"  region="north"
                                   header="false" anchor="100%">
                        <aos:docked forceBoder="0 0 1 0" layout="border" >
                            <aos:dockeditem xtype="tbtext" text="<b>项目基本信息</b>" padding="0 0 1 0" margin="5 5 0 0" region="west"/>
                            <aos:dockeditem  icon="gzt-fx.gif"  onclick="g_account_query" region="east" tooltip="分析" margin="5 5 0 0"/>
                        </aos:docked>
                        <aos:textfield name="name" fieldLabel="项目简称" columnWidth="0.5" margin="10 0 0 -20"/>
                          <aos:textfield name="begin_date" fieldLabel="启动时间" columnWidth="0.5" labelWidth="80" margin="10 10 0 0"/>
                         <aos:textfield name="pm_user_name" fieldLabel="项目经理" columnWidth="0.5"  margin="10 0 0 -20"/>
                       <aos:textfield name="pm2_user_name" fieldLabel="开发经理" labelWidth="80" columnWidth="0.5" margin="10 10 0 0"/>
                        <aos:textfield name="period" fieldLabel="计划周期" columnWidth="0.5" margin="10 0 0 -20"/>
                        <aos:textfield name="week_date" fieldLabel="进行周期" columnWidth="0.5"    labelWidth="80" margin="10 10 0 0"/>
                    </aos:formpanel>
                    <aos:panel anchor="100% 100%"  >
	                    <aos:gridpanel id="count_mes"  hidePagebar="true"     >
<%-- 	                        <aos:docked forceBoder="1 0 1 0" region="sourth" > --%>
<%-- 	                            <aos:dockeditem xtype="tbtext" text="<b>项目消息</b>"/> --%>
<%-- 	                             <aos:dockeditem  icon="icon146.png"  onclick="more_mes" region="east" tooltip="更多" margin="5 5 0 810"/> --%>
<%-- 	                        </aos:docked> --%>
							<aos:docked forceBoder="0 0 1 0" layout="border" >
	                            <aos:dockeditem xtype="tbtext" text="<b>项目消息</b>" padding="0 0 1 0" margin="5 5 0 0" region="west"/>
	                            <aos:dockeditem  icon="icon146.png"  onclick="more_mes" region="east" tooltip="更多" margin="5 5 0 0"/>
	                        </aos:docked>
							<aos:column header="项目ID" dataIndex="proj_id" width="20"  hidden="true"  align="center"/>
							<aos:column header="消息ID" dataIndex="id" width="50"  hidden="true"  align="center"/>
							<aos:column header="状态" dataIndex="hasRead" width="20" rendererFn="flag_mes"   align="center"/>
							<aos:column header="消息内容" dataIndex="content"  align="left" rendererFn="content" width="180" />
							<aos:column header="消息类型" dataIndex="type" width="50"   align="left"/>
							<aos:column header="项目名称" dataIndex="proj_name" width="130"    align="left"/>
							<aos:column header="消息时间" dataIndex="createTime" width="80"  format="Y-m-d" />
	                   	</aos:gridpanel>
                	</aos:panel>
				</aos:panel>
<%-- 				<aos:panel flex="3" border="true" layout="anchor"> --%>
<%-- 				</aos:panel> --%>
            </aos:panel>
        </aos:panel>
        <aos:panel layout="vbox">
		<aos:panel flex="1" layout="anchor" contentEl="div_tips" autoScroll="true" border="0 0 1 0">
				<aos:docked forceBoder="0 0 1 1"  layout="border">
					<aos:dockeditem  text="<b>本月任务</b>" region="west" tooltip="刷新" onclick="changeDate" iconVec="fa-refresh" />
					<aos:monthfield  id="id_sysdate" emptyText="选择日期" region="center"  value="${sysdate}" onchange="changeDate" editable="false"   width="100"/>
					<aos:dockeditem region="east" icon="icon146.png"  onclick="gotoTaskPage"  tooltip="详情" margin="5 5 0 0" />
				</aos:docked>
		</aos:panel>
        <aos:gridpanel flex="2.33" id="my_daily" layout="anchor"  hidePagebar="true" onrender="query_my_daily" border="0 0 1 0"
                       url="dailyProductionService.select_my_daily">
            <aos:layout type="hbox" align="stretch" />
            <aos:docked forceBoder="1 0 0 1" layout="border">
                    <aos:dockeditem region="west"  text="<b>我的日报</b>" tooltip="刷新" onclick="#my_daily_store.reload();" iconVec="fa-refresh" iconVecAlign=""/>
                     <aos:checkbox id="weekdayId"  boxLabel="<b>工作日</b>" checked="false" inputValue="0" onchange="showWorkday" margin="5 0 0 0" ></aos:checkbox> 
                   <aos:dockeditem region="east" icon="icon146.png"  onclick="gotoDailyPage"  tooltip="更多" margin="5 5 0 0" />
            </aos:docked>
            <aos:column header="星期   / 日期" dataIndex="m_time" align="left" flex="4" rendererFn="fn_time_render"/>
            <aos:column header="日期" dataIndex="daily_date" hidden="true"/>
            <aos:column header="日报描述" dataIndex="remark" flex="5" rendererFn="fn_descc_render" hidden="true" />
            <aos:column header="状态" dataIndex="3" align="center" flex="2" rendererFn="state_render"/>
           	<aos:column header="更新人" dataIndex="update_id" fixedWidth="50"
			hidden="true" />
			<aos:column header="更新人" dataIndex="daily_status" fixedWidth="50"
			hidden="true" />
            <aos:column header="日报内容" dataIndex="daily_desc" align="left" hidden="true"/>
        </aos:gridpanel>

</aos:panel>
        <%-- 新增窗口 --%>
        <aos:window id="book_win" title="新增日报"  width="800" height="500" onshow="report_grid_query" onhide="closing_daily">
			<aos:gridpanel id="report_grid"  forceFit="false"  border="true" url="dailyProductionService.page" onrender="report_grid_query">
					<aos:docked forceBoder="1 0 1 0"   >
						<aos:dockeditem xtype="tbtext" text="日报列表" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:dockeditem onclick="f_account_add" text="新增"   icon="add.png" id="account_add"/>
		                <aos:dockeditem onclick="f_account_del" text="删除"   icon="del.png" id="del_account"/>
					</aos:docked>
					<aos:plugins>
						<aos:editing id="id_plugin" clicksToEdit="1" ptype="cellediting" />
					</aos:plugins>
					<aos:column type="rowno"  />  
					<aos:column header="日报ID" dataIndex="daily_id" width="20"  hidden="true" />
					<aos:column header="日报日期" dataIndex="daily_date" width="20"  hidden="true" format="Y-m-d"/>
					<aos:column header="日报状态" dataIndex="daily_status" width="20"  hidden="true" />
					<aos:column header="同步ID" dataIndex="sync_id" width="20"  hidden="true" />
					<aos:column header="创建人ID" dataIndex="create_id" width="20"  hidden="true" />
					<aos:column header="创建时间" dataIndex="create_time" width="20"  hidden="true" />
					<aos:column header="修改人ID" dataIndex="update_id" width="20"  hidden="true" />
					<aos:column header="修改时间" dataIndex="update_time" width="20"  hidden="true" />
					<aos:column header="是否删除" dataIndex="is_del" width="20"  hidden="true" />
					<aos:column header="项目ID" dataIndex="proj_id" width="20"  hidden="true" />
					<aos:column header="工作量" dataIndex="working_workload" width="20" hidden="true" />
					<aos:column header="项目" dataIndex="proj_name" width="120"  align="center" celltip="true"/>
					<aos:column header="日报类型" dataIndex="daily_type" width="100" rendererFn="fn_daily_type" align="center"/>
					<aos:column header="日报状态" dataIndex="daily_status" width="100" rendererFn="fn_daily_status" align="center"/>
					<aos:column header="当天工作比重" dataIndex="working_percent" rendererFn="render_percent" align="left" width="100" >
						<aos:textfield />
					</aos:column>
					<aos:column header="日报描述" dataIndex="daily_desc"  align="left" width="450" >
						<aos:textareafield margin="34 0 0 0"/>
					</aos:column>
	   	 		</aos:gridpanel>
            <aos:docked dock="bottom" ui="footer" margin="0 120 0 0">
                <aos:dockeditem xtype="tbfill" />
                <aos:dockeditem onclick="f_account_get1" text="自动生成" margin="0 8 0 0" id="autopress" iconVec="fa-refresh"  />
                <aos:dockeditem onclick="f_account_save" text="草稿" margin="0 8 0 0" icon="ok.png" id="submit_account_btn"/>
                <aos:dockeditem onclick="f_account_submit" text="提交" margin="0 8 0 0" id="save_account_btn" icon="up2.png" />
                <aos:dockeditem onclick="closing_daily" text="关闭" icon="close.png" />
            </aos:docked>
        </aos:window>
        
        <aos:window id="w_account" title="修改日报" width="800" height="500" onshow="gird_account_query">
			<aos:gridpanel id="g_account"  forceFit="false"  border="true" url="dailyProductionService.page" onrender="gird_account_query">
					<aos:docked forceBoder="1 0 1 0"   >
						<aos:dockeditem xtype="tbtext" text="日报列表" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:dockeditem onclick="g_account_add"  text="新增"   icon="add.png" />
						<aos:dockeditem onclick="g_account_del"  text="删除"   icon="del.png" />
					</aos:docked>
					<aos:plugins>
						<aos:editing id="id_plugin" clicksToEdit="1" ptype="cellediting" />
					</aos:plugins>
					<aos:column type="rowno"  />  
					<aos:column header="日报ID" dataIndex="daily_id" width="20"  hidden="true" />
					<aos:column header="日报日期" dataIndex="daily_date" width="20"  hidden="true" />
					<aos:column header="日报状态" dataIndex="daily_status" width="20"  hidden="true" />
					<aos:column header="同步ID" dataIndex="sync_id" width="20"  hidden="true" />
					<aos:column header="创建人ID" dataIndex="create_id" width="20"  hidden="true" />
					<aos:column header="创建时间" dataIndex="create_time" width="20"  hidden="true" />
					<aos:column header="修改人ID" dataIndex="update_id" width="20"  hidden="true" />
					<aos:column header="修改时间" dataIndex="update_time" width="20"  hidden="true" />
					<aos:column header="是否删除" dataIndex="is_del" width="20"  hidden="true" />
					<aos:column header="项目ID" dataIndex="proj_id" width="20"  hidden="true" />
					<aos:column header="工作量" dataIndex="working_workload" width="20" hidden="true" />
					<aos:column header="项目" dataIndex="proj_name" width="120"  align="center" celltip="true"/>
					<aos:column header="日报类型" dataIndex="daily_type" width="100" rendererFn="fn_daily_type" align="center" />
					<aos:column header="日报状态" dataIndex="daily_status" width="100" rendererFn="fn_daily_status" align="center"/>
					<aos:column header="当天工作比重" dataIndex="working_percent" rendererFn="render_percent" align="left" width="100" >
						<aos:textfield />
					</aos:column>
					<aos:column header="日报描述" dataIndex="daily_desc"  align="left" width="450" >
					    	<aos:textareafield margin="34 0 0 0"/>
					</aos:column>
			
	   	 		</aos:gridpanel>
			
			<aos:docked dock="bottom" ui="footer" margin="0 20 0 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="f_account_get2" text="刷新日报"  margin="0 8 0 0" iconVec="fa-refresh" />
				<aos:dockeditem onclick="f_account2_update" text="草稿" margin="0 8 0 0" icon="ok.png" />
				<aos:dockeditem onclick="f_account_update_submit" text="提交" margin="0 8 0 0" icon="up2.png" />
				<aos:dockeditem onclick="#w_account.hide();" text="取消" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:window id="report_create_win" title="新增日报" >
			<aos:formpanel id="report_create_form" width="450" layout="anchor" labelWidth="70" msgTarget="qtip" center="true">
					<aos:combobox fieldLabel="项目名称" name="proj_id" allowBlank="false"
					editable="true" columnWidth="1" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true"
					url="dailyProductionService.listComboBoxUerid&team_user_id=${team_user_id}" />
					<aos:combobox  id="id_review_type"  name="daily_type" fieldLabel="日报类型" allowBlank="false" columnWidth="0.5">
						<aos:option value="1" display="自定义"/>
						<aos:option value="2" display="任务" />
						<aos:option value="3" display="缺陷" />
						<aos:option value="4" display="会议" />
				    </aos:combobox>
				    <aos:textfield fieldLabel="当天工作比重(%)" name="working_percent"  allowBlank="false" columnWidth="0.5"  />
				    <aos:fieldset title="日报描述"  columnWidth="1" margin="5">
						<aos:textareafield name="daily_desc" columnWidth="1"  margin="5" height="150"/>
					</aos:fieldset>
					<aos:hiddenfield fieldLabel="日报id" name="daily_id"/>
					<aos:hiddenfield fieldLabel="是否同步" name="sync_id"/>
					<aos:hiddenfield fieldLabel="创建人ID" name="create_id"/>
					<aos:hiddenfield fieldLabel="创建时间" name="create_time"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="report_create_preserve" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#report_create_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:window id="f_create_win" title="新增日报" >
			<aos:formpanel id="f_create_form" width="450" layout="anchor" labelWidth="70" msgTarget="qtip" center="true">
					<aos:combobox fieldLabel="项目名称" name="proj_id" allowBlank="false"
					editable="true" columnWidth="1" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true"
					url="dailyProductionService.listComboBoxUerid&team_user_id=${team_user_id}" />
					<aos:combobox  id="id_review_type2"  name="daily_type" fieldLabel="日报类型" allowBlank="false" columnWidth="0.5">
						<aos:option value="1" display="自定义"/>
						<aos:option value="2" display="任务" />
						<aos:option value="3" display="缺陷" />
						<aos:option value="4" display="会议" />
				    </aos:combobox>
				    <aos:textfield fieldLabel="当天工作比重(%)" name="working_percent"  allowBlank="false" columnWidth="0.5"  />
				    <aos:fieldset title="日报描述"  columnWidth="1" margin="5">
						<aos:textareafield name="daily_desc" columnWidth="1"  margin="5" height="150"/>
					</aos:fieldset>
					<aos:hiddenfield fieldLabel="日报id" name="daily_id"/>
					<aos:hiddenfield fieldLabel="是否同步" name="sync_id"/>
					<aos:hiddenfield fieldLabel="创建人ID" name="create_id"/>
					<aos:hiddenfield fieldLabel="创建时间" name="create_time"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="f_create_preserve" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#f_create_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
        
         <aos:window id="lookmes_win" title="查看消息"   >
        	  <aos:formpanel id="look_mes"     height="320" width="1000"   >
                        <aos:textfield name="hasRead" fieldLabel="状态" columnWidth="0.5"  value="已读"   labelWidth="80" margin="10 10 0 0"/>
                        <aos:textfield name="type" fieldLabel="消息类型" columnWidth="0.5" labelWidth="80" margin="10 10 0 0"/>
                        <aos:textfield name="proj_name" fieldLabel="项目名称" labelWidth="80" columnWidth="0.5" margin="10 10 0 0"/>
                        <aos:textfield name="createTime" fieldLabel="消息时间" columnWidth="0.5" labelWidth="80"  margin="10 10 0 0"/>
                        <aos:fieldset title="消息内容"  margin="5 10 0 17" >
							<aos:htmleditor name="content" allowBlank="false" width="1000" 
									height="200" margin="0 0 -5 0" />
               			 </aos:fieldset>
          	 </aos:formpanel>
            		<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="#lookmes_win.hide();" text="关闭"
							icon="close.png" />
					</aos:docked>
        </aos:window>
    </aos:viewport>
    <script type="text/javascript">
    count_mes.on("cellclick", function(grid, rowIndex, columnIndex, e) { 
		if (columnIndex == 1 ) {
			var selecttree = AOS.selectone(my_project_tree);
			AOS.get('lookmes_win').show();
			var select = AOS.selectone(count_mes);
			 var id=select.data.id;
			$.ajax({
				url: "http://"+AOS.Message_Url+"/mes/setMesToRead?mesId="+id,
				type : "post",
				contentType:"application/json",
				processData:false,	
				dataType: "json",
				success : function(data){
				}
			});
			if(selecttree==null){
			var proj_ids = '${proj_id__}'
		//	AOS.tip(proj_ids);
			  $.ajax({
				  url: "http://"+AOS.Message_Url+"/mes/getList",
		  			type : "patch",
		  			contentType:"application/json",
		  			processData:false,
		  			dataType: "json",
		  			data: JSON.stringify({
		  				"eq_channel.code":"9527",
        				"eq_mesGroup":"CHANNEL",
        				"in_extras.proj_id":proj_ids,
        				"great_extras.sedTime":'${preWeekMonday}',
     				    "less_extras.createTime":'${week_end_date}'
		  				}),
		  				success : function(data){
		  					count_mes_store.removeAll();
		  					count_mes_store.filter('proj_id', proj_ids);
		  				var arrayList=[];
								Ext.Array.each(data.data,function(item){
									arrayList.push(item);
								})
							Ext.each(arrayList,function(item){
								var content =JSON.parse(item.content).content;
								var proj_id =JSON.parse(item.content).proj_id;
								var type =JSON.parse( item.content ).type;
								var proj_name =JSON.parse( item.content ).proj_name;
								var hasRead = item.mesRecives[0].status;
		            			var mes_id = item.id;
		            						count_mes_store.insert(0,{
		            							content:content,
		            							proj_id:proj_id,
		            							proj_name:proj_name,
		            							type:item.title,
		            							createTime:item.createTime,
		            							id:item.id,
		            							hasRead:hasRead
		            						})
							}) 
				 	 	},
				  			
				  });
		    	  count_mes.columns[5].show();
			}else if (selecttree.raw.a == '0'){
				 AOS.reset(AOS.get('project_information_form'));
		    	  var arrayList=[];
		    		Ext.Array.each(selecttree.childNodes[0].childNodes,function(item){
		    			var id = item.internalId;
		    			arrayList.push(id);
		    		})
		    		Ext.Array.each(selecttree.childNodes[1].childNodes,function(item){
		    			var id = item.internalId;
		    			arrayList.push(id);
		    		})
		   			var proj_ids = arrayList.join(",");
		    	  $.ajax({
		    		  url: "http://"+AOS.Message_Url+"/mes/getList",
		  			type : "patch",
		  			contentType:"application/json",
		  			processData:false,
		  			dataType: "json",
		  			data: JSON.stringify({
		  				"eq_channel.code":"9527",
        				"eq_mesGroup":"CHANNEL",
        				"in_extras.proj_id":proj_ids,
        				"great_extras.sedTime":'${preWeekMonday}',
     				    "less_extras.createTime":'${week_end_date}'
		  				}),
		  				success : function(data){
		  					count_mes_store.removeAll();
		  					count_mes_store.filter('proj_id', proj_ids);
		  				var arrayList=[];
								Ext.Array.each(data.data,function(item){
									arrayList.push(item);
								})
							Ext.each(arrayList,function(item){
								var content =JSON.parse(item.content).content;
								var proj_id =JSON.parse(item.content).proj_id;
								var type =JSON.parse( item.content ).type;
								var proj_name =JSON.parse( item.content ).proj_name;
								var hasRead = item.mesRecives[0].status;
		            			var mes_id = item.id;
		            						count_mes_store.insert(0,{
		            							content:content,
		            							proj_id:proj_id,
		            							proj_name:proj_name,
		            							type:item.title,
		            							createTime:item.createTime,
		            							id:item.id,
		            							hasRead:hasRead
		            						})
		            					
							}) 
				 	 	},
				  			
				  });
		    	  count_mes.columns[5].show();
			}else if(selecttree.raw.a == '1'){
				 AOS.reset(AOS.get('project_information_form'));
		    	 var arrayList=[];
		  		Ext.Array.each(selecttree.data.children,function(item){
		 				var proj_id = item.id;
		 				arrayList.push(proj_id);
		  		})
		 			var proj_ids = arrayList.join(",");
		 			$.ajax({
		 				url: "http://"+AOS.Message_Url+"/mes/getList",
		       			type : "patch",
		       			contentType:"application/json",
		       			processData:false,
		       			dataType: "json",
		       			data: JSON.stringify({
		       				"eq_channel.code":"9527",
	        				"eq_mesGroup":"CHANNEL",
	        				"in_extras.proj_id":proj_ids,
	        			 	"great_extras.sedTime":'${preWeekMonday}',
	     				    "less_extras.createTime":'${week_end_date}'
		       				}),
		       				success : function(data){
		       					count_mes_store.removeAll();
		       					count_mes_store.filter('proj_id', proj_ids);
		       				var arrayList=[];
		   						Ext.Array.each(data.data,function(item){
		   							arrayList.push(item);
		   						})
		   					Ext.each(arrayList,function(item){
		   						var content =JSON.parse(item.content).content;
		   						var proj_id =JSON.parse(item.content).proj_id;
		   						var type =JSON.parse( item.content ).type;
		   						var proj_name =JSON.parse( item.content ).proj_name;
		   						var mes_id = item.id;
		   						var hasRead = item.mesRecives[0].status;
		            			var mes_id = item.id;
		            						count_mes_store.insert(0,{
		            							content:content,
		            							proj_id:proj_id,
		            							proj_name:proj_name,
		            							type:item.title,
		            							createTime:item.createTime,
		            							id:item.id,
		            							hasRead:hasRead
		            						})
		   			}) 
		       	},
		       });
		 			 count_mes.columns[5].show();
			}else if(selecttree.raw.a == '2'){
				 AOS.reset(AOS.get('project_information_form'));
		    	 var arrayList=[];
		 		Ext.Array.each(selecttree.data.children,function(item){
						var proj_id = item.id;
						arrayList.push(proj_id);
		 		})
		 		var proj_ids =arrayList.join(",");
		 		$.ajax({
		 			url: "http://"+AOS.Message_Url+"/mes/getList",
		  			type : "patch",
		  			contentType:"application/json",
		  			processData:false,
		  			dataType: "json",
		  			data: JSON.stringify({
		  				"eq_channel.code":"9527",
        				"eq_mesGroup":"CHANNEL",
        				"in_extras.proj_id":proj_ids,
        				"great_extras.sedTime":'${preWeekMonday}',
     				    "less_extras.createTime":'${week_end_date}'
		  				}),
		  				success : function(data){
		  					count_mes_store.removeAll();
		  					count_mes_store.filter('proj_id', proj_ids);
		  				var arrayList=[];
								Ext.Array.each(data.data,function(item){
									arrayList.push(item);
								})
							Ext.each(arrayList,function(item){
								var content =JSON.parse(item.content).content;
								var proj_id =JSON.parse(item.content).proj_id;
								var type =JSON.parse( item.content ).type;
								var proj_name =JSON.parse( item.content ).proj_name;
								var mes_id = item.id;
								var hasRead = item.mesRecives[0].status;
		            			var mes_id = item.id;
		            						count_mes_store.insert(0,{
		            							content:content,
		            							proj_id:proj_id,
		            							proj_name:proj_name,
		            							type:item.title,
		            							createTime:item.createTime,
		            							id:item.id,
		            							hasRead:hasRead
		            						})
							}) 
				  		},
				  });
		 		 count_mes.columns[5].show();
				 
			}else if(selecttree.raw.a == '3'){
				 $.ajax({
					 	url: "http://"+AOS.Message_Url+"/mes/getList",
	        			type : "patch",
	        			contentType:"application/json",
	        			processData:false,
	        			dataType: "json",
	        			data: JSON.stringify({
	        				"eq_channel.code":"9527",
	        				"eq_mesGroup":"CHANNEL",
	        				"in_extras.proj_id":selecttree.internalId,
	        				"great_extras.sedTime":'${preWeekMonday}',
	     				    "less_extras.createTime":'${week_end_date}'
	        				}),
	        				success : function(data){
	        					//AOS.get('count_mes').store.add(	data.data.list);
	        					count_mes_store.removeAll();
	        					count_mes_store.filter('proj_id', selecttree.internalId);
	        				var arrayList=[];
	    						Ext.Array.each(data.data,function(item){
	    							arrayList.push(item);
	    						})
	    					Ext.each(arrayList,function(item){
	    						var content =JSON.parse(item.content).content;
	    						var proj_id =JSON.parse(item.content).proj_id;
	    						var type =JSON.parse( item.content ).type;
	    						var proj_name =JSON.parse( item.content ).proj_name;
	    						var hasRead = item.mesRecives[0].status;
	                			var mes_id = item.id;
	                						count_mes_store.insert(0,{
	                							content:content,
	                							proj_id:proj_id,
	                							proj_name:proj_name,
	                							type:item.title,
	                							createTime:item.createTime,
	                							id:item.id,
	                							hasRead:hasRead
	                						})
	    			}) 
	        	},
	        			
	        });
	                count_mes.down("gridcolumn[dataIndex=proj_name]").hide();
			}
}
		$.ajax({
			url: "http://"+AOS.Message_Url+"/mes/getList",
			type : "patch",
			contentType:"application/json",
			processData:false,
			dataType: "json",
			data: JSON.stringify({
					    'eq_id':id
				}),
			success : function(data){
				var arrayList=[];
				Ext.Array.each(data.data,function(item){
					arrayList.push(item);
				})
			Ext.each(arrayList,function(item){
				var content =JSON.parse(item.content).content;
				var proj_id =JSON.parse(item.content).proj_id;
				var type =JSON.parse( item.content ).type;
				var proj_name =JSON.parse( item.content ).proj_name;
				AOS.setValue('look_mes.content',content);
				AOS.setValue('look_mes.type',item.title);
				AOS.setValue('look_mes.proj_name',proj_name);
				AOS.setValue('look_mes.createTime',item.createTime);
			})
			}
		});
	});
 
	       function toPic(value, metaData, record) {
	    	   var tmp = value;
	   		if (value =="缺陷") {
	   			tmp='<img src="${cxt}/static/icon/bug.png" align="center"/>'
			} else if(value=="任务"){
				tmp='<img src="${cxt}/static/icon/task_list.png" align="center"/>'
			}else if(value=="评审"){
				tmp='<img src="${cxt}/static/icon/vcard.png" align="center"/>'
			}
			return tmp;
		}
	       
	     //完成百分比
	   	function render_percent(value){
	   		if(value)return value+"%";
	   		return;
	   	}
	       
	     //加载表格数据
			function report_grid_query(value,mdate,record) {
			 	var record = AOS.selectone(AOS.get('my_daily'));
	    	    var time = record.data.daily_date;
	    	    report_grid_store.getProxy().extraParams = {
	    	    	daily_date : time
				};
	    	    report_grid_store.loadPage(1);
	     }
	     
			//加载表格数据
			function gird_account_query(value,mdate,record) {
			 	var record = AOS.selectone(AOS.get('my_daily'));
	    	    var time = record.data.daily_date;
	    	    g_account_store.getProxy().extraParams = {
	    	    	daily_date : time
				};
	    	    g_account_store.loadPage(1);
	     }
			
		//监听新增按钮
		function f_account_add(){
			AOS.reset(report_create_form);
			report_create_win.show();
		}	
		
		//监听新增按钮
		function g_account_add(){
			AOS.reset(f_create_form);
			f_create_win.show();
		}
	       
		//自动生成
		function f_account_get1(){
			var record = AOS.selectone(AOS.get('my_daily'));
			var daily_date = record.data.daily_date;
			AOS.ajax({
				params : {
				daily_date : daily_date
				},
				url : 'dailyProductionService.f_get',
				ok : function(data) {
					AOS.tip(data.appmsg);
					report_grid_store.reload();
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
	   		   var record = AOS.selectone(AOS.get('my_daily'));
	     	   var daily_date = record.data.daily_date;
	 	   		AOS.ajax({
	 	   			params : {
	 	   				daily_date : daily_date
	 	   			},
	 	   			url : 'dailyProductionService.delDate',
	 	   			ok : function(data) {
		 	   			AOS.ajax({
			 	   			params : {
			 	   				daily_date : daily_date
			 	   			},
			 	   			url : 'dailyProductionService.f_get1',
			 	   			ok : function(data) {
				 	   			AOS.tip(data.appmsg);
								g_account_store.reload();
			 	   			}
			 	   		});
	 	   			}
	 	   		});
	   		});
   		}
	     
	     
		//修改日报保存
		function f_account2_update(){
			var percent = g_account.getStore().data.items[0].data.working_percent;
    	  	if(percent == ''){
    	  		AOS.tip('请填写当天工作比重！');
    			return;
    	  	}
    		var checkDate = g_account.getStore().data.items[0].data.daily_date;
    		AOS.ajax({
    			params : {
    				aos_rows:AOS.mrs(g_account)
    			},
    			url : 'dailyProductionService.updateGrid',
    			ok : function(data){
		    		AOS.ajax({
		    			params : {
		    				daily_date : checkDate
		    			},
		    			url : 'dailyProductionService.draft_update',
		    			ok : function(data){
		    				AOS.tip(data.appmsg);
							my_daily_store.reload();
							g_account_store.reload();
							w_account.hide();
		    			}
		    		});
    			}
    		});
		}
		
		//修改日报保存并提交
		function f_account_update_submit(){
			var percent = g_account.getStore().data.items[0].data.working_percent;
    	  	if(percent == ''){
    	  		AOS.tip('请填写当天工作比重！');
    			return;
    	  	}
			var msg =  "提交后将不能进行任何操作，请谨慎选择！";
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
	    		var checkDate = g_account.getStore().data.items[0].data.daily_date;
	    		AOS.ajax({
	    			params : {
	    				aos_rows:AOS.mrs(g_account)
	    			},
	    			url : 'dailyProductionService.updateGrid',
	    			ok : function(data){
			    		AOS.ajax({
			    			params : {
			    				daily_date : checkDate
			    			},
			    			url : 'dailyProductionService.update_submit',
			    			ok : function(data){
			    				AOS.tip(data.appmsg);
								my_daily_store.reload();
								g_account_store.reload();
								w_account.hide();
			    			}
			    		});
	    			}
	    		});
			})
		}
		
		//新增保存
		function report_create_preserve(){
			// var record = AOS.selectone(AOS.get('my_daily'));
			// console.log(record);
			var daily_date = AOS.getValue('date.daily_date');
			AOS.ajax({
				forms : report_create_form,
				params :{
					daily_date:daily_date
				},
				url : 'dailyProductionService.saveAdd',
				ok : function(data) {
					AOS.tip(data.appmsg);	
					my_daily_store.reload();
					report_create_win.hide();
					report_grid_store.reload();
				}
			});
		}
		
		//新增保存
		function f_create_preserve(){
			var daily_date = AOS.getValue('date.daily_date');
			AOS.ajax({
				forms : f_create_form,
				params :{
					daily_date:daily_date
				},
				url : 'dailyProductionService.saveAdd',
				ok : function(data) {
					AOS.tip(data.appmsg);	
					my_daily_store.reload();
					f_create_win.hide();
					g_account_store.reload();
				}
			});
		}
		
	       //工作日
	       function showWorkday(){
	    	   if(AOS.get('weekdayId').getValue()==1){
	    		   var params = {
	    				   week:6
	   			};
	    		   my_daily_store.getProxy().extraParams = params;
	    		   my_daily_store.loadPage(1);
	    	   }else if(AOS.get('weekdayId').getValue()==0){
	    		   var params = {
	    				   week:''
	   			};
	    		   my_daily_store.getProxy().extraParams = params;
	    		   my_daily_store.loadPage(1);
	    	   }
	       }
	       //查询比赛
	       function queryAll(){
	    	   var params = {
		    			type_code:''
				};
		    	toDoTaskGrid_store.getProxy().extraParams = params;
		    	toDoTaskGrid_store.loadPage(1);
	       }
	    //任务过滤
	    function queryTask(){
	    	var params = {
	    			type_code:1
			};
	    	toDoTaskGrid_store.getProxy().extraParams = params;
	    	toDoTaskGrid_store.loadPage(1);
	    }
	  //bug过滤
	    function queryBug(){
	    	var params = {
	    			type_code:2
			};
	    	toDoTaskGrid_store.getProxy().extraParams = params;
	    	toDoTaskGrid_store.loadPage(1);
	    }
	    //评审过滤
	    function queryPins(){
	    	var params = {
	    			type_code:4
			};
	    	toDoTaskGrid_store.getProxy().extraParams = params;
	    	toDoTaskGrid_store.loadPage(1);
	    }
	 
	    function gotoTaskPage() {
	    	var me=this;
			var date=Ext.Date.format(id_sysdate.getValue(), "Y-m");
			//window.open('do.jhtml?router=homeService.initTaskShow&juid=${juid}&date='+date);
			 window.open('do.jhtml?router=homeService.personalWorkloadList&juid=${juid}&date='+date);
	    }
       //跳转到我的日报界面
	    function gotoDailyPage(){
	        window.open("do.jhtml?router=dailyReportService.init&juid=${juid}");
	    }
        function query_my_daily() {
            my_daily_store.loadPage(1);
        }
         function changeDate(){
        	var me=this;
			var date=Ext.Date.format(id_sysdate.getValue(), "Y-m");
        	AOS.ajax({
        		 dataType:"json", 
        		 data:{},
        	    url:'homeService.initRePortal&date='+date,
        	    ok: function(data){
        	    	document.getElementById("id_yjs").innerHTML= data.yjs;
        	    	document.getElementById("id_ywc").innerHTML= data.ywc;
        	    	document.getElementById("id_ygb").innerHTML= data.ygb;
        	    	document.getElementById("id_jhgzl").innerHTML= data.jhgzl;
        	    	document.getElementById("id_sjgzl").innerHTML= data.sjgzl;
        	    }
        	});
        } 
        function query_to_do_task() {
            toDoTaskGrid_store.loadPage(1);
        }

        function on_public_tree(view, record, node, item, e) { 
            if (record.raw.a == '3') {
                var proj_id = record.raw.id;
                AOS.ajax({
                    url: 'projCommonsService.queryOneProjectInformation',
                    params: {
                        proj_id: proj_id
                    },
                    ok: function (data) {
                        AOS.get('project_information_form.name').setValue(data[0].project_for_short);
                        AOS.get('project_information_form.pm_user_name').setValue(data[0].pm_user_name);
                        AOS.get('project_information_form.pm2_user_name').setValue(data[0].pm2_user_name);
                        AOS.get('project_information_form.begin_date').setValue(data[0].begin_date);
                        AOS.get('project_information_form.period').setValue(data[0].PERIOD);
                        AOS.get('project_information_form.week_date').setValue(data[1].week_date);
                    }
                });
                $.ajax({
                	url: "http://"+AOS.Message_Url+"/mes/getList",
        			type : "patch",
        			contentType:"application/json",
        			processData:false,
        			dataType: "json",
        			data: JSON.stringify({
        				"eq_channel.code":"9527",
        				"eq_mesGroup":"CHANNEL",
        				"eq_extras.proj_id":proj_id,
        				"great_extras.sedTime":'${preWeekMonday}',
     				    "less_extras.createTime":'${week_end_date}'
        				}),
        				success : function(data){
        					//AOS.get('count_mes').store.add(	data.data.list);
        					count_mes_store.removeAll();
        					count_mes_store.filter('proj_id', proj_id);
        				var arrayList=[];
    						Ext.Array.each(data.data,function(item){
    							arrayList.push(item);
    						})
    					Ext.each(arrayList,function(item){
    						var content =JSON.parse(item.content).content;
    						var proj_id =JSON.parse(item.content).proj_id;
    						var type =JSON.parse( item.content ).type;
    						var proj_name =JSON.parse( item.content ).proj_name;
    						var hasRead = item.mesRecives[0].status;
                			var mes_id = item.id;
    						count_mes_store.insert(0,{
    							content:content,
    							proj_id:proj_id,
    							proj_name:proj_name,
    							type:item.title,
    							createTime:item.createTime,
    							id:item.id,
    							hasRead:hasRead
    						})
    			}) 
        	},
        			
        });
              //count_mes.columns[5].hide();
                count_mes.down("gridcolumn[dataIndex=proj_name]").hide();//show()
      }else if(record.raw.a == '0'){
    	  AOS.reset(AOS.get('project_information_form'));
    	  var arrayList=[];
    		Ext.Array.each(record.childNodes[0].childNodes,function(item){
    			var id = item.internalId;
    			arrayList.push(id);
    		})
    		Ext.Array.each(record.childNodes[1].childNodes,function(item){
    			var id = item.internalId;
    			arrayList.push(id);
    		})
   			var proj_ids = arrayList.join(",");
    		if(proj_ids==""){
    			var	proj_ids =0
    		}
    	  $.ajax({
    		  url: "http://"+AOS.Message_Url+"/mes/getList",
  			type : "patch",
  			contentType:"application/json",
  			processData:false,
  			dataType: "json",
  			data: JSON.stringify({
  				"eq_channel.code":"9527",
				"eq_mesGroup":"CHANNEL",
  				"in_extras.proj_id" : proj_ids,
  				"great_extras.sedTime":'${preWeekMonday}',
				"less_extras.createTime":'${week_end_date}'
  				}),
  				success : function(data){
  					count_mes_store.removeAll();
  					count_mes_store.filter('proj_id', proj_ids);
  				var arrayList=[];
						Ext.Array.each(data.data,function(item){
							arrayList.push(item);
						})
					Ext.each(arrayList,function(item){
						var content =JSON.parse(item.content).content;
						var proj_id =JSON.parse(item.content).proj_id;
						var type =JSON.parse( item.content ).type;
						var proj_name =JSON.parse( item.content ).proj_name;
						var hasRead = item.mesRecives[0].status;
            			var mes_id = item.id;
            						count_mes_store.insert(0,{
            							content:content,
            							proj_id:proj_id,
            							proj_name:proj_name,
            							type:item.title,
            							createTime:item.createTime,
            							id:item.id,
            							hasRead:hasRead
            						})
						
					}) 
		 	 	},
		  			
		  });
    	  count_mes.columns[5].show();
     }else if(record.raw.a == '1'){
    	 AOS.reset(AOS.get('project_information_form'));
    	 var arrayList=[];
  		Ext.Array.each(record.data.children,function(item){
 				var proj_id = item.id;
 				arrayList.push(proj_id);
  		})
 			var proj_ids = arrayList.join(",");
	  		if(proj_ids==""){
				var	proj_ids =0
			}
 			$.ajax({
 				url: "http://"+AOS.Message_Url+"/mes/getList",
       			type : "patch",
       			contentType:"application/json",
       			processData:false,
       			dataType: "json",
       			data: JSON.stringify({
       				"eq_channel.code":"9527",
    				"eq_mesGroup":"CHANNEL",
      				"in_extras.proj_id" : proj_ids,
      				"great_extras.sedTime":'${preWeekMonday}',
 				    "less_extras.createTime":'${week_end_date}'
       				}),
       				success : function(data){
      					count_mes_store.removeAll();
      					count_mes_store.filter('proj_id', proj_ids);
      				var arrayList=[];
    						Ext.Array.each(data.data,function(item){
    							arrayList.push(item);
    						})
    					Ext.each(arrayList,function(item){
    						var content =JSON.parse(item.content).content;
    						var proj_id =JSON.parse(item.content).proj_id;
    						var type =JSON.parse( item.content ).type;
    						var proj_name =JSON.parse( item.content ).proj_name;
    						var hasRead = item.mesRecives[0].status;
                			var mes_id = item.id;
                						count_mes_store.insert(0,{
                							content:content,
                							proj_id:proj_id,
                							proj_name:proj_name,
                							type:item.title,
                							createTime:item.createTime,
                							id:item.id,
                							hasRead:hasRead
                						})
    						
    					}) 
    		 	 	},
       });
 			 count_mes.columns[5].show();
     }else if(record.raw.a == '2'){
    	 AOS.reset(AOS.get('project_information_form'));
    	 var arrayList=[];
 		Ext.Array.each(record.data.children,function(item){
				var proj_id = item.id;
				arrayList.push(proj_id);
 		})
 		var proj_ids =arrayList.join(",");
 		if(proj_ids==""){
			var	proj_ids =0
		}
 		$.ajax({
 			url: "http://"+AOS.Message_Url+"/mes/getList",
  			type : "patch",
  			contentType:"application/json",
  			processData:false,
  			dataType: "json",
  			data: JSON.stringify({
  				"eq_channel.code":"9527",
				"eq_mesGroup":"CHANNEL",
  				"in_extras.proj_id" : proj_ids,
  				 "great_extras.sedTime":'${preWeekMonday}',
				 "less_extras.createTime":'${week_end_date}'
  				}),
  				success : function(data){
  					count_mes_store.removeAll();
  					count_mes_store.filter('proj_id', proj_ids);
  				var arrayList=[];
						Ext.Array.each(data.data,function(item){
							arrayList.push(item);
						})
					Ext.each(arrayList,function(item){
						var content =JSON.parse(item.content).content;
						var proj_id =JSON.parse(item.content).proj_id;
						var type =JSON.parse( item.content ).type;
						var proj_name =JSON.parse( item.content ).proj_name;
						var hasRead = item.mesRecives[0].status;
            			var mes_id = item.id;
            						count_mes_store.insert(0,{
            							content:content,
            							proj_id:proj_id,
            							proj_name:proj_name,
            							type:item.title,
            							createTime:item.createTime,
            							id:item.id,
            							hasRead:hasRead
            						})
						
					}) 
		 	 	},
		  });
 		 count_mes.columns[5].show();
		 }
            
 }
    	function flag_mes(value, metaData, record, rowIndex, colIndex,store){
  		   var tmp = value;
 	   		if (value=='HAD_READ') {
 	   			tmp='<img src="${cxt}/static/icon/message_yd.png" align="center"/>'
 			} 
 	   		else{
 					tmp='<img src="${cxt}/static/icon/message_wd.png" align="center"/>'
 			}
 			return tmp;
  		}
  		
  		
  		 function flag_m(){
  			var value = AOS.getValue('look_mes.hasRead');
  			if(value=='HAD_READ'){
  	 	   		 return "<span style='color:green; font-weight:bold'>已读</span>"
  	 			}else {
  	   		 return "<span style='color:red; font-weight:bold'>未读</span>"
  			} 
  	   		
  			return value;
  			}
 		
 		
 		function content(value, metaData, record) {
 			return '<a href="javascript:void(0);">' + record.data.content +  '</a>' ;
 			var hasRead = AOS.setValue('count_mes.hasRead',1) 
 		}
 		
        //按钮列转换
        function state_Fn_render(value, metaData, record, rowIndex, colIndex,
                                 store) {
            if (record.raw.type_code == 1) {
                if (value == 1002) {
                    return "<span style='color:red; font-weight:bold'>待接收</span>"
                }
                if (value == 1003) {
                    return "<span style='color:green; font-weight:bold'>已接收</span>"
                }
                if (value == 1007) {
                	return "<span style='color:#FF00FF;font-weight:bold;'>已暂停</span>"
                }
            } 
            else if(record.raw.type_code == 4) {
            	if(value == 1){
                	 return "<span style='color:red; font-weight:bold'>待确认</span>";
                }else if(value == 2){
               	 	return "<span style='color:green; font-weight:bold'>已确认</span>";
               	}else if(value == 3){
               		return "<span style='color:green; font-weight:bold'>已拒绝</span>";
            	}else{
               		return "<span style='color:red; font-weight:bold'>待确认</span>";
               	}
            }
            else{
                if (value == 1000) {
                    return "<span style='color:red; font-weight:bold'>未解决</span>"
                } else if (value == 1001) {
                    return "<span style='color:green; font-weight:bold'>已解决</span>"
                } else if(value == 1002) {
                    return "<span style='color:orange; font-weight:bold'>延期处理</span>";
                }else if(value == 1003) {
                    return "<span style='color:orange; font-weight:bold'>关闭</span>";
                }else if(value == 1004) {
                    return "<span style='color:orange; font-weight:bold'>已拒绝</span>";
                }else if(value == 1005) {
                    return "<span style='color:blue; font-weight:bold'>重现打开</span>";
                }
            }

        }
		
        function fn_daily_type(value, metaData, record){
			if(value =='1'){
				return "<span>自定义</span>";
			}else if(value =='2'){
				return "<span>任务</span>";
			}else if(value =='3'){
				return "<span>缺陷</span>";
			}else {
				return "<span>会议</span>";
			}
		}
        
        function fn_daily_status(value, metaData, record){
			if(value =='0'){
				return "<span>草稿</span>";
			}else if(value =='1'){
				return "<span>提交</span>";
			}else if(value =='2'){
				return "<span>已同步</span>";
			}
		}
		
        //按钮列转换
        function state_render(value, metaData, record, rowIndex, colIndex,
                              store) {
	            if(record.raw.daily_status =="1"){
                return '<input type="button" value="查看"  class="cbtn" onclick="query_click();" />';
            } else {
                return '<input type="button" value="补充"  class="cbtn_danger"  onclick="button_click();" />';
            }
        }
        
        
        //日期转换
        function fn_time_render(value, metaData, record){
            var tmp = value;
            if(value.substr(value.length-1,1)=='一' || value.substr(12)=='Monday'){
                tmp = '<img src="../static/icon/one_daily.png" align="center"/>&nbsp;&nbsp;' +tmp.substring(0,10) 
            }
            if(value.substr(value.length-1,1)=='二' || value.substr(12)=='Tuesday'){
                tmp =' <img src="../static/icon/two_daily.png" align="center"/>&nbsp;&nbsp;'+ tmp.substring(0,10) 
            }
            if(value.substr(value.length-1,1)=='三' || value.substr(12)=='Wednesday'){
                tmp ='<img src="../static/icon/three_daily.png" align="center"/>&nbsp;&nbsp;'+ tmp.substring(0,10) 
            }
            if(value.substr(value.length-1,1)=='四' || value.substr(12)=='Thursday'){
                tmp = ' <img src="../static/icon/four_daily.png" align="center"/>&nbsp;&nbsp;'+tmp.substring(0,10) 
            }
            if(value.substr(value.length-1,1)=='五' || value.substr(12)=='Friday'){
                tmp =' <img src="../static/icon/five_daily.png" align="center"/>&nbsp;&nbsp;'+ tmp.substring(0,10) 
            }
            if(value.substr(value.length-1,1)=='六' || value.substr(12)=='Saturday'){
                tmp = ' <img src="../static/icon/six_daily.png" align="center"/>&nbsp;&nbsp;'+tmp.substring(0,10)
            }
            if(value.substr(value.length-1,1)=='日' || value.substr(12)=='Sunday'){
                tmp =' <img src="../static/icon/seven_daily.png" align="center"/>&nbsp;&nbsp;'+ tmp.substring(0,10) 
            }
            return tmp;
        }
        //内容转换
        function fn_descc_render(value, metaData, record){
            if(value!=''){
                metaData.tdAttr = "data-qtip=" + value;
            }
            return value;
        }
 

        function query_form_reset() {
            AOS.reset(AOS.get('query_form'));
        }

       
        function onwindows_toDo(grid, record) {
            //var select = AOS.select(AOS.get('toDoTaskGrid'));
           // AOS.tip(select[0].raw.to_do_name);
            //任务
            if (record.data.type_code==1) {
            	var task_code=record.data.task_code;
        		var task_name=record.data.task_name;
                window .open('do.jhtml?router=taskService.viewInit&juid=<%=request.getAttribute("juid") %>&task_id='+record.data.id+'&proj_id='+record.data.proj_id+'&task_code='+record.data.code+'&task_name='+record.data.to_do_name);
                return;
            }
            //缺陷
            if (record.data.type_code==2) {
                window.open("do.jhtml?router=bugManageService.newsdataInit&juid=<%=request.getAttribute("juid")%>&user_name=${user.name}&bug_id="+record.data.id);
                return;
            }
            //评审
            if (record.data.type_code==4) {
          		window.open('do.jhtml?router=filesManageService.initRepanel&juid=<%=request.getAttribute("juid")%>&mang_id='+record.data.code);
                return;
            }
        }
        
        //统一保存
        function fn_all_update(){
    		if (AOS.mrows(report_grid) == 0) {
    			AOS.tip('数据没变化，提交操作取消。');
    			return;
    		}
    		var percent = report_grid.getStore().data.items[0].data.working_percent;
    	  	if(percent == ''){
    	  		AOS.tip('请填写当天工作比重！');
    			return;
    	  	}
    		AOS.ajax({
    			params : {
    				aos_rows:AOS.mrs(report_grid)
    			},
    			url : 'dailyProductionService.updateGrid',
    			ok : function(data){
    				AOS.tip(data.appmsg);
    				report_grid_store.reload();
    			}
    		});
    	}
        
      //新增草稿
		function f_account_save(){
    	  	var percent = report_grid.getStore().data.items[0].data.working_percent;
    	  	if(percent == ''){
    	  		AOS.tip('请填写当天工作比重！');
    			return;
    	  	}
			var checkDate = report_grid.getStore().data.items[0].data.daily_date;
			AOS.ajax({
    			params : {
    				aos_rows:AOS.mrs(report_grid)
    			},
    			url : 'dailyProductionService.updateGrid',
    			ok : function(data){
		    		AOS.ajax({
		    			params : {
		    				daily_date : checkDate
		    			},
		    			url : 'dailyProductionService.draft_create',
		    			ok : function(data){
		    				AOS.tip(data.appmsg);
							my_daily_store.reload();
							report_grid_store.reload();
							book_win.hide();
		    			}
		    		});
    			}
    		});
		}
      	
		 //新增提交
        function f_account_submit(){
			var percent = report_grid.getStore().data.items[0].data.working_percent;
    	  	if(percent == ''){
    	  		AOS.tip('请填写当天工作比重！');
    			return;
    	  	}
			var msg =  "提交后将不能进行任何操作，请谨慎选择！";
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				var checkDate = report_grid.getStore().data.items[0].data.daily_date;
				AOS.ajax({
	    			params : {
	    				aos_rows:AOS.mrs(report_grid)
	    			},
	    			url : 'dailyProductionService.updateGrid',
	    			ok : function(data){
			    		AOS.ajax({
			    			params : {
			    				daily_date : checkDate
			    			},
			    			url : 'dailyProductionService.create',
			    			ok : function(data){
			    				AOS.tip(data.appmsg);
								my_daily_store.reload();
								report_grid_store.reload();
								book_win.hide();
			    			}
			    		});
	    			}
	    		});
			})
        }
        
      //关闭日报
     	function closing_daily(){
    	   var length = report_grid.getStore().data.length;
    	  	if(length == 0){
    	  		book_win.hide();
    	  	}else{
    	  		var state = report_grid.getStore().data.items[0].data.daily_status;
    	  		if(state == " "){
		     		var checkDate = report_grid.getStore().data.items[0].data.daily_date;
		     		AOS.ajax({
		    			params : {
		    				daily_date : checkDate
		    			},
		    			url : 'dailyProductionService.delDate',
		    			ok : function(data){
		    				my_daily_store.reload();
							report_grid_store.reload();
							book_win.hide();
		    			}
		    		});
    	  		}else{
    	  			book_win.hide();
    	  		}
    	  	}
     }
		 
        function f_all_update(){
    		if (AOS.mrows(g_account) == 0) {
    			AOS.tip('数据没变化，提交操作取消。');
    			return;
    		}
    		var percent = g_account.getStore().data.items[0].data.working_percent;
    	  	if(percent == ''){
    	  		AOS.tip('请填写当天工作比重！');
    			return;
    	  	}
    		AOS.ajax({
    			params : {
    				aos_rows:AOS.mrs(g_account)
    			},
    			url : 'dailyProductionService.updateGrid',
    			ok : function(data){
    				AOS.tip(data.appmsg);
    				g_account_store.reload();
    			}
    		});
    	}
        
        //删除
        function f_account_del(){
			var selection = AOS.selection(report_grid, 'daily_id');
			var rows = AOS.rows(report_grid);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'dailyProductionService.delete',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
	    				report_grid_store.reload();
					}
				});
			});
		}
        
      //删除
        function g_account_del(){
			var selection = AOS.selection(g_account, 'daily_id');
			var rows = AOS.rows(g_account);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'dailyProductionService.delete',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						g_account_store.reload();
					}
				});
			});
		}

        //详情
        function g_account_query(){
            var treeValue = my_project_tree.getSelectionModel().getSelection();
            var proj_id = '${proj_id__}';
            if(treeValue.length == 0){
            	window.open("do.jhtml?router=homeService.init&juid=<%=request.getAttribute("juid")%>&proj_id="+'${proj_id__}'+"&create_time="+'${create_time}');
            }else{
            	window.open("do.jhtml?router=homeService.init&juid=<%=request.getAttribute("juid")%>&proj_id="+treeValue[0].raw.id+"&proj_name="+treeValue[0].raw.text+"&create_time="+'${create_time}');
            }
        }
        
        //详情
        function more_mes(){
            var record = my_project_tree.getSelectionModel().getSelection();
            if(record.length==0){
             AOS.ajax({
            	url : 'projCommonsService.my_project_tree',
            	 ok: function (data) {
            		 var arrayList=[];
                 	Ext.Array.each(data[0].children[0].children,function(item){
             			var proj_id = item.id;
             			arrayList.push(proj_id);
             		})
             		Ext.Array.each(data[0].children[1].children,function(item){
             			var proj_id = item.id;
             			arrayList.push(proj_id);
             		})
            			var proj_ids = arrayList.join(",");
                	 window.open("do.jhtml?router=homeService.initMes&juid=<%=request.getAttribute("juid")%>&proj_id="+proj_ids);
            	 	}
            	});
            }
            if (record[0].raw.a == '3') {
           var proj_id = record[0].data.id;
           var proj_name = record[0].data.text;
       	 window.open("do.jhtml?router=homeService.initMes&juid=<%=request.getAttribute("juid")%>&proj_id=proj_id&proj_name="+proj_name);
          
        }
            if (record[0].raw.a == '1'||record[0].raw.a == '2') {
          	 var arrayList=[];
       		Ext.Array.each(record[0].data.children,function(item){
      				var proj_id = item.id;
      				arrayList.push(proj_id);
       		})
       		var proj_ids =arrayList.join(",");
       	 window.open("do.jhtml?router=homeService.initMes&juid=<%=request.getAttribute("juid")%>&proj_id="+proj_ids);
          
        }
            if (record[0].raw.a == '0') {
            	 var arrayList=[];
         		Ext.Array.each(record[0].childNodes[0].childNodes,function(item){
         			var id = item.internalId;
         			arrayList.push(id);
         		})
         		Ext.Array.each(record[0].childNodes[1].childNodes,function(item){
         			var id = item.internalId;
         			arrayList.push(id);
         		})
        			var proj_ids = arrayList.join(",");
            	 window.open("do.jhtml?router=homeService.initMes&juid=<%=request.getAttribute("juid")%>&proj_id="+proj_ids);
               
             }
     }
        
        function readsForm() {
        //	AOS.tip('这里开始自动设置进去1111111');
            AOS.reads(AOS.get('project_information_form'), "name,pm_user_name,pm2_user_name,begin_date,period,accept_date,week_date");
            var proj_id = '${proj_id__}';     
            if(proj_id != null && proj_id != ''){
            AOS.ajax({
                url: 'projCommonsService.queryOneProjectInformation_default',
                ok: function (data) {
                    AOS.get('project_information_form.name').setValue(data[0].project_for_short);
                    AOS.get('project_information_form.pm_user_name').setValue(data[0].pm_user_name);
                    AOS.get('project_information_form.pm2_user_name').setValue(data[0].pm2_user_name);
                    AOS.get('project_information_form.begin_date').setValue(data[0].begin_date);
                    AOS.get('project_information_form.period').setValue(data[0].PERIOD);
                    AOS.get('project_information_form.week_date').setValue(data[1].week_date);
                  } 
            });
            }
            AOS.ajax({
                url: 'weekService.cache_token',
                ok: function (data) {
                	var token=data.appmsg;
       			 socket = io.connect('http://'+AOS.Message_Host+':9090' + '/'+ 9527 + "?token=" + token, {
       					"transports" : [ 'websocket', 'polling' ]
       				});
       			 socket.on('client_connect', (mes) => {
       						if(mes.createTime!=null){
			       			var content =JSON.parse(mes.content).content;
								var proj_id =JSON.parse(mes.content).proj_id;
								var type =JSON.parse( mes.content).type;
								var createTime =JSON.parse( mes.content).createTime;
								var proj_name =JSON.parse( mes.content).proj_name;
								var hasRead = mes.mesRecives[0].status;
								count_mes_store.insert(0,{
						       		content:content,
						       		proj_id:proj_id,
						       		proj_name:proj_name,
						       		type:mes.title,
						       		createTime:createTime,
						       		id:mes.id,
						       		hasRead:hasRead
					  })
       			} 
       		});
    	  }
	  }); 
         $.ajax({
       		url: "http://"+AOS.Message_Url+"/mes/getList",
       		type : "patch",
       		contentType:"application/json",
       		processData:false,
       		dataType: "json",
       		data: JSON.stringify({
       				"eq_channel.code":"9527",
       				"eq_mesGroup":"CHANNEL",
       				"eq_extras.proj_id":proj_id,
       			    "great_extras.sedTime":'${preWeekMonday}',
				    "less_extras.createTime":'${week_end_date}'
       			}),
       		success : function(data){
       			console.log("data",data);
       			 var arrayList=[];
       			Ext.Array.each(data.data,function(item){
       				arrayList.push(item);
       			})
       		Ext.each(arrayList,function(item){
       			var content =JSON.parse(item.content).content;
       			var proj_id =JSON.parse(item.content).proj_id;
       			var type =JSON.parse( item.content ).type;
       			var proj_name =JSON.parse( item.content ).proj_name;
       			var hasRead = item.mesRecives[0].status;
       			var mes_id = item.id;
       						count_mes_store.insert(0,{
       							content:content,
       							proj_id:proj_id,
       							proj_name:proj_name,
       							type:item.title,
       							createTime:item.createTime,
       							id:item.id,
       							hasRead:hasRead
       						})
       					
       			}) 
       		 },
      	 }); 
       
  
     
 }
        
        
        function delect_default_project(){
        	Ext.getCmp("set_default_project_button").show();
    		Ext.getCmp("delect_default_project_button").hide();
    		window.proj_id___ = '';
    		 AOS.ajax({
    	            url : 'dailyReportService.delete_my_default_project',
    	            ok : function(data) {
    	                AOS.tip(data.appmsg);
    	                parent.location.reload();
   
    	            }
    	        });	
        }
        
        window.proj_id___ = '';
        
        function set_default_project(){
        	var proj_id = AOS.selectone(AOS.get('my_project_tree'), true).data.id;
        	window.proj_id___ = proj_id;
        	Ext.getCmp("set_default_project_button").hide();
    		Ext.getCmp("delect_default_project_button").show();
            AOS.ajax({
            	params:{
            		proj_id : proj_id
        		},
                url:'dailyReportService.set_my_default_project',
                ok : function(data) {
                	AOS.tip(data.appmsg);
                	parent.location.reload();
                //    AOS.tip('这里开始自动设置进去22222');
                    AOS.reads(AOS.get('project_information_form'), "name,pm_user_name,pm2_user_name,begin_date,period,accept_date,week_date");
                    AOS.ajax({
                        url: 'projCommonsService.queryOneProjectInformation_default',
                        ok: function (data) {
                          
                            AOS.get('project_information_form.name').setValue(data[0].project_for_short);
                            AOS.get('project_information_form.pm_user_name').setValue(data[0].pm_user_name);
                            AOS.get('project_information_form.pm2_user_name').setValue(data[0].pm2_user_name);
                            AOS.get('project_information_form.begin_date').setValue(data[0].begin_date);
                            AOS.get('project_information_form.period').setValue(data[0].PERIOD);
                            AOS.get('project_information_form.week_date').setValue(data[1].week_date);
                            
                           
                        }
                    });  
                 //   var proj_id = '${proj_id__}';
                 var proj_id = AOS.selectone(AOS.get('my_project_tree'), true).data.id;
              //     AOS.tip(proj_id);
                 AOS.ajax({
                     url: 'weekService.cache_token',
                     ok: function (data) {
                     	var token=data.appmsg;
            			 socket = io.connect('http://'+AOS.Message_Host+':9090' + '/'+ 9527 + "?token=" + token, {
            					"transports" : [ 'websocket', 'polling' ]
            				});
            			 socket.on('client_connect', (mes) => {
            						if(mes.createTime!=null){
     			       			var content =JSON.parse(mes.content).content;
     								var proj_id =JSON.parse(mes.content).proj_id;
     								var type =JSON.parse( mes.content).type;
     								var createTime =JSON.parse( mes.content).createTime;
     								var proj_name =JSON.parse( mes.content).proj_name;
     								var hasRead = mes.mesRecives[0].status;
     								count_mes_store.insert(0,{
     						       		content:content,
     						       		proj_id:proj_id,
     						       		proj_name:proj_name,
     						       		type:mes.title,
     						       		createTime:createTime,
     						       		id:mes.id,
     						       		hasRead:hasRead
     					  })
            			} 
            		});
         	  }
     	  }); 
              $.ajax({
            		url: "http://"+AOS.Message_Url+"/mes/getList",
            		type : "patch",
            		contentType:"application/json",
            		processData:false,
            		dataType: "json",
            		data: JSON.stringify({
            				"eq_channel.code":"9527",
            				"eq_mesGroup":"CHANNEL",
            				"eq_extras.proj_id":proj_id,
            				 "great_extras.sedTime":'${preWeekMonday}',
         				    "less_extras.createTime":'${week_end_date}'
            			}),
            		success : function(data){
            			console.log("data",data);
            			count_mes_store.removeAll();
            			 var arrayList=[];
            			Ext.Array.each(data.data,function(item){
            				arrayList.push(item);
            			})
            		Ext.each(arrayList,function(item){
            			var content =JSON.parse(item.content).content;
            			var proj_id =JSON.parse(item.content).proj_id;
            			var type =JSON.parse( item.content ).type;
            			var proj_name =JSON.parse( item.content ).proj_name;
            			var hasRead = item.mesRecives[0].status;
            			var mes_id = item.id;
            						count_mes_store.insert(0,{
            							content:content,
            							proj_id:proj_id,
            							proj_name:proj_name,
            							type:item.title,
            							createTime:item.createTime,
            							id:item.id,
            							hasRead:hasRead
            						})
            			}) 
            		 },
           	 }); 
	
         }
      });
     }
      //只有第三节点需要添加功能
        function my_project_tree_setmenu() {
    	   // AOS.tip('改默认项目显示问题在1367行哈！');
        	var tree_type = AOS.selectone(my_project_tree, true).data.depth;
        	var proj_id = '${proj_id__}'
        	var proj_id_now = AOS.selectone(AOS.get('my_project_tree'), true).data.id;

        	if(tree_type == '1'){
            	Ext.getCmp("set_default_project_button").hide();
            	Ext.getCmp("delect_default_project_button").hide();
            	}else if(tree_type == '2'){
            		Ext.getCmp("set_default_project_button").hide();
            		Ext.getCmp("delect_default_project_button").hide();
            	}else{
            		if(window.proj_id___!=null && window.proj_id___ !=''){
        
            			if(proj_id___ == proj_id_now){
                			Ext.getCmp("set_default_project_button").hide();
                    		Ext.getCmp("delect_default_project_button").show();
                		}else{
                		Ext.getCmp("set_default_project_button").show();
                		Ext.getCmp("delect_default_project_button").hide();
                	          }
            		                 }else{
            		                	
            		if(proj_id == proj_id_now){
            			// AOS.tip('点击到了默认的项目！');
            			Ext.getCmp("set_default_project_button").hide();
                		Ext.getCmp("delect_default_project_button").show();
            		                        }else{
            		Ext.getCmp("set_default_project_button").show();
            		Ext.getCmp("delect_default_project_button").hide();
            	                                 }
            		                        }
            	}
        }
      
      //完成百分比
    	function percent_render(value){
    		if(value)return value+"%";
    		return "0%";
    	}
    	
    	//修改完成百分比
    	function saveData2(){ 
    		if (AOS.mrows(toDoTaskGrid) == 0) {
    			AOS.tip('数据没变化，提交操作取消。');
    			return;
    		}
    		AOS.ajax({
    			params:{
    				aos_rows : AOS.mrs(toDoTaskGrid)
    			},
    			url:'taskService.updateGrid',
    			ok:function(data){
    				AOS.tip(data.appmsg);
    				toDoTaskGrid_store.reload();
    			}
    		});
    	}
    </script>
</aos:onready>
<script type="text/javascript">



      //查看已提交的日报
		function query_click() {
		    AOS.disableCmps('save_account_btn');
		    AOS.disableCmps('submit_account_btn');
		    AOS.disableCmps('autopress');
		    AOS.disableCmps('del_account');
		    AOS.disableCmps('account_add');
		    AOS.get("book_win").show();
		}
      
  	//补充日报
    function button_click() {
    	  AOS.enableCmps('save_account_btn');
          AOS.enableCmps('autopress');
          AOS.enableCmps('submit_account_btn');
          AOS.enableCmps('del_account');
          AOS.enableCmps('account_add');
          var record = AOS.selectone(AOS.get('my_daily'));
		  AOS.setValue('date.daily_date',record.data.daily_date);
        if(record.data.daily_status == 0){
        	AOS.get("w_account").show();
        }else{
     	  	AOS.get("book_win").show();
        }
    }
  //修改界面只读方法
	function fn_reads1(){
		AOS.reads(f_account,'name,daily_time');
	}
 
	function refresh() {
		AOS.get('toDoTaskGrid').getStore().reload();
	}

</script>



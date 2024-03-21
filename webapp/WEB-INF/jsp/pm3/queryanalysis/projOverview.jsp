<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<aos:html title="项目总览" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel  bodyBorder="0 0 1 0"  region="north">
			<aos:formpanel id="query_form" layout="column" labelWidth="60"
				header="false" border="false" >
				<aos:textfield fieldLabel="项目名称" name="proj_name" columnWidth="0.3"
				emptyText="请输入项目名称" margin="4"/>
				<aos:datefield fieldLabel="项目启动时间"  labelWidth="80" name="begin_time" margin="4" columnWidth="0.25"/>
				<aos:datefield fieldLabel="到" name="end_time"  labelWidth="25" margin="4" columnWidth="0.2"/>
				<aos:button text="查询" onclick="form_grid_query" margin="4 4 4 40" icon="query.png"
					 />
				<aos:button text="重置" onclick="AOS.reset(query_form);"
					margin="4" />
			</aos:formpanel>
		</aos:panel>
		<aos:gridpanel id="proj_grid" url="projOverviewService.page"   region="center"
			 onrender="proj_grid_query"  forceFit="false" onitemdblclick="#example_win_show('update');" 
			bodyBorder="1 0 1 0">
			<aos:docked>
				<aos:dockeditem xtype="tbtext" text="项目总览"/>
				<%-- <aos:dockeditem  text="打印" onclick="on_proj_print"/> --%>
			</aos:docked>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="项目ID"  dataIndex="PROJ_ID" width="100" hidden="true"/>
			<aos:column header="项目详情"  width="100" align="center" rendererFn="fn_button_render"/>
			<aos:column header="项目编码" dataIndex="PROJ_CODE" width="120"  align="left"/>
			<aos:column header="项目名称" dataIndex="PROJ_NAME" width="200" align="left"/>
			<aos:column header="状态" dataIndex="STATE" width="100" align="center"  rendererFn="fn_proj_state"/>
			<aos:column header="启动时间" dataIndex="BEGIN_DATE" format="Y-m-d"  type="date" width="100" align="center"/>
			<aos:column header="验收时间" dataIndex="ACCEPT_DATE" format="Y-m-d"  type="date" width="100" align="center"/>
			<aos:column header="当前周期/计划周期" dataIndex="WEEKDAY_PERIOD" width="150" align="center" />
			<aos:column header="项目经理" dataIndex="PM_USER_NAME" width="100" align="center"/>
			<aos:column header="开发经理" dataIndex="PM2_USER_NAME" width="100" align="center"/>
			<aos:column header="客户名称" dataIndex="CLIENT_NAME" width="150" />
			<aos:column header="客户地址" dataIndex="CLIENT_ADDRESS" width="150" />
			<aos:column header="客户责任人姓名" dataIndex="CLIENT_OUT_NAME" width="100" align="center"/>
			<aos:column header="客户责任人电话" dataIndex="CLIENT_OUT_PHONE" width="150" align="center"/>
			<aos:column header="创建人" dataIndex="CREATE_USER_NAME" width="100" align="center" hidden="true"/>
			<aos:column header="创建时间" dataIndex="CREATE_TIME" width="150" align="center" hidden="true"/>
			<aos:column header="更新人" dataIndex="UPDATE_USER_NAME" width="100" align="center" hidden="true"/>
			<aos:column header="更新时间" dataIndex="UPDATE_TIME" width="150" align="center" hidden="true"/>
		</aos:gridpanel>
		<aos:window id="proj_particulars" width="800" height="450" title="项目详情窗口"
			 >
			<aos:tabpanel id="id_tabs2" anchor="100% 35%" margin="10" plain="true">
				<aos:tab title="项目团队" id="proj_teams" onshow="team_grid_query">
					<aos:gridpanel id="team_grid" url="projOverviewService.teamPage" >
						<aos:column type="rowno" />
						<aos:column header="角色" dataIndex="TRP_NAME" align="center" />
						<aos:column header="成员姓名" dataIndex="TEAM_USER_NAME" align="center" />
						<aos:column header="加入时间" dataIndex="JOIN_DATE" format="Y-m-d" type="date" align="center"/>
						<aos:column header="退出时间" dataIndex="QUIT_DATE" width="120" align="center"/>
						<aos:column header="状态" dataIndex="state" align="center" rendererFn="fn_team_state"/>
						<aos:column header="成员说明" dataIndex="JP_DESC" />
					</aos:gridpanel>
				</aos:tab>
				<%-- <aos:tab title="合同详情" onshow="contract_grid_query" id="contract_particulars" >
					<aos:gridpanel id="contract_grid" url="projOverviewService.contractPage" >
						<aos:column type="rowno" />
						<aos:column header="合同名称" dataIndex="CONT_NAME" />
						<aos:column header="合同类型" dataIndex="CONT_TYPE" align="center" />
						<aos:column header="合同状态" dataIndex="CP_TYPE" align="center" rendererField="re_cp_type"/>
						<aos:column header="总金额" dataIndex="TOTAL_MONEY" align="center"/>
						<aos:column header="签订时间" dataIndex="SIGN_TIME" align="center"/>
						<aos:column header="合同描述" dataIndex="CONT_DESC" />
						<aos:column header="付款条件" dataIndex="PT_DESC" />
					</aos:gridpanel>
				</aos:tab>
				<aos:tab title="回款信息" onshow="money_grid_query">
					<aos:gridpanel id="money_grid" url="projOverviewService.moneyPage" >
						<aos:column type="rowno" />
						<aos:column header="支付名称" dataIndex="pay_name" />
						<aos:column header="支付时间" dataIndex="pay_time" align="center" />
						<aos:column header="支付金额" dataIndex="pay_money"/>
					</aos:gridpanel>
				</aos:tab> --%>
				<aos:tab title="风险信息" id="risk_info" onshow="risk_grid_query" >
					<aos:gridpanel id="risk_grid" url="projOverviewService.riskPage" forceFit="false">
						<aos:column type="rowno" />
						<aos:column header="风险名称" dataIndex="risk_name" width="200"/>
						<aos:column header="风险描述" dataIndex="risk_cata_name" width="250"/>
						<aos:column header="发生概率%" dataIndex="happ_probability" width="100" align="center"/>
						<aos:column header="影响程度" dataIndex="influe_degree" align="center" width="100"/>
						<aos:column header="风险等级" dataIndex="risk_level" align="center" width="100"/>
						<aos:column header="风险响应计划" dataIndex="risk_resp_plan" width="250"/>
						<aos:column header="是否开放" dataIndex="open_close" align="center" width="100" rendererField="open_close"/>
						<aos:column header="责任人" dataIndex="risk_owner" align="center" width="100"/>
					</aos:gridpanel>
				</aos:tab>
				<aos:tab title="过程文档" onshow="file_grid_query">
					<aos:gridpanel id="file_grid" url="projOverviewService.filePage" >
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem text="下载" icon="down.png"  onclick="g_acount_down" />
							<aos:dockeditem text="批量打包下载" icon="zipdown.png"  onclick="g_zip_down" />
						</aos:docked>
						<aos:menu>
							<aos:menuitem text="下载" onclick="g_acount_down" icon="down.png" />
						</aos:menu>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" />
						<aos:column header="文件id" dataIndex="file_id" hidden="true"/>
						<aos:column header="文件路径" dataIndex="file_path" hidden="true"/>
						<aos:column header="过程名称" dataIndex="process_name" width="150"/>
						<aos:column header="文件类型名称" dataIndex="proc_filetype_name" width="150"/>
						<aos:column header="文件名称" dataIndex="file_title" width="200"/>
						<aos:column header="创建人" dataIndex="create_user_name" align="center" width="100"/>
						<aos:column header="文件备注" dataIndex="file_remark" align="center" width="100"/>
						<aos:column header="状态" dataIndex="state" align="center" width="100" hidden="true"/>
					</aos:gridpanel>
				</aos:tab>
			</aos:tabpanel>
		</aos:window>
		<script type="text/javascript">
			//按钮列转换
			function fn_button_render(value, metaData, record) {
				return '<input type="button" value="详情" class="cbtn" onclick="w_account_show();" />';
			}
			 //当前周期/计划周期渲染
			function fn_period(value, metaData, record){
				var begin_date = record.raw.M_BEGIN_DATE;
				var end_date = record.raw.END_DATE;
		     	var begin_time =  new Date(begin_date).getTime();
		     	var end_time =  new Date(end_date).getTime();
		     	var date = new Date().getTime();
		     	console.log(begin_time +"=="+ end_time);
		     	return Math.ceil((date-begin_time)/(1000*3600*24*7))
		     		+"/"+
		     		 Math.ceil((end_time-begin_time)/(1000*3600*24*7));
			} 
			//团队人员状态渲染
			function fn_team_state(value, metaData, record){
				if(value == 1)
					return 	"<span style='color:green; font-weight:bold'>正常</span>";
				else if(value == 0)
					return  "<span style='color:red; font-weight:bold'>已退出</span>";
			}
			//项目状态渲染
			function fn_proj_state(value, metaData, record){
				if(value == 1){
					return "<span style='color:green; font-weight:bold'>已启用</span>"; 
				}else if(value == 0){
					return "<span style='color:blue; font-weight:bold'>未启用</span>"; 
				}else if(value == -1){
					return "<span style='color:red; font-weight:bold'>已作废</span>"; 
				}else if(value == 2){
					return "<span style='color:green; font-weight:bold'>已验收</span>"; 
				}
			}
			 //查询 项目总览列表/分页
	        function proj_grid_query() {
	            proj_grid_store.loadPage(1);
	        }
	        
	        //查询按钮
	        function form_grid_query(){
	        	var params = AOS.getValue('query_form');
	        	console.log(params);
	            proj_grid_store.getProxy().extraParams = params;
	        	proj_grid_store.loadPage(1);
	        }
	        //查询 项目回款列表/分页
	        function money_grid_query(){
	        	var record = AOS.select(proj_grid, true)[0];
	        	var params = new Object();
	        	params.proj_id = record.data.PROJ_ID;
	        	money_grid_store.getProxy().extraParams = params;
	        	money_grid_store.loadPage(1);
	        }
	        //查询 合同信息列表/分页
	        function contract_grid_query(){
	        	var record = AOS.select(proj_grid, true)[0];
	        	var params = new Object();
	        	params.proj_id = record.data.PROJ_ID;
	        	contract_grid_store.getProxy().extraParams = params;
	        	contract_grid_store.loadPage(1);
	        }
	        
	        //查询 项目风险信息/分页
	        function risk_grid_query(){
	        	var record = AOS.select(proj_grid,true)[0];
	        	var params = new Object();
	        	params.proj_id = record.data.PROJ_ID;
	        	risk_grid_store.getProxy().extraParams = params;
	        	risk_grid_store.loadPage(1);
	        }
	        //查询 项目过程文件/分页
	        function file_grid_query(){
	        	var record = AOS.select(proj_grid,true)[0];
	        	var params = new Object();
	        	params.proj_id = record.data.PROJ_ID;
	        	file_grid_store.getProxy().extraParams = params;
	        	file_grid_store.loadPage(1);
	        }
	        //查询 项目团队/分页
	        function team_grid_query(){
	        	var record = AOS.select(proj_grid,true)[0];
	        	var params = new Object();
	        	params.proj_id = record.data.PROJ_ID;
	        	team_grid_store.getProxy().extraParams = params;
	        	team_grid_store.loadPage(1);
	        }
	        
	        //下载
			function g_acount_down(){
				var selection = AOS.selection(file_grid, 'file_id');
				if(AOS.empty(selection)){
					AOS.tip('请选择需要下载的文件!');
					return;
				}
				var rows = AOS.rows(file_grid);
				if(rows > 1){
					AOS.tip('请只选择一条需要下载的文件!');
				return;
				}
				var file_path = AOS.selection(file_grid, 'file_path');
				var file_title = AOS.selection(file_grid, 'file_title');
				var file_id = AOS.selection(file_grid, 'file_id');
				if(AOS.empty(selection)){
					AOS.tip('请选择要下载的文件!');
					return;
				}
				console.log(file_path+"  "+file_title+"  "+file_id)
				AOS.file('do.jhtml?router=processFileUploadService.downloadFile&juid=${juid}&file_path='+file_path+'&file_title='+file_title+'&file_id='+file_id);
			}
			
			//批量压缩下载
			function g_zip_down(){
				var record = AOS.select(proj_grid,true)[0];
	        	var proj_name = record.data.PROJ_NAME;
				var selection = AOS.selection(file_grid, 'file_id');
				if(AOS.empty(selection)){
					AOS.tip('请选择需要批量打包下载的文件!');
					return;
				}
				
				var rows = AOS.rows(file_grid);
				var msg =  AOS.merge('确认要批量打包下载选中的{0}条数据吗？', rows);
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						return;
					}
					AOS.file('do.jhtml?router=processFileUploadService.downloadFileByZip&juid=${juid}&proj_name='+proj_name+'&aos_rows='+selection);
				});
				
			}
			//导出excel
			function fn_export_excel(){
				var selection = AOS.selection(example_grid,'standard_id');
				if(selection.length == 0){
					AOS.tip("导出前请选择数据。");
					return;
				}
				AOS.file('do.jhtml?router=testExampleService.exportExcel&juid=${juid}&selection='+selection);
			}
			
		</script>
	</aos:viewport>
</aos:onready>
<script type="text/javascript">
	  //项目详情显示窗口
       function w_account_show(){
       		AOS.get("proj_particulars").show();
       		AOS.get("risk_info").show();
       		AOS.get("proj_teams").show();
       }
      
</script>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="java.util.Date" %> 
<aos:html title="增删改查" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
	
   <aos:tabpanel  region="center"  id="id_tabpanel" bodyBorder="0 0 0 0" >
	<aos:tab id="t_weekly" title="周报列表" layout="border"    autoScroll="true">
		<aos:panel region="north">
		<aos:formpanel id="f_query_week"  height="70" labelWidth="80"    header="false" region="north" border="false" anchor= "100% " >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:datefield  name="begin_date" fieldLabel="开始时间" onchange="changeweekBdt"   columnWidth="0.17"  editable="false" />
			<aos:datefield name="end_date" fieldLabel="结束时间"  onchange="changeweekBdt"  columnWidth="0.17"  editable="false" />
		    <aos:dockeditem xtype="button" text="查询" onclick="g_week_query" icon="query.png" columnWidth="0.07" margin="0 0 10 10"/>
		    <aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(f_query_week);" icon="refresh.png" columnWidth="0.07"  margin="0 0 10 10"/>
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
		</aos:panel >
		<aos:gridpanel id="g_account_week" url="weeklyService.page"  onrender="g__week_query" onitemdblclick="action_tab_db"  region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="周报列表" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增" icon="add.png" onclick="f_week_save" />
				<aos:dockeditem text="删除" icon="del.png" onclick="g_week_del" />
				<aos:dockeditem text="导出" icon="icon70.png" onclick="fn_export_excel" />
				<aos:dockeditem text="提交" onclick="fn_commit"   icon="edit.png" />
				<aos:dockeditem text="打印" onclick="fn_commit_print"   icon="edit.png" />
			</aos:docked>
			<aos:menu>
	        	<aos:menuitem text="新增" icon="add.png" onclick="f_week_save" />
				<aos:menuitem text="删除" icon="del.png" onclick="g_week_del" />
				<aos:menuitem xtype="menuseparator" />
	            <aos:menuitem text="提交" onclick="fn_commit"   icon="edit.png" />
				<aos:menuitem text="导出" icon="icon70.png" onclick="fn_export_excel" />
           </aos:menu>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<!-- 隐藏的内容 -->
		    <aos:column header="周报ID" dataIndex="weekly_id"   hidden="true" />
		    <!-- 显示内容 -->
		    <aos:column header="周报编码" dataIndex="test_code"   hidden="true"  />
			<aos:column header="开始时间" dataIndex="begin_date"     type="date" format="Y-m-d" fixedWidth="100" align="center"/>
			<aos:column header="结束时间" dataIndex="end_date" fixedWidth="100" type="date" format="Y-m-d"  align="center"/>
			<aos:column header="提交状态" dataIndex="flag" rendererFn="fn_balance_flag"  fixedWidth="100" align="center"/>
			<aos:column header="创建人" dataIndex="add_name" fixedWidth="100" align="center"/>
			<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150"  align="center"/>
			<aos:column header="备注" dataIndex="remarks"    align="center" hidden="true"  />
		</aos:gridpanel>
    </aos:tab>
	<aos:tab id="t_weekly_detai" title="周报明细" layout="border"  disabled="true" >
		<aos:panel region="north">
		<aos:formpanel id="f_query_d"     msgTarget="qtip" labelWidth="70"  header="false" region="north" border="false"  >
			<aos:docked forceBoder="0 0 1 0"  >
				<aos:dockeditem xtype="tbtext" text="明细概要" />
				<aos:dockeditem xtype="tbseparator" />
		        <aos:dockeditem id="dis_save"  xtype="button" text="保存" onclick="saveDate" icon="ok.png" columnWidth="0.07"  margin="0 0 10 10"/>
		        <aos:dockeditem xtype="button" text="作废" onclick="delWeekly" icon="del.png" columnWidth="0.07"  margin="0 0 10 10"/>
		        <aos:dockeditem text="导出" icon="icon70.png" onclick="fn_export_excel_detail" margin="0 0 10 10" />
		</aos:docked>
			<aos:datefield    name="begin_date"   fieldLabel="开始时间"   onchange="changeBdt"  columnWidth="0.18"  editable="false" />
			<aos:datefield  
			name="end_date" fieldLabel="结束时间"  columnWidth="0.18" onchange="changeDt"   editable="false" />
			
		   
		  <aos:textareafield  height="60" name="remarks" fieldLabel="备注" maxLength="800"  columnWidth="0.99" />
			<aos:hiddenfield  name="test_code" />
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
		</aos:panel >
		<aos:gridpanel id="g_account" url="weeklyDetailService.page"      forceFit="false"     onitemdblclick="#w_account_backend.show()"  region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="周报明细" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem id="dis_add"  xtype="button" text="新增" onclick="#w_account.show()" icon="add.png" columnWidth="0.07" margin="0 0 10 10"/>
				<aos:dockeditem id="dis_addall" text="生成数据" icon="add.png" onclick="f_account_save" />
				<aos:dockeditem id="dis_update" text="修改" icon="edit.png" onclick="w_account_backend_show" />
				<aos:dockeditem id="dis_delete" text="删除" icon="del.png" onclick="g_acount_del" />
			</aos:docked>
			<aos:menu>
	        <aos:menuitem id="dis_backend_update" text="修改" onclick="w_account_backend_show" icon="add.png" />
	        <aos:menuitem xtype="menuseparator" />
	        <aos:menuitem id="dis_backend_delete" text="删除" onclick="g_acount_del"   icon="edit.png" />
           </aos:menu>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<!-- 隐藏的内容 -->
		    <aos:column header="周报ID" dataIndex="test_id"   hidden="true" />
		    <aos:column header="周报编码" dataIndex="test_code"  hidden="true"/>
		    <aos:column header="记录时间" dataIndex="add_time"  hidden="true"/>
		    <aos:column header="记录人" dataIndex="add_name"  hidden="true"/>
		    <!-- 显示内容 -->
		    <aos:column header="项目ID" dataIndex="proj_id"  width="280" hidden="true" />
		    <aos:column header="项目名称" dataIndex="proj_name"  width="120" />
			<aos:column header="缺陷总数" dataIndex="bug_input_num" width="80" align="right"  />
			<aos:column header="关闭数" dataIndex="bug_close_num" width="70" type="combobox" align="right" />
			<aos:column header="已解决数" dataIndex="bug_finish_num" width="75" align="right" >
			</aos:column>
			<aos:column header="未解决数" dataIndex="bug_unfinish_num" width="75" align="right" >
			</aos:column>
			<aos:column header="周新增" dataIndex="bug_add_num" width="70" align="right"  >
			</aos:column>
			<aos:column header="周关闭" dataIndex="lately_close_num" width="70" align="right" />
			<aos:column header="工作内容" dataIndex="job_content" width="300"  >
		    </aos:column>
		     <aos:column header="负责人" dataIndex="charge"  width="80" align="center" >
	        </aos:column>
			<aos:column header="周任务数" dataIndex="input_cond" width="75"  align="right">
			</aos:column>
			<aos:column header="任务接收情况" dataIndex="accept_cond" width="100" >
			</aos:column>
			<aos:column header="任务进度比例调整" dataIndex="finish_cond" width="500" />
			<aos:column header="问题描述" dataIndex="trouble_bewrite"  width="500"  >
			</aos:column>
			<aos:column header="建议" dataIndex="trouble_advise"   width="500" >
			</aos:column>
			<aos:column header="活动内容" dataIndex="job_plan" width="280"  hidden="true" >
			</aos:column>
	       
	        <aos:column header="备注" dataIndex="remarks"   width="500"  >
	        </aos:column>
		</aos:gridpanel>
		<%-- 新增窗口 --%>
		<aos:window id="w_account" title="新增信息"  width="900" height="500" layout="anchor" autoScroll="true" draggable="false"   >
			
			<aos:formpanel id="f_account" anchor="100%" msgTarget="qtip"  layout="anchor" >
				 <!--  隐藏内容 -->
				<aos:hiddenfield name="test_id" fieldLabel="周报ID" />
				<aos:hiddenfield name="test_code" fieldLabel="周报编码" />
				<aos:fieldset title="基础信息" labelWidth="85" columnWidth="1">
				<aos:hiddenfield name="proj_id" />
				 <aos:triggerfield fieldLabel="选择项目" name="proj_name" editable="false"  allowBlank="false"   margin="5" trigger1Cls="x-form-search-trigger" onTrigger1Click="w_account_find_show" columnWidth="1" />
					
				<aos:numberfield name="bug_add_num" fieldLabel="本周新增数"     margin="5" columnWidth="0.25"  allowDecimals="false"  minValue="0"  maxValue="100000"  />
				<aos:numberfield name="lately_close_num" fieldLabel="本周关闭数" columnWidth="0.25" margin="5"  allowDecimals="false"  minValue="0"  maxValue="100000"/>
				<aos:numberfield name="bug_input_num" fieldLabel="缺陷总数"  columnWidth="0.25" margin="5" minValue="0" maxValue="100000"   allowDecimals="false" />
				<aos:numberfield name="bug_close_num" fieldLabel="关闭数" columnWidth="0.25" margin="5" minValue="0" maxValue="100000"   allowDecimals="false" />
				<aos:numberfield name="bug_finish_num" fieldLabel="已解决数" columnWidth="0.25" margin="5" minValue="0" maxValue="100000"  allowDecimals="false" />
				<aos:numberfield name="bug_unfinish_num" fieldLabel="未解决数" columnWidth="0.25" margin="5" minValue="0"   maxValue="100000"  allowDecimals="false" />
				
				<aos:textfield name="charge" fieldLabel="负责人" allowBlank="true" maxLength="11"    columnWidth="0.25" margin="5"/>
				<aos:fieldset title="工作内容" labelWidth="85" columnWidth="1" >
				<aos:htmleditor name="job_content" columnWidth="1"  margin="5" allowBlank="false"   />
				</aos:fieldset>
				</aos:fieldset>
				<aos:fieldset title="工作任务检查" labelWidth="85" columnWidth="1">
				<aos:textfield name="accept_cond" fieldLabel="任务接受情况" allowBlank="true" maxLength="255"   columnWidth="0.69" margin="10"/>
				<aos:numberfield name="input_cond" fieldLabel="本周任务数" allowBlank="true" columnWidth="0.25" minValue="0"  maxValue="100000"  margin="10"  allowDecimals="false" />
			     <aos:fieldset title="任务进度比例调整" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="finish_cond" columnWidth="1"  margin="10"   />
				</aos:fieldset>
		    	</aos:fieldset>
				 <aos:fieldset title="问题描述" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="trouble_bewrite" columnWidth="1"  margin="10"   />
				</aos:fieldset>
				 <aos:fieldset title="建议" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="trouble_advise" columnWidth="1"  margin="10"   />
				</aos:fieldset>
				<aos:fieldset title="备注" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="remarks" columnWidth="1"  margin="10"   />
				</aos:fieldset>
		      </aos:formpanel>
		
			 <aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="addDate" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#w_account.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<%-- 选择项目 --%>
		<aos:window id="w_account_find" title="项目[双击选择]" height="-200" width="800" layout="fit" onshow="g_account_query">
			<aos:gridpanel id="g_accountc" url="weeklyDetailService.getProjt" onrender="g_account_query" onitemdblclick="g_account_dbclick">
				<aos:docked forceBoder="0 0 1 0">
					<aos:triggerfield emptyText="项目名称" id="proj_name" onenterkey="g_account_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="g_account_query" width="250" />
				</aos:docked>
				<aos:column type="rowno" />
				<aos:column header="项目ID" dataIndex="proj_id" width="90"  hidden="true"/>
				<aos:column header="项目编码" dataIndex="proj_code"  width="60" />
				<aos:column header="项目名称" dataIndex="proj_name" width="280" />
			</aos:gridpanel>
		</aos:window>
		<%-- 修改窗口 --%>
		<aos:window id="w_account_backend" title="修改信息"  width="900"
					height="500"
					layout="anchor" 
					autoScroll="true"
					draggable="false"  onshow="w_account_backend_onshow" >
			<aos:formpanel id="f_account_backend" anchor="100%"   layout="anchor" msgTarget="qtip"   >
				 <!--  隐藏内容 -->
				<aos:hiddenfield name="test_id" fieldLabel="周报ID" />
				<aos:hiddenfield name="test_code" fieldLabel="周报编码" />
				<aos:fieldset title="基础信息" labelWidth="85" columnWidth="1">
				<aos:hiddenfield fieldLabel="缓存行信息"  name="rowindex" /> 
				<aos:textfield  fieldLabel="项目名称" name="proj_name"   columnWidth="1"   margin="5"  readOnly="true"  />
				
				<aos:numberfield name="bug_add_num" fieldLabel="本周新增数"  margin="5" readOnly="true" columnWidth="0.25"  minValue="0"   maxValue="100000" allowDecimals="false" />
				<aos:numberfield name="lately_close_num" fieldLabel="本周关闭数" readOnly="true" columnWidth="0.25" margin="5" minValue="0" maxValue="100000" allowDecimals="false"/>
				<aos:numberfield name="bug_input_num" fieldLabel="缺陷总数"  readOnly="true" columnWidth="0.25" margin="5" minValue="0" maxValue="100000" allowDecimals="false"/>
				<aos:numberfield name="bug_close_num" fieldLabel="关闭数"  readOnly="true" columnWidth="0.25" margin="5" minValue="0" maxValue="100000" allowDecimals="false" />
				<aos:numberfield name="bug_finish_num" fieldLabel="已解决数" readOnly="true" columnWidth="0.25" margin="5" minValue="0" maxValue="100000" allowDecimals="false"/>
				<aos:numberfield name="bug_unfinish_num" fieldLabel="未解决数" readOnly="true" columnWidth="0.25" margin="5" minValue="0" maxValue="100000" allowDecimals="false"/>
				
				<aos:textfield name="charge" fieldLabel="负责人" allowBlank="true" maxLength="11" columnWidth="0.25" margin="5"/>
				<aos:fieldset title="工作内容" labelWidth="85" columnWidth="1"   >
				<aos:htmleditor name="job_content" columnWidth="1"  margin="5"  allowBlank="false" msgTarget="qtip"  />
				</aos:fieldset>
				</aos:fieldset>
				<aos:fieldset title="工作任务检查" labelWidth="85" columnWidth="1">
				<aos:textfield name="accept_cond" fieldLabel="任务接受情况" allowBlank="true"  maxLength="255"  columnWidth="0.69" margin="10" />
				<aos:numberfield name="input_cond" fieldLabel="本周任务数" allowBlank="true" readOnly="true" maxValue="100000" minValue="0" allowDecimals="false" columnWidth="0.25" margin="10" />
				 <aos:fieldset title="任务进度比例调整" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="finish_cond" columnWidth="1"  margin="10"   />
				</aos:fieldset>
				</aos:fieldset>
				 <aos:fieldset title="问题描述" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="trouble_bewrite" columnWidth="1"  margin="10"   />
				</aos:fieldset>
				 <aos:fieldset title="建议" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="trouble_advise" columnWidth="1"  margin="10"   />
				</aos:fieldset>
				<aos:fieldset title="备注" labelWidth="85" columnWidth="1">
				<aos:htmleditor name="remarks" columnWidth="1"  margin="10"   />
				</aos:fieldset>
		      </aos:formpanel>
		
			 <aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="updateBackend" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#w_account_backend.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		</aos:tab>
		
	</aos:tabpanel>
	</aos:viewport>

	<script type="text/javascript">
	//打印
	function fn_commit_print(){
		var row=AOS.rows(g_account_week);
		if(row!=1){
			AOS.tip("请选择需要打印的数据!");
			return;
		}
		var select=AOS.selectone(g_account_week,true);
		url='do.jhtml?router=weeklyService.listDetailReprot&juid=${juid}&test_code='+select.data.test_code;
		AOS.baseReport(url);
	}
	//弹出选择项目窗口
	function w_account_find_show() {
		w_account_find.show();
	}
	//账户表格双击事件
	function g_account_dbclick(obj, record) {
		AOS.setValue('f_account.proj_id',record.raw.proj_id);
		AOS.setValue('f_account.proj_name',record.raw.proj_name);
		w_account_find.hide();
	}
	//加载表格数据
	function g_account_query() {
		var params = {
				proj_name : proj_name.getValue()
		};
		g_accountc_store.getProxy().extraParams = params;
		g_accountc_store.load();
	}
	//主键状态列修改
	function fn_balance_flag(value){
		var str;
		if (value==1){
			str ="未提交"
		}else{
			str ="已提交"
		}
		return str;
	}
	//修改明细数据
	function updateBackend(){
		if(AOS.valid(f_account_backend)==false){
			return;
		}
		if(AOS.empty(AOS.getValue('f_account_backend.job_content' ))){
			AOS.tip('工作内容不能为空!');
			return;
		}
		
		var record =AOS.selectone(g_account,true);
		var records=record.data.test_id;
	if(AOS.empty(records)){
		var dataindex=g_account.getStore().indexOf( g_account.getSelectionModel().getSelection()[0] );
		if(dataindex!=null){
			var values = f_account_backend.getValues();
			g_account.store.getAt(dataindex).set(values);
			AOS.tip('数据修改成功!');
			w_account_backend.hide();
		  }
	}
	
	else{
		AOS.ajax({
			forms : f_account_backend,
			url : 'weeklyDetailService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				g_account_store.reload();
				w_account_backend.hide();
			 }
	       });
		}
	}
	//主表开始时间判断
	function changeweekBdt(){
		  var begin_date=AOS.getValue('f_query_week.begin_date');
		  var end_date=AOS.getValue('f_query_week.end_date');
		  if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			  AOS.setValue('f_query_week.begin_date',null);
    		  AOS.tip("结束时间不能小于开始时间,请重新选择!");
    		  return;
		}
	}

	
	
	//监听开始时间不能大于结束时间
	  function changeBdt(){
		  var begin_date=AOS.getValue('f_query_d.begin_date');
		  var end_date=AOS.getValue('f_query_d.end_date');
		  if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			  AOS.setValue('f_query_d.begin_date',null);
    		  AOS.tip("结束时间不能小于开始时间,请重新选择!");
    		  return;
		 }
	}
	 //监听获取开始时间
    function   changeDt(){
		var end_date=AOS.getValue('f_query_d.end_date');
    	AOS.ajax({
			params:{
				end_date : end_date
			},
			url : 'weeklyDetailService.changeDate',
			ok : function(data) {
				 AOS.setValue('f_query_d.begin_date',data.getDate);
			}
         });
    }
	
	//生成数据
	function f_account_save(){
		var  begin_date=  AOS.getValue('f_query_d.begin_date');
		var  end_date=  AOS.getValue('f_query_d.end_date');
		var  test_code= AOS.getValue('f_query_d.test_code');
		var  remarks= AOS.getValue('f_query_d.remarks');
		if(!AOS.empty(remarks)){
		AOS.confirm('此操作会清空备注里面原有的数据。', function(btn){
			if(btn === 'cancel'){
				return;
			}else{
				AOS.ajax({
					url : 'weeklyDetailService.createData',
					params : {
						test_code :test_code,
						begin_date:begin_date,
						end_date :end_date
					},
					ok : function(data){
						Ext.each(data,function(item){
							if(item.test_code != null){
								alert(item.jobsubStr);
								g_account_store.insert(0,{
									bug_close_num:item.close_num,
										bug_input_num:item.input_num,
										bug_add_num:item.lately_add,
										bug_unfinish_num:item.unfinish_num,
										proj_id:item.proj_id, 
										proj_name:item.proj_name,
										add_name:item.add_name, 
										test_code:item.test_code, 
										detail:item.detail,
										bug_finish_num:item.finish_num, 
										add_time:item.add_time, 
										lately_close_num:item.lately_close,
										input_cond:item.task_num,
										job_content:item.jobsubStr
								});
								 AOS.setValue('f_query_d.remarks',item.getFilesTheme);
							}
						});
						  AOS.tip('数据生成成功');
						 
					}
		   });
				
			}
		  });
		}else
			{
			AOS.ajax({
				url : 'weeklyDetailService.createData',
				params : {
					test_code :test_code,
					begin_date:begin_date,
					end_date :end_date
				},
				ok : function(data){
					Ext.each(data,function(item){
						if(item.test_code != null){
							g_account_store.insert(0,{
								bug_close_num:item.close_num,
									bug_input_num:item.input_num,
									bug_add_num:item.lately_add,
									bug_unfinish_num:item.unfinish_num,
									proj_id:item.proj_id, 
									proj_name:item.proj_name,
									add_name:item.add_name, 
									test_code:item.test_code, 
									detail:item.detail,
									bug_finish_num:item.finish_num, 
									add_time:item.add_time, 
									lately_close_num:item.lately_close,
									input_cond:item.task_num,
									job_content:item.jobsubStr
							});
							 AOS.setValue('f_query_d.remarks',item.getFilesTheme);
						}
					});
					  AOS.tip('数据生成成功');
					 
				}
	   });
			
			}
		
	}
	//新增一行
	function addDate(){
		if(AOS.valid(f_account)==false){
			return;
		}
		if(AOS.empty(AOS.getValue('f_account.job_content' ))){
			AOS.tip('工作内容不能为空!');
			return;
		}
		g_account_store.insert(0,f_account.getValues());
		AOS.reset(f_account);
		w_account.hide();
	}
	//保存数据
	function saveDate() {
		var  begin_date=  AOS.getValue('f_query_d.begin_date');
		var  end_date=  AOS.getValue('f_query_d.end_date');
		var  remarks=  AOS.getValue('f_query_d.remarks');
		var  test_code=  AOS.getValue('f_query_d.test_code');
		AOS.ajax({
			params : {
				aos_rows : AOS.mrs(g_account),
				begin_date:begin_date,
				end_date :end_date,
				remarks_w : remarks,
				test_code :test_code
			},
			url : 'weeklyDetailService.saveData',
			ok : function(data) {
				if(data.errStr==1){
					AOS.warn('时间选择有误！','提示');
				    return;
		       }else{
			     AOS.tip('数据保存成功');
			 	g_account_store.reload();
				g_account_week_store.reload();
		      }
			}
		});
	}
    //监听明细修改窗口
    function w_account_backend_onshow(){
    	var record = AOS.selectone(g_account,true);
    	console.log(record);
    	var rows = AOS.rows(g_account);
    	if(rows!=1){
    		AOS.tip('请选择一条需要修改的数据!');
    		w_account_backend.hide();
    		return;
    	}else{
    		if (!AOS.empty(record.data.test_id)){
    			if (AOS.mrows(g_account) > 0){
    				AOS.confirm('存在未保存数据，如果修改，未保存的数据将全部消失!', function(btn){
    					if(btn === 'cancel'){
    						w_account_backend.hide();
    						return;
    					}else{
    						f_account_backend.loadRecord(record);
    					}
    				  });
    			}
    		}   
   			 	  f_account_backend.loadRecord(record);
    	}
    }
    
	//监听主表修改窗口弹出
	function w_account_week_onshow(){
		//这里演示的是直接从表格行中加载数据，也可以发一个ajax请求查询数据(见misc1.jsp有相关用法)
		var record = AOS.selectone(g_account_week, true);
		if(AOS.empty(record)){
			w_account_week.hide();
			AOS.tip('请选择一条需要修改的数据!');
		}else{
		f_account_week.loadRecord(record);
		}
	}
	

	//加载表格数据
	function g__week_query() {
		AOS.setValue('f_query_week.end_date',new Date());
		var end_date=AOS.getValue('f_query_week.end_date');
		var begin_date=AOS.getValue('f_query_week.begin_date');
    	AOS.ajax({
			params:{
				end_date : end_date,
				begin_date : begin_date
			},
			url : 'weeklyDetailService.changeweekDate',
			ok : function(data) {
				 AOS.setValue('f_query_week.begin_date',data.getDate);
				 var params = AOS.getValue('f_query_week');
				 g_account_week_store.getProxy().extraParams = params;
				 g_account_week_store.loadPage(1);
			}
         });
	
	}
	//周报查询按钮
	function g_week_query() {
		var params = AOS.getValue('f_query_week');
		g_account_week_store.getProxy().extraParams = params;
		g_account_week_store.loadPage(1);
	}
	
	//跳转明细tab
	function f_week_save(){
		AOS.reset(f_query_d);
		 t_weekly_detai.enable();
		AOS.enableCmps('dis_add'); 
		AOS.enableCmps('dis_addall'); 
	    AOS.enableCmps('dis_update'); 
		AOS.enableCmps('dis_delete'); 
		AOS.enableCmps('dis_save'); 
		AOS.enableCmps('dis_backend_update');
		AOS.enableCmps('dis_backend_delete');
		AOS.ajax({
			url : 'weeklyDetailService.actionTab',
			ok : function(data) {
				 AOS.setValue('f_query_d.end_date',data.getendDate);
				AOS.setValue('f_query_d.test_code',data.test_code);
				var params = AOS.getValue('f_query_d');
				g_account_store.getProxy().extraParams = params;
				g_account_store.reload(1);
				//跳转
				id_tabpanel.setActiveTab(1);
			}
		});
	}
	//列表双击跳转
	function  action_tab_db(me, record){
		   var test_code =record.data.test_code;
		   t_weekly_detai.enable();
		   var end_date  =  record.data.end_date;
		   var remarks  =  record.data.remarks;
		   var flag  =  record.data.flag;
		  AOS.ajax({
				params:{
					test_code:test_code,
					end_date:end_date,
					remarks:remarks,
					flag:flag
				},
				url : 'weeklyDetailService.actionTabDb',
				ok : function(data) {
					AOS.setValue('f_query_d.test_code',data.test_code);
					AOS.setValue('f_query_d.remarks',data.remarks);
					//如果主表对应的数据未提交，禁用明细的相关操作
					if(data.flag==2){
					    AOS.disableCmps('dis_add');
						AOS.disableCmps('dis_addall');
						AOS.disableCmps('dis_update');
						AOS.disableCmps('dis_delete');
						AOS.disableCmps('dis_save');
						AOS.disableCmps('dis_backend_update');
						AOS.disableCmps('dis_backend_delete');
						
					 }else
					{      
						 AOS.enableCmps('dis_add'); 
						 AOS.enableCmps('dis_addall'); 
						 AOS.enableCmps('dis_update'); 
						 AOS.enableCmps('dis_delete'); 
						 AOS.enableCmps('dis_save'); 
						AOS.enableCmps('dis_backend_update');
						AOS.enableCmps('dis_backend_delete');
					}
					var params = AOS.getValue('f_query_d');
					g_account_store.getProxy().extraParams = params;
					g_account_store.reload(1);
					id_tabpanel.setActiveTab(1);
					AOS.setValue('f_query_d.end_date',data.end_date);
				}
	   });
	}
	//作废
	function delWeekly(){
		var test_code=AOS.getValue('f_query_d.test_code');
		var msg =  AOS.merge('确认要作废吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
		AOS.ajax({
			params:{
				test_code:test_code
				},
				url:'weeklyDetailService.delWeekly',
				ok: function(data){
					g_account_store.reload();
					g_account_week_store.reload();
					AOS.reset(f_query_d);
					AOS.tip(data.appmsg);
				}
			
		});
		});
	}
	
	
	//更新周报主表
	function f_account_week_update(){
				AOS.ajax({
					forms : f_account_week,
					url : 'weeklyService.update',
					ok : function(data) {
						AOS.tip(data.appmsg);
						g_account_week_store.reload();
						w_account_week.hide();
					}
			});
	 }
	//导出明细excel
	function fn_export_excel_detail(){
		//juid需要再这个页面的初始化方法中赋值,这里才引用得到
		var text_code=AOS.getValue('f_query_d.test_code');
		AOS.file('do.jhtml?router=weeklyDetailService.exportWeeklyExcel_d&juid=${juid}&test_code='+text_code);
	}
	//导出excel
	function fn_export_excel(){
		var row=AOS.rows(g_account_week);
		if(row<1){
			AOS.tip("请选择需要导出的数据!");
			return;
		}
		//juid需要再这个页面的初始化方法中赋值,这里才引用得到
		var select=AOS.selection(g_account_week,'weekly_id');
		AOS.file('do.jhtml?router=weeklyDetailService.exportWeeklyExcel&juid=${juid}&weeklyId='+select);
	}
    //删除账户信息
 	function g_acount_del(){
			var selection = AOS.selection(g_account, 'test_id');
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			var rows=AOS.rows(g_account);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗?', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
			
			if (AOS.mrows(g_account) > 0){
				AOS.confirm('存在未保存数据，如果删除，未保存的数据将全部消失!', function(btn){
					if(btn === 'cancel'){
						return;
					}else{
						AOS.ajax({
							url : 'weeklyDetailService.alldelete',
							params:{
								aos_rows: selection
							},
							ok : function(data) {
								AOS.tip(data.appmsg);
								g_account_store.reload();
							}
						});
					  }
				   })
			}else{
				AOS.ajax({
					url : 'weeklyDetailService.alldelete',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						g_account_store.reload();
					}
				});
			 }
			});
		}
    
 	//提交状态
	function fn_commit(){
		var selection = AOS.selection(g_account_week, 'weekly_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要提交的数据。');
			return;
		}
		var rows = AOS.rows(g_account_week);
		var msg =  AOS.merge('确认要提交选中的{0}条数据吗?', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'weeklyDetailService.state_commit',
				params:{
					aos_rows:selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					g_account_week_store.reload();
				}
			  });
		});
 	}
    //明细删除账户信息
 	function g_week_del(){
			var selection = AOS.selection(g_account_week, 'weekly_id');
			var test_code = AOS.selection(g_account_week, 'test_code');
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			var rows = AOS.rows(g_account_week);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗?', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'weeklyService.alldelete',
					params:{
						aos_rows: selection,
						test_code:test_code
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						g_account_week_store.reload();
					}
				});
			});
		}
	</script>
	</aos:onready>
	<script type="text/javascript">
	
	//弹出修改窗口
	function w_account_backend_show(){
		AOS.get('w_account_backend').show();
		}
	//弹出主表修改窗口
	function w_account_week_show(){
		AOS.get('w_account_week').show();
	}
</script>

	

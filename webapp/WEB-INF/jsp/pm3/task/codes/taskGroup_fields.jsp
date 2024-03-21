<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<% 
	String currentDayStr=AOSUtils.getDateStr(); 
%>
<aos:hiddenfield name="group_id"/>
<aos:hiddenfield name="parent_id"/>
<aos:combobox name="proj_id" fieldLabel="项目" json="[]" readOnly="true"/>
<aos:combobox name="module_id" fieldLabel="模块" json="[]"/>
<aos:combobox name="demand_id" fieldLabel="需求" json="[]"/>
<aos:textfield name="parent_group_name" fieldLabel="上级分组" readOnly="true"/>
<aos:textfield name="group_name" fieldLabel="分组名称" allowBlank="false" maxLength="50"/>
<aos:datetimefield fieldLabel="计划开始时间" name="plan_begin_time" onchange="on_plan_time_change" format="Y-m-d H:i:s" allowBlank="false" editable="false"  />
<aos:numberfield name="plan_wastage" fieldLabel="计划天数"  allowBlank="false" step="1" decimalPrecision="0" value="1" minValue="1" maxValue="999"  />
<aos:datetimefield fieldLabel="计划结束时间" onchange="on_plan_time_change" name="plan_end_time"  format="Y-m-d H:i:s" allowBlank="false" editable="false" />
<aos:textfield name="icon_name" fieldLabel="图标" allowBlank="true" maxLength="150"/>
<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" value="1" minWidth="0" maxValue="9999" />
<aos:textareafield name="remark" fieldLabel="备注" allowBlank="true" maxLength="500"/>


<script>
	//计划天数改变事件响应
	function on_plan_time_change(field){
		var plan_begin_time=field.up("form").down("datetimefield[name=plan_begin_time]");
		var plan_end_time=field.up("form").down("datetimefield[name=plan_end_time]");
		var plan_begin_time_value=AOS.empty(plan_begin_time.getValue())? new Date():plan_begin_time.getValue();
		var plan_end_time_value=AOS.empty(plan_end_time.getValue())? new Date():plan_end_time.getValue();
		if(plan_begin_time_value >= plan_end_time_value){
			AOS.tip('计划结束时间必须大于计划开始时间！')
			plan_end_time.setValue('');
		}
		
	}
/*  function on_plan_wastage_change(field){
		var plan_begin_time=field.up("form").down("datetimefield[name=plan_begin_time]");
		var plan_end_time=field.up("form").down("datetimefield[name=plan_end_time]");
		var plan_wastage=field.up("form").down("numberfield[name=plan_wastage]");
		var plan_begin_time_value=AOS.empty(plan_begin_time.getValue())? new Date():plan_begin_time.getValue();
		var plan_wastage_value=plan_wastage.getValue();
		//上午时间算半天
		//plan_wastage 每0.5天+12小时
		if(plan_begin_time_value.getHours()<12){
			if((""+plan_wastage_value+"").indexOf(".")==-1){//全天
				var plan_end_time_value=Ext.Date.add(plan_begin_time_value, Ext.Date.DAY,plan_wastage_value-1);
				var time= " 17:30:00";
				plan_end_time.setValue(new Date(Ext.Date.format(plan_end_time_value, "Y-m-d") + time));
			}else{//半天
				var plan_wastage_value=(parseInt(plan_wastage_value));
				var plan_end_time_value=Ext.Date.add(plan_begin_time_value, Ext.Date.DAY,plan_wastage_value);
				var time= " 12:00:00";
				plan_end_time.setValue(new Date(Ext.Date.format(plan_end_time_value, "Y-m-d") + time));
			}
		}else{
			//下午时间计算	
			if((""+plan_wastage_value+"").indexOf(".")==-1){//全天
				var plan_end_time_value=Ext.Date.add(plan_begin_time_value, Ext.Date.DAY,plan_wastage_value);
				var time= " 12:00:00";
				plan_end_time.setValue(new Date(Ext.Date.format(plan_end_time_value, "Y-m-d") + time));
			}else{//半天
				var plan_wastage_value=(parseInt(plan_wastage_value));
				var plan_end_time_value=Ext.Date.add(plan_begin_time_value, Ext.Date.DAY,plan_wastage_value);
				var time= " 17:30:00";
				plan_end_time.setValue(new Date(Ext.Date.format(plan_end_time_value, "Y-m-d") + time));
			}
		}
	}  */
	
</script>

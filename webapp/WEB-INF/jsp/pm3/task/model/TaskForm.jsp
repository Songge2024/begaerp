<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">
	/**
	 * 任务表格对象
	 */
	Ext.define("TaskForm", {
		mixins : {
			observable : 'Ext.util.Observable'
		},
		constructor : function(config) {
			this.mixins.observable.constructor.call(this, config);
			var me = this;
			this.addEvents({
				"reload" : true,
				"publish":true,
				"afterreload":true
			});
		},
		api:{
			get:"taskService.get",//获得任务
			save:"taskService.update",//修改任务
		},
		form:null,
		model:"add",//表单类型 add||update
		//所有加入到fields中的字段都将进入条件验证
		
		//表单元素初始状态 -1:不可用,0:隐藏,1:显示不可编辑,2:显示可编辑
		fields:{
			"group_name":"1",
			"group_id":"0",
			"proj_id":"1",
			"assign_user_id":"1",
			"module_id":"2",
			"demand_id":"2",
			"task_type":"2",
			"task_level":"2",
			"plan_wastage":"2",
			//"percent":"2",
			"handler_user_id":"1",
			"task_name":"2",
			"plan_begin_time":"2",
			"plan_end_time":"1",
			"cc_user_ids":"2"
		},
		setAllFieldsReads:function(){
			var me=this;
			//过滤出隐藏/和不可用的字段
 			var disable_fields=me.getFieldsByValue("-1");	
 			var hidden_fields=me.getFieldsByValue("0");
 			var read_fields=me.getFieldsByValue("1");
 			var edit_fields=me.getFieldsByValue("2");
 			//将所有显示的字段更新为隐藏
 			read_fields=Ext.Array.merge(read_fields,edit_fields);
 			
 			
 			me.updateFieldsValue(disable_fields,"-1");
		 	me.updateFieldsValue(hidden_fields,"0");
		 	me.updateFieldsValue(read_fields,"1");
 			//me.updateFieldsValue(edit_fields,"2");
			this.updateFieldsView();
		},
		//初始化表单元素
		reset:function(current_user,data){
			var me=this;
			var state=data.state;//任务状态
			var handler_user_id=data.handler_user_id;//任务处理人
			var assign_user_id=data.assign_user_id;//指派人
			var fields=me.getFeidsKeys();
			//过滤出隐藏/和不可用的字段
 			var disable_fields=me.getFieldsByValue("-1");	
 			var hidden_fields=me.getFieldsByValue("0");
 			var read_fields=me.getFieldsByValue("1");
 			var edit_fields=me.getFieldsByValue("2");
 			if(current_user!=assign_user_id){
 				//task_desc_editor.setDisabled();
	 			//task_remark_editor.setDisabled();
	 			this.form.setReadOnly(true);
 			}
 			return ;
			 switch(state){
				//草稿状态			 
			 	case "1001":
			 		//指派人使用默认配置 其他人只读
			 		if(current_user!=assign_user_id){
			 			//将所有显示的字段更新为隐藏
			 			read_fields=Ext.Array.merge(read_fields,edit_fields);
			 			edit_fields=[];
			 		}else{
			 			Ext.Array.remove(edit_fields,"plan_begin_time");
			 			read_fields.push("plan_begin_time");
			 		}
			 		break;
			 	//发布状态	
			 	case "1002":
			 		//已发布的任务不能修改计划开始时间/任务处理人
			 		if(current_user==assign_user_id){
			 			Ext.Array.remove(edit_fields,"plan_begin_time");
			 			read_fields.push("plan_begin_time");
			 		}else if(current_user==handler_user_id){
			 			//处理人只能修改任务备注其他只读
			 			read_fields=Ext.Array.merge(read_fields,edit_fields);
			 			Ext.Array.remove(read_fields,"remark");
			 			Ext.Array.remove(edit_fields,"plan_wastage");
			 			read_fields.push("plan_wastage");
			 			edit_fields=[];
			 			edit_fields.push("remark");
			 		}else{
			 			//将所有显示的字段更新为隐藏
			 		//	read_fields=Ext.Array.merge(read_fields,edit_fields);
			 		//	edit_fields=[];
			 		}
			 		break;
		 		//接受任务
			 	case "1003":
			 		//已发布的任务不能修改计划开始时间/任务处理人
			 		if(current_user==assign_user_id){
			 			Ext.Array.remove(edit_fields,"plan_begin_time");
			 			read_fields.push("plan_begin_time");
			 		}else if(current_user==handler_user_id){
			 			//处理人只能修改任务备注其他只读
			 			read_fields=Ext.Array.merge(read_fields,edit_fields);
			 			Ext.Array.remove(read_fields,"remark");
			 			edit_fields=[];
			 			edit_fields.push("remark");
			 		}else{
			 			//将所有显示的字段更新为只读
			 			read_fields=Ext.Array.merge(read_fields,edit_fields);
			 			edit_fields=[];
			 		}
			 		break;
			 	//完成任务
			 	case "1004":
			 		//将所有显示的字段更新为只读
		 			read_fields=Ext.Array.merge(read_fields,edit_fields);
		 			edit_fields=[];
		 			break;
		 		//关闭任务
			 	case "1005":
			 		//将所有显示的字段更新为只读
		 			read_fields=Ext.Array.merge(read_fields,edit_fields);
		 			edit_fields=[];
		 			break;
		 		default:
		 			//将所有显示的字段更新为只读
		 			read_fields=Ext.Array.merge(read_fields,edit_fields);
		 			edit_fields=[];
		 			break;
			}
		 	me.updateFieldsValue(disable_fields,"-1");
		 	me.updateFieldsValue(hidden_fields,"0");
		 	me.updateFieldsValue(read_fields,"1");
 			me.updateFieldsValue(edit_fields,"2");
			this.updateFieldsView();
		},
		//更新表单元素状态
		updateFieldsView:function(){
			var disable_fields=this.getFieldsByValue("-1");	
 			var hidden_fields=this.getFieldsByValue("0");
 			var read_fields=this.getFieldsByValue("1");
 			var edit_fields=this.getFieldsByValue("2");
 			
			if(!AOS.empty(disable_fields)){
				//禁用指定元素
				AOS.disables(this.form, disable_fields.toString());
			}
			if(!AOS.empty(hidden_fields)){
				//隐藏指定元素
				AOS.hides(this.form, hidden_fields.toString());
			}
			if(!AOS.empty(read_fields)){
				//隐藏指定元素
				AOS.reads(this.form, read_fields.toString());
			}
			if(!AOS.empty(edit_fields)){
				//隐藏指定元素
				AOS.edits(this.form, edit_fields.toString());
			}
		},
		//根据指定状态获得表单元素名集合
		getFieldsByValue:function(_value){
			var fields=[];
			var me=this;
			Ext.Object.each(me.fields, function(key, value) {
				if(me.fields[key]===_value)fields.push(key);
			});
			return fields;
		},
		//更新指定表单元素名集合对应值
		updateFieldsValue(fields,value){
			var me=this;
			Ext.Array.each(fields,function(field){
				me.fields[field]=value;
			});
		},
		//获得所有表单元素名集合
		getFeidsKeys:function(){
			return Ext.Object.getKeys(this.fields);
		},
		//选择combo
		comboSelect(filedName,valueKey,value){
			var combo=this.form.down("combobox[name="+filedName+"]");
			var store=combo.getStore();
			combo.select(store.getAt(store.find(valueKey,value)));
		}
		
	});
</script>
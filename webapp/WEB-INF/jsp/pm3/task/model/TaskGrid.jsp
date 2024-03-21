<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">
	/**
	 * 任务表格对象
	 */
	Ext.define("TaskGrid", {
		mixins : {
			curd:"Remexs.Curd",
		},
		api:{
			get:"taskService.get",//获得任务
			create:"taskService.create",//创建任务
			update:"taskService.update",//修改任务
			deleted:"taskService.delete",//删除任务
			publish:"taskService.publish",//发布任务
			receive:"taskService.receive",//接受任务
			resolve:"taskService.resolve",//分解任务
			resolves:"taskService.resolves",//保存并发布分解任务
			finish:"taskService.finish",//完成任务
			close:"taskService.close",//关闭任务
			up:"taskService.up",//升级任务
			back:"taskService.back",//打回
			pause:"taskService.pause",//暂停任务
			play:"taskService.play",//重启任务
			down:"taskService.down",//降级任务
			create_publish:"taskService.create_publish", //创建并发布任务
			create_message:"taskService.create_message" //消息
		},
		grid:null,
		constructor : function(config) {
			this.mixins.curd.constructor.call(this, config);
			var me = this;
			this.addEvents({
				"reload" : true,
				"publish":true,
				"afterreload":true
			});
		},
		// 重新加载表格数据
		reload:function (params,callback){
			var me=this;
			var params = Ext.apply(this.params,params || {});
			if (!me.fireEvent("reload", me, params)) {
				return;
			}
			this.grid.getStore().getProxy().extraParams = params;
			this.grid.getStore().loadPage(1, function() {
				me.fireEvent("afterreload", task_grid);
				if (callback) callback();
			});
		},
		//发布任务
		publish:function(records,callback){
			if(AOS.empty(records)){
				AOS.tip('请选择任务记录');
				return;
			}
			//选择所有草稿任务
			var task_ids = AOS.SelectionInRecordsArray(records, 'task_id', "state","1001");
			if(AOS.empty(task_ids)){
				AOS.tip('没有待发布的任务。');
				return;
			}
			this.ajax(this.api.publish,{aos_rows:task_ids},callback);
		},
		
		//创建并发布任务
	     create_publish:function(params,callback){
	    
			this.ajax(this.api.create_publish,params,callback);
		},
		
		//接受任务
		receive:function(data,callback){
			if(AOS.empty(data)){
				AOS.tip('请选择任务记录');
				return;
			}
			//选择所有草稿任务
			if(data["state"]!="1002"){
				AOS.tip('不是待接受的任务，请选择其他任务');
				return;
			}
			this.ajax(this.api.receive,{task_id:data["task_id"]},callback);
		},
		//打回任务
		back:function(data,callback){
			this.ajax(this.api.back,{task_id:data["task_id"]},callback);
		},
		//暂停任务
		pause:function(data,callback){
			this.ajax(this.api.pause,{task_id:data["task_id"]},callback);
		},
		//重启任务
		play:function(data,callback){
			this.ajax(this.api.play,{task_id:data["task_id"]},callback);
		},
		//任务分解
		resolve:function(data, datas, callback){
			if(AOS.empty(data)){
				AOS.tip('请选择任务记录');
				return false;
			}
			if(AOS.empty(datas)){
				AOS.tip('分解记录不能为空');
				return false;
			}
			if(data.state=="1004"||data.state=="1005"){
				AOS.tip('已完成或已关闭的任务不能分解');
				return false;
			}
// 			console.log(data);
			task_id=data.task_id;
			group_id = data.group_id;
			this.ajax(
				this.api.resolve,
				{task_id:task_id,group_id:group_id,task_resolves : Ext.encode(datas)},
				callback
			);
		},
		//任务分解保存并发布
		resolves:function(data, datas, callback){
			if(AOS.empty(data)){
				AOS.tip('请选择任务记录');
				return false;
			}
			/* if(AOS.empty(datas)){
				AOS.tip('分解记录不能为空');
				return false;
			} */
			if(data.state=="1004"||data.state=="1005"){
				AOS.tip('已完成或已关闭的任务不能分解');
				return false;
			}
// 			console.log(data);
			task_id=data.task_id;
			group_id = data.group_id;
			this.ajax(
				this.api.resolves,
				{task_id:task_id,group_id:group_id,task_resolves : Ext.encode(datas)},
				callback
			);
		},
		//批量保存修改
		updates:function(datas,callback){
			var me=this;
			if(AOS.empty(datas)){
				AOS.tip('请选择任务记录');
				return;
			}
			update_success_count=0;
			Ext.Array.each(datas,function(data){
				me.update(data,function(returnData){
					if(returnData.appcode==AOS.SUCCESS_CODE){
						update_success_count++;
					}
					if(update_success_count==datas.length){
						msg = AOS.merge(
							"本次修改成功{0}条记录，失败{1}条记录，总计已选择{2}条记录",
							update_success_count, 
							datas.length - update_success_count,
							datas.length
						);
						AOS.tip(msg);
						if(callback){callback.call(me)};
					}
				});
			});
		},
		//完成任务
		finish:function(data,callback){
			if(AOS.empty(data)){
				AOS.tip('请选择一条任务记录');
				return;
			}
			if(data["state"]!="1003"){
				AOS.tip('不是待完成的任务，请选择其他任务');
				return;
			}
			this.ajax(this.api.finish,{aos_rows:data["task_id"]},callback);
		},
		//完成任务
		create_message:function(data,callback){
			this.ajax(this.api.finish,{aos_rows:data["task_id"]},callback);
		},
		//关闭任务
		close:function(datas,callback){
			if(AOS.empty(datas)){
				AOS.tip('请选择一条任务记录');
				return;
			}
			var task_ids = AOS.SelectionInDataArray(datas, 'task_id', "state","1004");
			if(AOS.empty(task_ids)){
				AOS.tip('没有待关闭的任务。');
				return;
			}
			this.ajax(this.api.close,{aos_rows:task_ids},callback);
		},
		//删除任务
		deleted:function(records,callback){
			if(AOS.empty(records)){
				AOS.tip('请选择任务记录');
				return;
			}
			var task_ids = AOS.SelectionInRecordsArray(records, 'task_id', "state","1001");
		
			if(AOS.empty(task_ids)){
				AOS.tip('没有待删除的任务。');
				return;
			}
			this.ajax(this.api.deleted,{aos_rows:task_ids},callback);
		},
		//升级任务
		up:function(record,callback){
			if(AOS.empty(record)){
				AOS.tip('请选择一条任务。');
				return;
			}
			this.ajax(this.api.up,{task_id:record.get("task_id")},callback);
		},
		//降级任务
		down:function(record,callback){
			if(AOS.empty(record)){
				AOS.tip('请选择一条任务。');
				return;
			}
			this.ajax(this.api.down,{task_id:record.get("task_id")},callback);
		},
		//任务复制功能缓存数据
		hadCopyRecords : [],
		//清空缓存
		cleanCopyRecords : function() {
			this.hadCopyRecords = [];
		},
		//批量复制
		copyRecords : function(records) {
			var me = this;
			var insert_count = 0;
			hadCopyRecord = null;
			//剔除重复记录
			Ext.Array.each(records, function(record) {
				record.data.remark="";
				record.data.state="1001"
				record.data.percent="";
				record.data.real_begin_time="";
				record.data.real_end_time="";
				record.data.real_wastage="";
				if (!AOS.empty(me.hadCopyRecords)) {
					hadCopyRecord = AOS.findOne(me.hadCopyRecords, "task_code","" + record.get("task_code"));
				}
				if (AOS.empty(hadCopyRecord)) {
					me.hadCopyRecords.push(record);
					insert_count++;
				}
			});

			msg = AOS.merge(
				"本次复制成功{0}条记录，包含重复记录{1}条，总计已选择{2}条记录",
				insert_count, 
				records.length - insert_count,
				me.hadCopyRecords.length
			);
			AOS.tip(msg);
		},
		//保存批量复制
		saveCopy : function(group_id, callback) {
			if (AOS.empty(this.hadCopyRecords)) {
				return;
			}
			var me = this;
			var insert_success = 0;
			var insert_success_records = [];
			var len = this.hadCopyRecords.length;
			//循环新增
			Ext.each(this.hadCopyRecords, function(record) {
				record.data.group_id = group_id;
				me.create(record.data, function(data) {
					if (data.appcode == AOS.SUCCESS_CODE) {
						insert_success++;
						insert_success_records.push(record);
					}
					//检查是否新增完成
					if (insert_success == len) {
						insert_failure_records = Ext.Array.difference(
							me.hadCopyRecords, insert_success_records
						);
						me.cleanCopyRecords();
						msg = AOS.merge(
							"本次保存成功{0}条记录，失败{1}条,已清空待保存区域数据。",
							insert_success_records.length,
							insert_failure_records.length
						);
						AOS.tip(msg);
						if (callback) callback();
					}
				});
			});
		}
	});
	//将用id转换为用户名
	function renderProject(value, metaData, record) {
		if(AOS.empty(value)) return "";
		if(AOS.empty(CurrentTaskPage.projects)) return "";
		var data = AOS.findOneInArray(CurrentTaskPage.projects, "value", ""+ value);
		if (!AOS.empty(data)) {
			return data.display;
		}
		return "";
	}
	//将用id转换为用户名
	function renderUser(value, metaData, record) {
		if(AOS.empty(value)) return "";
		if(AOS.empty(CurrentTaskPage.projectUsersAll)) return "";
		var data = AOS.findOneInArray(CurrentTaskPage.projectUsersAll, "value", ""+ value);
		if (!AOS.empty(data)) {
			return data.display;
		}
		return "";
	}
	//将需求编码转换为需求名
	function renderDemand(value, metaData, record) {
		if(AOS.empty(value)) return "";
		if(AOS.empty(CurrentTaskPage.projectDemands)) return "";
		var data = AOS.findOneInArray(CurrentTaskPage.projectDemands, "value", ""+ value);
		if (!AOS.empty(data)) {
			return data.display;
		}
		return "";
	}
	//将模块编码转换为模块名
	function renderModule(value, metaData, record) {
		if(AOS.empty(value)) return "";
		if(AOS.empty(CurrentTaskPage.projectModules)) return "";
		var data = AOS.findOneInArray(CurrentTaskPage.projectModules, "value", ""+ value);
		if (!AOS.empty(data)) {
			return data.display;
		}
		return "";
	}
</script>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:treepanel id="checkMain_grid" region="west" bodyBorder="0 1 0 0" singleClick="false" rootVisible="false"  
	url="checkMainService.getCheckMainListTreeData" onitemclick="checkMainTree_query" cascade="true" rootExpanded="true">
	<aos:menu>
		<aos:menuitem text="新增" onclick="checkMain_add" icon="add.png" />
		<aos:menuitem text="删除" onclick="checkMain_delete" icon="del.png" />
		<aos:menuitem text="提交" onclick="checkMain_submit" icon="up.png" />
		<aos:menuitem text="撤回" onclick="checkMain_submit_recall" icon="down.png" />
	</aos:menu>
	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="检查单类型" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:dockeditem text="新增" icon="add.png" onclick="checkMain_add" />
		<aos:dockeditem text="删除" icon="del.png" onclick="checkMain_delete" />
		<aos:dockeditem text="提交" icon="up.png" onclick="checkMain_submit" />
		<aos:dockeditem text="撤回" icon="down.png" onclick="checkMain_submit_recall" />
	</aos:docked>
</aos:treepanel>

<script type="text/javascript">
	//单击树节点
	function checkMainTree_query(){
		//获取项目ID
		var proj_id = AOS.getValue('id_proj_name');
		if(AOS.empty(proj_id)){ 
			return; 
		}
		//获取项目过程树节点
		var record = AOS.selectone(checkMain_grid);
		if(!AOS.empty(record)){
			if(record.raw.a == undefined && record.raw.b == undefined){
				var params = {proj_id : proj_id}
				AOS.reset(checkMain_result_form);
			}else if(record.raw.a == undefined && record.raw.b != undefined){
				var params = {proj_id : proj_id}
				params.check_cata_id = record.raw.b;
				AOS.reset(checkMain_result_form);
			}else{
				var params = { proj_id : proj_id };
		 		params.check_id = record.raw.id;
		 		AOS.reset(checkMain_result_form);
		 		AOS.ajax({
		 			params : params,
		 			url : 'checkMainService.loadFormInfo',
		 			ok: function (data) {
			           AOS.setValues(checkMain_result_form,data);
					}
		 		});
			}
		}
		checkDetail_grid_store.getProxy().extraParams = params;
		checkDetail_grid_store.loadPage(1);
	}
	//新增
	function checkMain_add(){
		var proj_id = AOS.getValue('id_proj_name');
		if(proj_id==undefined){
			AOS.tip('请先选择一个项目!');
			return ;
		}
		AOS.reset(checkMain_create_form);
		var record = AOS.selectone(checkMain_grid);
		if(!AOS.empty(record)){
			if(record.raw.a==undefined&&record.raw.b!=undefined){
				check_cata_combobox_store.getProxy().extraParams = {
					proj_id : proj_id
				}
				check_cata_combobox_store.load({
					callback : function(){
						AOS.setValue('checkMain_create_form.check_cata_id',Number(record.raw.b));
						AOS.setValue('checkMain_create_form.check_cata_name',record.raw.text);
					}
				});
			}else if(record.raw.a!=undefined&&record.raw.b==undefined){
				check_cata_combobox_store.getProxy().extraParams = {
					proj_id : proj_id
				}
				check_cata_combobox_store.load({
					callback : function(){
						AOS.setValue('checkMain_create_form.check_cata_id',Number(record.raw.parentId));
						AOS.setValue('checkMain_create_form.check_cata_name',record.raw.text);
					}
				});
			}
		}
		AOS.setValue('checkMain_create_form.proj_id',proj_id);
		checkMain_create_win.show();
	}
	
	//删除
	function checkMain_delete(){
		var select = AOS.selectone(checkMain_grid);
		var selection = AOS.selection(checkMain_grid, 'id');
		if(select.raw.a==undefined){
			AOS.tip('请先选择一个检查项进行删除!');
			return ;
		}
		var msg =  AOS.merge('确认要删除选中的检查项记录吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				//	AOS.tip('删除操作被取消。');
					return;
			}
			AOS.ajax({
				url : 'checkMainService.delete',
				params:{
					aos_rows: select.raw.a
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					checkMain_grid_store.reload();
					checkDetail_grid_store.loadPage(1);
				}
			});
		});
	}
	
	//提交
	function checkMain_submit(){
		var select = AOS.selectone(checkMain_grid);
		var selection = AOS.selection(checkMain_grid, 'id');
		if(select.raw.a==undefined){
			AOS.tip('请先选择一个检查项进行提交!');
			return ;
		}
		if(select.raw.c == 1){
			AOS.tip('该检查单已提交，不得保存');
			return;
		}
		var proj_id =id_proj_name.getValue();
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var check_num=select.raw.text.substring(0,12);
		var yes_num=checkMain_result_form.down("textfield[name=yes_num]").rawValue;
		//var yes_num = "1";
		if(yes_num ==""||yes_num==null ){
			AOS.tip('您还未进行任何检查!');
		}else{
			var msg =  AOS.merge('提交以后不得修改任何数据,确认要提交选中的检查项记录吗？');
			AOS.confirm(msg,function(btn){
				if(btn === 'cancel'){
					//AOS.tip('提交操作被取消。');
					return;
				}
				AOS.ajax({
					url : 'checkMainService.submit',
					params:{
						aos_rows: select.raw.a
					},
					ok : function(data){
						AOS.ajax({
							url : 'problemTraceService.createProblem',
							params : {
								aos_rows: select.raw.a,
								check_id: select.raw.a
							},
							ok : function(data){
								AOS.tip("提交成功！");
								checkMain_grid_store.reload();
								//checkDetail_grid_store.loadPage(1);								
							}
						});
						/* var token=data.appmsg;
						
						var count="{\"proj_id\":\""+proj_id+"\","+"\"proj_name\":\""+tree_proj_name.getValue()+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}提交"
							+check_num+"检查单\","+"\"createTime\":\""+createTime+"\"}";
						var title="检查单"; 
						mesVO= {
								"title"  : title, 
								 "content": count,
								 "extras": {proj_id,proj_name,createTime,sedTime},
								 "mesGroup": "CHANNEL",
							}
						AOS.weekSend(token,mesVO); */
					}
				});
			});
		}
	}
	
	//撤回
	function checkMain_submit_recall(){
		var select = AOS.selectone(checkMain_grid);
		var selection = AOS.selection(checkMain_grid,'id');
		if(select.raw.a==undefined){
			AOS.tip('请先选择一条检查单进行撤回!');
			return ;
		}
		if(select.raw.c == 0){
			AOS.tip('未提交的检查单无法撤回');
			return;
		}
		var msg =  AOS.merge('是否要撤回选中的检查项？');
		AOS.confirm(msg,function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url: "checkMainService.noSubmit",
				params : {
					aos_rows: select.raw.a
				},
				ok : function(data){
					checkMain_grid_store.reload();
					checkDetail_grid_store.reload();
				}
			});
		});
	}
</script>
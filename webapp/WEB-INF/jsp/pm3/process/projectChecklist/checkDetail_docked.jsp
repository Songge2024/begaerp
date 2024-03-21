<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="检查项" />
	<aos:dockeditem xtype="tbseparator" />
	<%-- <aos:dockeditem text="新增" icon="add.png"  		onclick="checkDetail_win_show('create');" /> --%>
	<%-- <aos:dockeditem text="修改" icon="edit.png" 		onclick="checkDetail_win_show('update');" /> --%>
	<aos:dockeditem text="统一保存" onclick="fn_update"  icon="save.png" region="east"/>
	<aos:dockeditem text="复制" icon="copy.png" onclick="copy_detail" />
	<aos:dockeditem text="删除" icon="del.png" onclick="checkDetail_delete" />
</aos:docked>

<script type="text/javascript">
	//统一保存
	function fn_update(){
		if (AOS.mrows(checkDetail_grid) == 0) {
			AOS.tip('数据没变化，提交操作取消。');
			return;
		}
		selarr=[];
		cache_select=true;
		var select = AOS.select(checkMain_grid);
		var record = AOS.selectone(checkMain_grid);
		if(record.raw.a!=undefined&&record.raw.b==undefined){
			if(record.raw.c=="0"){
				var selarr = new Array();
				//保存选择
				var records = checkMain_grid.getSelectionModel().getSelection();
				selarr.splice(0);
				for (var i in records) {
					selarr.push(records[i].index);
				}
				var check_id = record.raw.a;
				var selection = AOS.selection(checkDetail_grid, 'check_id');
				AOS.ajax({
					params : {
						aos_rows:AOS.mrs(checkDetail_grid)
					},
					url : 'checkDetailService.updateGrid',
					ok : function(data) {
						checkDetail_grid_store.reload();
						AOS.ajax({
							params:{
								aos_rows: selection,
							},
							url : 'checkDetailService.checkCountByKey',
							ok : function(data) {
								AOS.tip(data.appmsg);
								checkDetail_update_win.hide();
							}
						});
						checkMain_grid_store.reload({
							callback:function(){
								for (var i = 0; i < selarr.length; i++) {
									checkMain_grid.getSelectionModel().select(selarr[i], true);
									var record = AOS.selectone(checkMain_grid, true);
								}
							}
						});
						AOS.ajax({
							params: {
								check_id:check_id,
								proj_id  : AOS.getValue('id_proj_name')
							},
							url: 'checkMainService.loadFormInfo',
							ok: function (data) {
								AOS.setValues(checkMain_result_form,data);
							}
						});
					}
				});
			}else{
				AOS.tip("该检查单已提交,不能进行保存!");
				var grid =  AOS.get('checkDetail_grid');
				grid.store.loadPage(1);
			}
		}else{
			AOS.tip("请先选择一条要保存的项目检查单");
		}
	}
	
	//复制
	function copy_detail(){
		var record = AOS.selectone(checkMain_grid)
		var selection = AOS.selection(checkDetail_grid, 'check_detail_id');
		var records = AOS.select(checkDetail_grid, true);
		if(record.raw.a!=undefined&&record.raw.b==undefined){
			var check_id = record.raw.a;
			if(AOS.empty(records) || records.length>1){
				AOS.tip('请选择一条需要复制的数据。');
				return;
			}
			AOS.ajax({
				params : {
					aos_rows: selection,
					check_id : check_id
				},
				url : 'checkDetailService.copyDetail',
				ok : function(data){
					AOS.tip(data.appmsg);
					checkDetail_grid_store.reload();
				}
			});	
		}else{
			AOS.tip("请先选择项目检查单。");
		}
	}
	//删除
	function checkDetail_delete(){
		var record = AOS.selectone(checkMain_grid)
		if(record.raw.a!=undefined&&record.raw.b==undefined){
			var selection = AOS.selection(checkDetail_grid, 'check_detail_id');
			var check_id = record.raw.a;
			if(AOS.empty(selection)){
				AOS.tip('删除前请先选中数据。');
				return;
			}
			
			var rows = AOS.rows(checkDetail_grid);
			var msg =  AOS.merge('确认要删除选中的{0}条检查项记录吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					AOS.tip('删除操作被取消。');
					return;
				}
				AOS.ajax({
					url : 'checkDetailService.delete',
					params:{
						aos_rows: selection,
						check_id : check_id
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						//checkMain_grid_store.reload();
						checkDetail_grid_store.reload();
					}
				});
			});
		}else{
			AOS.tip("请先选择一条要删除的项目检查单")
		}
	}
</script>
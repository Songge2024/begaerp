<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="风险目录信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="riskCatalog_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="riskCatalog_win_show('update');" />
	<aos:dockeditem text="启用" icon="go.gif"    onclick="riskCatalog_enable" />
	<aos:dockeditem text="停用" icon="stop.gif"    onclick="riskCatalog_disable" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="riskCatalog_delete" />
</aos:docked>

<script type="text/javascript">

//启用
function riskCatalog_enable(){
	var selection = AOS.selection(riskCatalog_grid, 'risk_cata_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要启用的数据。');
		return;
	}
	var grid = AOS.select(riskCatalog_grid);
	var state = grid[0].data.state;
	if(state!=0){
		AOS.tip('当前状态下不能进行启用操作!。');
		return;
	}
	var selection_state = AOS.selection(riskCatalog_grid, 'state');
	var rows = AOS.rows(riskCatalog_grid);
	var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('启用操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'riskCatalogService.enable',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				riskCatalog_grid_store.reload();
			}
		});
	});

}


//停用
function riskCatalog_disable(){
	var selection = AOS.selection(riskCatalog_grid, 'risk_cata_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要停用的数据。');
		return;
	}
	var grid = AOS.select(riskCatalog_grid);
	var state = grid[0].data.state;
	if(state!=1){
		AOS.tip('当前状态下不能进行停用操作!。');
		return;
	}
	var selection_state = AOS.selection(riskCatalog_grid, 'state');
	var rows = AOS.rows(riskCatalog_grid);
	var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('停用操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'riskCatalogService.disable',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				riskCatalog_grid_store.reload();
			}
		});
	});

}

</script>
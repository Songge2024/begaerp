<%@page import="aos.system.common.model.UserModel"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	UserModel userModel=AOSCxt.getUserModel((String)request.getAttribute("juid"));
	Integer current_user_id=userModel.getId();
%>
<aos:gridpanel 
	id="problemTrace_grid" 
	url="problemTraceService.page" 
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<aos:docked forceBoder="1 0 1 0" id="test">
		<aos:dockeditem xtype="tbtext" text="QA检查单问题" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:dockeditem text="统一保存" icon="save.png" onclick="fn_all_update" any="name:'fn_all_update_button'"/>
		<aos:dockeditem text="全部导出" icon="icon70.png" onclick="exportAll" any="name:'exportAll_button'"/>
	</aos:docked>
	<aos:plugins>
		<aos:editing id="id_plugin" clicksToEdit="1" ptype="cellediting" />
	</aos:plugins>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" width="40"/>
	<%@ include file="problemTrace_columns.jsp"%>
</aos:gridpanel>

<script type="text/javascript">
	var	fn_all_update_button = test.down("button[name=fn_all_update_button]");
	var	exportAll_button = test.down("button[name=exportAll_button]");
	function proj_manager(){
		var proj_id = AOS.getValue('id_proj_name');
		var current_user_id=<%=current_user_id%>;
		AOS.ajax({
			params:{
				proj_id : proj_id
			},
			url : 'problemTraceService.getProjManager',
			ok : function(data) {
				var con=Number(data.appmsg);
				if(con === current_user_id){
					fn_all_update_button.hide();
					exportAll_button.show();
				}else{
					fn_all_update_button.show();
					exportAll_button.show();
				}
			}
		});
	}
	
	function fn_all_update(){
		if (AOS.mrows(problemTrace_grid) == 0) {
			AOS.tip('数据没变化，提交操作取消。');
			return;
		}
		AOS.ajax({
			params : {
				aos_rows:AOS.mrs(problemTrace_grid)
			},
			url : 'problemTraceService.updateGrid',
			ok : function(data){
				AOS.tip(data.appmsg);
				problemTrace_grid_store.reload();
			}
		});
	}
	
	function exportAll(){
		var record = AOS.selectone(checkMain_grid);
		var proj_id = AOS.getValue('id_proj_name');
		var params = AOS.getValue('fn_problem_trace');
		var start = 0;
		var limit = 50;
		var problem_sources = params.problem_sources;
		if(problem_sources === undefined){
			problem_sources="";
		}
		var process_product = params.process_product;
		if(process_product === undefined){
			process_product="";
		}
		var problem_state = params.problem_state;
		if(problem_state === undefined){
			problem_state="";
		}
		var principal_org = params.principal_org;
		if(principal_org === undefined){
			principal_org="";
		}
		var problem_level = params.problem_level;
		if(problem_level === undefined){
			problem_level="";
		}
		var deal_man = params.deal_man;
		if(deal_man === undefined){
			deal_man="";
		}
		if(!AOS.empty(record)){
			if(record.raw.a == undefined && record.raw.b == undefined){
				var check_id = "";
				var check_cata_id = "";
			}else if(record.raw.a == undefined && record.raw.b != undefined){
				var check_id = "";
				var check_cata_id = record.raw.b;
			}else{
				var check_id = record.raw.id;
				var check_cata_id = "";
			}
		}
		AOS.file('do.jhtml?router=problemTraceService.exportAllExcel&juid=${juid}&proj_id='+proj_id
			+'&problem_sources='+problem_sources
			+'&process_product='+process_product
			+'&problem_state='+problem_state
			+'&principal_org='+principal_org
			+'&problem_level='+problem_level
			+'&deal_man='+deal_man
			+'&check_id='+check_id
			+'&check_cata_id='+check_cata_id
			+'&start='+start
			+'&limit='+limit
		);
	}
</script>
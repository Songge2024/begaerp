<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ include file="../../public/public_method.jsp"%>
<%@page import="aos.system.common.model.UserModel"%>
<aos:html title="项目角色分类维护" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
		<aos:gridpanel id="projRoleTypes_grid" onitemdblclick="projRoleTypes_win_show" 	onrender="projRoleTypes_query"  url="projRoleTypesService.page" region="center" >
			<%@ include file="codes/projRoleTypes_docked.jsp"%>
			<%@ include file="codes/projRoleTypes_menu.jsp"%>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<%@ include file="codes/projRoleTypes_columns.jsp"%>
		</aos:gridpanel>
	</aos:viewport>
			<%@ include file="codes/projRoleTypes_win.jsp"%>
	<script type="text/javascript">
			<%@ include file="codes/projRoleTypes_handler.jsp"%>
	</script>
</aos:onready>
<script type="text/javascript">
	function projRoleTypes_update_show(){
		var record = AOS.selectone(AOS.get('projRoleTypes_grid'));
		if(record.data.state=="1"){
		AOS.tip('无法修改已提交的记录,请重新选择!');
		return;
		}
		AOS.get('projRoleTypes_update_win').show();
	}
	function fn_del(){
		//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
		var record = AOS.selectone(AOS.get('projRoleTypes_grid'));
		if(record.data.state=="1"){
			AOS.tip('无法删除已提交的记录,请重新选择!');
			return;
			}
		var msg =  AOS.merge('确认要删除该项目角色分类【{0}】吗？', record.data.trp_name);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'projRoleTypesService.delProjRoleInfo',
				params:{
					trp_code: record.data.trp_code
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					AOS.get('projRoleTypes_grid').getStore().reload();
				}
			});
		});
	}
	</script>

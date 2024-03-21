<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	int userid = userModel.getId();
%>
<%
	//获取当前时间
	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();
	String time = simpleDateFormat.format(currentTime).toString();
	request.setAttribute("time", time);
%>
	
	<aos:docked >
		<aos:dockeditem xtype="tbtext" text="检查结果统计" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:dockeditem onclick="saveSuggest_update" text="保存" icon="ok.png" />
	</aos:docked>
	<aos:formpanel 
		id="checkMain_result_form"
	 	width="700"
	  	layout="column" 
	  	labelWidth="70"
	>
		<aos:hiddenfield name="check_id" fieldLabel="检查单目录ID" />
		<aos:hiddenfield  name="proj_id" fieldLabel="项目ID"  />
		<aos:textfield name="yes_num" fieldLabel="符合数" allowBlank="true" columnWidth="0.25" maxLength="10" readOnly="true"/>
		<aos:textfield name="no_num" fieldLabel="不符合数" allowBlank="true" columnWidth="0.25" maxLength="10" readOnly="true"/>
		<aos:textfield name="none_num" fieldLabel="不适用数" allowBlank="true" columnWidth="0.25" maxLength="10" readOnly="true"/>
		<aos:textfield name="prob_num" fieldLabel="转为问题数" allowBlank="true" columnWidth="0.25" maxLength="10" readOnly="true"/>
		<aos:combobox name="check_user_id" id="check_user_id"  fieldLabel="检查人"  value="${user.id}" allowBlank="true" columnWidth="0.5" margin="0 155 0 0" url="checkMainService.listCheckUserId" />
		<aos:datetimefield name="check_time" fieldLabel="检查时间" allowBlank="true" value="${time}" format="Y-m-d H:i:s" columnWidth="0.5" margin="0 0 0 0"/>
		<aos:textareafield name="suggest" fieldLabel="建议与意见" allowBlank="true" maxLength="3000" height="87" columnWidth="1" msgTarget="qtip" />
		
	</aos:formpanel>
	
	<script type="text/javascript">
	//保存
	function saveSuggest_update() {
		selarr=[];
		cache_select=true;
		var select = AOS.selectone(checkMain_grid);
		var record = AOS.selectone(checkMain_grid);
		if(record.raw.a!=undefined&&record.raw.b==undefined){
			var selarr = new Array();
			//保存选择
			var records = checkMain_grid.getSelectionModel().getSelection();
			selarr.splice(0);
			for (var i in records) {
				selarr.push(records[i].index);
			}
			var check_id = record.raw.a;
			AOS.ajax({
				forms : checkMain_result_form,
				url : 'checkMainService.update',
				params:{
					check_id:check_id,
					aos_rows: select.raw.a
				},
				ok : function(data) {
				AOS.tip(data.appmsg);
					var params = {check_id : check_id};
					checkDetail_grid_store.getProxy().extraParams = params;
					checkDetail_grid_store.loadPage(1);
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
			AOS.reset(checkMain_result_form);
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
		}else{
			AOS.tip("请先选择一条要保存的项目检查单")
		}
	}
</script>
	
	

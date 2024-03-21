<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkMain_create_win" 
	title="新增QA检查单类型"
>
	<aos:formpanel 
		id="checkMain_create_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
		<aos:hiddenfield name="check_id" fieldLabel="检查单目录ID" />
		<aos:hiddenfield name="check_code" fieldLabel="检查项编码" />
		<aos:hiddenfield name="proj_id" fieldLabel="proj_id" />
		<aos:combobox name="check_cata_id" id="check_cata_combobox" fieldLabel="类型名称" editable="true" 
			url="checkMainService.listComboBoxcheckCata" allowBlank="false" columnWidth="1"  onselect="check_cata_onselect1"/>
		<aos:hiddenfield name="check_cata_name" id="check_cata_name" fieldLabel="检查单目录ID" />
		<aos:hiddenfield name="check_name" fieldLabel="检查单名称" />
		<aos:hiddenfield name="comment" fieldLabel="说明" />
		<aos:hiddenfield name="yes_num" fieldLabel="统计 符合数" />
		<aos:hiddenfield name="no_num" fieldLabel="统计 不符合数" />
		<aos:hiddenfield name="none_num" fieldLabel="统计 不适应数" />
		<aos:hiddenfield name="suggest" fieldLabel="建议与意见" />
		<aos:hiddenfield name="check_user_id" fieldLabel="检查人" />
		<aos:hiddenfield name="check_time" fieldLabel="检查时间" />
		<aos:hiddenfield name="create_user_id" fieldLabel="创建人" />
		<aos:hiddenfield name="create_time" fieldLabel="创建时间" />
		<aos:hiddenfield name="update_user_id" fieldLabel="更新人" />
		<aos:hiddenfield name="update_time" fieldLabel="更新时间" />
		<aos:hiddenfield name="state" fieldLabel="状态" />
		<aos:hiddenfield name="plan_check_time" fieldLabel="计划检查时间" />
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkMain_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkMain_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

<script type="text/javascript">
	function check_cata_onselect1(obj){
		AOS.setValue('check_cata_name',obj.rawValue);
		AOS.ajax({
			url : 'checkMainService.countCata_id',
			params:{
				check_cata_id: obj.value
			},
			ok : function(data) {
				//AOS.tip(data.appmsg);
				if(data.appmsg==0){
					AOS.tip('该检查目录没有录入对应的检查项，请核对!');
					AOS.reset(checkMain_create_form);
					return;
				}
			}
		});
	}
</script>
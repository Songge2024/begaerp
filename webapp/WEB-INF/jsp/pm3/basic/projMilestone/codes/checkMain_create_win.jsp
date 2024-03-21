<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkMain_create_two_win" 
	title="新增检查项目录"
	height="260"
	width="500"
>
<aos:formpanel id="checkMain_create_two_form" layout="anchor" >
<aos:textfield name="milest_name"  fieldLabel="里程碑" readOnly="true" columnWidth="1"  />
<aos:hiddenfield name="milest_code"  fieldLabel="里程碑"   />
<aos:combobox name="check_cata_id" id="check_cata_two_combobox" fieldLabel="检查项目录" editable="true" 
url="checkMainService.listComboBoxcheckCata" allowBlank="false" columnWidth="1"  onselect="check_cata_onselect1"
/>
<aos:datetimefield name="plan_check_time" id="plan_check_time" fieldLabel="计划检查时间"  allowBlank="false" columnWidth="1"/>
<aos:hiddenfield name="check_cata_name" id="check_cata_two_name" fieldLabel="检查单目录ID" />
<!-- onselect="checkMain_query"  -->
<aos:hiddenfield name="check_id" fieldLabel="检查单目录ID" />
<aos:hiddenfield name="proj_id" fieldLabel="项目ID"  />
<aos:hiddenfield name="state" fieldLabel="状态"  />
<aos:textareafield name="comment" id="comment" fieldLabel="说明" allowBlank="true" maxLength="19" columnWidth="1" msgTarget="qtip" height="80" />
<aos:hiddenfield name="create_user_id" fieldLabel="设计人" />
<aos:hiddenfield name="create_time" fieldLabel="创建时间"  />
<aos:hiddenfield name="update_user_id" fieldLabel="更新人"  />
<aos:hiddenfield name="update_time" fieldLabel="更新时间" />
</aos:formpanel>
<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkMain_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkMain_create_two_win.hide();" text="关闭" icon="close.png" />
</aos:docked>
</aos:window>

<script type="text/javascript">
function check_cata_onselect1(obj){
	AOS.setValue('check_cata_two_name',obj.rawValue);
	AOS.ajax({
		url : 'checkMainService.countCata_id',
		params:{
			check_cata_id: obj.value
		},
		ok : function(data) {
			//AOS.tip(data.appmsg);
			if(data.appmsg==0){
				AOS.tip('该检查目录没有录入对应的检查项，请核对!');
				AOS.setValue('checkMain_create_two_form.check_cata_id',"");
				return;
			}
		}
	});
}
</script>


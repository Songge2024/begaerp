<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="回复内容信息" base="http" lib="ext,ueditor">
	<aos:body>
		<div id="files_desc_news_div">
			<script type="text/plain" id="files_desc_news_editor"
				style="text-align: left; margin-top: 5px; margin-right: 5px; width: 99%; min-height: 300px;"></script>
		</div>
	</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="fit">
		<aos:panel  id="p_main" anchor="100% 100% " layout="anchor"
			autoScroll="true" border="true">
<%-- 			<aos:panel id="p_theme" anchor="100% 50%" html="${remarks}" title="主题信息" autoScroll="true" --%>
<%-- 				collapsible="true" border="true"  margin="10 10 10 10" > --%>
<%-- 				 <aos:docked forceBoder="0 1 1 1" > --%>
<%--                     <aos:dockeditem text="确认" any="name:'comfirm_button'" onclick="chang_state" icon="ok1.png"  width="60"/> --%>
<%-- 					<aos:dockeditem text="已确认" any="name:'com_button'" hidden="true" icon="ok1.png" width="80" />  --%>
<%-- 					<aos:dockeditem text="拒绝" any="name:'re_button'" onclick="refuse_button" icon="del.png" width="60" /> --%>
<%-- 					<aos:dockeditem text="已拒绝" any="name:'Rejected_button'" hidden="true" icon="del.png" width="80" /> --%>
<%--                     <aos:dockeditem xtype="tbfill" /> --%>
<%--                 </aos:docked> --%>
<%-- 			</aos:panel > --%>
			<aos:formpanel id="idform_data1" layout="column" labelWidth="70" title="会议详情" anchor="100% 100%" border="true" margin="5">
					<aos:docked>
						<aos:dockeditem text="确认" any="name:'comfirm_button'" onclick="chang_state" icon="ok1.png"  width="60"/>
						<aos:dockeditem text="已确认" any="name:'com_button'" hidden="true" icon="ok1.png" width="80" /> 
						<aos:dockeditem text="拒绝" any="name:'re_button'" onclick="refuse_button" icon="del.png" width="60" />
						<aos:dockeditem text="已拒绝" any="name:'Rejected_button'" hidden="true" icon="del.png" width="80" />
						<aos:dockeditem xtype="tbseparator" />
					</aos:docked>
					<aos:fieldset title="会议信息" collapsible="false" >
						<aos:textfield name="proj_name" fieldLabel="项目名称" allowBlank="true" readOnly="true" columnWidth="0.495" value="${message.proj_name}"/>
						<aos:textfield name="theme" fieldLabel="会议主题" allowBlank="true" readOnly="true" columnWidth="0.495" value="${message.theme}"/>
						<aos:datetimefield name="begin_date" fieldLabel="开始时间" format="Y-m-d H:i:s" readOnly="true" allowBlank="true" columnWidth="0.2475" value="${begin_date}"/>
						<aos:datetimefield name="end_date" fieldLabel="结束时间" format="Y-m-d H:i:s" readOnly="true" allowBlank="true" columnWidth="0.2475" value="${end_date}"/>
						<aos:numberfield  name="workload" fieldLabel="会议用时" readOnly="true" columnWidth="0.2475" value="${message.workload}"/>
						<aos:textfield name="review_addre" fieldLabel="会议地点" readOnly="true" allowBlank="true" columnWidth="0.2475" value="${message.review_addre}" />
						<aos:textfield name="review_type" fieldLabel="会议方式" readOnly="true" allowBlank="true" columnWidth="0.2475"  value="${message.review_type}"/>
						<aos:textfield name="meeting_type" fieldLabel="会议类型" readOnly="true" allowBlank="true" columnWidth="0.2475"  value="${message.meeting_type}"/>
						<aos:textfield name="initiator" fieldLabel="发起人" readOnly="true" allowBlank="true" columnWidth="0.2475"  value="${message.initiator_name}"/>
						<aos:textfield name="compere" fieldLabel="主持人" readOnly="true" allowBlank="true" columnWidth="0.2475"  value="${message.compere_name}"/>
						<aos:textfield name="attende_mans" fieldLabel="参与人(内部)" readOnly="true" allowBlank="true" columnWidth="0.99"  value="${message.attende_mans}"/>
						<aos:textfield name="attende_mans_out" fieldLabel="参与人(外部)" readOnly="true" allowBlank="true" columnWidth="0.99"  value="${message.attende_mans_out}"/>
					</aos:fieldset>
					
					<aos:fieldset labelWidth="70" collapsible="false" columnWidth="1" border="true" title="会议内容" margin="5 0 5 0" height="400">
						<aos:panel columnWidth="1" margin="5" padding="5" contentEl="files_desc_news_div" height="500" />
					</aos:fieldset>
					
					<aos:fieldset  title="附件下载" collapsible="false" margin="5 0 5 0" height="270">
						<aos:gridpanel id="reply_details_grid" columnWidth="0.99" height="230" autoScroll="true" hidePagebar="true" border="true" 
							anchor="100%" region="center" layout="fit" forceFit="false" url="filesManageService.replyDetailPage" onrender="reply_details_grid_query">
							<aos:docked forceBoder="1 0 1 0">
								<aos:dockeditem xtype="tbtext" text="文件列表" />
								<aos:dockeditem xtype="tbseparator" />
								<aos:dockeditem text="下载" icon="down.png"  onclick="reply_details_down" />
							</aos:docked>
							
							<aos:selmodel type="checkbox" mode="multi" />
							<aos:column type="rowno"  />
							<aos:column header="文件ID" dataIndex="fileid" width="100" hidden="true" />
							<aos:column header="文件标题" dataIndex="title" fixedWidth="500" />
							<aos:column header="文件大小" dataIndex="filesize" fixedWidth="100" align="right"/>
							<aos:column header="备注" dataIndex="remark" width="100" hidden="true" />
							<aos:column header="文件访问路径" dataIndex="loadurl" width="100" hidden="true" />
							<aos:column header="评审附件关联字段" dataIndex="manin_id" width="100" hidden="true" />
							<aos:column header="文件编码" dataIndex="manage_code" width="100" hidden="true" />
							<aos:column header="文件存储相对路径" dataIndex="path" width="500" hidden="true"/>
						</aos:gridpanel>
					</aos:fieldset>
					
				</aos:formpanel>
<%-- 					<aos:panel id="p_theme" anchor="100% 30%" html="${remarks}" title="附件下载" autoScroll="true"  --%>
<%-- 						collapsible="true" border="true"  margin="10 10 10 10" >  --%>
<%-- 					</aos:panel> --%>
		</aos:panel>
		
		<%-- 批量打包窗口 --%>
		<aos:window id="loadzip_win" title="压缩包名称设置">
			<aos:formpanel id="f_loadzip" width="450" layout="anchor" labelWidth="120">
			    <aos:hiddenfield   name = "loadzip_code"  />
				<aos:textfield id="loadzip" name = "loadzip" fieldLabel="名称设置"  labelWidth="70" allowBlank="false"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="fn_loadzip" text="下载" icon="ok.png" />
				<aos:dockeditem onclick="#loadzip_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
	</aos:viewport>
	<script type="text/javascript">
	var  comfirm_button = idform_data1.down("button[name=comfirm_button]");
	var  com_button = idform_data1.down("button[name=com_button]");
	var  re_button = idform_data1.down("button[name=re_button]");
	var  Rejected_button = idform_data1.down("button[name=Rejected_button]");
	var msg_state = ${msg_state};
	if(msg_state == 2){
		comfirm_button.hide();
		com_button.show();
		Rejected_button.hide();
		re_button.hide();
	}
	if(msg_state == 3){
		comfirm_button.hide();
		com_button.hide();
		Rejected_button.show();
		re_button.hide();
	}
	files_desc_news_editor=UM.getEditor('files_desc_news_editor',{
		autoHeightEnabled:false,
		autoFloatEnabled:true
	});
	files_desc_news_editor.setContent('${message.msg_note}');
	files_desc_news_editor.setDisabled(false);
	//确认会议
	function chang_state(){
		var msg_id = ${msg_id};
		var msg_state = ${msg_state};
		if(msg_state == 2){
			AOS.tip("此条会议信息已确认。");
			return;
		}
		AOS.ajax({
			params : {
				msg_id : msg_id
			},
			url : 'filesManageService.changeMsgState',
			ok : function(data) {

				AOS.tip(data.appmsg);
				if(data.appcode == 1){
					console.log(data);
					Rejected_button.hide();
					comfirm_button.hide();
					re_button.hide();
					com_button.show();
				}
			}
		});
	}
	
	//拒绝会议
	function refuse_button(){
		var msg_id = ${msg_id};
		var msg_state = ${msg_state};
		if(msg_state == 3){
			AOS.tip("此条会议信息已拒绝。");
			return;
		}
		AOS.ajax({
			params : {
				msg_id : msg_id
			},
			url : 'filesManageService.changeRefuseState',
			ok : function(data) {
				AOS.tip(data.appmsg);
				if(data.appcode == 1){
					console.log(data);
					comfirm_button.hide();
					com_button.hide();
					re_button.hide();
					Rejected_button.show();
				}
			}
		});
	}
	
	//设置默认值
	function fn_pass(){
	  	AOS.setValue('pass',${pass_flag});
	  	if(${pass_flag}==2){
	      AOS.get('pass1').setValue(true);
	  	}
	  	if(${pass_flag}==1){
	  	  AOS.get('pass2').setValue(true);
	  	}
	}

	//文件批量下载
	function fn_loadzip(){
		var fileid=AOS.getValue('f_loadzip.loadzip_code');
		var name=AOS.getValue('f_loadzip.loadzip');
		
		name=AOS.setValue('f_loadzip.loadzip','');
		loadzip_win.hide();
	}
	//保存提交信息
	function b_save(){
		var usertx_code='${Opinion_code}';
		var pass=AOS.getValue('pass');
		var usertx_note=AOS.getValue('userinfo.name');
		if(AOS.getValue('pass1')==false&&AOS.getValue('pass2')==false){
			AOS.tip('请选择是否通过!');
			return;
		};
		if( AOS.empty(usertx_note)&&usertx_note==''){
			AOS.tip('请输入内容!');
			return;
		};
		AOS.ajax({
			params : {
				opinion_code:usertx_code,
				pass_flag:pass,
				text_note:usertx_note
			},
			url : 'filesManageService.createUser',
			ok : function(data) {
				 
				  if(data.sb==null){
					  AOS.tip(data.appmsg);
				  }else{
					  AOS.get('userinfo.name').setValue('');
					  AOS.get('id_ta_').body.update(data.sb);
				  }
				
			}
		});
	}
	
	function reply_details_grid_query(){
		var manin_id = '${message.manage_code}';
		reply_details_grid_store.getProxy().extraParams = {
			manin_id : manin_id
		};
		reply_details_grid_store.loadPage(1);
	}
	
	//下载
// 	function reply_details_down(){
// 		var selection = AOS.selection(reply_details_grid, 'fileid');
// 		if(AOS.empty(selection)){
// 			AOS.tip('请选择需要下载的文件!');
// 			return;
// 		}
// 		var rows = AOS.rows(reply_details_grid);
// 		if(rows > 1){
// 			AOS.tip('请只选择一条需要下载的文件!');
// 		return;
// 		}
// 		var path = AOS.selection(reply_details_grid, 'path');
// 		var title = AOS.selection(reply_details_grid, 'title');
// 		var fileid = AOS.selection(reply_details_grid, 'fileid');
// 		if(AOS.empty(selection)){
// 			AOS.tip('请选择要下载的文件!');
// 			return;
// 		}
// 		AOS.file('do.jhtml?router=filesManageService.downloadFile&juid=${juid}&path='+path
// 					+'&title='+title
// 					+'&fileid='+fileid
// 				);
// 	}
	function reply_details_down(){
		var selection = AOS.selection(reply_details_grid,'fileid');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件！');
			return;
		}
		var rows = AOS.rows(reply_details_grid);
		if(rows > 1){
			AOS.tip('请选择一条需要下载的文件！');
			return;
		}
		var path = AOS.selection(reply_details_grid,'path');
		var title = AOS.selection(reply_details_grid,'title');
		var fileid = AOS.selection(reply_details_grid,'fileid');
		AOS.file('do.jhtml?router=filesManageService.downloadFile&juid=${juid}&path='+path
				+'&title='+title
				+'&fileid='+fileid
				);
	}
	
	window.onbeforeunload = function() {
		window.opener.document.getElementById('page_refresh').click()
	}
	</script>
</aos:onready>
<script type="text/javascript">
function checkDownload(fileid){
	if((fileid+'').length>13){
		AOS.file('do.jhtml?router=filesManageService.downloadFileByZip&juid=${juid}&fileid='+"qm"+fileid);
	}else{
		AOS.file('do.jhtml?router=filesManageService.downloadFile&juid=${juid}&fileid='+fileid);
		AOS.ajax({
			url:'do.jhtml?router=filesManageService.downloadFile&juid=${juid}&fileid='+fileid,
			ok: function(date){
				if(!AOS.empty(date.appmsg)){
				AOS.tip(date.appmsg);
			  }
			}
		})
	
	}
}
</script>
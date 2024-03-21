<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function message_win_show(type){
	if(type=="create"){
		AOS.reset(message_create_form);
		message_create_win.show();
	}else{
		AOS.reset(message_update_form);
		var record = AOS.selectone(message_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		message_update_form.loadRecord(record);
		message_update_win.show();
	}
}
//状态渲染
function  fn_msg_state(value, metaData, record) {
			if (value === '1') {
				return '<img src="${cxt}/static/icon/email.png" />';
			} else if (value === '2') {
				return '<img src="${cxt}/static/icon/email_open.png" />';
			}
		 }
//渲染消息内容
function fn_balance_msg_note(value, metaData, record) {
			 var str= value.replace(/<div>/g, "");
				var str_= str.replace(/<br>/g, "");
				var _str_=str_.replace(/<\/div>/g, "");
				return _str_;
		 }
//渲染备注		 
function fn_remarks(value, metaData, record) {
			 var str= value.replace(/<div>/g, "");
				var str_= str.replace(/<br>/g, "");
				var _str_=str_.replace(/<\/div>/g, "");
				return _str_;
		 }
//已读
function y_read_(){
       message_grid_store.getProxy().extraParams = {
       msg_state:2
    };
    message_grid_store.loadPage(1);
}
//未读
function on_read_(){
       message_grid_store.getProxy().extraParams = {
       msg_state:1
    };
    message_grid_store.loadPage(1);
}		 

//新增
function message_create() {
	AOS.ajax({
		forms : message_create_form,
		url : 'messageService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			message_grid_store.reload();
			message_create_win.hide();
		}
	});
}
//加载数据
function message_query() {
	var params = AOS.getValue('query_form');
    message_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    message_grid_store.loadPage(1);
}
//修改
function message_update() {
	AOS.ajax({
		forms : message_update_form,
		url : 'messageService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			message_grid_store.reload();
			message_update_win.hide();
		}
	});
}
//表格列单击事件
function message_grid_click_(){
       var record= AOS.selectone(message_grid);
      	AOS.ajax({
      		params:{
				msg_id: record.data.msg_id
			},     
			url : 'filesManageService.paneldata',
			ok : function(data) {
			       window.open('do.jhtml?router=filesManageService.initpanel&juid=${juid}'+'&msg_id='+record.data.msg_id);
							message_grid_store.reload();
			   }
		});
}
//删除
function message_delete(){
	var selection = AOS.selection(message_grid, 'msg_id');
	var msg_state = AOS.selection(message_grid, 'msg_state');
	var num=0 ;
	var  msg_state_= msg_state.split(',');
       Ext.each(msg_state_,function(item){
          if(item==1){
            num=1;
            return false;
         }
     });
	var rows = AOS.rows(message_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条qa_message记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		if(num==1){
		AOS.confirm('存在未读消息,继续删除吗!', function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'messageService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				message_grid_store.reload();
			}
		  });
		 });
		}
		if(num==0){
		AOS.ajax({
			url : 'messageService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				message_grid_store.reload();
			}
		  });
		}
		
		
	});
}
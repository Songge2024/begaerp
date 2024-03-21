<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="测试工作台（临时）" base="http" lib="ext">


<div id="title"><br/>
</div>

<aos:body>

</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="anchor">
			<aos:panel  layout="hbox"  anchor="100% 50%" >
				<aos:layout type="hbox" align="stretch" />
				<aos:gridpanel title="我的任务" border="true" flex="1" autoScroll="true"
					hidePagebar="true" id="book_grid2"
					url="developerDeskService.page2" onrender="book_grid_query2" >
					<aos:hiddenfield name="handler_user_id" fieldLabel="修改人" />
					<aos:hiddenfield name="proj_id" fieldLabel="项目" />
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column header="ID" dataIndex="task_id" fixedWidth="50"
						hidden="true" />
					<aos:column header="所属项目" dataIndex="proj_name" />
					<aos:column header="任务名称" dataIndex="task_name" />
					<aos:column header="修改人" dataIndex="handler_user_id"
						fixedWidth="50" hidden="true" />
					<aos:column header="开始时间" dataIndex="plan_begin_time" type="date"
						format="Y-m-d" fixedWidth="80" />
					<aos:column header="截止时间" dataIndex="plan_end_time" type="date"
						format="Y-m-d" fixedWidth="80" />
					<aos:column header="级别" dataIndex="task_level"
						rendererFn="fn_level" fixedWidth="50" align="center" />
					<aos:column header="状态" dataIndex="state" rendererFn="fn_state1"
						fixedWidth="60" align="center" />
				</aos:gridpanel>

				<aos:gridpanel title="我的缺陷" border="true" flex="1" autoScroll="true"
					hidePagebar="true" id="book_grid4" 
					url="developerDeskService.page5" onrender="book_grid_query4">
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:hiddenfield name="create_man" fieldLabel="创建人" />
					<aos:hiddenfield name="proj_id" fieldLabel="项目" />
					<aos:column header="ID" dataIndex="bug_id" fixedWidth="50"
						hidden="true" />
					<aos:column header="所属项目" dataIndex="proj_name" />
					<aos:column header="缺陷模块" dataIndex="dm_name" fixedWidth="80" />
					<aos:column header="缺陷问题" dataIndex="bug_name" />
					<aos:column header="处理人" dataIndex="deal_man" fixedWidth="80"
						align="center" />
					<aos:column header="状态" dataIndex="state" rendererFn="fn_state"
						fixedWidth="60" />
				</aos:gridpanel>
			</aos:panel>


			<aos:panel  layout="hbox" anchor="100% 50%">
			<aos:layout type="hbox" align="stretch" />
				<aos:gridpanel title="我的日报" border="true" hidePagebar="true"  flex="1" autoScroll="true"
					id="book_grid1" url="developerDeskService.page"
					onrender="book_grid_query">
					<aos:hiddenfield name="update_user_id" fieldLabel="修改人" />
					<aos:hiddenfield name="begin_time" fieldLabel="从" editable="false" />
					<aos:hiddenfield name="end_time" fieldLabel="到" editable="false" />
					<aos:menu>
						<aos:menuitem text="提交" onclick="fn_submit" icon="up2.png" />
					</aos:menu>
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column header="日报编码" dataIndex="id" hidden="true" />
					<aos:column header="日报时间" dataIndex="daily_time" type="date"
						format="Y-m-d " fixedWidth="80" align="center" />
					<aos:column header="星期" dataIndex="week_day" fixedWidth="60"
						align="center" />
					<aos:column header="日报名称" dataIndex="name" fixedWidth="258"
						hidden="true" />
					<aos:column header="日报内容原" dataIndex="descc" fixedWidth="450"
						hidden="true" />
					<aos:column header="日报内容" dataIndex="desccc" />
					<aos:column header="日报描述" dataIndex="remark" fixedWidth="200"
						hidden="true" />
					<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="50"
						hidden="true" />
					<aos:column header="提交时间" dataIndex="update_time" type="date"
						format="Y-m-d H:i:s" fixedWidth="140" align="center" hidden="true" />
					<aos:column header="状态" dataIndex="state" rendererFn="flag"
						fixedWidth="50" align="center" />
				</aos:gridpanel>


				<aos:gridpanel title="我的评审" border="true" hidePagebar="true" flex="1" autoScroll="true"
					id="book_grid3"  url="developerDeskService.page3"
					onrender="book_grid_query3">
					<aos:hiddenfield name="create_user_id" fieldLabel="修改人" />
					<aos:hiddenfield name="proj_id" fieldLabel="项目" />
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column header="主题" dataIndex="theme" />
					<aos:column header="开始时间" dataIndex="begin_date" type="date"
						format="Y-m-d H:i:s" fixedWidth="140" />
					<aos:column header="结束时间" dataIndex="end_date" type="date"
						format="Y-m-d H:i:s" fixedWidth="140" />
					<aos:column header="评审方式" dataIndex="review_type"
						rendererFn="fn_type" fixedWidth="60" />
				</aos:gridpanel>
			</aos:panel>
	</aos:viewport>

	<script type="text/javascript">
//加载我的日报表格数据
function book_grid_query() {
	var proj_id = ${proj_id};
	var params = {proj_id : proj_id}
	book_grid1_store.getProxy().extraParams = params;
	book_grid1_store.loadPage(1);
}
//加载我的任务表格数据
function book_grid_query2() {
	var proj_id = ${proj_id};
	var params = {proj_id :proj_id}
	book_grid2_store.getProxy().extraParams = params;
	book_grid2_store.loadPage(1);
}
//加载我的评审表格数据
function book_grid_query3() {
	var proj_id = ${proj_id};
	var params = {proj_id :proj_id}
	book_grid3_store.getProxy().extraParams = params;
	book_grid3_store.loadPage(1);
}
//加载我的缺陷表格数据
function book_grid_query4() {
	var proj_id = ${proj_id};
	var params = {proj_id : proj_id}
	book_grid4_store.getProxy().extraParams = params;
	book_grid4_store.loadPage(1);
}

function fn_submit(){
	//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
	var record = AOS.selectone(AOS.get('book_grid1'));
	if(record.data.state ==='1002'){
		AOS.tip('该日报已提交。');
		return;
	}else{
	var record = AOS.selectone(AOS.get('book_grid1'));
	var msg =  AOS.merge('确认要提交日报【{0}】吗？', record.data.name);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'developerDeskService.submit',
			params:{
				id: record.data.id
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				AOS.get('book_grid1').getStore().reload();
			}
		});
	});
}}

//改变颜色
function flag(value, metaData, record) {
		if (value == '1002') {
			return "<span style='color:green; font-weight:bold'>提交</span>";
		}
		else{
			return "<span style='color:red; font-weight:bold'>草稿</span>";
		}
		return value;
	}
	
function fn_level(value, metaData, record) {
	if (value == '1010') {
		return "一般";
	}else if(value == '1020'){
		return "急";
	}else if(value == '1030'){
		return "加急";
	}else if(value == '1040'){
		return "特急";
	}
	return value;
}

function fn_state(value, metaData, record) {
	if (value == '1000') {
		return "<span style='color:red;font-weight:bold' >未解决</span>";
	}else if(value == '1001'){
		return "已解决";
	}else if(value == '1002'){
		return "<span style='color:green;font-weight:bold' >延期处理</span>";
	}else if(value == '1003'){
		return "关闭";
	}else if(value == '1004'){
		return "拒绝";
	}
	return value;
}

function fn_state1(value, metaData, record) {
	if (value == '1006') {
		return "已删除";
	}else if(value == '1002'){
		return "<span style='color:green;font-weight:bold' >已发布</span>";
	}else if(value == '1003'){
		return "<span style='color:blue;font-weight:bold' >已接收</span>";
	}else if(value == '1004'){
		return "<span style='color:red;font-weight:bold' >已完成</span>";
	}else if(value == '1005'){
		return "已关闭";
	}
	return value;
}

function fn_type(value, metaData, record) {
	if (value == '1') {
		return "会议";
	}else if(value == '2'){
		return "在线";
	}else if(value == '3'){
		return "邮件";
	}
	return value;
}

</script>
</aos:onready>


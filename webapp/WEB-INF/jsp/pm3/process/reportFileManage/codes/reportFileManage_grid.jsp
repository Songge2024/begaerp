<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="reportFileManage_grid" 
	url="reportFileManageService.page" 
	forceFit="true" 
	region="center"  
	bodyBorder="1 0 1 0"
  >
	<aos:menu>
		<aos:menuitem text="下载" onclick="g_acount_down" icon="down.png" />
		<aos:menuitem text="批量打包下载" onclick="g_zip_down" icon="zipdown.png" />
		<aos:menuitem xtype="menuseparator" />
		<aos:menuitem text="刷新" onclick="#reportFileManage_grid_store.reload();" icon="refresh.png" />
	</aos:menu>

	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="文件列表" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:combobox id="id_file_year" name="c_file_year" dicField="re_file_year" fieldLabel="年份" labelWidth="45" emptyText="年份"
			selectAll="true" width="150"
			onchange="reportFileManage_query" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:combobox id="id_file_type" name="c_file_type" dicField="re_file_type" fieldLabel="文件类型" labelWidth="68" emptyText="文件类型"
			selectAll="true" width="200"
			onchange="reportFileManage_query" />
		<aos:dockeditem xtype="tbseparator" />
			
		<aos:dockeditem text="下载" icon="down.png"  onclick="g_acount_down" />
		<aos:dockeditem text="批量打包下载" icon="zipdown.png"  onclick="g_zip_down" />
	</aos:docked>

	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<aos:column header="文件标题" dataIndex="re_file_title" width="400"/>
	<aos:column header="上传者" dataIndex="create_user_name" width="100"/>
	<aos:column header="上传日期" dataIndex="create_time" width="100"  align="center" type="date" format="Y-m-d"/>
	<aos:column header="文件大小" dataIndex="re_file_size" width="100" align="right"/>
	<aos:column header="文档类型" dataIndex="re_file_type" width="100" rendererFn= "file_type" align="center"/>
	<aos:column header="年份" dataIndex="re_file_year" width="100" align="center"/>
	
	<aos:column header="下载次数" dataIndex="down_num" fixedWidth="100"  align="right" hidden="true"/>
	<aos:column header="提交状态" dataIndex="state" fixedWidth="100"  align="center" rendererFn= "submit_state" hidden="true"/><!-- 0 未提交 1 已提交 -->
	<aos:column header="提交给" dataIndex="submit_user_name" fixedWidth="80"  hidden="true"/>
	<aos:column header="提交给" dataIndex="submit_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="文件ID" dataIndex="re_file_id" fixedWidth="300" hidden="true"/>
	<aos:column header="上传文件路径" dataIndex="re_file_path" fixedWidth="100" hidden="true"/>
	<aos:column header="上传文件URL" dataIndex="re_file_url" fixedWidth="100" hidden="true"/>
	<aos:column header="上传文件备注" dataIndex="re_file_mark" fixedWidth="100" hidden="true"/>
	<aos:column header="上传人ID" dataIndex="create_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100"  hidden="true"/>
	<aos:column header="排序号" dataIndex="sort_no" fixedWidth="100"  hidden="true"/>
</aos:gridpanel>

<script type="text/javascript">
	//选择文件列表查询
	function reportFileManage_query(){
		var params = {};
		
		var record = AOS.selectone(aos_user_tree);
		if(!AOS.empty(record)){
	 		params.user_param = record.raw.id;
		}
		
		//获取选中的年份
		var re_file_year = id_file_year.getValue();
		if(!AOS.empty(re_file_year)){
			params.re_file_year = re_file_year;
		}
		
		//获取选中的文件类型
		var re_file_type = id_file_type.getValue();
		if(!AOS.empty(re_file_type)){
			params.re_file_type = re_file_type;
		}
		reportFileManage_grid_store.getProxy().extraParams = params;
		reportFileManage_grid_store.loadPage(1);
	}
	
	
	
	//下载
	function g_acount_down(){
		var selection = AOS.selection(reportFileManage_grid, 're_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件!');
			return;
		}
		var rows = AOS.rows(reportFileManage_grid);
		if(rows > 1){
			AOS.tip('请只选择一条需要下载的文件!');
		return;
		}
		var re_file_path = AOS.selection(reportFileManage_grid, 're_file_path');
		var re_file_title = AOS.selection(reportFileManage_grid, 're_file_title');
		var re_file_id = AOS.selection(reportFileManage_grid, 're_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		AOS.file('do.jhtml?router=reportFileManageService.downloadFile&juid=${juid}&re_file_path='+re_file_path+'&re_file_title='+re_file_title+'&re_file_id='+re_file_id);
	}
	 

	function g_zip_down(){
		var proj_name = id_file_type.getRawValue();
		var selection = AOS.selection(reportFileManage_grid, 're_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要批量打包下载的文件!');
			return;
		}
		
		var rows = AOS.rows(reportFileManage_grid);
		var msg =  AOS.merge('确认要批量打包下载选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.file('do.jhtml?router=reportFileManageService.downloadFileByZip&juid=${juid}&proj_name='+proj_name+'&aos_rows='+selection);
		});
		
	}
	 
	
	function submit_state(value, metaData, record) {
		if (value == '1') {
			return "<span style='color:green; font-weight:bold'>已提交</span>";
		}
		else{
			return "<span style='color:red; font-weight:bold'>未提交</span>";
		}
		return value;
	}
	
	function file_type(value, metaData, record) {
		if (value == '1') {
			value = "周总结";
		}
		if (value == '2') {
			value = "月总结";
		}
		if (value == '3') {
			value = "季度总结";
		}
		if (value == '4') {
			value = "年度总结";
		}
		return value;
	}
	
	//默认选中第一个项目
	window.onload = function combobox_select(){
		AOS.get('id_file_type').setValue('4');
		AOS.get('id_file_year').setValue('2018');
	}
</script>
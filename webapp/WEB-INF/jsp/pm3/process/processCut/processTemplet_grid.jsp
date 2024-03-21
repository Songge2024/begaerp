<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<%-- <aos:gridpanel  id="processCut_grid"
	url="processService.loadGridInfo"
	forceFit="true"
	region="center"
	border="true"
	columnLines="true"
	onitemclick="cutProcess_onSelect"
	onrender="process_query"
	features="Ext.create('Ext.grid.feature.Grouping',{groupHeaderTpl: '{rootdir_name}'})"> --%>
	<!--  features="grouping"   -->
	<aos:treepanel id="processCut_grid" region="west" bodyBorder="0 1 0 0" singleClick="false" rootVisible="false"  
	url="processService.getProcessListTreeData" onitemclick="processFiletype_query" cascade="true">
	<aos:menu>
	<aos:menuitem text="新增过程" onclick="processCut_add" icon="add.png" />
	<aos:menuitem text="删除过程" onclick="processCut_delete" icon="del.png" />
	<%-- <aos:menuitem text="迭代"  onclick="iteration_add" icon="add2.png" /> --%>
	<aos:menuitem text="显示全部输出文档" onclick="processCut_showAll" icon="redo.png" />
	<aos:menuitem xtype="menuseparator" />
	<%-- <aos:menuitem text="裁剪过程保存" onclick="processCut_save" icon="save.png" /> --%>
	</aos:menu>
	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="项目过程裁剪" />
		<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增过程" icon="add.png" onclick="processCut_add" />
	<aos:dockeditem text="删除过程" icon="del.png" onclick="processCut_delete" />
	<aos:dockeditem text="显示全部文件类型" icon="redo.png" onclick="processCut_showAll" />
	<aos:dockeditem xtype="tbfill" />
	<%-- <aos:dockeditem text="裁剪过程保存" icon="save.png" onclick="processCut_save" /> --%>
	
	</aos:docked>
	</aos:treepanel>
	<%-- <aos:selmodel type="checkbox" mode="multi" />
	<aos:plugins>
			clicksToEdit可以控制是单击还是双击进入编辑模式
			<aos:editing id="sort_no_id_plugin" clicksToEdit="2" onedit="processCut_save"  autoCancel="false" onbeforeedit="fn_beforeedit" ptype="rowediting" />
	</aos:plugins>
	<aos:column type="rowno" />
	<aos:column header="过程id"  dataIndex="process_id" width="150" hidden="true"  />
	<aos:column header="过程模板id"  dataIndex="templet_id" width="150"  hidden="true"   >
	<aos:textfield name ="templet_id" id = "templet_id"/>
	</aos:column>
	<aos:column header="所属子目录id"  dataIndex="process_subdir_id" width="150"  hidden="true"  />
	<aos:column header="所属跟目录id"  dataIndex="rootdir_id" width="150"  hidden="true" />
	<aos:column header="过程阶段名称"  dataIndex="rootdir_name"  width="200" />
	<aos:column header="活动名称" dataIndex="process_name"  width="200"/>
	<aos:column header="排序号" dataIndex="sort_no" width="50" align="center">
	<aos:numberfield name ="sort_no" minValue="0"   maxValue="2147483647" >
	</aos:numberfield>
	</aos:column> --%>
<%-- </aos:gridpanel> --%>

<script type="text/javascript">
//新增过程
function processCut_add(){
	var proj_id = AOS.getValue('id_proj_name');
	if(proj_id==undefined||proj_id==""){
		AOS.tip('请先选择一个项目!');
		return ;
	}
	/* var processCutGrid =  AOS.select(processCut_grid);
	var select = AOS.selectone(processCut_grid);
	if(select.raw.a==undefined&&select.raw.b==undefined){
		console.log(select.raw.a+'第一个'+select.raw.b);
		AOS.reset(processTemplet_add_form);
		AOS.setValue('processTemplet_add_form.proj_id',proj_id);
		subdir_id_store.load();
		processTemplet_add_win.show();
	}else if(select.raw.a!=undefined&&select.raw.b==undefined){
		console.log(select.raw.a+'第二个'+select.raw.b);
		
  		AOS.setValue('processTemplet_add_form.rootdir_id',Number(select.raw.parentId));
  		AOS.setValue('processTemplet_add_form.process_subdir_id',Number(select.raw.a));
  		AOS.setValue('processTemplet_add_form.proj_id',proj_id);
  		subdir_id_store.getProxy().extraParams = {
			rootdir_id : Number(select.raw.parentId)
		};
		subdir_id_store.load();
		processTemplet_add_win.show();
	}else if(select.raw.a==undefined&&select.raw.b!=undefined){
		console.log(select.raw.a+'第三个'+select.raw.b);
		AOS.reset(processTemplet_add_form);
  		AOS.setValue('processTemplet_add_form.rootdir_id',Number(select.raw.id));
  		AOS.setValue('processTemplet_add_form.proj_id',proj_id);
  		subdir_id_store.getProxy().extraParams = {
			rootdir_id : Number(select.raw.id)
		}; 
		
	}*/
	AOS.reset(processTemplet_add_form);
	AOS.setValue('processTemplet_add_form.proj_id',proj_id);
subdir_id_store.load();
processTemplet_add_win.show();
}
//删除过程
function processCut_delete(){
	var record = AOS.select(processCut_grid);
	var selection = AOS.selection(processCut_grid, 'id');
	if(AOS.empty(record)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var proj_id = AOS.getValue('process_project_form').proj_id;
	var rows = AOS.rows(processCut_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条项目过程记录吗？', rows-1);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
		//	AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'processService.delete',
			params:{
				aos_rows: selection,
				proj_id : proj_id
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				processCut_grid_store.reload();
				processCutFiletype_grid_store.loadPage(1);
			}
		});
	});
}
//选择
function process_onselect(obj){
	var record=AOS.select(processCut_grid);
	record[0].set('rootdir_id',obj.valueModels[0].data.value);
	var rootdir_id = obj.valueModels[0].data.value;
		process_name_store.getProxy().extraParams = {
			rootdir_id : rootdir_id
		};
		process_name_store.load();
}

//选择
function process_onselect1(obj){
	var record=AOS.select(processCut_grid);
	record[0].set('process_subdir_id',obj.valueModels[0].data.value);
}

//单击过程列表
function cutProcess_onSelect() {
	if (AOS.mrows(processCutFiletype_grid) != 0) {
		AOS.tip('裁剪文件类型列表数据有变动,请先进行保存!');
		return;
	}
	var proj_id = AOS.getValue('process_project_form.proj_id')
	var select = AOS.select(processCut_grid)
	var subdir_id = select[0].data.process_subdir_id;
	var params ={subdir_id : subdir_id,proj_id : proj_id};
   //	processCutFiletype_grid_store.getProxy().extraParams = params;
   	processCutFiletype_grid_store.reload({
   		params : {
   			subdir_id : subdir_id,
   			proj_id : proj_id
   		}
   	});
}

//加载
function process_query(grid) {
	
	 var colIndexArray = [0,1,2,3,4,5];
	  mergeGrid(processCut_grid,colIndexArray,false);
			
	}
//显示全部文件类型	
function processCut_showAll(){
	var proj_id = AOS.getValue('id_proj_name');
	if(proj_id==undefined){
		AOS.tip('请先选择一个项目!');
		return ;
	}
	//var select = AOS.select(processCut_grid)
	//var subdir_id = select[0].data.process_subdir_id;
	processCut_grid_store.reload();
   	processCutFiletype_grid_store.loadPage(1);
}

//裁剪过程保存
function processCut_save(editor, e){
	if (!e.record.dirty) {
		AOS.tip('数据没变化，提交操作取消。');
		return;
	}
	var sort_no =e.record.data.sort_no;
	 var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/  
     if (!re.test(sort_no))
   		 {
       AOS.info('请输入数字!')
       return;
     }
	var process_id =AOS.select(processCut_grid)[0].data.process_id;
	AOS.ajax({
		params : {
			sort_no : sort_no,
			process_id : process_id
		},
		//url : 'processService.saveProcessGrid',
		url : 'processService.updateProcessGridSortNo',
		ok : function(data) {
			//AOS.tip(data.appmsg);
			processCut_grid_store.reload();
		}
	});

}
//单击
function processFiletype_query() {
	
	/* if (AOS.mrows(processCutFiletype_grid) != 0) {
		AOS.tip('裁剪文件类型列表数据有变动,请先进行保存!');
		return;
	}
	var proj_id = AOS.getValue('process_project_form.proj_id')
	var select = AOS.select(processCut_grid)
	var subdir_id = select[0].data.process_subdir_id;
	var params ={subdir_id : subdir_id,proj_id : proj_id};
   //	processCutFiletype_grid_store.getProxy().extraParams = params;
   	processCutFiletype_grid_store.reload({
   		params : {
   			subdir_id : subdir_id,
   			proj_id : proj_id
   		}
   	}); */
	//获取项目ID
	var proj_id = AOS.getValue('process_project_form.proj_id')
	if(AOS.empty(proj_id)){ 
		return; 
	}
	
	//获取项目过程树节点
	var record = AOS.selectone(processCut_grid);
	if(!AOS.empty(record)){
		if(record.raw.a==undefined&&record.raw.b==undefined){
			var params={proj_id : proj_id}
		}else if(record.raw.a==undefined&&record.raw.b!=undefined){
			var params={proj_id : proj_id}
			params.rootdir_id = record.raw.b;
		}else{
		var params = { proj_id : proj_id };
 		params.subdir_id = record.raw.a;
		}
	}
	var rootdir_id = AOS.selectone(processCut_grid).raw.parentId;
	var subdir_id = AOS.selectone(processCut_grid).raw.a;
	processCutFiletype_grid_store.getProxy().extraParams = params;
	processCutFiletype_grid_store.loadPage(1);
	filetype_id_store.getProxy().extraParams = {
		rootdir_id : rootdir_id,
		subdir_id : subdir_id
	};
	filetype_id_store.load();
  	//加载文件列表
	//processFileUploadByProc_query();
} 
function fn_beforeedit(obj, e) {
	var editing = processCut_grid.getPlugin('sort_no_id_plugin');
	var rowEditor = editing.getEditor();
	//这行是修复行编辑的一个bug，当数据校验时候如果初始时数据不合法，则数据纠正后保存按钮也不能用的bug。
	rowEditor.on('fieldvaliditychange', rowEditor.onFieldChange,
			rowEditor);
	//form = editing.editor.form;
	//form.findField('sex').setValue('1');
	//根据当前行的数据控制行编辑器
	/*
	var card_type = e.record.data.card_type;
	if(card_type == '2'){
		 AOS.read(form.findField('name'));
		 AOS.read(form.findField('balance'));
	}else{
		 AOS.edit(form.findField('name'));
		 AOS.edit(form.findField('balance'));
	} */

}

</script>

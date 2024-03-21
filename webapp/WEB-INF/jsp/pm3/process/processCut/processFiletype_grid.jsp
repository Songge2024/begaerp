<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="processCutFiletype_grid" 
	url="processService.loadFiletypeGridInfo" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  	columnLines="true"
  >
 <!--  onrender="processCutFiletype_query"  -->
  	<aos:menu>
	<aos:menuitem text="新增输出文档" icon="add.png" onclick="processFiletype_add" />
	<aos:menuitem text="删除输出文档" icon="del.png" onclick="processFileType_delete"/>
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="裁剪文件保存" icon="save.png"  onclick="processFiletype_save"/>
	</aos:menu>
	<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目输出文档" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增输出文档" icon="add.png" onclick="processFiletype_add" />
	<aos:dockeditem text="删除输出文档" icon="del.png" onclick="processFileType_delete" />
	<aos:dockeditem xtype="tbfill" />
	<aos:dockeditem text="保存" icon="save.png" onclick="processFiletype_save" />
	</aos:docked>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:plugins>
			<%-- clicksToEdit可以控制是单击还是双击进入编辑模式 --%>
			<aos:editing id="id_plugin" clicksToEdit="1"  ptype="cellediting" />
	</aos:plugins>
	<aos:column type="rowno" />
	<%@ include file="processFiletype_columns.jsp"%>
</aos:gridpanel>
<script type="text/javascript">
//新增文件
function processFiletype_add(){
	var rows = AOS.rows(processCut_grid);
	console.log(rows);
	if(rows-1!=1){
		AOS.tip('请选择一条需要新增输出文档的数据!');
		return;
		}
	var proj_id = AOS.getValue('process_project_form').proj_id;
	AOS.reset(processFiletype_add_form);
	AOS.setValue('processFiletype_add_form.process_id',AOS.select(processCut_grid)[1].raw.id);
	AOS.setValue('processFiletype_add_form.subdir_id',AOS.select(processCut_grid)[1].raw.a);
	AOS.setValue('processFiletype_add_form.proj_id',proj_id);
	filetype_id_store.getProxy().extraParams = {
		rootdir_id : AOS.select(processCut_grid)[1].raw.parentId,
		subdir_id : AOS.select(processCut_grid)[1].raw.a
	};
	filetype_id_store.load();
	processFiletype_add_win.show();

}
//删除文件
function processFileType_delete(){
	var record = AOS.select(processCutFiletype_grid);
	var selection = AOS.selection(processCutFiletype_grid, 'proc_filetype_id');
	var proj_id = AOS.getValue('process_project_form').proj_id;
	if(AOS.empty(record)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(processCutFiletype_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条项目输出文档记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
		//	AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'processFiletypeService.delete',
			params:{
				aos_rows: selection,
				proj_id : proj_id
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				processCut_grid_store.reload();
				processCutFiletype_grid_store.reload();
			}
		});
	});
}
//裁剪保存
function processFiletype_save(){

	if (AOS.mrows(processCutFiletype_grid) == 0) {
				AOS.tip('数据没变化，提交操作取消。');
				return;
			}
			AOS.ajax({
				params : {
					aos_rows : AOS.mrs(processCutFiletype_grid)
				},
				url : 'processFiletypeService.saveFiletypeGrid',
				ok : function(data) {
					AOS.tip(data.appmsg);
					processCutFiletype_grid_store.reload();
				}
			});
	
	
}
//文件类型加载
function processCutFiletype_query() {
	var params ={};
    processCutFiletype_grid_store.getProxy().extraParams = {
   	proj_id  : -1
    };
    processCutFiletype_grid_store.loadPage(1);
}

function filetype_onselect(obj){
	AOS.setValue('proc_filetype_name',obj.rawValue);
}
</script>
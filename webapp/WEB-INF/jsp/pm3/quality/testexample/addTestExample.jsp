<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" autoScroll="true" >
			<aos:formpanel id="example_form" layout="column" center="true" width="855"
				 labelWidth="90" msgTarget="qtip" padding="10 10 10 10 " onrender="load_from">
				<aos:hiddenfield name="standard_id" fieldLabel="缺陷id" />
				<aos:fieldset title="基本信息">
					<aos:combobox fieldLabel="项目" name="proj_id"  margin="5" editable="false" allowBlank="false" columnWidth="0.5" 
	 					url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" onchange="on_public_com" />
					<aos:combobox fieldLabel="模块" name="stand_id"  margin="5" editable="false" allowBlank="false" columnWidth="0.5" 
						url="moduleDivideService.listModuleDivideComboBox" />
					<aos:textfield name="standard_name" fieldLabel="用例名称" allowBlank="false"
						emptyText="请输入测试用例名称" columnWidth="0.50" margin="5"
						maxLength="20"/>
					<aos:combobox fieldLabel="用例类型" name="standard_type" columnWidth="0.50" 
						margin="5" allowBlank="false">
						<aos:option value="功能测试" display="功能测试" />
						<aos:option value="集成测试" display="集成测试" />
					</aos:combobox>
				</aos:fieldset>
				<aos:fieldset title="前置条件" >
						 <aos:htmleditor name="precondition"  allowBlank="false"
							columnWidth="1" padding="5 5 5 5"/>
				</aos:fieldset>
				<aos:fieldset title="测试步骤">
						 <aos:htmleditor name="standard_detail"  allowBlank="false"
							columnWidth="1" padding="5 5 5 5" />
				</aos:fieldset>
				<aos:fieldset title="状态" >
					<aos:combobox fieldLabel="是否通过" name="pass_or_fail"
						columnWidth="0.50" padding="0 10 10 0">
						<aos:option value="1" display="是" />
						<aos:option value="0" display="否" />
					</aos:combobox>
					<aos:combobox fieldLabel="是否回归测试" name="return_state" 
						columnWidth="0.50" padding="0 10 10 0">
						<aos:option value="1" display="是" />
						<aos:option value="0" display="否" />
					</aos:combobox>
				</aos:fieldset>
				<aos:fieldset title="结果" >
				<aos:textareafield fieldLabel="预期结果" name="expected_results"  allowBlank="false"
					 columnWidth="1" padding="5 5 5 0" maxLength="200"/>
				<aos:textareafield fieldLabel="备注" name="actual_results" columnWidth="1" 
					padding="5 5 5 0" maxLength="200"/>
				</aos:fieldset>
				<aos:docked dock="bottom" ui="footer" id="button" >
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="example_form_save" text="保存" icon="ok.png"
						tooltip="保存" />
					<aos:dockeditem onclick="history.back();" text="关闭" icon="close.png" />
				</aos:docked>
				
			</aos:formpanel>
		<script type="text/javascript">
			//新增/修改测试用例保存
	        function example_form_save() {
	        	AOS.ajax({
					forms : example_form,
					url : example_form.editModel=="update" ? 'testExampleService.update':'testExampleService.create',
					ok : function(data) {
						AOS.tip(data.appmsg);
						var standard_id = AOS.getValue('example_form.standard_id');
						//在当前页面跳转
						if(example_form.editModel == 'update')
							window.location.href='do.jhtml?router=testExampleService.init&juid=${juid}&standard_id='+standard_id;
						else
							window.location.href='do.jhtml?router=testExampleService.init&juid=${juid}&type=create';
					}
				});
	        }
	        
	        //加载form
	        function load_from(){
		        if(!AOS.empty('${id}')){
		        	 document.title = '修改测试用例';  
		        	example_form.editModel = "update";
		        	AOS.ajax({
							url : 'testExampleService.get',
							params:{
								id: '${id}'
							},
							ok : function(data) {
								AOS.setValues(example_form,data);
								AOS.setValue("example_form.proj_id",Number(data.proj_id));
								//下拉表单的value为字符串类型，将int值转换类型重新set
								AOS.setValue("example_form.pass_or_fail",data.pass_or_fail+"");
	 							AOS.setValue("example_form.return_state",data.return_state+"");
	 							if('${particulars}'=='true'){
		 							document.title = '测试用例详情';  
		 							//批量只读
									AOS.reads(example_form, 'proj_id,stand_id,standard_name'
										+',standard_type,precondition,standard_detail,pass_or_fail,return_state,expected_results,actual_results');
		 							var from = document.getElementById("example_form");
									from.setAttribute("align","center");
									var button = document.getElementById("button");
									button.setAttribute("hidden","true");
	 							}
							}
						});
		        }else{
		        	var id = '${proj_id}';
	        		AOS.setValue("example_form.proj_id",Number(id));
		        	document.title = '新增测试用例';
		        }
	        }
	//项目下拉框添加变更事件
	function on_public_com(me, records){
		var proj_id = me.getValue();
			AOS.get('example_form.stand_id').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
			AOS.get('example_form.stand_id').getStore().load();
	}
		</script>
	</aos:viewport>
</aos:onready>

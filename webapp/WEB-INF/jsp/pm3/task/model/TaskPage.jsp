<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">
	/**
	 * 任务模块页面对象
	 */
	Ext.define("TaskPage", {
		mixins : {
			observable : 'Ext.util.Observable'
		},
		api:{
			//getUserProjects:"taskService.getUserProjects",
			//getProjectUsers:"taskService.getProjectUsers",
			//getProjectModels:"taskService.getProjectModels",
			//getProjectDemands:"taskService.getProjectDemands"
			
			getUserProjects:"projCommonsService.listComboBoxUerid",
			getProjectUsers:"projCommonsService.listComboBoxProjId",
			getProjectModels:"moduleDivideService.listModuleDivideComboBox",
			getProjectDemands:"demandActionService.listdemand",
			getProjectUsersAll:"projCommonsService.listAllComboBoxProjId" //查询当前项目的所有用户，包含离职人员
		},
		params:{},
		userProjectsReady:false,
		projectUsersReady:false,
		projectDemandsReady:false,
		projectModelsReady:false,
		projctUsersAllReady:false,
		projects : [],//当前登录人员的项目列表
		projectUsers : [],//选择的项目成员列表
		projectDemands : [],//选择的项目需求列表
		projectModules : [],//选择的项目模块列表
		projectUsersAll : [], //查询当前项目的所有用户,包含离职人员
		constructor : function(config) {
			this.mixins.observable.constructor.call(this, config);
			var me = this;
			this.addEvents({
				"ready":true,
				'userProjectsReady' : true,
				'projectUsersReady' : true,
				'projectDemandsReady' : true,
				'projectModelsReady' : true,
				'projectUsersAllReady' : true
			});
			this.on('userProjectsReady' ,function(){
				me.userProjectsReady=true;
				if(me.checkReady()){
					me.fireEvent("ready");
				}
			});
			this.on('projectUsersReady' ,function(){
				me.projectUsersReady=true;
				if(me.checkReady()){
					me.fireEvent("ready");
				}
			});
			this.on('projectDemandsReady',function(){
				me.projectDemandsReady=true;
				if(me.checkReady()){
					me.fireEvent("ready");
				}
			});
			this.on('projectModelsReady',function(){
				me.projectModelsReady=true;
				if(me.checkReady()){
					me.fireEvent("ready");
				}
			});
			this.on('projectUsersAllReady' ,function(){
				me.projectUsersAllReady=true;
				if(me.checkReady()){
					me.fireEvent("ready");
				}
			});
		},
		//重新加载指定项目基础数据
		initParams:function(params){
			Ext.apply(this.params, params||{});
			var loadProjectInfo=AOS.empty(loadProjectInfo)?true:false;
			this.projectUsersReady=false;
			this.projectDemandsReady=false;
			this.projectModelsReady=false;
			this.projectUsersAllReady=false;
			if(loadProjectInfo){
				this.getProjectUsers(this.params);
				this.getProjectDemands(this.params);
				this.getProjectModels(this.params);
				this.getProjectUsersAll(this.params);
			}
		},
		//检查页面初始数据是否已经准备好了
		checkReady:function(){
			return (this.projectUsersReady && this.projectDemandsReady && this.projectModelsReady);
		},
		//获得当前登录人任务列表
		getUserProjects : function() {
			var me = this;
			AOS.ajax({
				url : me.api.getUserProjects,
				ok : function(data) {
					me.projects = data;
					me.fireEvent("userProjectsReady", me, data);
				}
			});
		},
		//获得指定项目成员列表
		getProjectUsers : function(params) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			AOS.ajax({
				params : params,
				url : me.api.getProjectUsers,
				ok : function(data) {
					me.projectUsers = data;
					me.fireEvent("projectUsersReady", me, data);
				}
			});
		},
		//根据项目编码获得项目需求列表
		getProjectDemands : function(params) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			AOS.ajax({
				params : params,
				url : me.api.getProjectDemands,
				ok : function(data) {
					me.projectDemands = data;
					me.fireEvent("projectDemandsReady", me, data);
				}
			});
		},
		//根据项目编码获得项目模块列表
		getProjectModels : function(params) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			AOS.ajax({
				params : params,
				url : me.api.getProjectModels,
				ok : function(data) {
					me.projectModules = data;
					me.fireEvent("projectModelsReady", me, data);
				}
			});
		},
		//获得指定项目成员列表
		getProjectUsersAll : function(params) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			AOS.ajax({
				params : params,
				url : me.api.getProjectUsersAll,
				ok : function(data) {
					me.projectUsersAll = data;
					me.fireEvent("projectUsersAllReady", me, data);
				}
			});
		}
	});
	var CurrentTaskPage= new TaskPage();
</script>
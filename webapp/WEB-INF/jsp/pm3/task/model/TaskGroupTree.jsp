<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">
	/**
	 * 任务树对象
	 */
	Ext.define("TaskGroupTree", {
		mixins : {
			curd:"Remexs.Curd",
		},
		tree:null,
		api:{
			"get":"taskGroupService.get",
			"create":"taskGroupService.create",
			"update":"taskGroupService.update",
			"deleted":"taskGroupService.delete",
			"getTreeData":"taskGroupService.getTreeData"
		},
		constructor : function(config) {
			this.mixins.curd.constructor.call(this, config);
			this.addEvents({
				"reload" : true,
				"afterreload" : true
			});
		},
		reload : function(params, callback) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			if (!me.fireEvent("reload", params)) {
				return;
			}
			AOS.ajax({
				url : me.api.getTreeData,
				params : params,
				ok : function(data) {
					me.tree.setRootNode(data);
					if (callback) callback();
					else me.fireEvent("afterreload", data);
				}
			});
		}
	});

</script>
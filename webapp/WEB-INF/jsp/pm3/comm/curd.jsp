<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">
	Ext.ns("Remexs");
	/**
	 * 定义公共方法 可通过代码混入到对象中
	 */

	Ext.define("Remexs.Curd", {
		mixins : {
			observable : 'Ext.util.Observable'
		},
		constructor : function(config) {
			this.mixins.observable.constructor.call(this, config);
			this.addEvents({
				"create" : true,
				"deleted" : true,
				"update" : true,
				"get" : true
			});
		},
		params:{},//缓存参数，所有后台请求都会包含的参数
		//增删改查url	
		api : {
			update : "",
			create : "",
			create : "",
			deleted : "",
		},
		init:function(config){
			Ext.apply(this, config || {});
		},
		//初始化缓存参数
		initParams : function(params) {
			Ext.apply(this.params, params || {});
		},
		//重新加载数据
		reload : function(params, callback) {

		},
		ajax : function(url,params,callback){
			var me = this;

			/*var params1 = Ext.apply(params || {}, this.params);*/
			AOS.ajax({
				params : params,
				url : url,
				ok : function(data) {
					if (callback) callback.call(me, data)
					else me.reload();
				}
			});
		},
		//新增
		create : function(params, callback) {
			var me = this;
			if (!me.fireEvent("create", me, params)) {
				return;
			}
			me.ajax(me.api.create, params, callback);
		},
		//修改处理
		update : function(params, callback) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			if (!me.fireEvent("update", me, params)) {
				return;
			}
			me.ajax(me.api.update, params, callback);
		},
		//删除处理
		deleted : function(params, callback) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			if (!me.fireEvent("deleted", me, params)) {
				return;
			}
			me.ajax(me.api.deleted, params, callback);
		},
		//获得指定数据
		get : function(params, callback) {
			var me = this;
			var params = Ext.apply(params || {}, this.params);
			if (!me.fireEvent("get", me, params)) {
				return;
			}
			AOS.ajax({
				params : params,
				url : me.api.get,
				ok : function(data) {
					if (callback) callback.call(me, data);
				}
			});
		}
	});
</script>
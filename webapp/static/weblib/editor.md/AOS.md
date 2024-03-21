# AOS.js公共函数
1. ####AOS.select(component , checkFields, checkValues)
 ######----获得表格中选中的记录
		params:
			component：表格/树组件
			checkFields：过滤字段
			checkValues：过滤字段的值
		return: records
		examples:
			AOS.select（grid,"name,age","张三，20"）
2. ####AOS.selectone(component, force)
######----返回树或表格当前选中行的Record对象。
		params:
			pObj：表格/树组件
			force：强制返回选中行的第一行，无提示信息
		return: record
		examples:
3. ####AOS.selection（component, field, checkFields, checkValues）
######----提取树或表格选中行的某一字段值以逗号分割
		params:
			comp：表格/树组件
			field：待查找的列名
			checkFields：过滤字段
			checkValues：过滤字段的值
		return: string
		examples:
			AOS.selection（grid,'id'，"name,age","张三，20"）
			return "1,2,3";
4.  ####AOS.SelectionInDataArray（array, field, checkFields, checkValues）
######----提取数组中某一列的值
		params:
			array：数组对象
			field：待查找的列名
			checkFields：过滤字段
			checkValues：过滤字段的值
		return: string
		examples:
			var array=[
				{id:"1",name:"张三",age:"20"}
				,{id:"1",name:"张三",age:"20"}
			];
			AOS.SelectionInDataArray（array,'id'，"name,age","张三，20"）
			return "1,2,3";
5. ####AOS.findOneInArray（array, checkFields, checkValues）
######----根据键值对从数组中获得一条记录
		params:
			array：数组对象
			checkFields：过滤字段
			checkValues：过滤字段的值
			return: object
			examples:
				var array=[
					{id:"1",name:"张三",age:"20"}
					,{id:"1",name:"张三",age:"20"}
				];
				AOS.findOneInArray(array,"id,name,age","1,张三，20")
				return {id:"1",name:"张三",age:"20"};
6. ####AOS.findInArray（array, checkFields, checkValues）
######----根据键值对从数组中获得符合条件的记录
		params:
			array：数组对象
			checkFields：过滤字段
			checkValues：过滤字段的值
			return: array
			examples:
			var array=[
				{id:"1",name:"张三",age:"20"}
				,{id:"1",name:"张三",age:"20"}
			];
			AOS.findInArray(array,"id,name,age","1,张三，20")
			return [
				{id:"1",name:"张三",age:"20"}
				,{id:"1",name:"张三",age:"20"}
			];
7. ####AOS.findOne（records/component, checkFields, checkValues）
######----根据键值对从records/component中获得符合条件的记录
		params:
			records/component：records数组或表格组件
			checkFields：过滤字段
			checkValues：过滤字段的值
			return: record
8. ####AOS.find（records/component, checkFields, checkValues）
######----根据键值对从records/component中获得符合条件的记录集合
		params:
			records/component：records数组或表格组件
			checkFields：过滤字段
			checkValues：过滤字段的值
			return: records
9. ####AOS.mr（grid）
######----返回表格修改数据集合(含新增的和修改的)
		params:
			grid：表格组件
			return records
10. ####AOS.mrs（grid）
######----返回表格修改Json集合(含新增的和修改的)
		params:
			grid：表格组件
			return:json
11. ####AOS.recordsToArray（records）
######----将records转换成数组
		params:
			records：records集合
			return:array
12. ####AOS.mrows（grid）
######----返回表格修改行数
		params:
			grid：表格组件
			return:number
13. ####AOS.rows（grid）
######----返回表格或树选中行数
		params:
			grid：表格组件
			return:number
14. ####AOS.read（field）
######----将表单元素设置为只读模式。 提示：仅针对表单元素调用此方法，其它组件使用原生方法。
		params:
			field：form表单元素组件
15. ####AOS.reads（form, fieldNames）
######----批量将表单元素设置为只读模式
		params:
			form：表单组件
			fieldNames:表单元素组件名称（多个name值用逗号分割）
16. ####AOS.edit（field）
######----将表单元素设置为可编辑模式。 提示：仅针对表单元素调用此方法，其它组件使用原生方法。。
		params:
			field：form表单元素组件
17. ####AOS.edits（form,fieldNames）
######----批量将表单元素设置为编辑模式
		params:
			form：form表单组件
			fieldNames:表单元素组件名称（多个name值用逗号分割）
18. ####AOS.disable（field）
######----禁用表单元素。 提示：仅针对表单元素调用此方法，其它组件使用原生方法。
		params:
			field：form表单元素组件
19. ####AOS.disables（form,fieldNames）
######----批量将表单元素设置为禁用模式
		params:
			form：form表单组件
			fieldNames:表单元素组件名称（多个name值用逗号分割）
20. ####AOS.enable（field）
######----将表单元素设置为可启用模式。 提示：仅针对表单元素调用此方法，其它组件使用原生方法。。
		params:
			field：form表单元素组件
21. ####AOS.enables（form,fieldNames）
######----批量将表单元素设置为启用模式
		params:
			form：form表单元素组件
			fieldNames:表单元素组件名称（多个name值用逗号分割）
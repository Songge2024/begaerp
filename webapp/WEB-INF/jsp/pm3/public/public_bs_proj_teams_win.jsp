<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
//过滤项目id  如果需要过滤，请在主页面设置 pageContext.setAttribute("win_proj_id", "1");默认查询所有
		if(AOSUtils.isEmpty(pageContext.getAttribute("win_proj_id"))){
		    pageContext.setAttribute("win_proj_id", "");
		};
%>
	<%-- 通过这个弹窗表单演示再查询一次DB加载数据的方法 --%>
		<aos:window id="w_user" title="项目人员详情" onshow="w_user_onshow" width="800" height="400" >
				<aos:docked forceBoder="0 0 1 0">
					<aos:triggerfield emptyText="姓名" id="id_name" onenterkey="g_account_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="g_account_query" width="250" />
				</aos:docked> 
				<aos:gridpanel hidePagebar="true"   id="g_aosuser" url="projTeamsService.query_aos_user&proj_id=${win_proj_id}"  onrender="g_user_query" region="center" >
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column header="姓名" dataIndex="user_name" width="80"/>
						<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
						<aos:column header="所属组织" dataIndex="org_name" width="120" />
						<aos:column header="所属角色" dataIndex="role_name"  width="120" />
						<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
						<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80" />
						<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="80"  />
				</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="personnel_save()" text="保存数据" icon="ok.png" />
				<aos:dockeditem onclick="#w_user.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<script type="text/javascript">
		//性别值转换
		function fn_sex(value, metaData, record, rowIndex, colIndex,
				store) {
			if(value=='1'){
				value='男'
			}
			if(value=='2'){
				value='女'
			}
			if(value=='3'){
				value='未知'
			}
			return value
		}
		//用户状态值转换
		function fn_status(value, metaData, record, rowIndex, colIndex,
				store) {
			if(value=='1'){
				value='正常'
			}
			if(value=='2'){
				value='非正常'
			}
			return value
		}
		//用户类型值转换
		function fn_type(value, metaData, record, rowIndex, colIndex,
				store) {
			if(value=='1'){
				value='缺省'
			}
			return value
		}
		
		</script>
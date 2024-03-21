<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	String userid = userModel.getId().toString();
%>
<aos:html title="${app_title}" base="http" lib="ext,buttons,filter">
<link rel="stylesheet" type="text/css" href="${cxt}/static/css/modules/index.css" />

<!-- <link rel="stylesheet" type="text/css"  href="${cxt}/static/layui/css/layui.css" /> -->

<style type="text/css">
.north_el {
	height: 60px;
	background-image:
		url('${cxt}/static/image/background/index/${north_back_img}');
}

.main_text {
	color: ${main_text_color}
}

.nav_text {
	color: ${nav_text_color}
}
#loading-mask {
	z-index: 20000;
	left: 0px;
	top: 0px;
	position: absolute;
	width: 100%;
	height: 100%;
	opacity: 0.5;
	filter: alpha(opacity = 50);
	background-color: ${south_back_color};
}
</style>
<aos:body>
	<%-- 显示loading --%>
	<div id="loading-mask"></div>
	<div id="loading">
		<c:choose>
			<c:when test="${page_load_gif_ == 'run.gif'}">
				<img src="${cxt}/static/image/gif/pageload/${page_load_gif}">
			</c:when>
			<c:otherwise>
				<img width="100" height="100" src="${cxt}/static/image/gif/pageload/${page_load_gif}">
			</c:otherwise>
		</c:choose>
	</div>
	<%-- Center导航 --%>
	<div id="div_center">
		<iframe id="iframe_main" src="do.jhtml?router=homeService.initPortal&juid=${juid}"></iframe>
	</div>
	<%-- Banner导航 --%>
	<div id="div_north_el" class="x-hidden north_el">
		<table style="width: 100%">
			<tr>
				<td width="300px"><img src="${cxt}/static/image/logo/left-logo.png"></td>
				<td align="left"><c:if test="${navDto.is_show_top_nav == '1' && fn:length(cardDtos) > 1}">
						<c:if test="${navDto.nav_button_style == 'tight' }">
							<div class="button-group">
								<c:forEach var="card" items="${cardDtos}">
									<button id="id_nav_${card.id}" type="button" onmouseout="_btn_onmouseout(this)"  onmouseover="_btn_onmouseover(this);" onclick="fn_nav_btn_click('${card.id}');"
										class="${navDto.nav_bar_style}">
										<c:if test="${card.vector != null}">
											<i id="id_icon_${card.id}" class="fa ${card.vector}"></i>
										</c:if>
										${card.name}
									</button>
								</c:forEach>
							</div>
						</c:if>
						<c:if test="${navDto.nav_button_style == 'standalone'}">
							<c:forEach var="card" items="${cardDtos}">
								<a id="id_nav_${card.id}" onclick="fn_nav_btn_click('${card.id}');" class="${navDto.nav_bar_style}"> <c:if
										test="${card.vector_ != null}">
										<i id="id_icon_${card.id}" class="fa ${card.vector}"></i>
									</c:if> ${card.name}
								</a>
							</c:forEach>
						</c:if>
					</c:if></td>
				<td align="right" style="padding: 5px;" width="360px">
				<table style="border-spacing: 3px;">
						<tr align="right">
						  <td colspan="4" class="main_text" style="padding-right: 10px;">
						  <nobr>
							<a id="count_msg" class="${navDto.right_button_style}"   style="font-size: 6px;"  onclick="grid_click()">消息</a>
			            	
								${date} ${week} <span   id="rTime"></span>
							</nobr>
							</td>
						<tr>
						<tr align="right">
							<td width="600px">
								<a class="${navDto.right_button_style}" onmouseout="_btn_onmouseout(this)" onclick="fn_show_myinfo()" onmouseover="_btn_onmouseover(this);"><i class="fa fa-github-square"></i> 个人设置</a>
								<a class="${navDto.right_button_style}" onmouseout="_btn_onmouseout(this)" onclick="fn_show_mypwd()" onmouseover="_btn_onmouseover(this);"><i class="fa fa-key"></i> 修改密码</a> 
								<a class="${navDto.right_button_style}" onclick="fn_logout()" onmouseout="_btn_onmouseout(this)" onmouseover="_btn_onmouseover(this);"><i class="fa fa-power-off"></i> 退出</a>
							</td>
						<tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<div id="div_south_el" class="x-hidden">
		<div class="south_el_left main_text">
			<i class="fa fa-pagelines"></i> ${welcome_msg}, ${user_name}. 所属组织:${org_name}.
		</div>
		
		<div class="south_el_right main_text" style="float: right; margin-right: 150px;">
			<span >${proj_name}</span>
		</div>
		
		<div class="south_el_right main_text">
			<i class="fa fa-copyright"></i> ${copyright}
		</div>
	</div>
	 <!-- <script src=" ${cxt}/static/layui/layui.js"></script>  -->
</aos:body>

</aos:html>

<aos:onready ux="iframe">
	<aos:viewport layout="border">
		<aos:panel id="b_north" region="north" contentEl="div_north_el" height="60" maxHeight="60" minHeight="60"
			border="false" header="false" collapsible="true" collapseMode="mini" split="true">
		</aos:panel>

		<aos:panel id="b_south" region="south" contentEl="div_south_el" height="18" border="false" header="false"
			bodyStyle="backgroundColor:'${south_back_color}'">
		</aos:panel>

		<aos:tabpanel id="b_west" region="west" activeTab="0" plain="true" tabBarHeight="30" bodyBorder="0 1 1 1" split="true" 
			maxWidth="300" border="true" minWidth="160" width="160" collapsible="true"   collapseMode="mini" header="false">
			<aos:tab id="sys_nav" title="系统导航" layout="accordion" animate="false">
				<aos:docked forceBoder="0 0 1 0">
					<aos:triggerfield id="id_filter" emptyText="过滤功能菜单..." trigger1Cls="x-form-search-trigger"
						onchange="fn_find_modules" onTrigger1Click="fn_find_modules" width="115" />
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem text="" tooltip="更多选型" icon="icon141.png">
						<aos:menu>
							<aos:menuitem text="个人设置" icon="user20.png" onclick="fn_show_myinfo" />
							<aos:menuitem text="修改密码" icon="key.png" onclick="fn_show_mypwd" />
							<aos:menuitem xtype="menuseparator" />
							<%-- <aos:menuitem text="锁定离开" icon="lock.png" onclick="fn_find_modules" /> --%>
							<aos:menuitem text="发送消息" icon="lock.png" onclick="#pushMes.show()" />
							<aos:menuitem text="安全退出" icon="close2.png" onclick="fn_logout" />
						</aos:menu>
					</aos:dockeditem>
				</aos:docked>
				<c:forEach var="card" items="${cardDtos}">
					<aos:treepanel id="id_card_${card.id}" onitemclick="fn_node_click" onexpand="fn_card_onexpand"
						oncollapse="fn_find_modules" icon="${card.icon_name}" title="${card.name}" rootVisible="false"
						rootId="${card.cascade_id}" url="homeService.getCardTree" nodeParam="cascade_id">
						<aos:menu>
							<aos:menuitem text="添加收藏" icon="user20.png" onclick="!addcollect" any="itemId:${card.id}"/>
						</aos:menu>
					</aos:treepanel>
				</c:forEach>
			</aos:tab>
			<aos:tab title="收藏夹">
			<aos:tab id="sys_navs" title="" layout="accordion" animate="false">
					<aos:treepanel id="id_card_s" onitemclick="fn_node_clicks"  icon="" title="收藏夹" rootVisible="false"
						 url="homeService.getCardTreeCollect" nodeParam="cascade_id">
						<aos:menu>
							<aos:menuitem text="取消收藏" icon="user20.png" onclick="removecollect" />
						</aos:menu>
					</aos:treepanel>
			</aos:tab>
			</aos:tab>
		</aos:tabpanel>
		<aos:tabpanel id="tabs" region="center"   activeTab="0" plain="true" tabBarHeight="30" bodyBorder="0 1 1 1">
			<aos:plugins>
				<aos:tabCloseMenu extraItemsTail1="最大化 还原:fn_collapse_expand:shape_move_back.png"
					extraItemsTail2="刷新:fn_reload:refresh2.png" />
				<aos:tabReorderer />
			</aos:plugins>
			<aos:tab id="id_tab_welcome" reorderable="false" title="${welcome_page_title}" contentEl="div_center" />
		</aos:tabpanel>
	</aos:viewport>

	<aos:window id="w_myinfo" title="我的个人设置" iconVec="fa-github-square" iconVecSize="20" resizable="true"
		onshow="w_myinfo_onshow">
		<aos:formpanel id="f_myinfo" width="1000" labelWidth="500" height="550" autoScroll="true">
			<aos:fieldset title="基础信息" labelWidth="75" columnWidth="1">
				<aos:textfield name="org_name" fieldLabel="所属部门" readOnly="true" columnWidth="0.5" />
				<aos:textfield name="name" fieldLabel="姓名" allowBlank="false" maxLength="20" columnWidth="0.49" />
				<aos:combobox name="sex" fieldLabel="性别" allowBlank="false" dicField="sex" value="3" columnWidth="0.5" />
				<aos:textfield name="email" fieldLabel="电子邮件" vtype="email" maxLength="50" columnWidth="0.49" />
				<aos:textfield name="mobile" fieldLabel="联系电话" maxLength="50" columnWidth="0.5" />
				<aos:textfield name="idno" fieldLabel="身份证号" maxLength="50" columnWidth="0.49" />
				<aos:textfield name="address" fieldLabel="联系地址" maxLength="500" columnWidth="0.5" />
				<aos:textareafield name="remark" fieldLabel="备注" maxLength="4000" height="25" columnWidth="0.49" />
			</aos:fieldset>
			<aos:fieldset title="配置信息" labelWidth="75" columnWidth="1">
				<aos:combobox name="skin" fieldLabel="界面皮肤" allowBlank="false" dicField="skin" value="blue" columnWidth="0.5" />
				<aos:textfield name="biz_code" fieldLabel="扩展码" maxLength="200" readOnly="true" columnWidth="0.49" />
			</aos:fieldset>

			<aos:fieldset title="常用联系人" labelWidth="500"  columnWidth="1" border="true" autoScroll="true">
				<aos:gridpanel id="topContacts_grid" url="topContactsService.page" onrender="topContacts_query" 
							width="980" height="300" autoScroll="true" hidePagebar="true" border="true" 
							anchor="100%" region="center" layout="fit" forceFit="false"> 
					<aos:menu> 
						<aos:menuitem text="新增" onclick="topContacts_win_show" icon="add.png" /> 
 						<aos:menuitem text="删除" onclick="topContacts_delete" icon="del.png" />
						<aos:menuitem xtype="menuseparator" /> 
 						<aos:menuitem text="刷新" onclick="#topContacts_grid_store.reload();" icon="refresh.png" /> 
					</aos:menu> 
 					<aos:docked forceBoder="1 0 1 0"> 
						<aos:dockeditem xtype="tbtext" text="常用联系人信息" /> 
						<aos:dockeditem xtype="tbseparator" /> 
						<aos:dockeditem text="新增" onclick="topContacts_win_show" icon="add.png" /> 
						<aos:dockeditem text="删除" onclick="topContacts_delete" icon="del.png" /> 
						<aos:triggerfield emptyText="姓名" id="top_user_name" onenterkey="topContacts_query" trigger1Cls="x-form-search-trigger" 
							onTrigger1Click="topContacts_query" width="180" />
			        	<aos:combobox id="top_principal_org" name="subordinate_departments" editable="false" width="150" queryMode="local" 
							url="topContactsService.listPrincipalOrg" emptyText="部门查询" onselect="topContacts_query"/>
					</aos:docked> 
 					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column type="rowno" /> 
 						<aos:column header="常用联系人ID" dataIndex="top_id" fixedWidth="100" hidden="true"/> 
						<aos:column header="常用联系人" dataIndex="top_name" fixedWidth="100" /> 
						<aos:column header="用户ID" dataIndex="user_id" fixedWidth="100" hidden="true"/>
						<aos:column header="创建人id" dataIndex="create_id" fixedWidth="100" hidden="true"/> 
 						<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100" hidden="true"/>
						<aos:column header="常用联系人所属部门id" dataIndex="top_org_name_id" fixedWidth="150" hidden="true"/>
						<aos:column header="常用联系人所属部门" dataIndex="top_org_name" fixedWidth="150" />
						<aos:column header="常用联系人角色" dataIndex="top_role_name" fixedWidth="150" /> 
 						<aos:column header="常用联系人性别" dataIndex="top_sex" fixedWidth="150" rendererFn="fn_sex"/> 
 				</aos:gridpanel> 
				
 				<aos:window id="topContacts_create_win" title="新增常用联系人(双击)"> 
 					<aos:formpanel  id="topContacts_create_form" width="450" layout="anchor" labelWidth="70" >
 						<aos:hiddenfield name="top_id" fieldLabel="常用联系人ID"/> 
 						<aos:triggerfield fieldLabel="常用联系人姓名" name="top_name" allowBlank="false"  editable="false" trigger1Cls="x-form-search-trigger" 
 										margin="5"  onTrigger1Click="w_account_find_show" columnWidth="1" />
						<aos:hiddenfield fieldLabel="创建人id" name="create_id"/> 
 						<aos:hiddenfield fieldLabel="创建时间" name="create_time"/> 
						<aos:hiddenfield fieldLabel="用户ID" name="user_id"/>
 					</aos:formpanel> 
 					<aos:docked dock="bottom" ui="footer"> 
 						<aos:dockeditem xtype="tbfill" /> 
 						<aos:dockeditem onclick="topContacts_create" text="保存" icon="ok.png" /> 
 						<aos:dockeditem onclick="#topContacts_create_win.hide();" text="关闭" icon="close.png" /> 
 					</aos:docked> 
 				</aos:window> 
 			</aos:fieldset>
 			<aos:window id="w_user" title="新增常用联系人(双击)"  width="900" height="450"   layout="border" onshow="w_user_onshow"   >
					<aos:gridpanel hidePagebar="true"   id="g_aosuser" url="topContactsService.topUserPage" onitemdblclick="add_contract_grid"  width="450"  onrender="g_user_query" region="west" >
						<aos:docked forceBoder="0 0 1 0">
					    	<aos:triggerfield emptyText="姓名" id="id_name" onenterkey="g_user_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="g_user_query" width="180" />
				        	<aos:combobox id="search_principal_org" name="subordinate_departments" editable="false" width="150" queryMode="local" 
								url="topContactsService.listPrincipalOrg" emptyText="部门查询" onselect="fn_org"/>
				        </aos:docked> 
						<aos:selmodel type="row" mode="multi" />
						<aos:column type="rowno" width="30"/>
						<aos:column header="姓名" dataIndex="user_name" width="80"/>
						<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
						<aos:column header="所属组织" dataIndex="org_name" width="120" />
						<aos:column header="所属角色" dataIndex="role_name"  width="120" />
						<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
						<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80"  hidden="true"/>
						<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="80" hidden="true" />
					</aos:gridpanel>
					<aos:gridpanel id="g_aosuser_corp"   hidePagebar="true" url="topContactsService.topUsersPage"  onitemdblclick="del_contract_grid"  width="450"  onrender="g_user_query_corp"  region="center" >
						<aos:docked forceBoder="0 0 1 0"   >
						</aos:docked>
						<aos:selmodel type="row" mode="multi" />
						<aos:column type="rowno" width="30"/>
						<aos:column header="姓名" dataIndex="user_name" width="80" id="top_name_user"/>
						<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
						<aos:column header="所属组织" dataIndex="org_name" width="120" />
						<aos:column header="所属角色" dataIndex="role_name"  width="120" />
						<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
						<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80" hidden="true"/>
						<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="80"  hidden="true"/>
					</aos:gridpanel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="topContacts_create()" text="保存数据" icon="ok.png" />
					<aos:dockeditem onclick="#w_user.hide();" text="关闭" icon="close.png" />
				</aos:docked>
			</aos:window>
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
            <aos:dockeditem onclick="f_myinfo_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#w_myinfo.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	
	<aos:window id="w_webui" title="个人消息"   iconVec="fa-github-square" iconVecSize="15" resizable="false" 
	        height="700"
	        width="300"
	        modal="false"
	        x="x=1280"
	        y="y=50">
		<aos:gridpanel   hidePagebar="true" id="message_grid" forceFit="false" region="center" bodyBorder="1 0 1 0" onitemclick="wxiaoxiShow"   >
		    <aos:column header="内容" dataIndex="msg_conunt"  hidden="true"   />
		      <aos:column header="消息ID" dataIndex="msg_id"  hidden="true"   />
		    <aos:column header="状态" dataIndex="msg_state"  fixedWidth="40" align="center" rendererFn="flag_mes"    />
		    <aos:column header="发送者" dataIndex="name"   fixedWidth="100" align="center"  />
		     <aos:column header="时间" dataIndex="send_time"   fixedWidth="147" align="center" type="date" format="m月d日 h点m分"  />
        </aos:gridpanel>
	  </aos:window>
	  <aos:window id="w_xiaoxi" title="消息内容"   iconVec="fa-github-square" iconVecSize="15" resizable="false" 
	        height="500"
	        width="700"
	        modal="false"
	        layout="anchor"
	        >
	       <aos:formpanel id="f_xiaoxi" region="center"
							 labelWidth="70"    >
							<aos:hiddenfield fieldLabel="关联人名称" name="send_name"    />
							<aos:hiddenfield fieldLabel="关联人ID" name="send_id" />
			</aos:formpanel>
				<aos:textareafield name="content"  id="id_content"  anchor="100% 90%" margin="10 10 10 10" 
				  />
				<%-- <aos:textareafield name="content"  id="id_content"  anchor="100% 20% " margin="10 10 10 10" 
				  /> --%>
			    <aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<%-- <aos:dockeditem onclick="c_mesg_save" text="发送" icon="ok.png" /> --%>
				<aos:dockeditem onclick="#w_xiaoxi.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	  </aos:window>
	  
	  

	<aos:window id="w_mypwd" title="修改密码" iconVec="fa-key" iconVecSize="15" resizable="false"
		onshow="#AOS.reset(f_mypwd);">
		<aos:formpanel id="f_mypwd" width="400" labelWidth="75">
			<aos:textfield name="password" fieldLabel="原密码" inputType="password" allowBlank="false" maxLength="20"
				columnWidth="0.99" />
			<aos:textfield name="new_password" fieldLabel="新密码" inputType="password" allowBlank="false" maxLength="20"
				columnWidth="0.99" />
			<aos:textfield name="confirm_new_password" fieldLabel="确认新密码" inputType="password" allowBlank="false" maxLength="20"
				columnWidth="0.99" />
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="f_mypwd_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#w_mypwd.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	
	<aos:window id="pushMes" title="发送消息" iconVec="fa-key" iconVecSize="15" resizable="false" onshow="#AOS.reset(f_mypwd);">
		<aos:formpanel id="pushMesForm" width="600" labelWidth="75">
			<aos:radioboxgroup fieldLabel="发送方式" columnWidth="0.99" columns="4" >
				<aos:radiobox boxLabel="指定人发送" name="mesPushType" value="0" inputValue="0"></aos:radiobox>
				<aos:radiobox boxLabel="指定房间发送" name="mesPushType" value="1" inputValue="1" ></aos:radiobox>
				<aos:radiobox boxLabel="指定频道发送" name="mesPushType" value="2" inputValue="2" checked="true"></aos:radiobox>
				<aos:radiobox boxLabel="全频道发送" name="mesPushType" value="3" inputValue="3"></aos:radiobox>
			</aos:radioboxgroup>
			<aos:textfield name="title" value="${user_name}:指定频道发送的消息" fieldLabel="标题" inputType="text" allowBlank="false" maxLength="20" columnWidth="0.99" />
			<aos:textareafield name="view_content" fieldLabel="展示内容" readOnly="true" allowBlank="true" autoScroll="true" maxLength="20" columnWidth="0.99" height="300"/>
			<aos:textareafield name="content" fieldLabel="内容" allowBlank="false" maxLength="20" columnWidth="0.99" height="50"/>
			
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="sendMes" text="发送" icon="ok.png" />
			<aos:dockeditem onclick="#pushMes.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	
	<script type="text/javascript">
	//人员信息表信息
	function g_user_query(){
		var id_name = AOS.getValue('id_name');
		var subordinate_departments = AOS.getValue('search_principal_org');
		var top_id = AOS.getValue('topContacts_create_form.top_id');
		g_aosuser_store.getProxy().extraParams = {
			id_name : id_name,
			subordinate_departments : subordinate_departments,
			id : top_id
		};
		g_aosuser_store.loadPage(1);
	}
	
	//人员信息表信息
	function fn_org(){
		var id_name = AOS.getValue('id_name');
		var subordinate_departments = AOS.getValue('search_principal_org');
		var top_id = AOS.getValue('topContacts_create_form.top_id');
		g_aosuser_store.getProxy().extraParams = {
			id_name : id_name,
			subordinate_departments : subordinate_departments,
			id : top_id
		};
		g_aosuser_store.loadPage(1);
	}
	
	//添加选中的单条grid
	function add_contract_grid(me, record){
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid1Records = grid1.data.items;
		var grid2 = AOS.get('g_aosuser').store;
		var flag = true;
		Ext.each(grid1Records, function (grid1Record) {
			if(grid1Record.data.id == record.data.id){
				AOS.tip("该人员已存在，请勿重复添加!");
				flag = false;
				return;
			}
	    });
		if(flag){
			grid1.add(record);
			grid2.remove(record);
		}
	}
	
	//组件显示的时候调用
    function  w_user_onshow(){
    	var attende_id = AOS.getValue('topContacts_grid.user_id');
    	var params = AOS.getValue('id_name');
    	
   		g_aosuser_corp_store.getProxy().extraParams = {id:attende_id}
		g_aosuser_corp_store.loadPage(1);
   		
  		g_aosuser_store.getProxy().extraParams = {id_name:params,id:attende_id};
		g_aosuser_store.loadPage(1);
    }
	
	//删除某条数据
	function del_contract_grid(me,record){
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid2 = AOS.get('g_aosuser').store;
		grid1.remove(record);
		grid2.add(record);
	}
	
	//临时窗口
	function g_user_query_corp(){
		var top_id = AOS.getValue('topContacts_create_form.top_id');
		g_aosuser_corp_store.getProxy().extraParams = {id:top_id}
		g_aosuser_corp_store.loadPage(1);
   }
	
	//弹出选择角色窗口
	function w_account_find_show() {
		w_user.show();
	}
			
	//显示新增窗口
	function topContacts_win_show(type){
// 		AOS.reset(topContacts_create_form);
		w_user.show();
	}
	//查询
	function topContacts_query() {
		var top_user_name = AOS.getValue('top_user_name');
		var top_principal_org = AOS.getValue('top_principal_org');
		var top_id = AOS.getValue('topContacts_create_form.top_id');
		var user_id = ${user.id};
	    topContacts_grid_store.getProxy().extraParams = {
	    	create_id : user_id,
	    	top_user_name : top_user_name,
			top_principal_org : top_principal_org,
			id : top_id
	    };
	    topContacts_grid_store.loadPage(1);
	}
	
	//常用联系人姓名查询
	function top_user_query(){
		var top_user_name = AOS.getValue('top_user_name');
		var top_principal_org = AOS.getValue('top_principal_org');
		topContacts_grid_store.getProxy().extraParams = {
			top_user_name : top_user_name,
			top_principal_org : top_principal_org,
			id : top_id
		};
		topContacts_grid_store.loadPage(1);
	}
	
	//用户名称保存
    function    personnel_save(){
    	g_aosuser_corp.getSelectionModel().selectAll();
    	var select=AOS.selection(g_aosuser_corp,'id');
    	var user_name=AOS.selection(g_aosuser_corp,'user_name');
    	var attende_id=select.split(",");
    	var user_name_=user_name.split(",");
    	var attende_id_=[];
    	var user_name_p=[];
    	Ext.each(attende_id,function(item){
    		if(!AOS.empty(item)){
    			attende_id_.push(Number(item));
    		};
    	});
    	Ext.each(user_name_,function(item){
    		if(!AOS.empty(item)){
    			user_name_p.push(item);
    		};
    	});
    	AOS.setValue('topContacts_create_form.top_id',attende_id_);
    	AOS.setValue('topContacts_create_form.top_name',user_name_p);
    	w_user.hide();
    }
	
	//新增
	function topContacts_create() {
		g_aosuser_corp.getSelectionModel().selectAll();
    	var select=AOS.selection(g_aosuser_corp,'id');
    	var user_name=AOS.selection(g_aosuser_corp,'user_name');
//     	var attende_id=select.split(",");
//     	var user_name_=user_name.split(",");
//     	var attende_id_=[];
//     	var user_name_p=[];
//     	Ext.each(attende_id,function(item){
//     		if(!AOS.empty(item)){
//     			attende_id_.push(Number(item));
//     		};
//     	});
//     	Ext.each(user_name_,function(item){
//     		if(!AOS.empty(item)){
//     			user_name_p.push(item);
//     		};
//     	});
		AOS.ajax({
			params : {
				top_name : user_name,
				user_id : select
			},
			url : 'topContactsService.create',
			ok : function(data) {
				AOS.tip(data.appmsg);
				topContacts_grid_store.reload();
				w_user.hide();
			}
		});
	}
	//修改
	function topContacts_update() {
		AOS.ajax({
			forms : topContacts_update_form,
			url : 'topContactsService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				topContacts_grid_store.reload();
				topContacts_update_win.hide();
			}
		});
	}
	//删除
	function topContacts_delete(){
		var selection = AOS.selection(topContacts_grid, 'top_id');
		if(AOS.empty(selection)){
			AOS.tip('删除前请先选中数据。');
			return;
		}
		var rows = AOS.rows(topContacts_grid);
		var msg =  AOS.merge('确认要删除选中的{0}条联系人记录吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				AOS.tip('删除操作被取消。');
				return;
			}
			AOS.ajax({
				url : 'topContactsService.delete',
				params:{
					aos_rows: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					topContacts_grid_store.reload();
				}
			});
		});
	}
	
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
		
		//mesVO {			//消息对象 	
		//	mesPushType,	//发送方式 [0: 一对多], [1: 指定房间发送], [2: 指定平台发送],[3: 全平台发送]
							//0:必传发送待发送的用户编码(并缓存消息)
							//1:可以不传用户编码-向全房间在线用户广播
							//2:可以不传用户编码-向全频道在线用户广播
							//3:可以不传用户编码-向所有在线用户广播
		//	fromId:123,		//消息来源-默认当前登录用户
		//	toIds:[],		//接收者
		//	extrasIds:[],	//过滤者(不发送)
		//	title:"",		//标题
		//	content:"",		//内容
		//	extras:{}		//扩展字段
		//}
		var socket,token,login_count=0;
		//使用当前系统账号及密码登录系统
		function mesLogin(){
			login_count++;
			var account='${account}';
			var password='123456';
			var vcode='1234';
			var name="${user_name}";
			var userid;
			var mesid;
			$.post(
					"http://"+AOS.Message_Url+"/user/validAccount?account="+account,
				function(data){
						if(data.data!=false){
							$.post(
									"http://"+AOS.Message_Url+"/user/login",
									{account:account,password:password,vcode:vcode},
									function(result){
										if(result.data){
											token=result.data;
											console.log("token",token);
											AOS.ajax({
												url:'weekService.cache_token',
												params:{
													token:token
												}
											});
											createSocket();
										}
									}
								);
						
						}else{
							$.ajax({
								url:"http://"+AOS.Message_Url+"/user/register?name=${user_name}&account=${account}&password="+password,
								data:JSON.stringify({account:account,password:password,name:name}),
								type : "POST",
								contentType:"application/json",
								processData:false,
								dataType: "json",
								success:function(result){
									console.log("result=",result);
									if(login_count<3){
										mesLogin();
							}
						}
					});
				}
			}
		)
		
	}
		mesLogin();
		//发送消息
		function sendMes(){
			var params=pushMesForm.getValues();
			console.log("params=",params);
			if(!params.content){	
				AOS.tip("消息不能为空");
				pushMesForm.down("textfield[name=content]").focus();
				return;
			}
			socket.emit('client_message',params,function(data){
				console.log("send message callback",data);
				pushMesForm.down("textarea[name=content]").setValue().focus();
				pushMes.hide();
			});
		}
		
		//创建消息传送通道
		function createSocket(){
			if(!token){
				AOS.tip("未登录消息推送框架请先登录");
				return;
			}
			if(!socket){
				socket = io.connect('http://'+AOS.Message_Host+':9090' + '/'+ 9527 + "?token=" + token, {
					"transports" : [ 'websocket', 'polling' ]
				});
			}
			//收到服务器消息A已上线
			socket.on('client_connect', (mes) => {
				console.log(mes);
				var view_textarea=pushMesForm.down("textarea[name=view_content]");
				view_textarea.setValue(view_textarea.getValue()+"\n"+mes.content+"\n");
				var jsonObject = {
	                title:"客户端消息",
	                content:"收到客户端消息"
	            };
				//告知服务器我已知道A上线
				socket.emit('client_connect_callback', jsonObject,function(data){
					console.log("send recive connect callback",data);
					pushMes.hide();
				});
			});
			//收到服务器告知消息A给你发了消息
			socket.on('client_message', function(mes) {
				console.log(mes);
				var view_textarea=pushMesForm.down("textarea[name=view_content]");
				view_textarea.setValue(view_textarea.getValue()+"\n"+mes.content+"\n");
				//告知服务器我已收到A的消息
				var jsonObject = {
					id:	mes.id,
	                title:"客户端消息",
	                content:"收到客户端消息"
	            };
				//告知服务器我已收到A发给我的消息
				socket.emit('client_message_callback', jsonObject,function (data){
					console.log("send message recive callback",data);
					pushMes.hide();
				});
			});
			//收到服务器告知消息A已下线
			socket.on('client_disconnect', function(mes) {
				console.log(mes);
				var view_textarea=pushMesForm.down("textarea[name=view_content]");
				view_textarea.setValue(view_textarea.getValue()+"\n"+mes.content+"\n");
				
				var jsonObject = {
					id:	mes.id,
	                title:"客户端消息",
	                content:"收到客户端消息"
	            };
				//告知服务器我知道到A下线
				socket.emit('client_disconnect_callback', jsonObject,function(data){
					console.log("send recive disconnect callback",data);
					pushMes.hide();
				});
			});
		}
		
		
		
		
		
		
	/* 	//即时通信
		layui.use('layim', function(layim){
  //基础配置
  layim.config({
 
    init: {
    	 mine: {
    		     "username": "${user_name}" //我的昵称
    		      ,"id": "100000" //我的ID
    		      ,"status": "online" //在线状态 online：在线、hide：隐身
    		      ,"sign": "在深邃的编码世界，做一枚轻盈的纸飞机" //我的签名
    		      ,"avatar": "/aosuite/static/image/demo/tx.jpg" //我的头像
    	 }
	    ,friend: [{
	        "groupname": "前端好友" //好友分组名
	            ,"id": 1 //分组ID
	            ,"list": [{ //分组下的好友列表
	              "username": "贤心" //好友昵称
	              ,"id": "100001" //好友ID
	              ,"avatar": '/aosuite/static/image/demo/demo.png' //好友头像
	              ,"sign": "这些都是测试数据，实际使用请严格按照该格式返回" //好友签名
	              ,"status": "online" //若值为offline代表离线，online或者不填为在线
	            }]
	          }]
	    ,group: [{
	        "groupname": "前端群" //群组名
	            ,"id": "101" //群组ID
	            ,"avatar": "/aosuite/static/image/demo/qun.jpg" //群组头像
	          }]
    } //获取主面板列表信息，下文会做进一步介绍
 
    //获取群员接口（返回的数据格式见下文）
    ,members: {
      url: '' //接口地址（返回的数据格式见下文）
      ,type: 'get' //默认get，一般可不填
      ,data: {} //额外参数
    }
    
    //上传图片接口（返回的数据格式见下文），若不开启图片上传，剔除该项即可
    ,uploadImage: {
      url: '' //接口地址
      ,type: 'post' //默认post
    } 
    
    //上传文件接口（返回的数据格式见下文），若不开启文件上传，剔除该项即可
    ,uploadFile: {
      url: '' //接口地址
      ,type: 'post' //默认post
    }
    ,msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html' //消息盒子页面地址，若不开启，剔除该项即可
    ,find: layui.cache.dir + 'css/modules/layim/html/find.html' //发现页面地址，若不开启，剔除该项即可
    ,chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.html' //聊天记录页面地址，若不开启，剔除该项即可
  });
});    */   //消息查询

	/* 	//列表单击事件
		function g_webui_click() {
			var record= AOS.selectone(message_grid);
			AOS.get('w_xiaoxi').show();
			AOS.setValue('f_xiaoxi.send_id',record.data.send_id);
			AOS.setValue('f_xiaoxi.send_name',record.data.send_name);
			var send_id=AOS.getValue('f_xiaoxi.send_id');
			var send_name=AOS.getValue('f_xiaoxi.send_name');
			AOS.ajax({
				params:{
					send_id: send_id
				}, 
				url : 'filesManageService.getmsg',
				ok : function(data) {
						  Ext.getCmp('id_ta_').body.update(data.sb);
					  }
			});
		} */
	/* 	//发送
		function c_mesg_save() {
			var con= AOS.get('id_content').getValue();
			var record= AOS.selectone(message_grid);
			AOS.ajax({
				params:{
					content: con,
					send_id: record.data.send_id,
					send_name: record.data.send_name
				}, 
				url : 'filesManageService.sendMsg',
				ok : function(data) {
					AOS.setValue('id_content',"");
					  g_webui_click();
					  }
			});
		} */
		 //添加收藏
	    function addcollect(menu,item) {
	    	var ids,records;
	    	ids= "id_card_"+menu.itemId;
	    	records= Ext.getCmp(ids).getSelectionModel().getSelection();
		    if(menu.itemId == records[0].raw.id){
		    	AOS.tip('不能收藏整个目录,请重新选择!');
		    		return;
		    }
	    	AOS.ajax({
	    		params:{module_id:records[0].raw.id,
	    			   root_id:menu.itemId},
				url : 'replyNewsService.addCollect',
				ok : function(data) {
					AOS.tip(data.appmsg);
					id_card_s_store.load();
				}
			});
		 }
	    //取消收藏
	    function  removecollect() {
	    	var recode=AOS.selectone(id_card_s);
	    	AOS.ajax({
	    		params:{module_id:recode.raw.id},
				url : 'replyNewsService.removeCollect',
				ok : function(data) {
					AOS.tip(data.appmsg);
					id_card_s_store.load();
				}
			});
	    }
	   
		   //快速过滤
		function fn_find_modules(){
			<c:forEach var="card" items="${cardDtos}">
			    	Ext.getCmp('id_card_${card.id}').filterByText(id_filter.getValue());
			</c:forEach>
		}
		
		//获取我的个人设置信息
		function w_myinfo_onshow(){
			AOS.ajax({
				url : 'homeService.getUser',
				ok : function(data) {
					f_myinfo.form.setValues(data);
				}
			});
		}
		
		//修改我的个人设置信息
		function f_myinfo_save(){
			var record = AOS.getValue('f_myinfo');
			var sex = record.sex;
			var address = record.address;
			var biz_code = record.biz_code;
			var mobile = record.mobile;
			var skin = record.skin;
			var remark = record.remark;
			var idno = record.idno;
			var name = record.name;
			var org_name = record.org_name;
			var email = record.email;
			AOS.ajax({
				params : {
					sex:sex,
					address:address,
					biz_code:biz_code,
					mobile:mobile,
					skin:skin,
					remark:remark,
					idno:idno,
					name:name,
					org_name:org_name,
					email:email
				},
				url : 'homeService.updateMyInfo',
				ok : function(data) {
					AOS.tip(data.appmsg);
					w_myinfo.hide();
					if(data.is_skin_changed_ == '1'){
						AOS.job(function(){
							location.reload();
						},200)
					}
				}
			});
		}
		
		//修改我的密码
		function f_mypwd_save(){
			AOS.ajax({
				forms : f_mypwd,
				url : 'homeService.updateMyPwd',
				ok : function(data) {
					if(data.appcode == '1'){
						AOS.tip(data.appmsg);
						w_mypwd.hide();
					}else{
						AOS.err(data.appmsg);
					}
				}
			});
		}
		
	    //刷新当前活动卡片
	    function fn_reload(){
	    	var cur_tab_id = tabs.getLayout().activeItem.id;
	    	if(cur_tab_id === 'id_tab_welcome'){
	    		Ext.get('iframe_main').dom.contentWindow.location.reload();
	    	}else{
	    		Ext.getCmp(cur_tab_id + '.iframe').load();
	    	}
	    }
	    
	    //最大化 还原
	    function fn_collapse_expand(){
	    	b_west.toggleCollapse();
	    	b_north.toggleCollapse();
	    }
		
		//响应卡片展开事件
		function fn_card_onexpand(me, eOpts) {
			var id_ = me.id.substr(9)
			fn_nav_btn_click(id_);
		}

		//响应导航菜单树节点单击事件
		function fn_node_click(view, record, item, index, e) {
			//菜单节点所属的那个卡片标识，也是当前菜单树的根节点
			var root_id = record.getPath().split('/')[2];
			var url =  record.raw.a;
			if (!Ext.isEmpty(url)) {
				fnaddtab(url,record.raw.text,record.raw.id,root_id);
			}else{
				if(record.raw.leaf){
					 AOS.tip('没有配置菜单的请求地址。');
				}
			}
		}
		//响应导航菜单树节点单击事件(收藏)
		function fn_node_clicks(view, record, item, index, e) {
			//菜单节点所属的那个卡片标识，也是当前菜单树的根节点
			var root_id = record.raw.parentId;
			var url =  record.raw.a;
			if (!Ext.isEmpty(url)) {
				fnaddtab(url,record.raw.text,record.raw.id,root_id);
			}else{
				if(record.raw.leaf){
					 AOS.tip('没有配置菜单的请求地址。');
				}
			}
		}
		//响应快捷菜单单击事件
		function fn_quick_click(id, name, url) {
			fnaddtab(id, name, url);
		}
		
		b_west.setActiveTab(0);
	</script>
</aos:onready>
<script type="text/javascript">
	//打开菜单功能页面
	function fnaddtab(url, menuname, module_id, root_id) {
		if (Ext.isEmpty(url)) {
			return;
		}
		var id = "id_tab_" + module_id;
		url = url.indexOf('http://') === 0 ? url : '${cxt}/http/do.jhtml?router=' + url;
		var index = url.indexOf('?');
		//一级菜单的主页面所属的页面元素其pageid_同moduleid_。
		url = url + (index === -1 ? '?' : '&') + 'juid=${juid}' + '&aos_module_id=' + module_id;
		var tabs = Ext.getCmp('tabs');
		var tab = tabs.getComponent(id);
		var tempflag = 0;
		if (!tab) {
			var iframe = Ext.create('AOS.ux.IFrame', {
				id : id + '.iframe',
				mask : true,
				layout : 'fit',
				//这个参数仅起到将iframe组件自带的mask调节到相对居中位置的作用
				height : document.body.clientHeight - 200,
				loadMask : '${page_load_msg}'
			});
			tab = tabs.add({
				id : id,
				module_id: module_id, //供Tab与导航树逆向联动使用。
				//root_id: root_id, //菜单节点所属的那个卡片标识，也是当前菜单树的根节点。供Tab与导航树逆向联动使用。
				title : '<span class="app-container-title-normal">' + menuname + '</span>',
				closable : true,
				layout : 'fit',
				items : [ iframe ]
			});
			tab.on('activate', function() {
				//防止已打开的功能页面切回时再次加载
				if (tempflag === 0) {
					iframe.load(url);
					tempflag = 1;
				}
				//切换的时候和导航树保持同步
				fn_sync_tab_tree(tab);
			});
		}
		//激活新增Tab
		tabs.setActiveTab(tab);
	}
	
	//切换卡片的时候和导航树保持同步
	function fn_sync_tab_tree(tab){
	
		if(AOS.empty(tab.root_id) || AOS.empty(tab.module_id)){
			return;
		}
		var sys_nav_tab = Ext.getCmp('sys_nav');
		if(!sys_nav_tab.isVisible()){
			return;
		}
		var expanded_tree = Ext.getCmp('id_card_' + tab.root_id);
		var expanded_tree_store = expanded_tree.getStore();
		var cur_node = expanded_tree_store.getById(tab.module_id);
		if(AOS.empty(cur_node)) return;
		//如果节点所属卡片不可见，则使之可见
		fn_nav_left_mode1(tab.root_id);
		//如果节点不可见，则使之可见
		if(!cur_node.isVisible()) expanded_tree.expandPath(cur_node.getPath());
		var sm = expanded_tree.getSelectionModel();
		sm.select(cur_node);
	}

	//当前已按下的导航按钮
	var g_visited_domid = '';
	//横向导航和左侧导航的互动
	function fn_nav_btn_click(id_) {
		//重定位当前卡片位
		var sys_nav = Ext.getCmp('sys_nav');
		if(!sys_nav.isVisible()){
			Ext.getCmp('b_west').setActiveTab(sys_nav);
		}
		var domid = 'id_nav_' + id_;
		var dom_obj = Ext.getDom(domid);
		if (!AOS.empty(g_visited_domid)) {
			var dom_visited = Ext.getDom(g_visited_domid);
			dom_visited.className = '${navDto.nav_bar_style}';
			//停止ICON转动
			//if(Ext.get(dom_visited).down('i')) Ext.get(dom_visited).down('i').removeCls('fa-spin');
		}
		
		dom_obj.className = '${navDto.nav_bar_style_visited}';
		g_visited_domid = domid;
		fn_nav_left_mode1(id_);
	}

	//当导航模式为1时，水平和左侧导航的互动模式
	function fn_nav_left_mode1(id) {
		var cmpid = 'id_card_' + id;
		var cmp_card = Ext.getCmp(cmpid);
		if (cmp_card.getCollapsed()) {
			cmp_card.expand(true)
		}
	}

	//移除首页正在加载的缓冲div
	Ext.EventManager.on(window, 'load', function() {
		AOS.job(function() {
			Ext.get('loading').fadeOut({
				duration : 500, //遮罩渐渐消失
				remove : true
			});
			Ext.get('loading-mask').fadeOut({
				duration : 500,
				remove : true
			});
		}, 0); //做这个延时，只是为在Dom加载很快的时候GIF动画效果更稍微显著一点

	});

	//注销
	function fn_logout() {
		AOS.confirm('注销并安全退出系统吗？', function(btn) {
			if (btn === 'cancel') {
				AOS.tip('操作被取消。');
				return;
			}
			AOS.mask('正在注销, 请稍候...');
			AOS.ajax({
				url : 'homeService.logout',
				wait : false,
				ok : function(data) {
					AOS.unmask();
					window.location.href = 'do.jhtml?router=homeService.initLogin';
				}
			});
		});
	}
	//消息
 	AOS.job(function fn_show_message(){
		AOS.ajax({
			url : 'filesManageService.getMessage',
			ok : function(data) {
				var str=data.count;
				  $.ajax({
			       		url: "http://"+AOS.Message_Url+"/mes/getList",
			       		type : "patch",
			       		contentType:"application/json",
			       		processData:false,
			       		dataType: "json",
			       		data: JSON.stringify({
			       				"eq_channel.code":"9527",
			       				 "eq_mesRecives.0.reciveUser.account":'${account}',
			       				 "eq_mesRecives.0.reciveUser.status":"NOT_SEND"
			       		}),
			       		success : function(data){
			       			str=data.data.length;
			       			if(str==0){
								document.getElementById('count_msg').innerHTML='<img  src="${cxt}/static/icon/notice.png" />'
							}else if(str>0&&str<=9){
								document.getElementById('count_msg').innerHTML='<img  src="${cxt}/static/icon/notice.png" />('+str+')'
							}else{
									document.getElementById('count_msg').innerHTML='<img  src="${cxt}/static/icon/notice.png" />('+9+'+'+')'
								}
							if (AOS.empty(data.msg)){}else{
						//	AOS.tip(data.msg);
							}
			       		 },
			      });
			
			}
		});
	},4000); 
	
//	function fn_show_message(){
//		Ext.get('count_msg').update('<img  src="${cxt}/static/icon/notice.png" />');
//	}
	
	//响应消息窗口跳转事件
	function grid_click() {
		AOS.get('w_webui').show();
		  $.ajax({
	       		url: "http://"+AOS.Message_Url+"/mes/getList",
	       		type : "patch",
	       		contentType:"application/json",
	       		processData:false,
	       		dataType: "json",
	       		data: JSON.stringify({
	       				"eq_channel.code":"9527",
	       				 "eq_mesRecives.0.reciveUser.account":'${account}'
	       		}),
	       		success : function(data){
	       		Ext.getCmp('message_grid').store.removeAll();
	       		Ext.each(data.data,function(item){
	       			var hasRead = item.mesRecives[0].status;
	       			var name=item.fromUser.name;
	       			var mes_id = item.id;
	       			Ext.getCmp('message_grid').store.insert(0,{
     					send_time:item.createTime,
     					msg_conunt:item.content,
     					name:name,
     					msg_id:mes_id,
     					msg_state:hasRead
	       				})
	       			}) 
	       		 },
	      });
 	}
	function  wxiaoxiShow(mod,recode,index){
		console.log(recode);
		AOS.get('w_xiaoxi').show();
		var con= AOS.get('id_content').setValue(recode.data.msg_conunt);
		var id=recode.data.msg_id;
		$.ajax({
			url: "http://"+AOS.Message_Url+"/mes/setMesToRead?mesId="+id,
			type : "post",
			contentType:"application/json",
			processData:false,	
			dataType: "json",
			success : function(data){
			}
		});
		  $.ajax({
	       		url: "http://"+AOS.Message_Url+"/mes/getList",
	       		type : "patch",
	       		contentType:"application/json",
	       		processData:false,
	       		dataType: "json",
	       		data: JSON.stringify({
	       				"eq_channel.code":"9527",
	       				 "eq_mesRecives.0.reciveUser.account":'${account}'
	       		}),
	       		success : function(data){
	       		Ext.getCmp('message_grid').store.removeAll();
	       		Ext.each(data.data,function(item){
	       			console.log(item);
	       			var hasRead = item.mesRecives[0].status;
	       			var name=item.fromUser.name;
	       			var mes_id = item.id;
	       			Ext.getCmp('message_grid').store.insert(0,{
   					send_time:item.createTime,
   					msg_conunt:item.content,
   					name:name,
   					msg_id:mes_id,
   					msg_state:hasRead
	       				})
	       			}) 
	       		 },
	      });
	}
	//消息状态图标渲染
    function flag_mes(value, metaData, record, rowIndex, colIndex,store){
		   var tmp = value;
	   		if (value=='HAD_READ') {
	   			tmp='<img src="${cxt}/static/icon/message_yd.png" align="center"/>'
			} 
	   		else{
					tmp='<img src="${cxt}/static/icon/message_wd.png" align="center"/>'
			}
			return tmp;
		}
	
	//任务详情
	function fn_show_mytask(){
		var me=this;
		var date=Ext.Date.format(new Date(), "Y-m");
		 window.open('do.jhtml?router=homeService.initTaskShow&juid=${juid}&date='+date);		
	  } 
	//打开我的个人设置
	function fn_show_myinfo() {
		Ext.getCmp('w_myinfo').show();
	}
	
	//打开修改密码窗口
	function fn_show_mypwd(){
		Ext.getCmp('w_mypwd').show();
	}

	//按钮矢量图标动画控制
	function _btn_onmouseout(me) {
		//停止ICON转动
		Ext.get(me).down('i').removeCls('fa-spin');
	}

	//按钮矢量图标动画控制
	function _btn_onmouseover(me) {
		//ICON转动
		Ext.get(me).down('i').addCls('fa-spin');
	}
	
	//显示系统时钟
	function showTime() {
		Ext.get('rTime').update(Ext.Date.format(new Date(), 'H:i:s'));
	}

	//加载完毕执行函数
	window.onload = function() {
		showTime();
		AOS.task(showTime, 1000);
		//页面加载完毕后选中第一个导航按钮
		if (!AOS.empty('${first_card_id}')) {
			var nav_tab_index_ = '0';
			if(nav_tab_index_ === '0'){
				fn_nav_btn_click('${first_card_id}');
			}
		}
	}
	<c:if test="${run_mode_ == '2'}">
    //在线演示系统自动弹出加入QQ群对话框
    window.onload=function(){
   	 setTimeout(function(){
				var downloadIframe = document.createElement('iframe');
				downloadIframe.src = '${qq_group_link}';
				downloadIframe.style.display = "none";
				document.body.appendChild(downloadIframe);
   	 },20000);
    };	
   </c:if>
</script>
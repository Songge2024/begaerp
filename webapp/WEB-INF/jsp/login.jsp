<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="${app_title}" base="http" lib="ext">
<style type="text/css">
.bodyclass {
	background-image:
		url('${cxt}/static/image/background/${login_back_img}');
	background-size: 100%;
	background-color: #1BA3F9;
	background-repeat: no-repeat;
}

.north_el {
	height: 80px;
	padding-top: 8px;
	background-image:
		url('${cxt}/static/image/background/login/${north_back_img}');
}
</style>
<aos:body class2="bodyclass">
	<div id="north_el" class="x-hidden north_el">
		<table>
			<tr>
				<td align="left" width="360"><img src="${cxt}/static/image/logo/left-logo.png"></td>
			</tr>
		</table>
	</div>
	<div id="div_vercode" class="x-hidden " align="center">
		<aos:vercode id="vercode" uuid="${vercode_uuid}" fontSize="28" characters="${vercode_characters}"
			length="${vercode_length}" />
	</div>
	<div id="system_notice"  class="x-hidden " align="left"  >
	<div>
	<span><a><img src="${cxt}/static/icon/newstitle.png" /></a></span>
	</div>
	<p>
	<span style="margin-left:20px;" ><font  face="微软雅黑" color="#1BA3F9" size="2"><a>&nbsp;&nbsp;试运行开始时间定为2018年3月16日，请各项目经理将手上的项目录入项目管理平台!</a></font></span>
	<p>
	</div>
	<div id="about"  class="x-hidden " align="left"  >
	<span><a><img src="${cxt}/static/icon/downloadDoc.png" /></a></span>
	<p>
	<span style="margin-left:20px"><font face="微软雅黑"  ><a href="http://113.240.251.178:8053/svn/888588/%E6%96%87%E6%A1%A3/06-%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C/BL3%E9%A1%B9%E7%9B%AE%E7%AE%A1%E7%90%86%E5%B9%B3%E5%8F%B0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C%EF%BC%88%E5%BC%80%E5%8F%91%E4%BA%BA%E5%91%98%EF%BC%89.doc"><img src="${cxt}/static/icon/Monday.png" />&nbsp;&nbsp;bl3项目管理平台用户手册(开发人员)</a></font></span>
	<p>
	<span style="margin-left:20px;"><font face="微软雅黑"  ><a href="http://113.240.251.178:8053/svn/888588/%E6%96%87%E6%A1%A3/06-%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C/BL3%E9%A1%B9%E7%9B%AE%E7%AE%A1%E7%90%86%E5%B9%B3%E5%8F%B0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C%EF%BC%88%E9%83%A8%E9%97%A8%E7%BB%8F%E7%90%86%EF%BC%89.doc"><img src="${cxt}/static/icon/Tuesday.png" />&nbsp;&nbsp;bl3项目管理平台用户手册(部门经理)</a></font></span>
	<p>
	<span style="margin-left:20px;"><font face="微软雅黑"  ><a href="http://113.240.251.178:8053/svn/888588/%E6%96%87%E6%A1%A3/06-%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C/BL3%E9%A1%B9%E7%9B%AE%E7%AE%A1%E7%90%86%E5%B9%B3%E5%8F%B0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C%EF%BC%88%E9%A1%B9%E7%9B%AE%E7%BB%8F%E7%90%86%EF%BC%89.doc"><img src="${cxt}/static/icon/Wednesday.png" />&nbsp;&nbsp;bl3项目管理平台用户手册(项目经理)</a></font></span>
	</div>
</aos:body>
</aos:html>

<aos:onready>
	<aos:window 
		id="w_login" 
		title="欢迎使用${app_title}" 
		maximizable="false" 
		autoShow="false" 
		closable="false"
		modal="false"
		draggable="false" 
		onshow="w_login_onshow" 
		resizable="false" 
		opacity="1" 
		y="0" 
		width="550" 
		layout="anchor"
		header="true"
	>
		<aos:panel contentEl="north_el" anchor="100%" />
		<aos:tabpanel id="id_tabs" activeTab="0" plain="false" tabBarHeight="30" height="220" anchor="100%">
			<aos:formpanel id="f_login" layout="column" labelWidth="90" border="false" title="身份认证" padding="${padding} 0 0 0"
				msgTarget="qtip" rowSpace="${row_space}">
				<aos:textfield fieldLabel="帐 号" name="account" maxLength="25" allowBlank="false" star="false" height="28"
					onenterkey="fn_accountenter" columnWidth="1" margin="0 60 0 0" />
				<aos:textfield fieldLabel="密  码" name="password" maxLength="20" allowBlank="false" star="false"
					onenterkey="fn_passwordenter" inputType="password" height="28" columnWidth="1" margin="0 60 0 0" />
				<c:if test="${is_show_vercode == '1' }">
					<aos:textfield fieldLabel="验证码" name="vercode" maxLength="${vercode_length}" allowBlank="false" star="false"
						height="28" columnWidth="0.7" onenterkey="fn_login" margin="0 15 0 0" />
					<aos:fieldset labelWidth="65" columnWidth="0.3" height="30" collapsible="false" contentEl="div_vercode"
						border="false" margin="0 60 0 0" />
					<aos:hiddenfield name="vercode_uuid" value="${vercode_uuid}" />
				</c:if>
				<%-- 
				<aos:toggle name="remberme" offText="忽略" onText="记住" state="true" columnWidth="0.4" resizeHandle="true"
					margin="0 65 0 95" /> 
					--%>
			</aos:formpanel>
			<aos:panel title="系统公告" border="false" contentEl="system_notice">
			</aos:panel>
			<aos:panel title="关于" anchor="100%"  contentEl="about" >
			</aos:panel>
		</aos:tabpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem xtype="button" onclick="fn_login" icon="user6.png" text="登 录" tooltip="登录系统" />
			<aos:dockeditem xtype="button" onclick="fn_reset" icon="icon140.png" text="重 置" tooltip="重置身份认证表单" />
		</aos:docked>
	</aos:window>
	<script type="text/javascript">
		w_login.show();
		//开发人员自动登录标志
		var login_dev_ = '${login_dev}';
		//窗口显示监听事件
		function w_login_onshow() {
			var cmp = AOS.get('f_login.account');
			cmp.focus();
		}

		//响应窗口变化事件
		Ext.EventManager.onWindowResize(function() {
			//w_login.center();
			var left = (Ext.getBody().getViewSize().width - 550) / 2;
			var top = (Ext.getBody().getViewSize().height - 430) / 2;
			w_login.setPosition(left, top, true)
		});

		//监听帐号输入框回车键
		function fn_accountenter(obj) {
			login_dev_ = '0'; //取消开发者快捷登录功能
			if (AOS.empty(obj.getValue())) {
				obj.validate();
			} else {
				AOS.get('f_login.password').focus();
			}
		}

		//监听密码输入框回车键
		function fn_passwordenter(obj) {
			if (AOS.empty(obj.getValue())) {
				obj.validate();
			} else {
				if ('${is_show_vercode}' == '1') {
					AOS.get('f_login.vercode').focus();
				} else {
					fn_login();
				}
			}
		}

		//登录窗口动画
		Ext.create('Ext.fx.Animator', {
			target : w_login,
			duration : 1000,
			easing : 'backOut',
			//easing : 'ease',
			delay : 0,
			keyframes : {
				0 : {
					opacity : 1,
					top : 0
				},
				100 : {
					opacity : 1,
					top : (Ext.getBody().getViewSize().height - 430) / 2
				}
			}
		});

		//验证码首次加载动画
		var _elvercode = Ext.get('vercode');
		var vercodetask = new Ext.util.DelayedTask(function() {
			_elvercode.switchOff();
			_elvercode.fadeIn();
		});
		vercodetask.delay(1000);

		//表单校验
		function fn_check() {
			var flag = f_login.isValid();
			//可以继续做其它检查，验证不通过则flag=false即可
			//
			return flag;
		}

		//登录提交
		function fn_login() {
			if (!fn_check()) {
				return;
			}
			AOS.mask('${login_wait_msg}');
			AOS
					.ajax({
						forms : f_login,
						url : 'homeService.login',
						wait : false,
						ok : function(data) {
							if (data.appcode === '1') {
								Ext.util.Cookies.set('juid', data.juid);
								fn_login_success();
								window.location.href = 'do.jhtml?router=homeService.initIndex&juid='
										+ data.juid;
							} else {
								Ext.util.Cookies.clear('juid');
								AOS.unmask();
								AOS.info(data.appmsg, function() {
									if (data.appcode === '000') {
										//验证码错误
										AOS.get('f_login.vercode').focus();
									} else if (data.appcode === '001') {
										//帐号错误
										AOS.get('f_login.account').focus();
									} else if (data.appcode === '002') {
										//密码错误
										AOS.get('f_login.password').reset();
										AOS.get('f_login.password').focus();
										AOS.get('f_login.password')
												.validate();
									}
								});
							}
						}
					});
		}

		//开发者快捷登录提交
		function fn_login_dev() {
			AOS.mask('${login_wait_msg}');
			AOS
					.ajax({
						params : {
							account : '${login_dev_account}'
						},
						url : 'homeService.loginDev',
						wait : false,
						ok : function(data) {
							if (data.appcode == '1') {
								Ext.util.Cookies.set('juid', data.juid);
								fn_login_success();
								window.location.href = 'do.jhtml?router=homeService.initIndex&juid='
										+ data.juid;
							} else {
								AOS.err('开发用户快捷登录发生错误。');
							}
						}
					});
		}

		//开发者快捷登录
		AOS.job(function() {
			if (login_dev_ == '1') {
				fn_login_dev();
			}
		}, 1500);

		//登录成功动画
		function fn_login_success() {
			Ext.create('Ext.fx.Animator', {
				target : w_login,
				duration : 350,
				easing : 'ease',
				delay : 250,
				keyframes : {
					0 : {
						opacity : 1,
						top : (Ext.getBody().getViewSize().height - 430) / 2
					},
					100 : {
						opacity : 1,
						top : Ext.getBody().getViewSize().height - 430
					}
				}
			});
		}

		//登录窗口重置
		function fn_reset() {
			f_login.form.reset();
		}
	</script>
</aos:onready>
<html>
<body>
</body>
</html>
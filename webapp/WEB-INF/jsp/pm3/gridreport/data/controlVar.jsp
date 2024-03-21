<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript">
	var gr_InstallPath = "grinstall";
	var gr_Version = "6,0,15,0819";

	//以下注册号为本机开发测试注册号，报表访问地址为localhost时可以去掉试用标志
	//购买注册后，请用您的注册用户名与注册号替换下面变量中值
	var gr_UserName = '锐浪报表插件本机开发测试注册';
	var gr_SerialNo = '8PJH495VA61FLI5TG0L4KB2337F1G7AKLD6LNNA9F9T28IKRU6N33P8Z6XX4BUYB5E9NZ6INMD5T8EN47IX63VV7F9BJHB5ZJQQ6MX3J3V12C4XDHU97SXX6X3VA57KCB6';

	//区分浏览器(IE or not)
	var _gr_agent = navigator.userAgent.toLowerCase();
	var _gr_isIE = (_gr_agent.indexOf("msie")>0)? true : false;
	var gr_CodeBase;
	if( _gr_isIE )
	    gr_CodeBase = 'codebase="' + gr_InstallPath + '/grbsctl5.cab#Version=' + gr_Version + '"';
	else
	    gr_CodeBase = ''; //'codebase="' + gr_InstallPath + '/grbsctl5.xpi"';
	    
</script>
</head>
<body>
</body>
</html>


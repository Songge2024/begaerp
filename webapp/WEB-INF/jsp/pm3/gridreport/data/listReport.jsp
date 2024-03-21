<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:include page="controlVar.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印预览</title>
<style type="text/css">
    html,body {
        margin:0;
        height:100%;
    }
</style>

</head>
<body>

<script type="text/javascript">
function Install_InsertReport()
{
	
    var typeid;
    if( _gr_isIE )
    	//396841CC-FC0F-4989-8182-EBA06AA8CA2F
        typeid = 'classid="clsid:396841CC-FC0F-4989-8182-EBA06AA8CA2F" ';
    else
        typeid = 'type="application/x-grplugin6-report" ';
    typeid += gr_CodeBase;
	document.write('<object id="_ReportOK" ' + typeid);
	document.write(' width="0" height="0" VIEWASTEXT>');
	document.write('</object>');
}
Install_InsertReport();
//以 ReportViewer 为 ID 创建报表查询显示器插件(DisplayViewer)，参数说明参考 CreateDisplayViewerEx2

function CreateDisplayViewerEx(Width, Height, ReportURL, DataURL, AutoRun, ExParams)
{   
    CreateDisplayViewerEx2("ReportViewer", Width, Height, ReportURL, DataURL, AutoRun, ExParams)
}

//用更多的参数创建报表打印显示插件，详细请查看帮助中的 IGRDisplayViewer
//PluginID - 插件的ID，可以通过 var ReportViewer = document.getElementById("%PluginID%"); 这样的方式获取插件引用变量
//Width - 插件的显示宽度，"100%"为整个显示区域宽度，"500"表示500个屏幕像素点
//Height - 插件的显示高度，"100%"为整个显示区域高度，"500"表示500个屏幕像素点
//ReportURL - 获取报表模板的URL
//DataURL - 获取报表数据的URL
//AutoRun - 指定插件在创建之后是否自动生成并展现报表,值为false或true
//ExParams - 指定更多的插件属性阐述,形如: "<param name="%ParamName%" value="%Value%">"这样的参数串
function CreateDisplayViewerEx2(PluginID, Width, Height, ReportURL, DataURL, AutoRun, ExParams)
{
  var typeid;
  if( _gr_isIE )
      typeid = 'classid="clsid:600CD6D9-EBE1-42cb-B8DF-DFB81977122E" ' + gr_CodeBase;
  else
      typeid = 'type="application/x-grplugin6-displayviewer"';
	document.write('<object id="' + PluginID + '" ' + typeid);
	document.write(' width="' + Width + '" height="' + Height + '">');
	document.write('<param name="ReportURL" value="' + ReportURL + '">');
	document.write('<param name="DataURL" value="' + DataURL + '">');
	document.write('<param name="AutoRun" value=' + AutoRun + '>');
	document.write('<param name="SerialNo" value="' + gr_SerialNo + '">');
	document.write('<param name="UserName" value="' + gr_UserName + '">');
	document.write(ExParams);
	document.write('</object>');
}
 var Installed = Install_Detect();
 if ( Installed ){
	CreateDisplayViewerEx("100%", "99%", "${report}", encodeURI("${data}"), true, null);
 }
 
//用来判断插件是否已经安装，或是否需要安装更新版本。如果需要安装，则在网页中插入安装相关的文字内容
//如果插件已经安装且也不要更新，则返回 true，反之为 false。
//此函数应该在网页的<body>开始位置处调用，具体请看例子 ReportHome.htm 中的用法
function Install_Detect()
{
   var _ReportOK = document.getElementById("_ReportOK");
   if (_ReportOK.Register == undefined) //if ((_ReportOK == null) || (_ReportOK.Register == undefined))
   {
       document.write('<div style="width: 100%; background-color: #fff8dc; text-align: center; vertical-align: middle; line-height: 20pt; padding-bottom: 12px; padding-top: 12px;">');
           document.write('<strong> 此网站需要安装 锐浪报表插件 才能保证其正常运行<br /></strong>');
           
       if( _gr_isIE )
           document.write('<strong><span style="color: #ff0000"> 如浏览器的顶部或底部出现提示条，左键点击提示条并运行加载项，按此方式安装最简便</span><br /></strong>');
           
           document.write('<a href="' + gr_InstallPath + '/grbsctl6.exe"><span style="color: #ff0000"><strong>点击此处下载锐浪报表插件安装包<br /></strong></span></a>');
           document.write('锐浪报表插件安装后，<a href="#" onclick="javascript:document.location.reload();">点击此处</a> 重新加载此网站');
       document.write('</div>');
       return false;
   }
   else if ((_ReportOK.Utility.ShouldUpdatePlugin == undefined) || _ReportOK.Utility.ShouldUpdatePlugin(gr_Version) == true)  //检查是否应该下载新版本程序
   {
       document.write('<div style="width: 100%; background-color: #fff8dc; text-align: center; vertical-align: middle; line-height: 20pt; padding-bottom: 12px; padding-top: 12px;">');
           document.write('<strong> 此网站需要升级安装 锐浪报表插件 才能保证其正常运行<br /></strong>');
           document.write('<a href="' + gr_InstallPath + '/grbsctl6.exe"><span style="color: #ff0000"><strong>点击此处下载锐浪报表插件安装包<br /></strong></span></a>');
           document.write('插件安装时必须关闭网页窗口，点击本网页窗口的关闭按钮进行关闭，安装完成后再重新打开本网页<br />');
           document.write('如安装中出现“不能打开要写入的文件...”的提示时，请将网页窗口关闭，然后点击“重试”按钮继续安装');
       document.write('</div>');
       return false;
   }
   
   return true;
}
</script>
</body>

</html>

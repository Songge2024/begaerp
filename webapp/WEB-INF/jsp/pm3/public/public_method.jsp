<!-- 公共参数及方法处理  -->
<%@page import="com.bl3.pm.task.service.TaskService"%>
<%@page import="aos.framework.core.typewrap.Dto"%>
<%@page import="java.util.List"%>
<%@page import="com.google.common.collect.Lists"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	String juid=request.getAttribute("juid").toString();
	UserModel userModel=AOSCxt.getUserModel(juid);
	//获得个人信息
	request.setAttribute("user", userModel);
	
	TaskService taskService=(TaskService)AOSCxt.getBean("taskService");
	
	//项目类型
	
	
%>




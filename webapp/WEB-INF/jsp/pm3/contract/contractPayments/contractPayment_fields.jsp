<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//获取当前时间
	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();
	String time = simpleDateFormat.format(currentTime).toString();
	request.setAttribute("time", time);
%>
	<aos:hiddenfield name="ct_pay_id" fieldLabel="支付ID" />
	<aos:hiddenfield name="ct_id" fieldLabel="合同ID" />
	<aos:textfield name="pay_name" fieldLabel="支付名称"  maxLength="100" allowBlank="false" columnWidth="0.5"/>
	<aos:numberfield name="pay_money" fieldLabel="支付金额(元)"  allowBlank="false" minValue="0" maxValue="2147483647" columnWidth="0.5"/>
	<aos:datetimefield name="pay_time" fieldLabel="支付时间" allowBlank="false"  format="Y-m-d H:i:s" value="${time}" columnWidth="0.5"/>
	<aos:textfield name="pay_object" fieldLabel="支付人" allowBlank="false" maxLength="20" columnWidth="0.5"/>
	<aos:textfield name="pay_condition" fieldLabel="支付条件" allowBlank="true" maxLength="100" columnWidth="0.5"/>
	<aos:textfield name="pay_remark" fieldLabel="备注" allowBlank="true" maxLength="200" columnWidth="0.5" />
	<aos:hiddenfield name="create_user_id" fieldLabel="创建人" />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" />
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" />
	<aos:hiddenfield name="state" fieldLabel="状态" />

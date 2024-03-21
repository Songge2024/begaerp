<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@page import="java.util.Calendar"%>
<%
   Calendar date = Calendar.getInstance();
   int year = date.get(Calendar.YEAR);
   int month = date.get(Calendar.MONTH);
   int day = date.get(Calendar.DATE);
   String dateValue = "";
   dateValue = year+"-"+(month+1)+"-"+day;
   pageContext.setAttribute("dateValue", dateValue);
 %>


	<aos:hiddenfield name="ct_id" fieldLabel="合同ID" />
	<aos:textfield name="cont_name" fieldLabel="合同名称" allowBlank="false" maxLength="100" columnWidth=".5"/>
	<aos:textfield name="cont_type" fieldLabel="合同类型" allowBlank="false" maxLength="20" columnWidth=".5"/>
	<aos:datefield name="cp_bengin_date" fieldLabel="合同开始日期" value="${dateValue}" onselect="cp_bengin_date_onselect" format="Y-m-d" editable="false" allowBlank="false" columnWidth=".5"/>
	<aos:datefield name="cp_end_date" fieldLabel="合同结束日期" minValue="${dateValue}" editable="false" format="Y-m-d" allowBlank="false" columnWidth=".5"/>
	<aos:combobox name="cp_type" fieldLabel="合同状态" dicField="re_cp_type" allowBlank="false" columnWidth=".5"/>
	<aos:numberfield name="total_money" fieldLabel="总金额" allowBlank="true" minValue="0" maxValue="9999999999" columnWidth=".5"/>
	<aos:datefield name="sign_time" fieldLabel="签订时间" allowBlank="true" columnWidth=".5"/>
	<aos:textfield name="cont_desc" fieldLabel="合同描述" allowBlank="true" maxLength="200" columnWidth="1"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="check_id" fieldLabel="检查单目录ID" />
	<aos:textfield name="check_code" fieldLabel="检查项编码" allowBlank="false" maxLength="60"/>
	<aos:textfield name="proj_id" fieldLabel="proj_id" allowBlank="false" maxLength="10"/>
	<aos:textfield name="check_cata_id" fieldLabel="检查项维护ID" allowBlank="false" maxLength="10"/>
	<aos:textfield name="check_name" fieldLabel="检查单名称" allowBlank="true" maxLength="300"/>
	<aos:textfield name="comment" fieldLabel="说明" allowBlank="true" maxLength="3000"/>
	<aos:textfield name="yes_num" fieldLabel="统计 符合数" allowBlank="true" maxLength="10"/>
	<aos:textfield name="no_num" fieldLabel="统计 不符合数" allowBlank="true" maxLength="10"/>
	<aos:textfield name="none_num" fieldLabel="统计 不适应数" allowBlank="true" maxLength="10"/>
	<aos:textfield name="suggest" fieldLabel="建议与意见" allowBlank="true" maxLength="3000"/>
	<aos:textfield name="check_user_id" fieldLabel="检查人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="check_time" fieldLabel="检查时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="create_user_id" fieldLabel="创建人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="update_user_id" fieldLabel="更新人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="更新时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="state" fieldLabel="状态" allowBlank="true" maxLength="12"/>
	<aos:textfield name="plan_check_time" fieldLabel="计划检查时间" allowBlank="true" maxLength="19"/>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="项目风险ID" dataIndex="risk_id" width="100" hidden="true"/>
	<aos:column header="风险目录ID" dataIndex="risk_cata_id" width="100" hidden="true"/>
	<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true" />
	<aos:column header="风险目录" dataIndex="risk_cata_id_name" width="300" />
	<aos:column header="风险描述" dataIndex="risk_cata_name" width="300" />
	<aos:column header="发生概率(%)" dataIndex="happ_probability" width="120" rendererFn="fn_probability_render" align="right"/>
	<aos:column header="影响程度" dataIndex="influe_degree"  width="100" align="center" rendererFn="fn_influe_render"/>
	<aos:column header="风险等级" dataIndex="risk_level" rendererFn="fn_level_render" width="100" align="center" />
	<aos:column header="风险响应计划" dataIndex="risk_resp_plan" width="300" />
	<aos:column header="责任人" dataIndex="risk_owner" width="60" />
	<aos:column header="开放/关闭 " dataIndex="open_close" rendererFn="fn_open_render" width="80" align="center" />

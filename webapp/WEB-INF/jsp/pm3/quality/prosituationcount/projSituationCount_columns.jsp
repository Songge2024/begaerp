<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="部门名称" dataIndex="dep_name" width="100" align="center" />
	<aos:column header="项目名称" dataIndex="proj_name" width="150" />
	<aos:column header="项目状态" dataIndex="state_name" width="100"   align="center" />
	<aos:column header="进度状态" dataIndex="plan_state" width="100"  align="center"  />
	<aos:column header="工作量状态" dataIndex="workload_state" width="100" align="center"  />
	<aos:column header="实际开始日期" dataIndex="begin_date" width="150" type="date" format="Y-m-d" align="center"  />
	<aos:column header="计划结项日期" dataIndex="plan_completion_time" width="150" type="date" format="Y-m-d" align="center"    />
	<aos:column header="计划工期" dataIndex="plan_end_time" width="150" align="right" />
	<aos:column header="已实施工期" dataIndex="emb_time" width="150"  align="right" />
	<aos:column header="计划完工比例" dataIndex="plan_finish_ratio" width="150" align="right"  rendererFn="fn_percent" />
	<aos:column header="实际完工比例" dataIndex="real_finish_ratio" width="150" align="right"  rendererFn="fn_percent"  />
	<aos:column header="估算工作量" dataIndex="est_workload" width="150"  align="right" />
	<aos:column header="预计投入工作量" dataIndex="real_wastage" width="180" align="right" />
	<aos:column header="实际投入工作量 " dataIndex="	" width="180" align="right" />
	<aos:column header="计划值（PV） " dataIndex="plan_wastage" width="150" align="right" />
	<aos:column header="实际工作量（AC） " dataIndex="reali_workload" width="180"  align="right" />
	<aos:column header="挣值（EV） " dataIndex="real_wastage" width="150" align="right" />
	<aos:column header="进度偏差（SV） " dataIndex="sv" width="180"  align="right" />
	<aos:column header="进度绩效指数（SPI）" dataIndex="spi" width="180" align="right" rendererFn="fn_percent" />
	<aos:column header="工作量偏差（CV）" dataIndex="cv" width="180" align="right"  />
	<aos:column header="工作量绩效指数（CPI） " dataIndex="cpi" width="180"  align="right"  rendererFn="fn_percent" />
	<aos:column header="预测结项日期 " dataIndex="pdd_completion_time" width="150" type="date" format="Y-m-d" align="center"   />
	<aos:column header="预测结项时工作量" dataIndex="pdd_completion_work" width="180"  align="right" />
	
	
	

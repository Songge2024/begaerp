<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="id" dataIndex="register_id"  hidden="true"/>
	<aos:column header="姓名" dataIndex="name" fixedWidth="100" summaryType="count" align="center" summaryRenderer="function(v){return '共 '+ v +' 条'}" />
	<aos:column header="性别" dataIndex="sex" fixedWidth="80" rendererField="sex" align="center"/>
	<aos:column header="联系方式" fixedWidth="100" dataIndex="link_phone"  />
	<aos:column header="来源" fixedWidth="80" dataIndex="source"  />
	<aos:column header="登记备注" fixedWidth="100" dataIndex="register_remark"  />
	<aos:column header="登记日期" fixedWidth="120" dataIndex="register_date"  align="center" type="date" format="Y-m-d" />
	<aos:column header="登记人" fixedWidth="100" dataIndex="register_user_id"  hidden="true"/>
	<aos:column header="登记人" fixedWidth="100" dataIndex="register_user_name" align="center" />
	<aos:column header="联系日期" fixedWidth="120" dataIndex="contact_date"  type="date" format="Y-m-d" align="center"/>
	<aos:column header="联系人" fixedWidth="100" dataIndex="contact_user_id" hidden="true" />
	<aos:column header="联系人" fixedWidth="100" dataIndex="contact_user_name"  align="center"/>
	<aos:column header="联系结果" fixedWidth="100" dataIndex="contact_result"  />
	<aos:column header="联系情况" fixedWidth="100" dataIndex="contact_information"/>
	<aos:column header="约定面试日期" fixedWidth="100" dataIndex="interview_date" type="date" format="Y-m-d" align="center" />
	<aos:column header="Id" dataIndex="result_id" fixedWidth="100" hidden="true" />
	<aos:column header="人员基本情况" dataIndex="base_situation" fixedWidth="100" />
	<aos:column header="面试类型" dataIndex="interview_type" fixedWidth="80" align="center" hidden="true" />
	<aos:column header="笔试分数" dataIndex="written_score" fixedWidth="80" align="right" />
	<aos:column header="面试分数" dataIndex="interview_score" fixedWidth="80" align="right" />
	<aos:column header="面试官" dataIndex="interviewer" fixedWidth="100"  align="center" />
	<aos:column header="实际面试时间" dataIndex="real_interviewer_time" align="center" fixedWidth="110" type="date" format="Y-m-d" maxWidth="150" />
	<aos:column header="面试结果" dataIndex="interview_result"  fixedWidth="100" align="center" rendererFn="fn_render_result" />
	<aos:column header="结论说明" dataIndex="conclusion" fixedWidth="100" />
	<aos:column header="id" dataIndex="entry_id" hidden="true" />
	<aos:column header="入职类型" dataIndex="entry_type"  fixedWidth="100"  rendererField="entry_type" />
	<aos:column header="入职时间" dataIndex="entry_date" fixedWidth="120"  type="date" format="Y-m-d"/>
	<aos:column header="入职岗位" dataIndex="entry_post" fixedWidth="100"  rendererField="entry_post"/>
	<aos:column header="经验" dataIndex="experience" fixedWidth="100" />
	<aos:column header="培训情况" dataIndex="train_situation" fixedWidth="100" />
	<aos:column header="备注" dataIndex="result_remark" fixedWidth="100" />
	

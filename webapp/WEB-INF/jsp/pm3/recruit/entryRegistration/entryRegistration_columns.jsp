<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="结果id" dataIndex="result_id" hidden="true" />
	<aos:column header="id" dataIndex="entry_id" hidden="true" />
	<aos:column header="姓名" dataIndex="name"  width="100" />
	<aos:column header="性别" dataIndex="sex"  rendererField="sex" align="center" width="60"/>
	<aos:column header="联系方式" dataIndex="link_phone" width="100"  />
	<aos:column header="入职类型" dataIndex="entry_type"  width="100"  rendererField="entry_type" />
	<aos:column header="入职时间" dataIndex="entry_date" width="120"  type="date" format="Y-m-d"/>
	<aos:column header="入职岗位" dataIndex="entry_post" width="100"  rendererField="entry_post"/>
	<aos:column header="经验" dataIndex="experience" width="100" />
	<aos:column header="培训情况" dataIndex="train_situation" width="100" />
	<aos:column header="创建人Id" dataIndex="create_user_id" hidden="true"  />
	<aos:column header="更新人id" dataIndex="update_user_id" hidden="true"  />
	<aos:column header="创建时间" dataIndex="create_time" hidden="true"  />
	<aos:column header="更新时间" dataIndex="update_time" hidden="true"  />
	<aos:column header="备注" dataIndex="result_remark" width="100" />

<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ include file="user_task_view.jsp" %>

<script type="text/javascript">
//我的待办任务刷新
window.onbeforeunload = function() {
	window.opener.document.getElementById('page_refresh').click()
}
</script>
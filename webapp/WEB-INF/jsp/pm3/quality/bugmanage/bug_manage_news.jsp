<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ include file="bugNews.jsp" %>

<script type="text/javascript">
	window.onbeforeunload = function() {
		window.opener.document.getElementById('bug_page_refresh').click()
	}
</script>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="需求文件信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="上传" onclick="demandActionFile_upload" icon="up.png" />
	<aos:dockeditem text="下载" onclick="demandActionFile_down" icon="down.png" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="demandActionFile_delete" />
</aos:docked>
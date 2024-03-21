<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="fad_id" dataIndex="fad_id" fixedWidth="100" hidden="true"/>
	<aos:column header="AD_ID" dataIndex="ad_id" fixedWidth="100" hidden="true"/>
	<aos:column header="文件名称" dataIndex="fad_name" fixedWidth="150" align="center"/>
	<aos:column header="文件大小" dataIndex="fad_size" fixedWidth="100" align="right"/>
	<aos:column header="文件存放位置" dataIndex="fad_path" fixedWidth="300" align="left"/>
	<aos:column header="文件访问地址" dataIndex="fad_adress" fixedWidth="300" align="left"/>
	<aos:column header="修改人员" dataIndex="update_user_id" hidden="true" fixedWidth="100" />
	<aos:column header="修改时间" dataIndex="update_time" hidden="true" fixedWidth="100" />
	<aos:column header="创建人" dataIndex="create_user_id" hidden="true" fixedWidth="100" />
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150" align="center"/>
	<aos:column header="状态" dataIndex="state" hidden="true" fixedWidth="100" />

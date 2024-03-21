<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="fad_id" fieldLabel="ID" />
	<aos:textfield name="ad_id" fieldLabel="AD_ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="fad_name" fieldLabel="文件名称" allowBlank="true" maxLength="60"/>
	<aos:textfield name="fad_size" fieldLabel="文件大小" allowBlank="true" maxLength="11"/>
	<aos:textfield name="fad_path" fieldLabel="文件存放位置" allowBlank="true" maxLength="600"/>
	<aos:textfield name="fad_adress" fieldLabel="文件访问地址" allowBlank="true" maxLength="600"/>
	<aos:textfield name="update_user_id" fieldLabel="修改人员" hidden="true" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="修改时间" allowBlank="true" hidden="true" maxLength="19"/>
	<aos:textfield name="create_user_id" fieldLabel="创建人" allowBlank="true" hidden="true" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="state" fieldLabel="状态" allowBlank="true" hidden="true" maxLength="12"/>

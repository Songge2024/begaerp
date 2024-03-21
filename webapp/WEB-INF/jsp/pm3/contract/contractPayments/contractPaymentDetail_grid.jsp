<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="contractPaymentDetail_grid" 
	url="contractPaymentDetailService.page" 
	forceFit="true"
 	region="center"
  	hidePagebar="true"
  	columnLines="true"
  	features="summary"
  >
	<aos:docked >
	<aos:dockeditem xtype="tbtext" text="合同回款明细信息" />
	<aos:dockeditem xtype="tbseparator" />
	</aos:docked>
	<aos:column type="rowno" />
	<%@ include file="contractPaymentDetail_columns.jsp"%>
</aos:gridpanel>
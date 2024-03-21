<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_contract_file" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="north"  height ="140" >
			<%@ include file="contract_form.jsp"%>
		</aos:panel>
		<aos:panel  region="west"  bodyBorder="0 1 0 0" width= "500">
			<%@ include file="contractStage_grid.jsp"%>
		</aos:panel>
		<aos:panel region="center" border="false">
		<aos:layout type="vbox" align="stretch"/>
			<aos:panel   flex="1" >
				<%@ include file="contractPayment_grid.jsp"%>
			</aos:panel>
			<aos:panel flex="1"  >
				<%@ include file="contractPaymentDetail_grid.jsp"%>
			</aos:panel>
		</aos:panel>
	</aos:viewport>
	<%@ include file="contractPayment_handler.jsp"%>
	<%@ include file="contractPayment_win.jsp"%>
	<%@ include file="contractPaymentDetail_handler.jsp"%>
	<%@ include file="contractPaymentDetail_win.jsp"%>
</aos:onready>
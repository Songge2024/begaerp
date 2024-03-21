<%@ page contentType="text/html; charset=utf-8"%>

//查询
function templet_query() {
	var params = AOS.getValue('query_form');
    templet_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    templet_grid_store.loadPage(1);
}



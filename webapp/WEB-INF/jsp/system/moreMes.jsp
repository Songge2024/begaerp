<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="aos.framework.web.router.HttpModel"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>

	<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	int userid = userModel.getId();
%>
<aos:html title="消息" base="http" lib="ext,echart">
<link rel="stylesheet" type="text/css" href="${cxt}/static/weblib/buttons/css/buttons.css" />
<link rel="stylesheet" type="text/css" href="${cxt}/static/weblib/buttons/js/buttons.js" />
</aos:html>
<aos:body >

</aos:body>
<aos:onready>
    <aos:viewport layout="border" >
    	<aos:formpanel id="query_form_mes" layout="column" labelWidth="70"
			header="false" region="north" border="false">
			<aos:textfield fieldLabel="项目名称" name="proj_name" 
					margin="0 10 0 0" columnWidth="0.2" />
				<aos:combobox fieldLabel="日期" name="main_time" columnWidth="0.14"
							margin="0 -10 0 -40" onselect="fn_change" >
							<aos:option value="4" display="当天" />
							<aos:option value="1" display="本周" />
							<aos:option value="2" display="本月" />
							<aos:option value="3" display="本年" />
				</aos:combobox>
				<aos:datefield name="plan_begin_time" fieldLabel="开始时间" 
					format="Y-m-d" columnWidth="0.18" editable="false" margin="0 -10 0 0" />
				<aos:datefield name="plan_end_time" fieldLabel="结束时间"
					format="Y-m-d" columnWidth="0.18" editable="false" margin="0 0 0 0" />
			<aos:dockeditem xtype="button" text="查询" onclick="query_button_click"
				margin="0 10 0 50" icon="query.png" />
			<aos:dockeditem xtype="button" text="重置"
				onclick="AOS.reset(query_form_mes);" margin="0 40 0 2"
				icon="refresh.png" />
		</aos:formpanel>
                    <aos:panel region="center"    >
                    <aos:gridpanel id="count_mes"   forceFit="true"  hidePagebar="true"  onrender="fn_mes" >
                        <aos:docked forceBoder="0 0 0 0" region="sourth" >
                        </aos:docked>
                          <aos:column header="项目ID" dataIndex="proj_id" width="50"  hidden="true"  align="center"/>
                          <aos:column header="状态" dataIndex="hasRead" width="20" rendererFn="flag_mes"   align="center"/>
                          <aos:column header="消息类型" dataIndex="type" width="40"   align="left"/>
		                  <aos:column header="消息内容" dataIndex="content"  width="260" />
		                  <aos:column header="项目名称" dataIndex="proj_name"  width="100" />
		                  <aos:column header="消息时间" dataIndex="createTime"  />
                   </aos:gridpanel>
                    </aos:panel>
        

       
    </aos:viewport>
    <script type="text/javascript">
    function query_button_click(){
 	   var plan_begin_time = AOS.getValue('query_form_mes.plan_begin_time');
 	   var plan_end_time = AOS.getValue('query_form_mes.plan_end_time');
 	   var proj_name = AOS.getValue('query_form_mes.proj_name');
 	   if(plan_begin_time!=null&&plan_end_time!=null){
 		   var end_time = Ext.Date.format(Ext.Date.add(plan_end_time,Ext.Date.DAY,1),'Y-m-d');
 		   var begin_time = Ext.Date.format(Ext.Date.add(plan_begin_time,Ext.Date.DAY,0.5),'Y-m-d');
 	   }
 	   var proj_id = '${proj_id}'
 	if(proj_id!=''){
 	   $.ajax({
 		   url: "http://"+AOS.Message_Url+"/mes/getList",
 			type : "patch",
 			contentType:"application/json",
 			processData:false,
 			dataType: "json",
 			data: JSON.stringify({
 	     				"in_extras.proj_id":proj_id,
 					    "great_extras.sedTime":begin_time,
 					    "less_extras.createTime":end_time,
 					   "regx_extras.proj_name":proj_name
 				}),
 			success : function(data){
 				count_mes_store.removeAll();
 				var arrayList=[];
 				Ext.Array.each(data.data,function(item){
 					arrayList.push(item);
 				})
 			Ext.each(arrayList,function(item){
 				var content =JSON.parse(item.content).content;
 				var proj_id =JSON.parse(item.content).proj_id;
 				var type =JSON.parse( item.content ).type;
 				var proj_name =JSON.parse( item.content ).proj_name;
 				var hasRead = item.mesRecives[0].status;
     			var mes_id = item.id;
     						count_mes_store.insert(0,{
     							content:content,
     							proj_id:proj_id,
     							proj_name:proj_name,
     							type:item.title,
     							createTime:item.createTime,
     							id:item.id,
     							hasRead:hasRead
     						})
 			})
 			
 			},
 		});
 	}
    }
    
    function fn_mes(){
 	   var proj_id = '${proj_id}'
 	   AOS.setValue('query_form_mes.plan_begin_time', '${plan_begin_time}');
	   AOS.setValue('query_form_mes.plan_end_time', '${plan_end_time}');
	   AOS.setValue('query_form_mes.proj_name', '${proj_name}');
	   AOS.setValue('query_form_mes.main_time', '2');
 	   if(proj_id!=''){
 		   $.ajax({
 			   url: "http://"+AOS.Message_Url+"/mes/getList",
 				type : "patch",
 				contentType:"application/json",
 				processData:false,
 				dataType: "json",
 				data: JSON.stringify({
 					    "eq_channel.code":"9527",
 	     				"eq_mesGroup":"CHANNEL",
 	     				"in_extras.proj_id":proj_id
 					}),
 				success : function(data){
 					var arrayList=[];
 					Ext.Array.each(data.data,function(item){
 						arrayList.push(item);
 					})
 				Ext.each(arrayList,function(item){
 					var content =JSON.parse(item.content).content;
 					var proj_id =JSON.parse(item.content).proj_id;
 					var type =JSON.parse( item.content ).type;
 					var proj_name =JSON.parse( item.content ).proj_name;
 					var hasRead = item.mesRecives[0].status;
         			var mes_id = item.id;
         						count_mes_store.insert(0,{
         							content:content,
         							proj_id:proj_id,
         							proj_name:proj_name,
         							type:item.title,
         							createTime:item.createTime,
         							id:item.id,
         							hasRead:hasRead
         						})
         					
 				})
 				
 				},
 			});
 	   }
 	  query_button_click();
    }
    function flag_mes(value, metaData, record, rowIndex, colIndex,store){
 	   var tmp = value;
   		if (value=='HAD_READ') {
   			tmp='<img src="${cxt}/static/icon/message_yd.png" align="center"/>'
 		} 
   		else{
 				tmp='<img src="${cxt}/static/icon/message_wd.png" align="center"/>'
 		}
 		return tmp;
 		}
    
   
 //查询时间段改变
	function fn_change(obj) {
		var val = obj.getValue();
		var date_ = '${plan_begin_time}';
		var date1_ = '${plan_end_time}';
		var today_date_ = '${today_date}';
		var year_begin_date_ = '${year_begin_date}';
		var year_end_date_ = '${year_end_date}';
		var recently_begin_date_ = '${recently_begin_date}';
		var recently_end_date_ = '${recently_end_date}';
		var week_begin_date_ = '${week_begin_date}';
		var week_end_date_ = '${week_end_date}';
		if (val == "1") {
			AOS.setValue('query_form_mes.plan_begin_time', week_begin_date_);
			AOS.setValue('query_form_mes.plan_end_time', week_end_date_);
		} else if (val == "2") {
			AOS.setValue('query_form_mes.plan_begin_time', date_);
			AOS.setValue('query_form_mes.plan_end_time', date1_);
		} else if (val == "3") {
			AOS.setValue('query_form_mes.plan_begin_time', year_begin_date_);
			AOS.setValue('query_form_mes.plan_end_time', year_end_date_);

		} else if (val == "4") {
			AOS.setValue('query_form_mes.plan_begin_time', today_date_);
			AOS.setValue('query_form_mes.plan_end_time', today_date_);
		}

	}
	     
    </script>
</aos:onready>

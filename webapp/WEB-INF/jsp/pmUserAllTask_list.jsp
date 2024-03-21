<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	String userid = userModel.getId().toString();
%>
<%
	//获取当前时间
	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.text.SimpleDateFormat mdate = new java.text.SimpleDateFormat("yyyy-MM");
	java.util.Date currentTime = new java.util.Date();
	String end_t = simpleDateFormat.format(currentTime).toString();
	request.setAttribute("end_t", end_t);
	//获取当前时间的月初时间
	String begin_t = simpleDateFormat.format(currentTime).toString().substring(0,7).concat("-01");
	request.setAttribute("begin_t", begin_t);
	request.setAttribute("date", mdate.format(currentTime));
%>
<aos:html title="组员所有项目任务展示" base="http" lib="ext,echart,ueditor">
<script src="${cxt}/static/weblib/jquery/jquery.min-1.10.2.js"></script>

<style type="text/css">
.x-grid-cell.red { 
background:#FF69B4; 
} 
.x-grid-cell.green { 
background:#98FB98; 
} 
.x-grid-cell.blue { 
background:#87CEFA; 
} 
.x-grid-cell.gray { 
background:#B0E0E6; 
} 
.tablestyle {
 border:1px solid #99bde9;
}

.tablestyle table{
    width: 100%;
    margin:0 auto;
}

.tablestyle table td {
color: #000;
padding: 5px 0;
text-indent: 0em;
font-weight: 0;

}


.tablestyle thead th em{font-style: normal; font-weight: bold;}
.tablestyle thead th {
background-color: #00EEEE;
color: #14498b;
text-align: left;
padding:6px 1em;
line-height: 1.8em;
font-size: 18px;
font-weight: lighter;
text-align: center;

}
.tablestyle table tr,.tablestyle table th {

}




.tablestyle tr td:nth-of-type(1){ width: 6%; padding-right: 1em; color: #777; }

.tablestyle thead th span:nth-of-type(1){ float: right;}

.tablestyle table tr {background:#f5fafe;}

.tablestyle tbody   th:nth-child(odd) {background:#D3D3D3; height:30px}


.text-center{
	text-align: center;
}
.text-right{
	text-align: right;
}
</style>
<script type="text/javascript">
	function stepToTask(id,name,state_name,proj_ids){
		if(state_name=="未完成"){
			state_name="1002,1003";
		}else{
			state_name="1004,1005";
		}
		window.open("do.jhtml?router=taskService.initPmUserTaskView&juid=${juid}&id="+id+"&proj_name="+name+"&states="+state_name+"&proj_id="+proj_ids);
	}
</script>
</aos:html>
<aos:body>
<div class="x-hidden" > 
<div class="tablestyle"  id="tablestyle_id">
<table id="test" >
 <thead>
    <tr>
      <th colspan="26"   style ="text-align:center;background-color: #6098CC;font-size: 30px" ><em style="font-size: 30px">${proj_name}</em>&nbsp;&nbsp;<em>组员所有项目</em><em>完成情况</em></th>
    </tr>
    </thead>
    <thead>
           <c:forEach var="user" items="${userList}" > 
     <tr>
      <th colspan="26"   style ="text-align:right;background-color: #D3D3D3;font-size: 18px;color:blue" >&nbsp;&nbsp;<b>${user.name}</b></th>
    </tr>
   
   <tr>
       <td colspan="5" class="text-center" hidden="true" ><b>组员</b></td>
      <td colspan="8" class="text-left"  ><b>项目名称</b></td>
     <td colspan="6" class="text-left"><b>工作量(天)</b></td>
      <td colspan="6" class="text-left"  ><b>任务数(个)</b></td>
     <td colspan="6" class="text-center"  ><b>状态</b></td>
    </tr>
  <c:forEach var="sd" items="${user.faPO}"  >
  <tbody >
    <tr>
   		   <td hidden="true"  colspan="5"  class="text-center">${sd.userid}</td>
	        <td   colspan="5" hidden="true" class="text-center">${sd.name}</td>
	        <td colspan="9" hidden="true" >${sd.proj_id}</td>
	       <td colspan="8" id="proj_name_id">${sd.proj_name}</td>
	       <td colspan="6"  class="text-left" >${sd.task_amount}</td>
	       <td colspan="6"  class="text-left" >${sd.task_total}</td>
	      
	       <c:if test="${sd.state_name == '未完成'}">  
	       <td colspan="6" class="text-center" style="color: red" >未完成 </td>
	       </c:if>
	       
      	   <c:if test="${sd.state_name == '已完成'}">  
	       <td colspan="6" class="text-center" style="color: green" >已完成 </td>
	       </c:if>
    </tr>
   </tbody>
 </c:forEach>
  </c:forEach> 
   </thead>
</table>
</div>
</div>
</aos:body>
<aos:onready>
	<aos:viewport layout="border">
			<aos:tab title="项目组员任务一览表" layout="anchor" closable="false" region="center" 
				autoScroll="true">
           <aos:panel contentEl="tablestyle_id" region="center" anchor="100%" ></aos:panel>
			</aos:tab>
	</aos:viewport>
</aos:onready>



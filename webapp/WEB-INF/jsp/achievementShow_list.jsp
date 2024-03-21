<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
%>
<aos:html title="工作成果展" base="http" lib="ext">
<style type="text/css">
.tablestyle {
 border:1px solid #99bde9;
}

.tablestyle table{
    width: 100%;
    margin:0 auto;
    font-size: 16px;
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
	function stepToTask(date,id,proj_id,name,state_name){
		if(state_name=="未完成"){
			state_name="1002,1003";
		}else{
			state_name="1004,1005";
		}
		window.open("do.jhtml?router=taskService.initPmUserTaskView&juid=${juid}&proj_id="+proj_id+"&id="+id+"&proj_name="+name+"&states="+state_name+"&create_time="+date);
	}
</script>
</head>

<body>
<script type="text/javascript" src="${cxt}/static/weblib/jquery/jquery.min-1.10.2.js">
</script>
<div class="tablestyle">
<table id="test" >
 <thead>
    <tr>
      <th colspan="26"   style ="text-align:center;background-color: #6098CC;font-size: 30px" > <em>${name}</em>&nbsp;&nbsp;<em>${date}</em>&nbsp;&nbsp;<em>任务完成情况</em></th>
    </tr>
    
     <tr>
      <th colspan="26"  style ="text-align:center" > <b>总体情况</b></th>
    </tr>
    <tr>
      <td colspan="4"  class="text-center" > <b>项目总数</b></td>
        <td colspan="2" id="proj_num" class="text-left" > <b>${proj_num}个</b></td>
          <td colspan="4"  class="text-center" > <b>总任务数</b></td>
       <td colspan="2" id="total" class="text-left" > <b>${total}个</b></td>
       <td colspan="4"  class="text-center" > <b>总完成百分比</b></td>
       <td colspan="2" id="percent"  class="text-left" > <b>${percent}%</b></td>
       <td colspan="5"  class="text-center" > <b>评审工作量</b></td>
       <td colspan="3" id="psgzl"  class="text-left" > <b>${psgzl}</b>人天</td>
      </tr>
       <tr>
      <th colspan="26"  style ="text-align:center"  > <b>详细情况</b></th>
    </tr>
   <tr>
   
      <td colspan="6" class="text-left"  ><b>项目名称</b></td>
     <td colspan="3" class="text-center"><b>计划工作量(天)</b></td>
     <td colspan="3" class="text-center"><b>实际工作量(天)</b></td>
      <td colspan="5" class="text-center"  ><b>任务数(个)</b></td>
     <td colspan="5" class="text-center"  ><b>状态</b></td>
       <td colspan="4" class="text-center"  ><b>详情</b></td>
    </tr>
    </thead>
  <c:forEach var="sd" items="${faPOss}"  >
  <tbody >
    <tr>
    
      <td colspan="2" hidden="true" id="proj_id" >${sd.proj_id}</td>
      <td colspan="6" id="proj_name">${sd.proj_name}</td>
      <td colspan="3" id="task_amount" class="text-center" >${sd.task_amount}</td>
       <td colspan="3" id="task_amount_sj" class="text-center" >${sd.task_amount_sj}</td>
      <td colspan="5" id="task_total" class="text-center" >${sd.task_total}</td>
       <c:if test="${sd.state_name == '未完成'}">  
      <td colspan="5" class="text-center" style="color: red" >未完成 </td>
      </c:if>
       <c:if test="${sd.state_name == '已完成'}">  
      <td colspan="5" class="text-center" style="color: green" >已完成 </td>
      </c:if>
       <td colspan="4" id="detail" class="text-center" ><a href="javascript:stepToTask('${date}','${sd.userid}','${sd.proj_id}','${sd.proj_name}','${sd.state_name}')">详情</a></td>
    </tr>
  </tbody>
</c:forEach>
</table>
</div>
</body>
<script type="text/javascript" >
$('#month_id').change(function(){
	var date=$("input[ type='month'] ").val()
	  AOS.ajax({
          url:'homeService.initTaskShow&juid=${juid}&date='+date,
          data:{},  
          ok:function(data){
        	
          }
	  });
});
</script>
</aos:html>




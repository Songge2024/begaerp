<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>周报详情</title>
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
</head>

<body>
<div class="tablestyle">
<table  >
  <c:forEach var="sd" items="${faPO}" >
  <thead>
    <tr>
      <th colspan="7"  style ="text-align:center"> <em>${sd.proj_name}</em><em>周工作计划及任务完成情况</em> <em>${sd.task_plan_num}</em></th>
    </tr>
   </thead>
  <tbody>
     <tr>
      <th  class="text-center" colspan="7"  >情况说明</th>
      
    </tr>
    <tr>
     <td colspan="3" class="text-center"><b>内部总结</b></td>
      <td colspan="4" class="text-center"  ><b>对外沟通</b></td>
    </tr>
    <tr>
     <td colspan="3" >${sd.solve}</td>
      <td colspan="4">${sd.description}</td>
    </tr>
    <tr>
      <th class="text-center" colspan="7" >周报时段</th>
    </tr >
    <tr>
      <td colspan="7" class="text-center">${sd.begin_date}<em>-</em> ${sd.end_date} </td>
    <tr>
     <tr  >
      <th class="text-center" colspan="7" >本周完成情况</th>
    <tr >
      <td class="text-center" width= 4%><b>序号</b> </td>
      <td class="text-center" width= 7%><b>任务类型</b></td>
      <td width= 45% class="text-center"><b>任务描述</b></td>
      <td class="text-center" width= 5%><b>责任人</b></td>
      <td class="text-center" width= 5%><b>完成情况</b></td>
      <td class="text-center" width= 10%><b>实际完成时间</b></td>
      <td  width= 15%  class="text-center"><b>任务进度偏差分析及解决措施</b></td>
    </tr>
    <c:forEach var="ta" items="${faPOss}"  >
    <c:if test="${ta.test_code == sd.test_code}">   
    <tr>
      <td class="text-center">${ta.rowno}</td>
       <c:if test="${ta.week_class == '1'}">  
      <td class="text-center"    >交流沟通 </td>
      </c:if>
       <c:if test="${ta.week_class == '2'}">  
      <td class="text-center"     >成果输出 </td>
      </c:if>
      
       <c:if test="${ta.week_class == '1030'}">  
      <td class="text-center"     >需求响应</td>
      </c:if>
      
       <c:if test="${ta.week_class == '1040'}">  
      <td class="text-center" >测试与缺陷 </td>
      </c:if>
       <c:if test="${ta.week_class == '1090'}">  
      <td class="text-center"     >其他 </td>
      </c:if>
        <c:if test="${ta.week_class == ''}">  
      <td class="text-center"     > 其他</td>
      </c:if>
      
      
      <td class="text-left">${ta.remarks}</td>
      <td class="text-center">${ta.owner_name}</td>
        <c:if test="${ta.finish_cond == '已完成'}">  
      <td class="text-center"     ><font color="blue">${ta.finish_cond}</font>  </td>
      </c:if>
      
      <c:if test="${ta.finish_cond == '未完成'}">  
      <td class="text-center"     ><font color="red">${ta.finish_cond}</font>  </td>
      </c:if>
      <td class="text-center">${ta.finish_time}</td>
      <td>${ta.descc}</td>
    </tr>
   
     </c:if>
    </c:forEach>
    <tr>
      <th class="text-center" colspan="7" >人员工时</th>
      <tr>
     </tr>
     <c:forEach var="userH" items="${userHouers}"  >
    <c:if test="${userH.test_code == sd.test_code}">   
      <tr>
        <td    colspan="9" >${userH.sb}</td>
     </tr>
      </c:if>
    </c:forEach>
    
      <tr>
     <tr >
      <th class="text-center" colspan="7" >下周工作计划</th>
    <tr>
      <td class="text-center" ><b>序号</b></td>
      <td class="text-center" ><b>任务类型</b></td>
      <td  colspan="2"   class="text-center"  ><b>任务描述</b></td>
      <td class="text-center" ><b>责任人</b></td>
      <td class="text-center" ><b>计划开始时间</b></td>
      <td class="text-center" ><b>计划完成时间</b></td>
    </tr>
     <c:forEach var="nextWeek" items="${nextWeek}"  >
    <c:if test="${nextWeek.test_code == sd.test_code}">   
    <tr>
       <td class="text-center">${nextWeek.rowno}</td>
      <c:if test="${nextWeek.week_class == '1'}">  
      <td class="text-center"    >交流沟通 </td>
      </c:if>
      
       <c:if test="${nextWeek.week_class == '2'}">  
      <td class="text-center"     >成果输出 </td>
      </c:if>
      
       <c:if test="${nextWeek.week_class == '1030'}">  
      <td class="text-center"     >需求响应</td>
      </c:if>
      
       <c:if test="${nextWeek.week_class == '1040'}">  
      <td class="text-center" >测试与缺陷 </td>
      </c:if>
      <c:if test="${nextWeek.week_class == '1090'}">  
      <td class="text-center" >其他 </td>
       </c:if>
       <c:if test="${nextWeek.week_class == ''}">  
      <td class="text-center" >其他 </td>
      </c:if>
      <td class="text-left"  colspan="2">${nextWeek.remarks}</td>
      <td class="text-center">${nextWeek.owner_name}</td>
      <td class="text-center">${nextWeek.begin_date}</td>
      <td class="text-center">${nextWeek.end_date}</td>
    </tr>
     </c:if>
    </c:forEach>
  </tbody>
</c:forEach>
</table>
</div>
</body>
</html>




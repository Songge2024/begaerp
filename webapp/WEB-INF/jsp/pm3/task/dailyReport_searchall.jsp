<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目组日报" base="http" lib="ext">
<style type="text/css">
.tablestyle table{
    width: 100%;
    border:1px solid #99bde9;
    margin:0 auto;
    font-size: 14px;
    margin: 50 auto;
    margin-bottom: 30px;
}

.tablestyle table td {
color: #000;
padding: 5px 0;
text-indent: 1em;
font-weight: 0;
}
.tablestyle thead th em{font-style: normal; font-weight: bold;}
.tablestyle thead th {
background-color: #b9d9ff;
color: #14498b;
text-align: left;
padding:6px 1em;
font-size: 15px;
font-weight: lighter;
}

.tablestyle table tr,.tablestyle table th {

}


.tablestyle tr td:nth-of-type(1){ width: 15%; padding-right: 1em; color: #777; text-align: right;}
.tablestyle thead th span:nth-of-type(2){ float: right;}
.tablestyle table tr:nth-child(odd) {background:#f5fafe;}

</style>

<div class="tablestyle" id="title" >
	<c:forEach var="sd" items="${faPOss}" >
		<table>
			<thead>
				<th colspan="2"><span><em>${sd.update_user_id}</em></span><span style="font-size:14px;">时间：<em>${sd.daily_time}  ${sd.week_day}</em></span></th>
			</thead>
			<tbody>
				<tr>
					<td>日报名称：</td>
					<td>${sd.name}</td>
				</tr>
				<tr> 
					<td colspan="1">日报内容：</td>
					<td> ${sd.descc}</td>
				</tr>
			</tbody>
		</table>				
	</c:forEach>
</div>
<aos:body>

</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="fit" >
		<aos:panel id="query_form"  contentEl="title" title="!${aaa}人员日报   "  frame="true" margin="0 0 0 0"	autoScroll="true"
		  padding="0px 0px 0px 0px"  width="1000" height="400" >
		</aos:panel>	
	</aos:viewport>
</aos:onready>

<script type="text/javascript">

</script>
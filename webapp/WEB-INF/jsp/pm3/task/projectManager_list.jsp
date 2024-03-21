<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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
	java.text.SimpleDateFormat ydate = new java.text.SimpleDateFormat("yyyy");
	java.util.Date currentTime = new java.util.Date();
	String end_t = simpleDateFormat.format(currentTime).toString();
	request.setAttribute("end_t", end_t);
	//获取当前时间的月初时间
	String begin_t = simpleDateFormat.format(currentTime).toString().substring(0, 7).concat("-01");
	request.setAttribute("begin_t", begin_t);
	request.setAttribute("date", mdate.format(currentTime));
	request.setAttribute("ydate", ydate.format(currentTime));
%>
<aos:html title="项目经理工作台" base="http" lib="ext,echart,ueditor,jedate">
<script type="text/javascript"
	src="${cxt}/static/weblib/jquery/jquery.min-1.10.2.js"></script>
<link type="text/css" rel="stylesheet"
	href="${cxt}/static/weblib/jquery/jeDate/skin/jedate.css">

<style type="text/css">
.icons {
	background-image:
		url("${cxt}/static/weblib/jquery/jeDate/skin/jedate.png");
	background-repeat: no-repeat;
}

.x-grid-cell.red {
	background: #FF69B4;
}

.x-grid-cell.green {
	background: #98FB98;
}

.x-grid-cell.blue {
	background: #87CEFA;
}

.x-grid-cell.gray {
	background: #B0E0E6;
}

.tablestyle {
	border: 1px solid #99bde9;
}

.tablestyle table {
	width: 100%;
	margin: 0 auto;
	font-size: 16px;
}

/* .tablestyle table td { */
/* 	color: #000; */
/* 	padding: 5px 0; */
/* 	text-indent: 0em; */
/* 	font-weight: 0; */
/* } */

.tablestyle thead th em {
	font-style: normal;
	font-weight: bold;
}

.tablestyle thead th {
	background-color: #AFEEEE;
	color: #14498b;
	text-align: left;
	padding: 6px 1em;
	line-height: 1.8em;
	font-size: 18px;
	font-weight: lighter;
	text-align: center;
}

.tablestyle table tr, .tablestyle table th {
	
}

.tablestyle tr td:nth-of-type(1) {
	width: 6%;
	padding-right: 1em;
	color: #777;
}

.tablestyle thead th span:nth-of-type(1) {
	float: right;
}

.tablestyle table tr {
	background: #f5fafe;
}

.tablestyle tbody   th:nth-child(odd) {
	background: #D3D3D3;
	height: 30px
}

.text-center {
	text-align: center;
	font-weight:bold;
	color:#696969;
}

.text-right {
	text-align: right;
	font-weight: bold;
	color:#000000;
}
</style>

</aos:html>
<aos:body>
	<div id="div_tips" class="x-hidden"
		style="line-height: 25px; margin-right: 10px; text-align: center;">
		<h1>深圳项目项目组成员一览表</h1>
	</div>
	<div id="div_projSummary" class="tablestyle"
		style="line-height: 30px; margin-right: 10px; margin-left: 10px; text-align: center;">
			<table id="id_projSummaryTable">
				<thead>
					<tr>
						<th colspan="35" style="text-align: center; font-size: 20px">
							<b><div id="proj_name" style="display: inline-block;"></div>总体情况</b>
						</th>
					</tr>
						<tr>
						<td colspan="2" class="text-center"><b>项目经理</b></td>
						<td colspan="2" class="text-left"><b><span id="proj_manage_name"></span></b></td>
						<td colspan="2" class="text-center"><b>总人数</b></td>
						<td colspan="2" class="text-left"><b><span id="person_count"></span>个</b></td>
						<td colspan="2" class="text-center"><b>总任务数</b></td>
						<td colspan="2" class="text-left"><b><span id="task_count"></span>个</b></td>
						<td colspan="4" class="text-center"><b>未完成数</b></td>
						<td colspan="2" class="text-left"><b><span id="task_wwc_count"></span>个</b></td>
						<td colspan="4" class="text-center"><b>总计划完成工作量</b></td>
						<td colspan="2" class="text-left"><b><span id="sums_plan_wastage"></span>人天</b></td>
						<td colspan="4" class="text-center"><b>总实际完成工作量</b></td>
						<td colspan="2" class="text-left"><b><span id="sums_real_wastage"></span>人天</b></td>
						<td colspan="4" class="text-center"><b>总完成百分比</b></td>
						<td colspan="2" class="text-left"><b><span id="complete_pers" ></span></b></td>
					</tr>
				</thead>
			</table>
	</div>
</aos:body>
<aos:onready>
	<aos:viewport layout="border">
		<aos:tabpanel id="echarts_panelId" region="center" activeTab="2">
			<aos:tab title="任务跟踪" layout="anchor" autoScroll="true">
				<aos:formpanel title="查询条件" id="formqueryProce" region="north"
					layout="column" anchor="100%" labelWidth="80">
					<aos:datefield fieldLabel="开始" id="begin_n" name="begin_time"
						margin="0 0 0 -40" value="${begin_t}" columnWidth="0.16"></aos:datefield>
					<aos:hiddenfield fieldLabel="項目id" name="proj_id"
						value="${proj_id}"></aos:hiddenfield>
					<aos:datefield fieldLabel="结束" id="end_d" name="end_time"
						margin="0 0 0 -40" value="${end_t}" columnWidth="0.16"></aos:datefield>
					<aos:combobox name="state" fieldLabel="状态" columnWidth="0.15"
						onchange="task_grid_query">
						<aos:option value="1002" display="已发布" />
						<aos:option value="1003" display="已接收" />
						<aos:option value="1004" display="已完成" />
						<aos:option value="1005" display="已关闭" />
					</aos:combobox>
					<aos:combobox fieldLabel="项目成员" name="hander_user_id"
						onchange="task_grid_query" editable="false" columnWidth="0.15"
						url="projCommonsService.listComboBoxProjUserId&proj_id=${proj_id}" />
					<aos:combobox fieldLabel="任务类型" name="task_type" editable="false"
						onchange="task_grid_query" columnWidth="0.15" dicField="task_type" />
					<aos:combobox fieldLabel="任务节点" name="group_name" editable="false"
						onchange="task_grid_query" columnWidth="0.2"
						url="taskGroupService.listComboBoxData&proj_id=${proj_id}&is_leaf=0" />
					<aos:dockeditem xtype="button" text="查询" margin="0 10 0 20"
						onclick="task_grid_query" icon="query.png" />
					<aos:dockeditem xtype="button" text="重置" margin="0 10 0 10"
						onclick="resetProcess" icon="refresh.png" />
				</aos:formpanel>
				<aos:gridpanel title="任务进度" id="grid4" anchor="100%"
					hidePagebar="true" url="projCommonsService.queryProjectProgress"
					onrender="task_grid_query" onitemdblclick="task_grid_dbclick">
					<aos:column type="rowno" />
					<aos:column header="状态" dataIndex="state" align="center" width="50"
						rendererFn="fn_state_renderer"/>
					<aos:column header="任务编码" dataIndex="task_code" width="80"
						align="center" />
					<aos:column header="任务id" dataIndex="task_id" width="50" align="center" hidden="true" />
					<aos:column header="项目id" dataIndex="proj_id" width="50" align="center" hidden="true" />
					<aos:column header="任务名称" dataIndex="task_name" width="180" />
					<aos:column header="进度" dataIndex="percent" rendererFn="progress"
						align="center" hidden="true" />
					<aos:column header="成员" dataIndex="handler_user_name"
						align="center" fixedWidth="80" />
					<aos:column header="计划开始时间" dataIndex="plan_begin_time"
						align="center" width="60" />
					<aos:column header="计划完成时间" dataIndex="plan_end_time" width="60"
						align="center" />
						<aos:column header="实际开始时间" dataIndex="real_begin_time"
						align="center" width="60" />
					<aos:column header="实际完成时间" dataIndex="real_end_time" width="60"
						align="center" />
					<aos:column header="消耗天数" dataIndex="real_wastage" width="40"
						align="center" />
					<aos:column header="任务组Id" dataIndex="group_id" hidden="true"
						align="center" />
					<aos:column header="任务节点" dataIndex="group_name" align="center" />
				</aos:gridpanel>

			</aos:tab>
			<aos:tab title="图表" layout="border" closable="false" region="center"
				autoScroll="true">
				<aos:panel layout="hbox" region="north">
					<aos:layout type="hbox" align="stretch" />
					<aos:panel headerBorder="0 0 0 1" border="true"
						bodyBorder="0 0 0 1" flex="1"
						html='<div id="task_completion_chart" style="width:600px;height:400px;" ></div>'>
					</aos:panel>
					<aos:panel border="true" bodyBorder="0 0 0 1" flex="1"
						html='<div id="test_line_chart" style="width:600px;height:400px;" ></div>'>
					</aos:panel>
				</aos:panel>

				<aos:panel layout="hbox" region="north" border="true">
					<aos:layout type="hbox" align="stretch" />
                    //已完成任务分布图
                    <aos:panel bodyBorder="0 0 0 1"
						headerBorder="0 0 0 1" border="true" flex="1"
						html='<div id="test_complete_pie_chart" style="width:600px;height:400px;"></div>'>
					</aos:panel>
                    //未完成任务分布图
                    <aos:panel border="true" bodyBorder="0 0 0 1"
						flex="1"
						html='<div id="test_pie_chart" style="width:600px;height:400px;"></div>'>
					</aos:panel>
				</aos:panel>
				<aos:panel layout="hbox" region="north">
					<aos:layout type="hbox" align="stretch" />
                    //项目过程文档上传情况图
                    <aos:panel headerBorder="0 0 0 1" border="true"
						bodyBorder="0 0 0 1" flex="1"
						html='<div id="processfileupload_pie_chart" style="width:600px;height:400px;"></div>'>
					</aos:panel>
				</aos:panel>
			</aos:tab>
			<aos:tab title="项目组员任务一览表" layout="anchor" closable="false"
				region="center" autoScroll="true">
<%-- 				<%@ include file="projTeamsTaskSummary.jsp"%> --%>
				<aos:layout type="vbox" align="stretch" />
				<%-- <aos:panel>
					<aos:panel height="60" contentEl="div_tips"  border="false">
					</aos:panel>
				</aos:panel> --%>
				<aos:panel layout="fit">
					<aos:formpanel id="f_query" layout="column" labelWidth="70" header="false"  border="false">
						<aos:docked forceBoder="0 0 1 0">
							<aos:dockeditem xtype="tbtext" text="项目经理工作台" />
						</aos:docked>
						<aos:hiddenfield fieldLabel="項目id" name="proj_id"
						value="${proj_id}"></aos:hiddenfield>
						<aos:textfield name="user_name" fieldLabel="姓名" columnWidth="0.18"/>
						<aos:datefield name="plan_begin_time" fieldLabel="开始时间"
							format="Y-m-d" columnWidth="0.18" editable="false" margin="0 0 0 0" />
						<aos:datefield name="plan_end_time" fieldLabel="结束时间" format="Y-m-d"
							columnWidth="0.18" editable="false" margin="0 0 0 0" />
						<aos:dockeditem xtype="button" text="查询" onclick="query_proj_workload_summary_query"
							icon="query.png" />
						<aos:dockeditem xtype="button" text="重置"
							onclick="AOS.reset(f_query);" icon="refresh.png" />
					</aos:formpanel>
				</aos:panel>
				<aos:panel layout="fit" height="95" contentEl="div_projSummary">
<%-- 					<aos:formpanel id="projSummaryForm" layout="column" labelWidth="80" header="false"  border="false"> --%>
<%-- 						<aos:docked forceBoder="0 0 1 0"> --%>
<%-- 							<aos:dockeditem xtype="tbtext" text="总体情况" /> --%>
<%-- 						</aos:docked> --%>
<%-- 						<aos:textfield name="proj_name" fieldLabel="项目名称" columnWidth="0.2" readOnly="true"/> --%>
<%-- 						<aos:textfield name="proj_manage_name" fieldLabel="项目经理" columnWidth="0.13" readOnly="true"/> --%>
<%-- 						<aos:textfield name="sums_plan_wastage" fieldLabel="总计划完成工作量" labelWidth="120" columnWidth="0.13" readOnly="true"/> --%>
<%-- 						<aos:textfield name="sums_real_wastage" fieldLabel="总实际完成工作量" labelWidth="120" columnWidth="0.13" readOnly="true"/> --%>
<%-- 						<aos:textfield name="complete_pers" fieldLabel="总完成百分比" labelWidth="120" columnWidth="0.13" readOnly="true"/> --%>
<%-- 						<aos:textfield name="task_count" fieldLabel="总任务数" columnWidth="0.13" readOnly="true"/> --%>
<%-- 						<aos:textfield name="task_wwc_count" fieldLabel="未完成任务数" columnWidth="0.13" labelWidth="120" readOnly="true"/> --%>
<%-- 					</aos:formpanel> --%>
				</aos:panel>
				<aos:panel flex="1" layout="fit">
					<aos:groupingPanel id="projWorkloadSummary_grid" title="任务详情" url="homeService.projWorkloadList"  hidePagebar="true" 
									   forceFit="false" onrender="proj_workload_summary_query" border="true" margin="5" groupField="handler_user_name"
								 	   property="handler_user_name"   startCollapsed="false"  groupHeaderTpl="姓名{#handler_user_name#}">
						<aos:column type="rowno"  />
						<aos:column header="用户ID" dataIndex="handler_user_id"   hidden="true" />
						<aos:column header="项目id" dataIndex="proj_id" width="50" align="center" hidden="true" />
						<aos:column header="计划开始时间" dataIndex="plan_begin_time" width="50" align="center" hidden="true" />
						<aos:column header="计划结束时间" dataIndex="plan_end_time" width="50" align="center" hidden="true" />
						<aos:column header="姓名" dataIndex="handler_user_name" width="400" rendererFn="fn_value_change"/>
						<aos:column header="状态" dataIndex="task_state" width="100"  align="left" rendererFn="fn_task_state" />
						<aos:column header="计划工作量（人天）" dataIndex="plan_wastage" width="300"   align="right" rendererFn="fn_value_change"/>
						<aos:column header="实际工作量（人天）" dataIndex="real_wastage" width="300"  align="right" rendererFn="fn_value_change"/>
						<aos:column header="任务数（个）" dataIndex="task_count" width="300"  align="right" rendererFn="fn_value_change"/>
						<aos:column header="任务数（个）" dataIndex="task_count" width="300"  align="right" rendererFn="fn_value_change"/>
						<aos:column header="详情" dataIndex="detail" width="120" rendererFn="task_detail" align="center"/>
					</aos:groupingPanel>
				</aos:panel>
			</aos:tab>
		</aos:tabpanel>
	</aos:viewport>


	<script type="text/javascript">
	
	//表格双击事件响应
	function task_grid_dbclick(grid,record){
		window.open('do.jhtml?router=taskService.viewInit&juid=<%=request.getAttribute("juid") %>&task_id='+record.get("task_id")+'&proj_id='+record.get("proj_id")+'&task_code='+record.data.task_code+'&task_name='+record.data.task_name);
	}

	function fn_state_renderer(value, metaData, record) {
		if (value == '1006') {
			return "已删除";
		}else if(value == '1002'){
			return "<span style='color:green;font-weight:bold' >已发布</span>";
		}else if(value == '1003'){
			return "<span style='color:blue;font-weight:bold' >已接收</span>";
		}else if(value == '1004'){
			return "<span style='color:red;font-weight:bold' >已完成</span>";
		}else if(value == '1005'){
			return "已关闭";
		}
		return value;
	}
	
	function fn_task_state(value, metaData, record){
		if(value =='task_wwc'){
			return "<span style='color:red;'>未完成</span>"; 
		}else if(value == 'task_ywc'){
			return "<span style='color:green; '>已完成</span>"; 
		}else if(value == 'task_zt'){
			return "<span style='color:#FF00FF; '>暂停</span>"; 
		}else if(value == 'task_hz'){
			return "<span style='color:#FF4500; font-weight:bold; background:#FFF68F;'>汇总统计</span>"; 
		}
		
		else{
			return value;
		}
	}
	
	function fn_value_change(value, metaData, record){
		var task_state = record.get('task_state');
		if(task_state == 'task_hz'){
			return "<span style='color:#FF4500; font-weight:bold; background:#FFF68F;'>"+value+"</span>"; 
		}
		return value;
	}
	
	function fn_tab_onactivate(value){
		alert(value)
	}
	
	//重置
	function resetProcess(){
		var form = AOS.getValue('formqueryProce');
		AOS.reset(formqueryProce);
		begin_n.setValue(null);
		end_d.setValue(null);
	}
    //查询任务跟踪信息
    function task_grid_query() {
    	var params = AOS.getValue('formqueryProce');
    	console.log(params)
    	if(!(AOS.empty(params.begin_time))&&AOS.empty(params.end_time)){
    		AOS.tip("请选择结束时间");
    		return;
    	}else if(AOS.empty(params.begin_time)&&!(AOS.empty(params.end_time))){
    		AOS.tip("请选择开始时间");
    		return;
    	}
    	grid4_store.getProxy().extraParams = params;
    	grid4_store.loadPage(1);
    }
    //进度条
    function progress(value, metaData, record) {
   	  var state=record.data.state;
   	  if (state == "1002") {
   		  metaData.tdCls="green";
 		}else if (state == "1003") {
 		  metaData.tdCls="blue";
 		}else if (state == "1004") {
 		  metaData.tdCls="red";
 		}else if (state == "1005") {
 		  metaData.tdCls="gray";
 		}
 		return value + '%';
       /*  var id = Ext.id();
        metaData.tdAttr = 'data-qtip="' + value + '%"';
        Ext.defer(function () {
            Ext.widget('progressbar', {
                renderTo: id,
                value: value / 100,
                height: 20,
                width: 100,
                text: value + '%'
            });
        }, 50);
        return Ext.String.format('<div id="{0}"></div>', id); */
    }
	      
	 
        function init_chart(proj_id) {
            AOS.ajax({
                url: 'moduleDivideService.listModuleNumber',
                params: {
                    proj_id: proj_id,
                },
                ok: function (data) {

                    // 指定图表的配置项和数据
                    var labelOption = {
                        normal: {
                            show: true,
                            position: 'top',
                            distance: 10,
                            align: 'center',
                            verticalAlign: 'center',
                            rotate: 0,
                            formatter: '{c}',
                            fontSize: 16,
                            rich: {
                                name: {
                                    textBorderColor: '#000'
                                }
                            }
                        }
                    };
                    option = {
                        title: {
                            text: '模块缺陷情况统计图',
                            top: '15',
                            left: 'center'
                        },
                        color: ['#003366', '#006699', '#e5323e'],
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {
                                type: 'shadow'
                            }
                        },
                        legend: {
                            data: ['总缺陷', '已完成缺陷', '未完成缺陷'],
                            bottom: 10
                        },
                        grid: {width: '500'},
                        toolbox: {
                            show: true,
                            orient: 'vertical',
                            left: 'right',
                            top: 'center',
                        },
                        calculable: true,
                        xAxis: [{
                            type: 'category',
                            axisTick: {
                                show: false
                            },
                            data: data[3]
                        }],
                        yAxis: [{
                            type: 'value'
                        }],
                        series: [
                            {
                                name: '总缺陷',
                                type: 'bar',
                                barGap: 0,
                                label: labelOption,
                                barGap: '1%',
                                data: data[0]
                            }, {
                                name: '已完成缺陷',
                                type: 'bar',
                                barGap: '1%',
                                label: labelOption,
                                data: data[1]
                            }, {
                                name: '未完成缺陷',
                                type: 'bar',
                                barGap: '1%',
                                label: labelOption,
                                data: data[2]
                            }]
                    };

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document
                        .getElementById('test_line_chart'));
                    
                    window.onresize = function(){
                        myChart.resize();
                    };
                    
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                    // 添加点击事件  
                   var ecConfig = echarts.config;  
                    function eConsole(param) {
                        if (typeof param.seriesIndex != 'undefined') {
                            if(param.seriesIndex==0){
                            	 window.open("do.jhtml?router=bugManageService.init&juid=${juid}");

                            }else if(param.seriesIndex==1){
                            	   window.open("do.jhtml?router=bugManageService.init&juid=${juid}&state=1001");
                            }else if(param.seriesIndex==2){
                            	   window.open("do.jhtml?router=bugManageService.init&juid=${juid}&state=1000");
                            }
                        }
                    }
                    myChart.on('click', eConsole);
                   
                }
            })
        }

        function init_pie_chart(proj_id) {
            AOS.ajax({
                url: 'moduleDivideService.listPendingTask',
                params: {
                    proj_id: proj_id,
                    type: 0
                },
                ok: function (data) {

                    var option = {
                        title: {
                            text: '待处置工作任务分布图',
                            subtext: '单位（个）',
                            top: '15',
                            x: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{b}:</br>{c}个({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            left: 10,
                            itemWidth: 20,  // 图例图形宽度
                            itemHeight: 10,
                            top: 50,
                            bottom: 20,
                        },
                        series: [{
                            name: '访问来源',
                            type: 'pie',
                            radius: '40%',
                            center: ['50%', '60%'],
                            label: {
                                normal: {
                                    fontSize: 12,
                                    formatter: '{b}: {c} ({d}%)  ',
                                    rich: {
                                        b: {
                                            fontSize: 16,
                                            lineHeight: 33
                                        },

                                    }
                                }
                            },
                            data: data,
                        }]
                    };

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document
                        .getElementById('test_pie_chart'));
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                    // 添加点击事件  
                    var ecConfig = echarts.config;  
                     function eConsole(param) {
                         if (typeof param.seriesIndex != 'undefined') {
                             if(param.seriesIndex==0){
                             	   window.open("do.jhtml?router=taskService.init&juid=${juid}");
                             }
                         }
                     }
                     myChart.on('click', eConsole);
                }
            });

        }

        function test_complete_pie_chart(proj_id) {
            AOS.ajax({
                url: 'moduleDivideService.listPendingTask',
                params: {
                    proj_id: proj_id,
                    type: 1
                },
                ok: function (data) {

                    var option = {
                        title: {
                            text: '已完成工作任务分布图',
                            subtext: '单位（个）',
                            top: '15',
                            x: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{b}:</br>{c}个({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            left: 10,
                            top: 50,
                            itemWidth: 20,  // 图例图形宽度
                            itemHeight: 10,
                            bottom: 20,
                        },
                        series: [{
                            name: '访问来源',
                            type: 'pie',
                            radius: '40%',
                            center: ['50%', '60%'],
                            label: {
                                normal: {
                                    fontSize: 12,
                                    formatter: '{b}: {c} ({d}%)  ',
                                    rich: {
                                        b: {
                                            fontSize: 16,
                                            lineHeight: 33
                                        },

                                    }
                                }
                            },
                            data: data,
                        }]
                    };

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document
                        .getElementById('test_complete_pie_chart'));
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                    // 添加点击事件  
                    var ecConfig = echarts.config;  
                     function eConsole(param) {
                         if (typeof param.seriesIndex != 'undefined') {
                             if(param.seriesIndex==0){
                             	   window.open("do.jhtml?router=taskService.init&juid=${juid}");
                             }
                         }
                     }
                     myChart.on('click', eConsole);
                }
            });
        }

        function task_completion_chart(proj_id) {
            AOS.ajax({
                url: 'moduleDivideService.listProjectTaskDetails',
                params: {
                    proj_id: proj_id,
                },
                ok: function (data) {
                    option = {
                        title: {
                            text: '任务详情',
                            top: '15',
                            x: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{b} : {c} ({d}%)"
                        },
                        legend: {
                            left: 'center',
                            bottom: 80,
                            itemWidth: 20,  // 图例图形宽度
                            itemHeight: 10,
                        },
                        series: [{
                            name: '访问来源',
                            type: 'pie',
                            radius: '40%',
                            center: ['50%', '45%'],
                            label: {
                                normal: {
                                    fontSize: 12,
                                    formatter: '{b}: {c} ({d}%)  ',
                                    rich: {
                                        b: {
                                            fontSize: 16,
                                            lineHeight: 33
                                        },
                                    }
                                }
                            },
                            data: data,
                            itemStyle: {
                                emphasis: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }]
                    };
                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document
                        .getElementById('task_completion_chart'));
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                    // 添加点击事件  
                    var ecConfig = echarts.config;  
                     function eConsole(param) {
                         if (typeof param.seriesIndex != 'undefined') {
                             if(param.seriesIndex==0){
                             	   //window.open("do.jhtml?router=taskService.init&juid=${juid}");
                            	 echarts_panelId.setActiveTab(0);
                             }
                         }
                     }
                     myChart.on('click', eConsole);
                }
            })
        }

        function processfileupload_pie_chart(proj_id) {
            AOS.ajax({
                url: 'moduleDivideService.listProcessFileUpload',
                params: {
                    proj_id: proj_id,
                },
                ok: function (data) {
                    var option = {
                        title: {
                            text: '过程文档完成情况',
                            subtext: '单位（个）',
                            top: '15',
                            x: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            left: 'center',
                            bottom: 80,
                            itemWidth: 20,  // 图例图形宽度
                            itemHeight: 10,
                        },
                        series: [{
                            name: '访问来源',
                            type: 'pie',
                            radius: '40%',
                            center: ['50%', '50%'],
                            label: {
                                normal: {
                                    fontSize: 12,
                                    formatter: '{b}:  {c}个  ({d}%)  ',
                                    rich: {
                                        b: {
                                            fontSize: 16,
                                            lineHeight: 33
                                        },
                                    }
                                }
                            },
                            data: data,
                            itemStyle: {
                                emphasis: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }]
                    };

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document
                        .getElementById('processfileupload_pie_chart'));
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                    // 添加点击事件  
                    var ecConfig = echarts.config;  
                     function eConsole(param) {
                         if (typeof param.seriesIndex != 'undefined') {
                             //alert(param.seriesIndex);
                        	   window.open("do.jhtml?router=processFileUploadService.init&juid=${juid}");
                         }
                     }
                     myChart.on('click', eConsole);
                }
            })
        }
         
        // 项目组员任务一览表
        function proj_workload_summary_query() {
			AOS.setValue('f_query.plan_begin_time', '${plan_begin_time}');
			AOS.setValue('f_query.plan_end_time', '${plan_end_time}');
			var params = AOS.getValue('f_query');
			AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'homeService.projWorkloadSummary',
				ok : function(data) {
					summary = data;
					$("#proj_name").text(summary.proj_name);
					$("#proj_manage_name").text(summary.proj_manage_name);
					$("#sums_plan_wastage").text(summary.sums_plan_wastage);
					$("#sums_real_wastage").text(summary.sums_real_wastage);
					$("#task_wwc_count").text(summary.task_wwc_count);
					$("#task_count").text(summary.task_count);
					$("#complete_pers").text(summary.complete_pers);
					$("#person_count").text(summary.person_count);
// 					AOS.setValue('projSummaryForm.proj_name', summary.proj_name);
// 					AOS.setValue('projSummaryForm.proj_manage_name', summary.proj_manage_name);
// 					AOS.setValue('projSummaryForm.sums_plan_wastage', summary.sums_plan_wastage);
// 					AOS.setValue('projSummaryForm.sums_real_wastage', summary.sums_real_wastage);
// 					AOS.setValue('projSummaryForm.task_wwc_count', summary.task_wwc_count);
// 					AOS.setValue('projSummaryForm.task_count', summary.task_count);
// 					AOS.setValue('projSummaryForm.complete_pers', summary.complete_pers);
					
					projWorkloadSummary_grid_store.getProxy().extraParams =params;
					projWorkloadSummary_grid_store.loadPage(1);
				}
			});
		}
        
        
     // 项目组员任务一览表
        function query_proj_workload_summary_query() {
        	
			var params = AOS.getValue('f_query');
			
			AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'homeService.projWorkloadSummary',
				ok : function(data) {
					summary = data;
					$("#proj_name").text(summary.proj_name);
					$("#proj_manage_name").text(summary.proj_manage_name);
					$("#sums_plan_wastage").text(summary.sums_plan_wastage);
					$("#sums_real_wastage").text(summary.sums_real_wastage);
					$("#task_wwc_count").text(summary.task_wwc_count);
					$("#task_count").text(summary.task_count);
					$("#complete_pers").text(summary.complete_pers);
					$("#person_count").text(summary.person_count);
// 					AOS.setValue('projSummaryForm.proj_name', summary.proj_name);
// 					AOS.setValue('projSummaryForm.proj_manage_name', summary.proj_manage_name);
// 					AOS.setValue('projSummaryForm.sums_plan_wastage', summary.sums_plan_wastage);
// 					AOS.setValue('projSummaryForm.sums_real_wastage', summary.sums_real_wastage);
// 					AOS.setValue('projSummaryForm.task_wwc_count', summary.task_wwc_count);
// 					AOS.setValue('projSummaryForm.task_count', summary.task_count);
// 					AOS.setValue('projSummaryForm.complete_pers', summary.complete_pers);
					
					projWorkloadSummary_grid_store.getProxy().extraParams =params;
					projWorkloadSummary_grid_store.loadPage(1);
				}
			});
		}
     
     	//详情链接
	 	function task_detail(value, metaData, record){
				return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn" />';
		}
	 	projWorkloadSummary_grid.on("cellclick", function(grid, rowIndex, columnIndex, e){
			var record = AOS.selectone(projWorkloadSummary_grid, true);
			var params = AOS.getValue('f_query');
			if (columnIndex == 7 ) {
				var state_name = record.data.task_state;
				var user_id = record.data.handler_user_id;
				var proj_id = record.data.proj_id;
				var create_time = '${date}';
				var plan_begin_time = params.plan_begin_time;
				var plan_end_time = params.plan_end_time
				if(state_name=="task_wwc"){
					state_name="1002,1003";
				}else if(state_name=="task_ywc"){
					state_name="1004,1005";
				}else if(state_name=="task_zt"){
					state_name="1007";
				}else{
					state_name="1002,1003,1004,1005,1007";
				}
				window.open("do.jhtml?router=taskService.initPmUserTaskView&juid=${juid}&states="+ state_name
						+"&id="+user_id
						+"&proj_id="+proj_id
						+"&create_time="+create_time
						+"&plan_begin_time="+plan_begin_time
						+"&plan_end_time="+plan_end_time
						);
			}
		});
        
        window.onload = function () {
      	    echarts_panelId.setActiveTab(1);
      	    init_chart(${proj_id});
            init_pie_chart(${proj_id});
            test_complete_pie_chart(${proj_id});
            task_completion_chart(${proj_id});
            processfileupload_pie_chart(${proj_id});
            params = {proj_id:${proj_id}}
            echarts_panelId.setActiveTab(2);
            console.log('${userList}');
            console.log(''+'${userList}.faPO');
        }

        function findDimensions() {
        }
    </script>


</aos:onready>

<script type="text/javascript">
	function stepToTask(id,name,state_name,date){
		if(state_name=="未完成"){
			state_name="1002,1003";
		}else{
			state_name="1004,1005";
		}
		window.open("do.jhtml?router=taskService.initPmUserTaskView&juid=${juid}&proj_id=${proj_id}&id="+id+"&proj_name="+name+"&states="+state_name+"&create_time="+date);
	}
	
	function queryAllTask(proj_name){
	window.open("do.jhtml?router=homeService.initRe&juid=${juid}&proj_id=${proj_id}&proj_name="+proj_name);
	}
	
		 
</script>



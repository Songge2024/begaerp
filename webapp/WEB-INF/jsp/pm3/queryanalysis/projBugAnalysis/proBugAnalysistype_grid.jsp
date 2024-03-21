<!-- 查询分析-项目缺陷分析图表 -->
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目缺陷分析表" base="http" lib="ext,echart" >
<aos:body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="position:absolute; top:1px; right:20px; width:98.5%; height:150%"  ></div>
      
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="west" width="280">
				<aos:layout type="vbox" align="stretch"/>
				<%-- 	<aos:radiobox name="bug_module" boxLabel="按项目模块分布" id="bug_module" 
					checked="true" selectOnFocus="true"/> --%>
				<aos:button text="按项目模块分布"  scale="medium" margin="5" id="bug_module" />
				<aos:button text="按需求分布"  scale="medium"  margin="5" id="bug_demand"/>
				<aos:button text="按总体计划分布"  scale="medium"  margin="5" id="bug_week"/>
				<aos:button text="遗留缺陷按人分布"  scale="medium"  margin="5" id="bug_man" />
				<aos:button text="按缺陷类型分布"  scale="medium"  margin="5" id="bug_type" />
				<aos:button text="按缺陷状态分布"  scale="medium"  margin="5" id="bug_state" />
			<aos:docked >
				<aos:dockeditem xtype="tbtext" text="选择项目:" />
		<%-- 	<aos:combobox  id="id_proj_name" dicField="proj_name" emptyText="项目名称" onchange="change_Proj"
			selectAll="true" width="200" allowBlank="false" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"
					/> --%>
			 <aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="200" />
			 <aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			</aos:docked>
			<aos:docked >
				<aos:dockeditem xtype="tbtext" text="项目缺陷分类统计列表" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:panel>
		<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
			<aos:formpanel id="bug_state_form" layout="column" labelWidth="100"
				header="false" border="false">
				<aos:combobox fieldLabel="项目" name="proj_id" margin="4"
					hidden="true" editable="false" columnWidth="0.4"
					url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"	/>
				<aos:datefield  name="find_begin_time" fieldLabel="发现开始时间" columnWidth="0.3"  editable="false"  margin="4"/>
				<aos:datefield  name="find_end_time" fieldLabel="发现结束时间" columnWidth="0.3"  editable="false" margin="4" />
				<aos:combobox id="test_version_id" fieldLabel="测试版本号" name="test_version_ids" multiSelect="true"
					editable="false" columnWidth="0.3" queryMode="local" width="100"  margin="4"
					url="bugManageService.listSearchTestVersionId" emptyText="测试版本号查询"/>
				<aos:button text="重置" onclick="AOS.reset(bug_state_form);"
					icon="refresh.png" margin="4 4 4 10" />
			</aos:formpanel>
		</aos:panel>
		<aos:panel region="center" contentEl="main" autoScroll="true" ></aos:panel>
	</aos:viewport>
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="276" layout="fit" autoScroll="true">
			<aos:treepanel id="t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>

	<script type="text/javascript">
	
	 	window.onload = function combobox_select(){
	 		var record = t_org_find;
			var arr = record.store.tree.root.childNodes;
			if(arr.length > 0){
				var proj_id = arr[0].raw.id;
				var porj_name = arr[0].raw.text;
				AOS.get('id_proj_name').setValue(proj_id);
				AOS.get('tree_proj_name').setValue(porj_name);
				//proj_onselect();
			}
 	}
     // 基于准备好的dom，初始化echarts图表
     var myChart = echarts.init(document.getElementById('main')); 
     //切换项目清空数据
   function change_Proj(){
 		 myChart.clear();//数据清空重新加载
 	}
     
 //项目缺陷分析表默认加载默认项目
	window.onload = function(){
		  var proj_id = '${proj_id}';
		  var proj_name = '${proj_name}';
   	  if(proj_id !=null && proj_id!=''){
   		AOS.setValue('id_proj_name',proj_id);
   		AOS.setValue('tree_proj_name',proj_name);
   		test_version_id.getStore().getProxy().extraParams = {
			proj_id : proj_id
		}
		test_version_id.getStore().load();
   		change_Proj();
			}
	}
     
    //点击选择项目
   function t_org_find_select() {
	  	var record = AOS.selectone(t_org_find);
	  	if(record.raw.a=="1"){
	  	AOS.setValue('id_proj_name',record.raw.id);
	  	AOS.setValue('tree_proj_name',record.raw.text);
	  	test_version_id.getStore().getProxy().extraParams = {
			proj_id : record.raw.id
		}
		test_version_id.getStore().load();
	  	change_Proj();
		w_org_find.hide();
   }else{
		AOS.tip("请选择项目!");
		return;
		//w_org_find.hide();
	}
	  }
	
	//弹出选择上级模块窗口
	  function proj_tree_show() {
	  	w_org_find.show();
	  }
     
     //按模块分布饼图
     $(function() {  
         $('#bug_module').click(function() {
        	 var params = AOS.getValue('bug_state_form');
        	 params.proj_id = AOS.get('id_proj_name').getValue();
        	 params.id = AOS.get('bug_module');
      AOS.ajax({
    	  url:"projBugAnalysisService.listModule",
         data: {  },
         params: params,
      
         ok:function(data){
        	 if(!AOS.empty(data.appmsg)){
        		 myChart.clear();//数据清空重新加载
        		 AOS.tip(data.appmsg);
        		 return;
        	 }
 				option = {
 					title : {
 						text : '项目按模块分布图',
 						top: '15',
 						x : 'center'
 					},
 					tooltip : {
 						trigger : 'item',
 						  formatter: "{a} <br/>{b} : {c} ({d}%)"
 					},
 					legend : {
 						orient : 'vertical',
 				        x : 'left',
 				        data:data["legen"]
 					},
 					  toolbox: {
 					        show : true,
 					        feature : {
 					            mark : {show: true},
 					            dataView : {show: true, readOnly: false},
 					            magicType : {
 					                show: true, 
 					                type: ['pie']
 					            },
 					            restore : {show: true},
 					            saveAsImage : {show: true}
 					        }
 					    },
 					    calculable : true,
 					series : [ {
 						name : '模块bug分布情况',
 						type : 'pie',
 						radius : '40%',
 						center : [ '70%', '40%' ],
 						label : {
 							normal : {
 								fontSize : 12,
 								formatter : '{b}: {c} ({d}%)  ',
 								rich : {
 									b : {
 										fontSize : 16,
 										lineHeight : 33
 									},
 								}
 							}
 						},
 						data : data,
 						itemStyle : {
 							emphasis : {
 								shadowBlur : 10,
 								shadowOffsetX : 0,
 								shadowColor : 'rgba(0, 0, 0, 0.5)'
 										}
 									}
 								} ]
 						};
 				 myChart.clear();//数据清空重新加载
 				// 使用刚指定的配置项和数据显示图表。
 				myChart.setOption(option);
 					}
 			})
         })
     })
     
     
   //按需求分布饼图
     $(function() {  
         $('#bug_demand').click(function() { 
        	 var params = AOS.getValue('bug_state_form');
        	 params.proj_id = AOS.get('id_proj_name').getValue();
        	 params.id = AOS.get('bug_demand');
      AOS.ajax({
    	  url:"projBugAnalysisService.listDemand",
         data: {  },
         params: params,
         ok:function(data){
        	 if(!AOS.empty(data.appmsg)){
        		 myChart.clear();//数据清空重新加载
        		 AOS.tip(data.appmsg);
        		 return;
        	 }
        	 option = {
  					title : {
  						text : '项目按需求分布图',
  						top: '15',
  						x : 'center'
  					},
  					tooltip : {
  						trigger : 'item',
  						  formatter: "{a} <br/>{b} : {c} ({d}%)"
  					},
  					legend : {
  						orient : 'vertical',
  				        x : 'left',
  				        data:data["legen"]
  					},
  					  toolbox: {
  					        show : true,
  					        feature : {
  					            mark : {show: true},
  					            dataView : {show: true, readOnly: false},
  					            magicType : {
  					                show: true, 
  					                type: ['pie']
  					            },
  					            restore : {show: true},
  					            saveAsImage : {show: true}
  					        }
  					    },
  					    calculable : true,
  					series : [ {
  						name : 'bug按需求分布情况',
  						type : 'pie',
  						radius : '40%',
  						center : [ '50%', '45%' ],
  						label : {
  							normal : {
  								fontSize : 12,
  								formatter : '{b}: {c} ({d}%)  ',
  								rich : {
  									b : {
  										fontSize : 16,
  										lineHeight : 33
  									},
  								}
  							}
  						},
  						data : data,
  						itemStyle : {
  							emphasis : {
  								shadowBlur : 10,
  								shadowOffsetX : 0,
  								shadowColor : 'rgba(0, 0, 0, 0.5)'
  										}
  									}
  								} ]
  						};
        	 myChart.clear();//数据清空重新加载
  				// 使用刚指定的配置项和数据显示图表。
  				myChart.setOption(option);
  					}
  			})
          })
      })
     
     

      //按进度计划分布饼图
  $(function() {  
      $('#bug_week').click(function() {  
    	  var params = AOS.getValue('bug_state_form');
     	 params.proj_id = AOS.get('id_proj_name').getValue();
     	 params.id = AOS.get('bug_week');
   AOS.ajax({
 	  url:"projBugAnalysisService.listWeek",
      data: {  },
      params: params,
      ok:function(data){
     	 if(!AOS.empty(data.appmsg)){
     		 myChart.clear();//数据清空重新加载
     		 AOS.tip(data.appmsg);
     		 return;
     	 }
				option = {
					title : {
						text : 'bug按进度计划分布图',
						top: '15',
						x : 'center'
					},
					tooltip : {
						trigger : 'item',
						  formatter: "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
				        x : 'left',
				        data:data["legen"]
					},
					  toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {
					                show: true, 
					                type: ['pie']
					            },
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
					series : [ {
						name : '按进度计划分布情况',
						type : 'pie',
						radius : '40%',
						center : [ '50%', '45%' ],
						label : {
							normal : {
								fontSize : 12,
								formatter : '{b}: {c} ({d}%)  ',
								rich : {
									b : {
										fontSize : 16,
										lineHeight : 33
									},
								}
							}
						},
						data : data,
						itemStyle : {
							emphasis : {
								shadowBlur : 10,
								shadowOffsetX : 0,
								shadowColor : 'rgba(0, 0, 0, 0.5)'
										}
									}
								} ]
						};
				 myChart.clear();//数据清空重新加载
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
					}
			})
      })
  })
     
     //按缺陷遗留人分布饼图
     $(function() {  
         $('#bug_man').click(function() {  
        	 var params = AOS.getValue('bug_state_form');
        	 params.proj_id = AOS.get('id_proj_name').getValue();
        	 params.id = AOS.get('bug_man');
      AOS.ajax({
    	  url:"projBugAnalysisService.listUser",
         data: {  },
         params: params,
         ok:function(data){
        	 if(!AOS.empty(data.appmsg)){
        		 myChart.clear();//数据清空重新加载
        		 AOS.tip(data.appmsg);
        		 return;
        	 }
				option = {
					title : {
						text : '遗留缺陷按人分布图',
						top: '15',
						x : 'center'
					},
					tooltip : {
						trigger : 'item',
						  formatter: "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
				        x : 'left',
				        data:data["legen"]
					},
					  toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {
					                show: true, 
					                type: ['pie']
					            },
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
					series : [ {
						name : 'bug按人分布情况',
						type : 'pie',
						radius : '40%',
						center : [ '50%', '45%' ],
						label : {
							normal : {
								fontSize : 12,
								formatter : '{b}: {c} ({d}%)  ',
								rich : {
									b : {
										fontSize : 16,
										lineHeight : 33
									},
								}
							}
						},
						data : data,
						itemStyle : {
							emphasis : {
								shadowBlur : 10,
								shadowOffsetX : 0,
								shadowColor : 'rgba(0, 0, 0, 0.5)'
										}
									}
								} ]
						};
				 myChart.clear();//数据清空重新加载
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
					}
			})
      })
  })
     
     
     //按类型分布柱形图
     $(function() {  
         $('#bug_type').click(function() {  
        	 var params = AOS.getValue('bug_state_form');
        	 params.proj_id = AOS.get('id_proj_name').getValue();
        	 params.id = AOS.get('bug_type');
      AOS.ajax({
    	 url:"projBugAnalysisService.listType", 
         data: {},
         params: params,
         ok:function(data){
        	 if(!AOS.empty(data.appmsg)){
        		 myChart.clear();//数据清空重新加载
        		 AOS.tip(data.appmsg);
        		 return;
        	 }
        	 option = {
        			    title : {
        			        text: '按缺陷类型分布图'
        			    },
        			    tooltip : {
        			        trigger: 'axis'
        			    },
        			    legend: {
        			        data:data["legen"]
        			    },
        			    toolbox: {
        			        show : true,
        			        feature : {
        			            mark : {show: true},
        			            dataView : {show: true, readOnly: false},
        			            magicType : {show: true, type: ['line', 'bar']},
        			            restore : {show: true},
        			            saveAsImage : {show: true}
        			        }
        			    },
        			    calculable : true,
        			    xAxis : [
        			        {
        			            type : 'category',
        			            data : data["legen"]
        			        }
        			    ],
        			    yAxis : [
        			        {
        			            type : 'value'
        			        }
        			    ],
        			    series : [
        			        {
        			            type:'bar',
        			            data:data["series"],
        			       　//设置柱的宽度，要是数据太少，柱子太宽不美观~
	         		　　　　　　　　　　barWidth:70,
       			           itemStyle: {
       		                    normal: {
       		　　　　　　　　　　　　　　//好，这里就是重头戏了，定义一个list，然后根据所以取得不同的值，这样就实现了，
       		                        color: function(params) {
       		                            var colorList = [
       		                              '#C1232B','#C71585','#483D8B','#5F9EA0','	#696969',
       		                               '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
       		                               '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
       		                            ];
       		                            return colorList[params.dataIndex]
       		                       							 },
       		　　　　　　　　　　　　　　//以下为是否显示，显示位置和显示格式的设置了
	         		                        label: {
	         		                            show: true,
	         		                            position: 'top',
	//         		                             formatter: '{c}'
	         		                            formatter: '{b}\n{c}'
	         		                       		 }
       		                  			  }
       		               			 },
       	       		          	  markLine : {
       	       		                data : [
       	       		                    {type : 'average', name : '平均值'}
       	       		                ]
       	       		            }
       		          	  } 
       		        ]
          	 };
        	 myChart.clear();//数据清空重新加载
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
					}
			})
      })
  })
     
     
         //按状态分布柱形图
         $(function() {  
             $('#bug_state').click(function() {  
            	 var params = AOS.getValue('bug_state_form');
            	 params.proj_id = AOS.get('id_proj_name').getValue();
            	 params.id = AOS.get('bug_state');
          AOS.ajax({
        	 url:"projBugAnalysisService.listState", 
             data: {},
             params : params,
             ok:function(data){
            	 //数据接口成功返回
            	 if(!AOS.empty(data.appmsg)){
            		 myChart.clear();//数据清空重新加载
            		 AOS.tip(data.appmsg);
            		 return;
            	 }
            	 option = {
         			    title : {
         			        text: '按缺陷状态分布图'
         			    },
         			    tooltip : {
         			        trigger: 'axis'
         			    },
         			    legend: {
         			        data:data["legen"]
         			    },
         			    toolbox: {
         			        show : true,
         			        feature : {
         			            mark : {show: true},
         			            dataView : {show: true, readOnly: false},
         			            magicType : {show: true, type: ['line', 'bar']},
         			            restore : {show: true},
         			            saveAsImage : {show: true}
         			        }
         			    },
         			    calculable : true,
         			    xAxis : [
         			        {
         			            type : 'category',
         			            data : data["legen"]
         			        }
         			    ],
         			    yAxis : [
         			        {
         			            type : 'value'
         			        }
         			    ],
         			    series : [
         			        {
         			            type:'bar',
         			            data:data["series"],
         			          　//设置柱的宽度，要是数据太少，柱子太宽不美观~
  	         		　　　　　　　　　　barWidth:70,
         			           itemStyle: {
         		                    normal: {
         		　　　　　　　　　　　　　　//好，这里就是重头戏了，定义一个list，然后根据所以取得不同的值，这样就实现了，
         		                        color: function(params) {
         		                            var colorList = [
         		                              '#C1232B','#C71585','#483D8B','#ADD8E6','	#696969',
         		                               '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
         		                               '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
         		                            ];
         		                            return colorList[params.dataIndex]
         		                       							 },
         		　　　　　　　　　　　　　　//以下为是否显示，显示位置和显示格式的设置了
	         		                        label: {
	         		                            show: true,
	         		                            position: 'top',
	//         		                             formatter: '{c}'
	         		                            formatter: '{b}\n{c}'
	         		                       		 }
         		                  			  }
         		               			 },
              	       		          	  markLine : {
                 	       		                data : [
                 	       		                    {type : 'average', name : '平均值'}
                 	       		                ]
                 	       		            }
         		          	  }
         		        ]
            	 };
	         		 myChart.clear();//数据清空重新加载
	 				// 使用刚指定的配置项和数据显示图表。
	 				myChart.setOption(option);
 					}
 			})
       })
   })
        
	</script>
</aos:onready>

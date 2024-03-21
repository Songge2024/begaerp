# echarts图表范例

## 1. echarts配置文件引用
- 首先在html中引入echarts文件(不同的框架引入方式不同)
- a.一般引用echarts文件的格式：

```
<aos:html>
  <script src="echarts/echarts.min.js"></script> (项目存放echarts.min.js的路径)
<aos:body>
</aos:body>
</aos:html>
```
- 例如：在BL3项目管理平台中的echarts文件引用(两种选其一)
```
<aos:html title="" base="http" lib="ext,echart" >
  <aos:body>
  </aos:body>
  </aos:html>
  ```
  ```
  <aos:html title="" base="http" lib="ext" >
    <script src="${cxt}/static/weblib/echart/echarts.min.js"  ></script>
    <aos:body>
    </aos:body>
    </aos:html>
```
 ## 2. 准备放置图表的容器

```
<aos:html title="项目缺陷分析表" base="http" lib="ext,echart" >
<aos:body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="position:absolute; top:15px; right:20px; width:720px; height:460px"  ></div>
      
</aos:body>
</aos:html>
```
## 3. 初始化图表

```
<script type="text/javascript">
  // 基于准备好的dom，初始化echarts图表
     var myChart = echarts.init(document.getElementById('main')); 
     </script>
```

## 4.  图表的基本配置显示项option


####   [柱状图Option配置(可修改查看效果)](http://echarts.baidu.com/examples/editor.html?c=bar-simple)

```
option = {
    xAxis: {  //x轴配置
        type: 'category', 
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']//后台传输的数据
    },
    yAxis: { //y轴配置
        type: 'value'
    },
    series: [{
        data: [120, 200, 150, 80, 70, 110, 130],//柱子展示的详细数值
        type: 'bar' //bar表示为柱形图
    }]
};
```
![image](E:/workspace/AOSuite/webapp/static/weblib/editor.md/images/zzt.png)
####   [折线图Option配置(可修改查看效果)](http://echarts.baidu.com/examples/editor.html?c=line-stack)

```
折线图和柱形图Option配置项一致，只需要将type:'bar'改为'line'(可修改查看效果)
```
![image](E:/workspace/AOSuite/webapp/static/weblib/editor.md/images/zxt.png)
####  [饼状图Option配置(可修改查看效果)](http://echarts.baidu.com/examples/editor.html?c=pie-simple)

```
option = {
    title : {
        text: '某站点用户访问来源',
        subtext: '纯属虚构',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
    },
    series : [
        {
            name: '访问来源',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:335, name:'直接访问'},
                {value:310, name:'邮件营销'},
                {value:234, name:'联盟广告'},
                {value:135, name:'视频广告'},
                {value:1548, name:'搜索引擎'}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
};
```
![image](E:/workspace/AOSuite/webapp/static/weblib/editor.md/images/bzt.png)
## 5. 使用刚指定的配置项和数据显示图表
 				myChart.setOption(option);

## 关键点：
```
在使用echarts.js的时候一定要配置xAxis,yAxis,series这三个参数，如果是不想设置的话也要初始化可以将其设置为空JSON就可以了，要不然会出项报错，同时要保证在echarts.init之前的对象是有宽高的，要不然也会出现错误
```
#### 清空上次数据重载图表(可用于按钮切换事件)

```
myChart.clear();//数据清空重新加载,放在myChart.setOption(option)之前
```

## 后台异步加载数据
### 饼图代码参考：
```
        $(function() {  
                 $('#id').click(function() {  
              AOS.ajax({
            	  url:"projBugAnalysisService.listModule",
                 data: { },
                 params:{
                 },
   ok:function(data){
 			option = {
 					title : {         //标题
 						text : '',
 						top: '15',
 						x : 'center'
 					},
 					tooltip : { //鼠标悬浮框
 						trigger : 'item',
 						  formatter: "{a} <br/>{b} : {c} ({d}%)"
 					},
 					//左部标签数据展示图例，每个图表最多仅有一个图例 
 					legend : {               
 						orient : 'vertical',
 				        x : 'left',
 				        data:data["legen"]
 				       //data内的字符串数组需要与sereis数组内每一个series的name值对应
 					},
 					  toolbox: { //工具箱，每个图表最多仅有一个工具箱   
 					        show : true,
 					        feature : {
 					            mark : {show: true},//辅助线标志
 					            dataView : {show: true, readOnly: false},//只可读的数据视图
 					            magicType : {
 					                show: true, 
 					                type: ['pie']//类型为饼图
 					            },
 					            restore : {show: true},//还原图形
 					            saveAsImage : {show: true}//可存为图片
 					        }
 					    },
 			 //是否启用拖拽重计算特性，默认关闭(即值为false) 
 			  calculable : true,
 					series : [ {
 						name : '',
 						type : 'pie//类型为饼图
 						radius : '40%',
 						center : [ '50%', '45%' ],//圆的中心位置
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
 						data : data//后台传输的json数组
 						itemStyle : {//饼图上显示的数据
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
```
### 参考资料
#### [参数详解](http://blog.csdn.net/bruce__taotao/article/details/52815550)
#### [echarts官网实例](http://echarts.baidu.com/echarts2/doc/example.html)

#### [入门教程](http://echarts.baidu.com/echarts2/doc/start.html)






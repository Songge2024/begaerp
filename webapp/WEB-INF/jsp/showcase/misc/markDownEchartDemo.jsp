<!-- 基于markdown编辑器的echarts图表范例-->
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="基于markdown在线编辑器" base="http" lib="ext">
<aos:body>
<link href="${cxt}/static/weblib/editor.md/css/editormd.min.css" rel="stylesheet" type="text/css" />
<link href="${cxt}/static/weblib/editor.md/css/editormd.logo.css" rel="stylesheet" type="text/css" />
<link href="${cxt}/static/weblib/editor.md/css/editormd.logo.min.css" rel="stylesheet" type="text/css" />
<link href="${cxt}/static/weblib/editor.md/css/editormd.css" rel="stylesheet" type="text/css" />
<link href="${cxt}/static/weblib/editor.md/css/editormd.preview.css" rel="stylesheet" type="text/css" />
<link href="${cxt}/static/weblib/editor.md/css/editormd.preview.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${cxt}/static/weblib/jquery/jquery.min-1.10.2.js">
</script>
<script type="text/javascript" src="${cxt}/static/weblib/editor.md/editormd.min.js">
</script>
<script type="text/javascript" src="${cxt}/static/weblib/editor.md/editormd.js">
</script>
<script type="text/javascript" src="${cxt}/static/weblib/editor.md/Gulpfile.js">
</script>
<script type="text/javascript" src="${cxt}/static/weblib/editor.md/editormd.amd.min.js">
</script>
<script type="text/javascript" src="${cxt}/static/weblib/editor.md/editormd.amd.js">
</script>
<div class="editormd" id="test-editormd">
  <textarea class="editormd-markdown-textarea" name="test-editormd-markdown-doc"></textarea>
  <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
  <textarea class="editormd-html-textarea" name="text">
  </textarea>
</div>
<script type="text/javascript">
  $(function() {
      editormd("test-editormd", {
          width   : "95%",
          height  : 640,
          emoji: true,
          tex: true,               // 默认不解析
          syncScrolling : "single",
          //你的lib目录的路径，我这边用JSP做测试的
          path    : "${cxt}/static/weblib/editor.md/lib/",
          //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。
          saveHTMLToTextarea : true
      });
  });
  
  
  
</script>
</aos:body>
</aos:html>


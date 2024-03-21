<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="评论内页" base="http" lib="ext,ueditor">
	<link rel="stylesheet" type="text/css" href="${cxt}/static/css/modules/theme.css" />
	<style>
		body {
			overflow: auto
		}
	</style>
<aos:body>
	<main>
		<c:choose>
			<c:when test="${has_theme == 'false'}">
				<div class="comment_box">
					<div class="guest_link">
						<span class="log_ico"><i class="fa fa-user fa-1x"></i></span> 
						<span class="txt">
							没有评论信息
						</span>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<!-- 主题区域 开始 -->
				<article id="theme_article">
					<h1 class="csdn_top">${theme.title}</h1>
					<div class="article_bar clearfix">
			            <div class="artical_tag">
			                <span class="time"><fmt:formatDate pattern="yyyy年MM月dd日  HH:MM" value="${theme.create_time}" /></span>
			            </div>
			            <ul class="article_tags clearfix csdn-tracking-statistics tracking-click" data-mod="popu_377">
			                <li class="tit">标签：</li>
							<li>${theme.tags }</li>
			            </ul>
			            <ul class="right_bar">
			                <li>
			                <button class="btn-noborder">
			                <i class="fa fa-bullseye"></i><span class="txt">${theme.reply_num }</span>
			                </button></li>
			                <li class="edit" >
			                    <a class="btn-noborder" href="javascript:;">
			                        <i class="fa fa-edit"></i><span class="txt">编辑</span>
			                    </a>
			                </li>
			            </ul>
			        </div>
			        <div class="article_content"><c:if test="${!empty theme.content}">${theme.content }</c:if></div>
				</article>
				<!-- 主题区域结束  -->
				<c:choose>
					<c:when test="${has_reply == 'false'}">
						<div class="comment_box">
							<div class="guest_link">
								<span class="log_ico"><i class="fa fa-user fa-1x"></i></span> 
								<span class="txt">
									没有回复信息
								</span>
							</div>
						</div>
						<div class="comment_li_outbox">
			    			<div class="comment_list">
			    				<div class="more_comment">
									<div id="comment_bar" class="trackgin-ad" data-mod="popu_385"
										style="display: block;">
										<a class="btn btn-large more_comment_btn show_editor" >新增回复 <i class="icon iconfont icon-xiajiantou"></i></a>
										<a class="btn btn-large more_comment_btn save_editor" >保存回复 <i class="icon iconfont icon-xiajiantou"></i></a>
									</div>
									<script type="text/plain" id="add_reply_editor" style="text-align: left; width:100%;height:350px;">
									</script>
							    </div>
			    			</div>
			    		</div>
					</c:when>
					<c:otherwise>
						<div class="comment_li_outbox">
			    			<div class="comment_list">
				    			<c:forEach var="reply" items="${replys}" varStatus="status">
									<div class="comment_li_box clearfix"> 
									   <dl class="comment_list clearfix"> 
										   <dt><a href="#"><img src="${cxt}/static/css/modules/33177965.png" alt="qq_33177965" /></a></dt> 
										   <dd> 
											   <ul class="com_r clearfix"> 
												   <li class="top clearfix"> <h4><a href="javascript:;">${reply.username }</a></h4> 
													   <span class="time"><fmt:formatDate pattern="yyyy-MM-dd HH:MM" value="${reply.create_time}" /></span>
													   <span class="floor_num" floor="${status.index+1 }">${status.index+1 }楼</span> 
												   </li> 
												   <li class="mid clearfix">
												   	   <div class="comment_p">${reply.content}</div>
												   </li> 
											   </ul> 
										    </dd> 
									   </dl>
									   <div class="child_comment" data-listshow="false"> 
									   		<div class="autoHeight clearfix"> </div>
									   </div> 
									</div>
								</c:forEach>
								<!-- 查看更多 -->
								<div class="more_comment">
									<div id="comment_bar" class="trackgin-ad" data-mod="popu_385"
										style="display: block;">
										<a class="btn btn-large more_comment_btn show_editor" >新增回复 <i class="icon iconfont icon-xiajiantou"></i></a>
										<a class="btn btn-large more_comment_btn save_editor" >保存回复 <i class="icon iconfont icon-xiajiantou"></i></a>
									</div>
									<script type="text/plain" id="add_reply_editor" style="text-align: left; width:100%;height:350px;">
									</script>
							    </div>
			    			</div>
			    		</div>
					</c:otherwise>
				</c:choose>	
			</c:otherwise>
		</c:choose>
	</main>
</aos:body>
</aos:html>
<aos:onready>
	<script>
		var add_reply_editor;
		$("a.save_editor").hide();
		$("a.show_editor").click(function(){
			if(!add_reply_editor){
				add_reply_editor= UM.getEditor('add_reply_editor');
			}
			$("a.save_editor").show();
			$("a.show_editor").hide();
		});
		$("a.save_editor").click(function(){
			if(AOS.empty(add_reply_editor.getContent().trim())){
				AOS.tip("回复内容不能为空");
				return;
			}
			//保存回复信息
			AOS.ajax({
				url:'themeService.createReply',
				params : {
					theme_id:'${theme.id}',
					content:add_reply_editor.getContent()
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					window.location.reload();
				}
			});
		});
	</script>
</aos:onready>

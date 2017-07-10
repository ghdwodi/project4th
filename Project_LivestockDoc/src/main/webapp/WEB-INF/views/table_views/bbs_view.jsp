<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축산천국</title>
		<script type="text/javascript">
			function bbs_del(b_idx){
				var delConfirm = confirm("정말로 삭제하시겠습니까?");
				if(!delConfirm){
					return;
				}else{
					$.ajax({
						url:"Rest/bbs_delete.do",
						type:"get",
						data:"b_idx="+b_idx,	// 서블릿에 넘어가는 데이터
						dataType:"text",
						success:function(data){
							location.href="bbs.go?b_category=${b_category}&cPage=${cPage}";
						},
						error:function(){
							alert("실패");
						}
					});
				}
			}
			function reply_do(b_idx,c_idx){
				if("${loginchk}"=='-1'){
					alert("로그인을 하십시오!");
					location.href="loginpage.go";
				}else{
					if($("#replycontent").val()==""){
						alert("내용을 입력하세요.")
						return;
					}
					$.ajax({
						url:"Rest/reply_insert.do",
						type:"get",
						data:"b_idx="+b_idx+"&c_idx="+c_idx+"&content="+$("#replycontent").val(),	// 서블릿에 넘어가는 데이터
						dataType:"text",
						success:function(data){
							location.href="bbsView.go?b_idx=${bbsVO.b_idx}&cPage=${cPage}&b_category=${b_category}";
						},
						error:function(){
							alert("실패");
						}
					});
				}
			}
			function del_reply(r_idx) {
				var delConfirm = confirm("정말로 삭제하시겠습니까?");
				if(!delConfirm){
					return;
				}else{
					$.ajax({
						url:"Rest/reply_delete.do",
						type:"get",
						data:"r_idx="+r_idx,	// 서블릿에 넘어가는 데이터
						dataType:"text",
						success:function(data){
							location.href="bbsView.go?b_idx=${bbsVO.b_idx}&cPage=${cPage}&b_category=${b_category}";
						},
						error:function(){
							alert("실패");
						}
					});
				}
			}
		</script>
		<style type="text/css">
			.intronav{
				background-color: skyblue;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../top.jsp"/>
		<div class="container">
			<div class="row">
				<div class="col-md-2">
					<ul class="nav intronav">
						<li><a href="bbs.go?b_category=0">공지사항</a></li>
						<li><a href="bbs.go?b_category=1">자유게시판</a></li>
						<li><a href="bbs.go?b_category=2">연재</a></li>
						<li><a href="bbs.go?b_category=3">뉴스</a></li>
					</ul>
				</div>
				<div class="col-md-10">
					<div class="container-fluid">
						<table class="table">
							<tr>
								<th colspan="2">${bbsVO.title}</th><!-- 제목 -->
							</tr>
							<tr>
								<td class="col-xs-10">${bbsVO.c_nickname}</td><!-- 글쓴이 -->
								<td class="col-xs-2">조회수 : ${bbsVO.hit}</td><!-- 히트수 -->
							</tr>
							<tr>
								<td colspan="2">${bbsVO.content}</td><!-- 내용 -->
							</tr>
							<tr>
								<td colspan="2">
									<c:choose>
										<c:when test="${(bbsVO.c_idx==cvo.c_idx)||(cvo.c_idx==0)}">
											<input type="button" class="btn btn-default" value="수정" onclick="javascript:location.href='bbs_modify.go?b_idx=${bbsVO.b_idx}'"/>
											<input type="button" class="btn btn-default" value="삭제" onclick="bbs_del(${bbsVO.b_idx})"/>
										</c:when>
									</c:choose>
									<input type="button" class="btn btn-default" value="목록" onclick="javascript:location.href='bbs.go?b_category=${b_category}'"/>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea id="replycontent" rows="5" class="form-control"></textarea>
								</td>
							</tr>
							<tr>
								<td class="col-sm-11"></td>
								<td class="col-sm-1"><input type="button" class="btn btn-default" value="답글" onclick="reply_do(${bbsVO.b_idx},${cvo.c_idx})"></td>
							</tr>
						</table>
						<c:forEach items="${repVOList}" var="k">
							<hr />
							<div class="media">
								<div class="media-body">
									<c:choose>
										<c:when test="${k.lev==0}">
											<div class="row">
												<div class="col-sm-6"><h4 class="media-heading">${k.c_nickname}님의 답글</h4></div>
												<c:choose>
													<c:when test="${cvo.c_idx==k.c_idx}">
														<div class="col-sm-2"><input type="button" class="btn btn-default" value="댓글 삭제" onclick="del_reply(${k.r_idx})"></div>
													</c:when>
												</c:choose>
												<div class="col-sm-4"><p>${k.r_date}</p></div>
											</div>
											<p>${k.content}</p>
										</c:when>
										<c:otherwise>
											<div class="row">
												<div class="col-sm-8"><h4 class="media-heading">삭제된 댓글입니다.</h4></div>
												<div class="col-sm-4"><p>${k.r_date}</p></div>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>	
	</body>
</html>
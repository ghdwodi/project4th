<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축산천국</title>
		<script type="text/javascript">
			function bbs_insert_go(b_category) {
				if("${loginchk}"=='-1'){
					alert("로그인을 하십시오!");
					location.href="loginpage.go";
				}else{
					if(b_category=='0' && "${loginchk}"!='0'){
						alert("관리자만 글쓰기가 가능합니다!");
						return;
					}
					location.href="bbs_insert.go?b_category="+b_category;
				}
			}
			function msgModalview(c_idx,c_idx_sender,c_sender_nickname) {
				if("${loginchk}"=='-1'){
					alert("로그인을 하십시오!");
					location.href="loginpage.go";
				}else{
					$("#postSend_title").html(c_sender_nickname+"님에게 보내는 쪽지");
					$("#sendMsgModal_c_idx").val(c_idx);
					$("#sendMsgModal_c_idx_sender").val(c_idx_sender);
					$("#msgSendModal").modal('show');
				}
			}
			function msg_send2(f) {
				if(f.m_content.value==""){
					alert("내용을 입력하세요.");
					return;
				}
				var c_idx = f.c_idx.value;
				var c_idx_sender = f.c_idx_sender.value;
				var m_content = f.m_content.value;
				$.ajax({
					url:"Rest/msg_insert.do",
					type:"get",
					data:"c_idx="+c_idx+"&c_idx_sender="+c_idx_sender+"&m_content="+m_content,
					// 서블릿에 넘어가는 데이터
					dataType:"text",
					success:function(data){
						alert("전송했습니다.");
						f.m_content.value="";
						$("#msgSendModal").modal("hide");
					},
					error:function(){
						alert("실패");
					}
				});
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
					<table class="table">
						<thead>
							<tr>
								<th class="col-xs-1">번호</th>
								<th class="col-xs-6">제목</th>
								<th class="col-xs-3">글쓴이</th>
								<th class="col-xs-2">날짜</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty bbsVOList}">
									<tr><td colspan="4"><h2>등록된 자료가 없습니다.</h2></td></tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="k" items="${bbsVOList}" varStatus="vs">
										<tr>
											<td>${p.totalRecord-((p.nowPage-1)*p.numPerPage+vs.index)}</td>
											<td align="left">
												<a href="bbsView.go?b_idx=${k.b_idx}&cPage=${cPage}&b_category=${b_category}">${k.title}</a>
											</td>
											<td>
												<div class="dropdown">
													<a data-toggle="dropdown">${k.c_nickname}</a>
													<ul class="dropdown-menu" role="menu">
														<c:choose>
															<c:when test="${loginchk==-1}">
																<li><a tabindex="-1" href="javascript:alert('로그인을 하십시오')">회원정보</a></li>
																<li><a tabindex="-1" href="javascript:alert('로그인을 하십시오')">쪽지보내기</a></li>
															</c:when>
															<c:otherwise>
																<li><a tabindex="-1" href="javascript:location.href='personalpage.go?c_idx=${k.c_idx}'">회원정보</a></li>
																<li><a tabindex="-1" href="javascript:msgModalview(${k.c_idx},${cvo.c_idx},'${k.c_nickname}')">쪽지보내기</a></li>
															</c:otherwise>
														</c:choose>
													</ul>
												</div>
											</td>
											<td>${k.b_date.substring(0,10)}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
						<tfoot>
							<tr align="center">
								<td colspan="4">
									<div class="row visible-md visible-lg">
										<div class="col-md-8 col-md-offset-2">
											<ul class="pagination">
												<%-- 이전 버튼 --%>
												<c:choose>
													<c:when test="${p.beginPage<=p.pagePerBlock}">
														<li class="disabled"><a href="#">&laquo;</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="bbs.go?b_category=${b_category}&cPage=${p.beginPage-p.pagePerBlock}">&laquo;</a></li>
													</c:otherwise>
												</c:choose>
												<c:forEach var="k" begin="${p.beginPage}" end="${p.endPage}" step="1" varStatus="vs">
													<c:choose>
														<c:when test="${k==p.nowPage}">
															<li class="active"><a href="bbs.go?b_category=${b_category}&cPage=${k}">${k}</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="bbs.go?b_category=${b_category}&cPage=${k}">${k}</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<%--다음 버튼--%>
												<c:choose>
													<c:when test="${p.endPage>=p.totalPage}">
														<li class="disabled"><a href="#">&raquo;</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="bbs.go?b_category=${b_category}&cPage=${p.beginPage+p.pagePerBlock}">&raquo;</a></li>
													</c:otherwise>
												</c:choose>
											</ul>
										</div>
										<div class="col-md-2">
											<input type="button" class="btn btn-default" value="글쓰기" onclick="bbs_insert_go(${b_category})"/>
										</div>
									</div>
									<div class="row visible-xs visible-sm">
										<div class="col-xs-12">
											<ul class="pager">
												<%-- 이전 버튼 --%>
												<c:choose>
													<c:when test="${p.nowPage>1}">
														<li><a href="bbs.go?b_category=${b_category}&cPage=${p.nowPage-1}">← 이전 페이지</a></li>
													</c:when>
												</c:choose>
												<li>${p.nowPage}/${p.totalPage}</li>
												<%--다음 버튼--%>
												<c:choose>
													<c:when test="${p.nowPage<p.totalPage}">
														<li><a href="bbs.go?b_category=${b_category}&cPage=${p.nowPage+1}">다음 페이지 →</a></li>
													</c:when>
												</c:choose>
											</ul>
										</div>
									</div>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			<div id="msgSendModal" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span>
								<span class="sr-only">Close</span>
							</button>
							<h4 id="postSend_title"></h4>
						</div>
						<form>
							<div id="msgSend_body" class="modal-body">
								<textarea rows="5" class="form-control" name="m_content"></textarea>
							</div>
							<div class="modal-footer">
								<input type="hidden" name="c_idx" id="sendMsgModal_c_idx"/>
								<input type="hidden" name="c_idx_sender" id="sendMsgModal_c_idx_sender"/>
								<input type="button" class="btn btn-default" value="보내기" onclick="msg_send2(this.form)">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>			
	</body>
</html>
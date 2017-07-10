<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript">
			function loginpage_go(){
				alert("로그인하십시오");
				location.href="loginpage.go";
			}
		</script>
	</head>
	<c:choose>
		<c:when test="${loginchk==-1||empty loginchk}">
			<body onload="loginpage_go()"></body>
		</c:when>
		<c:otherwise>
			<body>
				<table class="table">
					<thead>
						<tr>
							<th class="col-xs-8">보낸 사람</th>
							<th class="col-xs-4">날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty msgList}">
								<tr><td colspan="2"><h2>쪽지가 없습니다.</h2></td></tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="k" items="${msgList}" varStatus="vs">
									<c:choose>
										<c:when test="${k.readchk==0}">
											<tr class="tr_${k.m_idx}" style="background-color: #ccffcc">
												<td align="left">
													<a href="javascript:postview(${k.m_idx},${k.c_idx})">${k.c_sender_nickname} 님의 메시지</a>
												</td>
												<td>${k.m_date}</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<td align="left">
													<a href="javascript:postview(${k.m_idx},${k.c_idx})">${k.c_sender_nickname} 님의 메시지</a>
												</td>
												<td>${k.m_date}</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
					<tfoot>
						<tr align="center">
							<td colspan="2">
								<div class="row visible-md visible-lg">
									<div class="col-md-12">
										<ul class="pagination">
											<%-- 이전 버튼 --%>
											<c:choose>
												<c:when test="${p.beginPage<=p.pagePerBlock}">
													<li class="disabled"><a href="#">&laquo;</a></li>
												</c:when>
												<c:otherwise>
													<li><a href="personalpost.go?c_idx=${c_idx}&cPage=${p.beginPage-p.pagePerBlock}">&laquo;</a></li>
												</c:otherwise>
											</c:choose>
											<c:forEach var="k" begin="${p.beginPage}" end="${p.endPage}" step="1" varStatus="vs">
												<c:choose>
													<c:when test="${k==p.nowPage}">
														<li class="active"><a href="personalpost.go?c_idx=${c_idx}&cPage=${k}">${k}</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="personalpost.go?c_idx=${c_idx}&cPage=${k}">${k}</a></li>
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
				<div id="msgViewModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">&times;</span>
									<span class="sr-only">Close</span>
								</button>
								<h4 id="post_title"></h4>
							</div>
							<div id="post_body" class="modal-body"></div>
							<div class="modal-footer">
								<form>
									<textarea rows="5" class="form-control" name="m_content"></textarea>
									<input type="hidden" name="c_idx" id="modal_c_idx"/>
									<input type="hidden" name="c_idx_sender" id="modal_c_idx_sender"/>
									<input type="button" class="btn btn-default" value="답장하기" onclick="msg_send(this.form)">
								</form>
							</div>
						</div>
					</div>
				</div>
			</body>
		</c:otherwise>
	</c:choose>
</html>
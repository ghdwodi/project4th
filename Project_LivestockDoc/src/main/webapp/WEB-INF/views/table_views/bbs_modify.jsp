<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축산천국</title>
		<script type="text/javascript">
			function bbs_modify(f) {
				if(f.title.value==""){
					alert("제목을 입력하세요");
					return;
				}
				if(f.content.value==""){
					alert("내용을 입력하세요");
					return;
				}
				$.ajax({
					url:"Rest/bbs_modify.do",
					type:"get",
					data:$("#bbsmodifyform").serialize(),	// 서블릿에 넘어가는 데이터
					dataType:"text",
					success:function(data){
						location.href="bbs.go?b_category=${b_category}&cPage=${cPage}";
					},
					error:function(){
						alert("실패");
					}
				});
			}
			function loginpage_go(){
				alert("로그인하십시오");
				location.href="loginpage.go";
			}
		</script>
		<style type="text/css">
			.intronav{
				background-color: skyblue;
			}
		</style>
	</head>
	<c:choose>
		<c:when test="${loginchk==-1||empty loginchk}">
			<body onload="loginpage_go()"></body>
		</c:when>
		<c:otherwise>
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
								<form id="bbsmodifyform">
									<table class="table">
										<tr>
											<th colspan="2">
												<input type="hidden" value="${bbsVO.b_idx}" name="b_idx">
												<input type="hidden" value="${b_category}" name="b_category">
												<label class="col-xs-2">제목</label>
												<div class="col-xs-10">
													<input type="text" class="form-control" value="${bbsVO.title}" name="title">
												</div>
											</th><!-- 제목 -->
										</tr>
										<tr>
											<td colspan="2">
												<textarea rows="5" class="form-control" name="content">${bbsVO.content}</textarea>
											</td><!-- 내용 -->
										</tr>
										<tr>
											<td colspan="2">
												<input type="button" value="입력" onclick="bbs_modify(this.form)"/>
												<input type="button" value="목록"/>
											</td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
				</div>	
			</body>
		</c:otherwise>
	</c:choose>
</html>
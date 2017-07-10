<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript">
			function counsel_insert(f) {
				if(f.title.value=="" || f.counsel_content.value==""){
					alert("제목과 내용을 입력하세요");
					return;
				}
				$.ajax({
					url:"Rest/insertcounsel.do",
					type:"post",
					data:$("#insertcounsel").serialize(),
					dataType:"text",
					success:function(data){
						location.href="personalcounsel.go?c_idx="+data;
					},
					error:function(){
						alert("상담 입력 실패");
					}
				});
			}
			function score_save(i,counsel_idx) {
				$("#score_"+counsel_idx).val(i);
				$("#score_view_"+counsel_idx).html(i+"점");
			}
			function score_do(f,counsel_idx,c_idx) {
				if(f.counsel_score.value==""){
					alert("점수를 선택하세요");
					return;
				}
				$.ajax({
					url:"Rest/updatecounselScore.do",
					type:"post",
					data:$("#counselScoreForm_"+counsel_idx).serialize(),
					dataType:"text",
					success:function(data){
						location.href="personalcounsel.go?c_idx="+c_idx;
					},
					error:function(){
						alert("상담 입력 실패");
					}
				});
			}
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
				<form id="insertcounsel">
					<div class="radio">
						<label class="radio-inline">
							<input type="radio" name="counsel_category" value="0" checked="checked">질병
						</label>
						<label class="radio-inline">
							<input type="radio" name="counsel_category" value="1">건강관리
						</label>
						<label class="radio-inline">
							<input type="radio" name="counsel_category" value="2">기타
						</label>
					</div>
					<input type="hidden" name="c_idx" value="${cvo.c_idx}">
					<div class="form-group">
						<label for="Title">제목</label>
						<input type="text" class="form-control" name="title">
					</div>
					<textarea rows="5" class="form-control" name="counsel_content"></textarea>
					<input type="button" class="btn btn-default" value="확인" onclick="counsel_insert(this.form)"/>
				</form>
				<hr />
				<div id="counsel-accordian">
					<div class="panel panel-default">
						<c:forEach items="${counselList}" var="k">
							<c:choose>
								<c:when test="${k.answered==1}">
									<div class="panel-heading" style="background-color: #ffe6ff">
										<h4 class="panel-title">
											<a data-toggle="collapse" onclick="addClassCounsel(${k.counsel_idx})" data-parent="#counsel-accordian" href="#counsel_${k.counsel_idx}">
												${k.title}
											</a>
										</h4>
									</div>
								</c:when>
								<c:otherwise>
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" onclick="addClassCounsel(${k.counsel_idx})" data-parent="#counsel-accordian" href="#counsel_${k.counsel_idx}">
												${k.title}
											</a>
										</h4>
									</div>
								</c:otherwise>
							</c:choose>
							<div id="counsel_${k.counsel_idx}" class="panel-collapse collapse counsel_collapse">
								<div class="panel-body">
									<p>${k.counsel_content}</p>
									<c:choose>
										<c:when test="${k.answered!=0}">
											<hr />
											<div class="media">
												<div class="pull-left">
													<img class="media-object" style="width: 100px;height: 100px" src="doc_profile_img/doc_${k.answerer}.png">
												</div>
												<div class="media-body">
													<h5>답변인 : ${k.answer_name}</h5>
													<p>${k.counsel_answer}</p>
												</div>
											</div>
											<hr />
											<c:choose>
												<c:when test="${k.answered==1}">
													<div class="dropdown col-sm-2">
														<input type="button" class="btn btn-default" value="▼점수" data-toggle="dropdown">
														<ul class="dropdown-menu" role="menu">
															<c:forEach begin="1" end="10" var="i">
																<li onclick="score_save(${i},${k.counsel_idx})">
																	<img src="starratings/star (${i}).png"/>
																</li>
															</c:forEach>
														</ul>
													</div>
													<div class="col-sm-10">
														<form id="counselScoreForm_${k.counsel_idx}">
															<input id="score_${k.counsel_idx}" type="hidden" name="counsel_score">
															<input type="hidden" name="counsel_idx" value="${k.counsel_idx}">
															<span id="score_view_${k.counsel_idx}"></span>
															<input type="button" class="btn btn-default" value="평가 완료" onclick="score_do(this.form,${k.counsel_idx},${cvo.c_idx})">
														</form>
													</div>
												</c:when>
												<c:when test="${k.answered==2}">
													<h3>이미 평가했습니다.</h3>
												</c:when>
											</c:choose>
										</c:when>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</body>
		</c:otherwise>
	</c:choose>
</html>
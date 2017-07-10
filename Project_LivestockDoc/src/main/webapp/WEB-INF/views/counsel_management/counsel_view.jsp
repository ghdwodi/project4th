<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>축산천국</title>
		<script type="text/javascript">
			function answer(f) {
				if(f.counsel_answer.value==""){
					alert("답변을 입력하세요");
					return;
				}
				$.ajax({
					url:"Rest/answercounsel.do",
					type:"post",
					data:$("#counsel_answer_form").serialize(),
					dataType:"text",
					success:function(data){
						location.href="counselmanagement.go";
					},
					error:function(){
						alert("상담 입력 실패");
					}
				});
			}
		</script>
	</head>
	<body>
		<jsp:include page="../top.jsp"/>
		<div class="container">
			<div class="form-group">
				<form id="counsel_answer_form" class="form-horizontal">
					<table class="table">
						<tbody>
							<tr>
								<td>요청인</td>
								<td>${counselVO.c_name}</td>
							</tr>
							<tr>
								<td>제목</td>
								<td>${counselVO.title}</td>
							</tr>
							<tr>
								<td colspan="2">${counselVO.counsel_content}</td>
							</tr>
							<tr>
								<td colspan="2">답변란</td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea rows="5" class="form-control" name="counsel_answer"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="hidden" name="counsel_idx" value="${counselVO.counsel_idx}">
									<input type="hidden" name="c_idx" value="${counselVO.c_idx}">
									<input type="hidden" name="answerer" value="${cvo.c_idx}">
									<input type="button" class="btn btn-default" value="답변" onclick="answer(this.form)">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</body>
</html>
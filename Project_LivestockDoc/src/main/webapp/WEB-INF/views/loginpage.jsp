<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축산천국</title>
		<script type="text/javascript">
			function login2(f) {
				if(f.id.value=="" || f.pwd.value==""){
					alert("ID와 비밀번호를 입력하세요.");
					return;
				}
				$.ajax({
					url:"Rest/login.do",
					type:"post",
					data:$("#login_form2").serialize(),	// 서블릿에 넘어가는 데이터
					dataType:"text",
					success:function(data){
						location.href="login.go";
					},
					error:function(){
						alert("로그인 실패");
					}
				});
			}
		</script>
	</head>
	<body>
		<jsp:include page="top.jsp"/>
		<div class="container">
			<form id="login_form2">
				<div class="col-sm-4 col-sm-offset-4" id="loginfield_div">
					<fieldset>
						<div style="text-align: center;"><img src="resources/img_login.png" style="width: 100%"></div>
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
							<input type="text" name="id" class="form-control" placeholder="아이디">
						</div>
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
							<input type="password" name="pwd" class="form-control" placeholder="암 호">
						</div>
						<input type="button" class="btn btn-default" value="로그인" onclick="login2(this.form)"/>
						<input type="button" class="btn btn-default" value="회원가입" data-toggle="modal" data-target="#loginModal"/>
					</fieldset>
				</div>
			</form>
		</div>
	</body>
</html>
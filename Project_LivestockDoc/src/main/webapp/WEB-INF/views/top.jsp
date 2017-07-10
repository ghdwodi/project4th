<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<title>축산천국</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
		<style type="text/css">
			.navbar{
				background-color: white;
			}
			.loginforms{
				float: right;
			}
			.join_form > div > div > label{
				margin-left: 0px;
			}
		</style>
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
		<script type="text/javascript">
			$(function() {
				// 중복확인
 				$("#input_id").keyup(function() {
					$.ajax({
						url:"Rest/idchk.do",
						type:"get",
						data:"id="+$("#input_id").val(),	// 서블릿에 넘어가는 데이터
						dataType:"text",
						success:function(data){
							if(data=="error"){
								// 중복아이디일 시 가입버튼 비활성화
								$("#id_form").addClass("has-error");
								$("#id_err").text("이미 있는 아이디입니다.");
								$("#joinbtn").attr("disabled","disabled");
							}else if(data=="incorrect"){
								// 형식에 맞지 않을 시 가입버튼 비활성화
								$("#id_form").addClass("has-error");
								$("#id_err").text("아이디 형식이 맞지 않습니다.");
								$("#joinbtn").attr("disabled","disabled");
							}else{
								// 중복아이디 아닐 시 가입버튼 활성화
								$("#id_form").removeClass("has-error");
								$("#id_form").addClass("has-success");
								$("#id_err").text("사용 가능한 아이디입니다.");
								$("#joinbtn").removeAttr("disabled");
							}
						},
						error:function(){
							alert("실패");
						}
					});
				});
				$("#input_pwd").keyup(function() {
					var passwordRules = /^[a-zA-Z0-9]{5,10}$/;
					if(!passwordRules.test($("#input_pwd").val())){
						$("#pwd_err").text("숫자와 영문자 조합으로 5~10자리를 사용해야 합니다.");
						$("#pwd_chkform").addClass("has-error");
						$("#joinbtn").attr("disabled","disabled");
					}else{
						$("#pwd_err").text("사용할 수 있는 암호입니다..");
						$("#pwd_chkform").removeClass("has-error");
						$("#pwd_chkform").addClass("has-success");
						$("#joinbtn").removeAttr("disabled");
					}
					if($("#input_pwd").val()==$("#input_pwd2").val() && $("#input_pwd").val()!=""){
						$("#pwd_err2").text("암호가 일치합니다.");
						$("#pwd_chkform2").removeClass("has-error");
						$("#pwd_chkform2").addClass("has-success");
						$("#joinbtn").removeAttr("disabled");
					}else{
						$("#pwd_err2").text("암호가 다릅니다.");
						$("#pwd_chkform2").addClass("has-error");
						$("#joinbtn").attr("disabled","disabled");
					}
				});
				$("#input_pwd2").keyup(function() {
					if($("#input_pwd").val()==$("#input_pwd2").val()){
						$("#pwd_err2").text("암호가 일치합니다.");
						$("#pwd_chkform2").removeClass("has-error");
						$("#pwd_chkform2").addClass("has-success");
						$("#joinbtn").removeAttr("disabled");
					}else{
						$("#pwd_err2").text("암호가 다릅니다.");
						$("#pwd_chkform2").addClass("has-error");
						$("#joinbtn").attr("disabled","disabled");
					}
				});
			});
			function join_go(f) {
				if(f.id.value==""){
					alert("아이디를 입력하세요");
					return;
				}
				if(f.pwd.value==""){
					alert("패스워드를 입력하세요");
					return;
				}
				if(f.name.value==""){
					alert("이름을 입력하세요");
					return;
				}
				if(f.nickname.value==""){
					alert("별명을 입력하세요");
					return;
				}
				$.ajax({
					url:"Rest/join.do",
					type:"post",
					data:$("#joinform1").serialize(),	// 서블릿에 넘어가는 데이터
					dataType:"text",
					success:function(data){
						alert("가입 성공");
						clear(f);
						$("#joinbtn").val("회원가입");
						$("#loginModal").modal("hide");
					},
					error:function(){
						alert("가입 실패");
					}
				});
			}
			function login(f) {
				if(f.id.value=="" || f.pwd.value==""){
					alert("ID와 비밀번호를 입력하세요.");
					return;
				}
				$.ajax({
					url:"Rest/login.do",
					type:"post",
					data:$("#login_form").serialize(),	// 서블릿에 넘어가는 데이터
					dataType:"text",
					success:function(data){
						if(data=="fail"){
							alert("회원정보가 틀립니다.");
							f.id.value = "";
							f.pwd.value = "";
						}else if(data=="success"){
							location.href="login.go";
						}
					},
					error:function(){
						alert("로그인 실패");
					}
				});
			}
			function clear(f) {
				for (var i = 0; i < f.elements.length; i++) {
					if(i!=9){
						f.elements[i].value="";
					}
				}
			}
			function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var fullAddr = ''; // 최종 주소 변수
		                var extraAddr = ''; // 조합형 주소 변수

		                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    fullAddr = data.roadAddress;

		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    fullAddr = data.jibunAddress;
		                }

		                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		                if(data.userSelectedType === 'R'){
		                    //법정동명이 있을 경우 추가한다.
		                    if(data.bname !== ''){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있을 경우 추가한다.
		                    if(data.buildingName !== ''){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
		                document.getElementById('sample6_address').value = fullAddr;

		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById('sample6_address2').focus();
		            }
		        }).open();
		    }
		</script>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-4">
					<h1><a href="main.go">축산천국</a></h1>				
				</div>
				<div class="col-xs-8" style="margin-top: 15px">
					<c:choose>
						<c:when test="${loginchk==-1}">
							<form id="login_form" class="form-inline" role="form">
								<div class="form-group loginforms">
									<label class="sr-only" for="id">ID</label>
									<input type="text" name="id" size="7" class="form-control" placeholder="ID"/>
									<label class="sr-only" for="pwd">비밀번호</label>
									<input type="password" name="pwd" size="7" class="form-control" placeholder="비밀번호"/>
									<input type="button" value="로그인" class="btn btn-default" onclick="login(this.form)"/>
									<input type="button" value="회원가입" class="btn btn-default" data-toggle="modal" data-target="#loginModal"/>
									<!-- Modal -->
								</div>
							</form>
							<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
											<h4 class="modal-title" id="loginModalLabel">회원가입</h4>
										</div>
										<form id="joinform1" class="form-horizontal join_form" role="form">  
											<div class="modal-body">
												<div id="id_form" class="form-group">   
													<div class="col-md-9 col-md-offset-3">
												    	<label class="control-label" id="id_err" for="inputWarning"></label>
												    </div>
												    <label for="Id" class="col-md-3 hidden-xs control-label">아이디</label>
												    <div class="col-md-9">
												        <input type="text" id="input_id" name="id" class="form-control" placeholder="아이디"> 
												    </div>
												</div>       
												<div id="pwd_chkform" class="form-group">  
													<div class="col-md-9 col-md-offset-3">
												    	<label class="control-label" id="pwd_err" for="inputWarning"></label>
												    </div>
													<label for="Password" class="col-md-3 hidden-xs control-label">비밀번호</label>
													<div class="col-md-9">
													    <input type="password" id="input_pwd" name="pwd" class="form-control" placeholder="비밀번호"> 
													</div>
												</div> 
												<div id="pwd_chkform2" class="form-group">
													<div class="col-md-9 col-md-offset-3">
												    	<label class="control-label" id="pwd_err2" for="inputWarning"></label>
												    </div>
												    <label for="PasswordCheck" class="col-md-3 hidden-xs control-label">비밀번호 확인</label>
												    <div class="col-md-9">
												        <input type="password" id="input_pwd2" name="pwd2" class="form-control" placeholder="비밀번호 확인"> 
												    </div>
												</div>       
												<div class="form-group">  
													<label for="Name" class="col-md-3 hidden-xs control-label">이름</label>
													<div class="col-md-9">
													    <input type="text" name="name" class="form-control" placeholder="이름"> 
													</div>
												</div> 
												<div class="form-group">   
												    <label for="Nickname" class="col-md-3 hidden-xs control-label">별명</label>
												    <div class="col-md-9">
												        <input type="text" name="nickname" class="form-control" placeholder="별명"> 
												    </div>
												</div>       
												<div class="form-group">  
													<label for="emailaddress" class="col-md-3 hidden-xs control-label">이메일</label>
													<div class="col-md-9">
													    <input type="email" name="email" class="form-control" placeholder="이메일"> 
													</div>
												</div> 
												<div class="form-group">  
													<label for="telephone" class="col-md-3 hidden-xs control-label">집전화</label>
													<div class="col-md-9">
													    <input type="tel" name="phone" class="form-control" placeholder="집전화"> 
													</div>
												</div> 
												<div class="form-group">  
													<label for="mobilephone" class="col-md-3 hidden-xs control-label">휴대전화</label>
													<div class="col-md-9">
													    <input type="tel" name="mobilephone" class="form-control" placeholder="휴대전화"> 
													</div>
												</div> 
												<div class="form-group">  
													<div class="col-md-6">
													    <input type="text" name="addrnum" id="sample6_postcode" class="form-control" placeholder="우편번호"> 
													</div>
													<div class="col-md-3">
														<input type="button" class="btn btn-primary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
													</div>
												</div> 
												<div class="form-group">  
													<div class="col-md-6">
													    <input type="text" name="addr" id="sample6_address" class="form-control" placeholder="주소"> 
													</div>
													<div class="col-md-6">
													    <input type="text" name="addr2" id="sample6_address2" class="form-control" placeholder="상세주소"> 
													</div>
												</div> 
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
												<button type="button" id="joinbtn" class="btn btn-primary" onclick="join_go(this.form)">회원가입</button>
											</div>
										</form>
									</div> <!-- 모달 콘텐츠 -->
								</div> <!-- 모달 다이얼로그 -->
							</div> <!-- 모달 전체 윈도우 -->
						</c:when>
						<c:when test="${loginchk==2}"> <!-- 일반 회원 로그인 -->
							<div class="loginforms">
								<c:choose>
									<c:when test="${newMsgCount>0}">
										<span class="glyphicon glyphicon-envelope" style="color: red" onclick="javascript:location.href='personalpost.go?c_idx=${cvo.c_idx}'"></span>
										${newMsgCount}개의 새 쪽지가 있습니다.
									</c:when>
									<c:otherwise>
										<span class="glyphicon glyphicon-envelope" onclick="javascript:location.href='personalpost.go?c_idx=${cvo.c_idx}'" ></span>
										새 쪽지가 없습니다.
									</c:otherwise>
								</c:choose>
								<input type="button" class="btn btn-default" value="마이페이지" onclick="javascript:location.href='personalpage.go?c_idx=${cvo.c_idx}'"/>
								<input type="button" class="btn btn-default" value="로그아웃" onclick="javascript:location.href='logout.do'"/>
							</div>
						</c:when>
						<c:when test="${loginchk==1}"> <!-- 의사 회원 로그인 -->
							<div class="loginforms">
								<c:choose>
									<c:when test="${newMsgCount>0}">
										<span class="glyphicon glyphicon-envelope" style="color: red" onclick="javascript:location.href='personalpost.go?c_idx=${cvo.c_idx}'"></span>
										${newMsgCount}개의 새 쪽지가 있습니다.
									</c:when>
									<c:otherwise>
										<span class="glyphicon glyphicon-envelope" onclick="javascript:location.href='personalpost.go?c_idx=${cvo.c_idx}'" ></span>
										새 쪽지가 없습니다.
									</c:otherwise>
								</c:choose>
								<input type="button" class="btn btn-default" value="마이페이지" onclick="javascript:location.href='personalpage.go?c_idx=${cvo.c_idx}'"/>
								<input type="button" class="btn btn-default" value="상담목록" onclick="javascript:location.href='counselmanagement.go'"/>
								<input type="button" class="btn btn-default" value="로그아웃" onclick="javascript:location.href='logout.do'"/>
							</div>
						</c:when>
						<c:when test="${loginchk==0}"> <!-- 관리자 로그인 -->
							<div class="loginforms">
								<c:choose>
									<c:when test="${newMsgCount>0}">
										<span class="glyphicon glyphicon-envelope" style="color: red" onclick="javascript:location.href='personalpost.go?c_idx=${cvo.c_idx}'"></span>
										${newMsgCount}개의 새 쪽지가 있습니다.
									</c:when>
									<c:otherwise>
										<span class="glyphicon glyphicon-envelope" onclick="javascript:location.href='personalpost.go?c_idx=${cvo.c_idx}'" ></span>
										새 쪽지가 없습니다.
									</c:otherwise>
								</c:choose>
								<input type="button" class="btn btn-default" value="회원관리" onclick="javascript:location.href='customer.go'"/>
								<input type="button" class="btn btn-default" value="마이페이지" onclick="javascript:location.href='personalpage.go?c_idx=${cvo.c_idx}'"/>
								<input type="button" class="btn btn-default" value="로그아웃" onclick="javascript:location.href='logout.do'"/>
							</div>
						</c:when>
					</c:choose>
				</div>
			</div>
			<nav class="navbar navbar-default" role="navigation">
		      <!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".top_menubar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
				
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse top_menubar">
					<ul class="nav navbar-nav">
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">소개</a>
							<ul class="dropdown-menu">
								<li><a href="intro.go?cmd=greeting">인사말</a></li>
								<li><a href="intro.go?cmd=map">오시는길</a></li>
							</ul>
						</li>
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">커뮤니티</a>
							<ul class="dropdown-menu">
								<li><a href="bbs.go?b_category=0">공지사항</a></li>
								<li><a href="bbs.go?b_category=1">자유게시판</a></li>
								<li><a href="bbs.go?b_category=2">연재</a></li>
								<li><a href="bbs.go?b_category=3">뉴스</a></li>
							</ul>
						</li>
						<li><a href="personalcounsel.go?c_idx=${cvo.c_idx}">1:1상담</a></li>
						<li><a href="diseasemap.go">전염병 경보 지도</a></li>
					</ul>
				</div><!-- /.navbar-collapse -->
		    </nav>
		</div>
	</body>
</html>
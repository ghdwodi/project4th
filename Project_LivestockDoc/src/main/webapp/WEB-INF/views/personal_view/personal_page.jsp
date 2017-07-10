<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축산천국</title>
		<script type="text/javascript">
			function postview(m_idx,c_idx) {
				$.ajax({
					url:"Rest/msg_view.do",
					type:"get",
					data:"m_idx="+m_idx+"&c_idx="+c_idx,
					dataType:"text",
					success:function(data){
						var msgArr = data.split("#++#");
						var c_idx = msgArr[0];
						var c_idx_sender = msgArr[1];
						var c_sender_nickname = msgArr[2];
						var m_content = msgArr[3];
						$("#post_title").html(c_sender_nickname+"님의 쪽지");
						$("#post_body").html(m_content);
						$("#modal_c_idx").val(c_idx_sender);
						$("#modal_c_idx_sender").val(c_idx);
						$("#msgViewModal").modal('show');
						$(".tr_"+m_idx).css('background-color', '');
					},
					error:function(){
						alert("쪽지 열람 실패");
					}
				});
			}
			function msg_send(f) {
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
						$("#msgViewModal").modal("hide");
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
	</head>
	<c:choose>
		<c:when test="${loginchk==-1||empty loginchk}">
			<body onload="loginpage_go()"></body>
		</c:when>
		<c:otherwise>
			<body>
				<jsp:include page="../top.jsp"/>
				<div class="container">
					<div class="col-sm-2">
						<ul class="nav intronav">
							<li><a href="personalpage.go?c_idx=${cvo.c_idx}">회원정보</a></li>
							<li><a href="personalpost.go?c_idx=${cvo.c_idx}">쪽지함</a></li>
							<li><a href="personalcounsel.go?c_idx=${cvo.c_idx}">상담내역</a></li>
						</ul>
					</div>
					<div class="col-sm-8">
						<c:choose>
							<c:when test="${cmd==0}">
								<table class="table">
									<tr>
										<td class="col-xs-4">아이디</td>
										<td class="col-xs-8">${cvo.id}</td>
									</tr>
									<tr>
										<td>이름</td>
										<td>${cvo.name}</td>
									</tr>
									<tr>
										<td>별명</td>
										<td>${cvo.nickname}</td>
									</tr>
									<tr>
										<td>이메일</td>
										<td>${cvo.email}</td>
									</tr>
									<tr>
										<td>전화번호</td>
										<td>${cvo.phone}</td>
									</tr>
									<tr>
										<td>휴대폰번호</td>
										<td>${cvo.mobilephone}</td>
									</tr>
									<tr>
										<td>주소</td>
										<td>${cvo.addr}<br />${cvo.addr2}</td>
									</tr>
									<tr>
										<td>회원유형</td>
										<c:choose>
											<c:when test="${cvo.c_authority==0}">
												<td>관리자</td>
											</c:when>
											<c:when test="${cvo.c_authority==1}">
												<td>의사</td>
											</c:when>
											<c:otherwise>
												<td>일반회원</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</table>
							</c:when>
							<c:when test="${cmd==1}">
								<jsp:include page="personal_post.jsp"/>
							</c:when>
							<c:when test="${cmd==2}">
								<jsp:include page="personal_counsel.jsp"/>
							</c:when>
						</c:choose>
					</div>
				</div>
			</body>
		</c:otherwise>
	</c:choose>
</html>
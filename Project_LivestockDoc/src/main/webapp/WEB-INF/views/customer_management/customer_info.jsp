<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<title>축산천국</title>
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
				<jsp:include page="../top.jsp"/>
				<div class="container">
					<div class="row">
						<div class="col-md-6 col-md-offset-3">
							<table class="table">
								<tr>
									<td class="col-xs-4">아이디</td>
									<td class="col-xs-8">${cvo_info.id}</td>
								</tr>
								<tr>
									<td>이름</td>
									<td>${cvo_info.name}</td>
								</tr>
								<tr>
									<td>별명</td>
									<td>${cvo_info.nickname}</td>
								</tr>
								<tr>
									<td>이메일</td>
									<td>${cvo_info.email}</td>
								</tr>
								<tr>
									<td>전화번호</td>
									<td>${cvo_info.phone}</td>
								</tr>
								<tr>
									<td>휴대폰번호</td>
									<td>${cvo_info.mobilephone}</td>
								</tr>
								<tr>
									<td>주소</td>
									<td>${cvo_info.addr}<br />${cvo_info.addr2}</td>
								</tr>
								<tr>
									<td>회원유형</td>
									<c:choose>
										<c:when test="${cvo_info.c_authority==0}">
											<td>관리자</td>
										</c:when>
										<c:when test="${cvo_info.c_authority==1}">
											<td>의사</td>
										</c:when>
										<c:otherwise>
											<td>일반회원</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<tr>
									<td colspan="2">
										<input type="button" value="회원정보 수정" class="btn btn-default" onclick="javascript:location.href='customer_modify.go?c_idx=${cvo_info.c_idx}'" style="float: right;">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
			</body>
		</c:otherwise>
	</c:choose>
</html>
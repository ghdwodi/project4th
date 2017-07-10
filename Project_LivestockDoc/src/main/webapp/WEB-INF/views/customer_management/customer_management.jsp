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
			function delete_go(c_idx) {
				var del = confirm("정말로 삭제하시겠습니까?");
				if(del){
					$.ajax({
						url:"Rest/c_delete.do",
						type:"post",
						data:"c_idx="+c_idx,	// 서블릿에 넘어가는 데이터
						dataType:"text",
						success:function(data){
							alert("삭제 성공");
							location.href="customer";
						},
						error:function(){
							alert("삭제 실패");
						}
					});
				}else{
					return;
				}
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
					<div class="table-responsive">
						<table class="table table-hover" style="width: 70%;margin: auto">
							<thead>
								<tr>
									<th class="col-xs-2">회원번호</th>
									<th class="col-xs-4">아이디</th>
									<th class="col-xs-4">닉네임</th>
									<th class="col-xs-2"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${cvoList}" var="k">
									<tr>
										<td class="col-xs-2">${k.c_idx}</td>
										<td class="col-xs-4" onclick="javascript:location.href='customer_info.go?c_idx=${k.c_idx}'">${k.id}</td>
										<td class="col-xs-4">${k.nickname}</td>
										<td class="col-xs-2"><input type="button" value="삭제" class="btn btn-primary" onclick="delete_go(${k.c_idx})"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
			</body>
		</c:otherwise>
	</c:choose>
</html>
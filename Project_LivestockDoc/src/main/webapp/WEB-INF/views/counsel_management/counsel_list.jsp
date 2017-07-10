<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<jsp:include page="../top.jsp"/>
		<div class="container">
			<table class="table">
				<thead>
					<tr>
						<th>제목</th>
						<th>고객</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${newCounselList}" var="k">
						<tr>
							<td><a href="javascript:location.href='counselview.go?counsel_idx=${k.counsel_idx}'">${k.title}</a></td>
							<td>${k.c_name}</td>
							<td>${k.req_date.substring(0,10)}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</body>
</html>
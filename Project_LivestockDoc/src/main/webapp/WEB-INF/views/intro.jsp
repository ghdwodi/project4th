<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축산천국</title>
		<script type="text/javascript">	
		</script>
		<style type="text/css">
			.intronav{
				background-color: skyblue;
			}
			path #_xAC15__xB3D9__xAD6C_{
				background-color: red;
			}
		</style>
	</head>
	<body>
		<jsp:include page="top.jsp"/>
		<div class="container">
			<div class="row">
				<div class="col-md-2">
					<ul class="nav intronav">
						<li><a href="intro.go?cmd=greeting">인사말</a></li>
						<li><a href="intro.go?cmd=map">오시는길</a></li>
					</ul>
				</div>
				<div class="col-md-10">
					<c:choose>
						<c:when test="${cmd=='greeting'}">
							<jsp:include page="intro_views/greeting.jsp"/>
						</c:when>
						<c:when test="${cmd=='map'}">
							<jsp:include page="intro_views/map.jsp"/>
						</c:when>
						<c:otherwise>
							<h2>몰라</h2>
						</c:otherwise>
					</c:choose>					
				</div>
			</div>
		</div>
	</body>
</html>
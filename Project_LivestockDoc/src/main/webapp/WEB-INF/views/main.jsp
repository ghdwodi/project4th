<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">			
		</script>
	</head>
	<body>
		<jsp:include page="top.jsp"/>
		<div class="container">
			<div class="row">
				<div class="col-sm-7">
					<div id="main_carousel" class="carousel slide">
						<ol class="carousel-indicators">
							<li data-target="main_carousel" data-slide-to="0" class="active"></li>
							<li data-target="main_carousel" data-slide-to="1"></li>
							<li data-target="main_carousel" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner">
							<div class="item active">
								<img src="carousel_imgs/final_cow.png" style="width: 100%" alt="first_slide">
							</div>
							<div class="item">
								<img src="carousel_imgs/final_pig.png" style="width: 100%" alt="second_slide">
							</div>
							<div class="item">
								<img src="carousel_imgs/final_chicken.png" style="width: 100%" alt="third_slide">
							</div>
						</div>
						<a class="left carousel-control" href="#main_carousel" data-slide="prev">
							<span class="icon-prev"></span>
						</a>
						<a class="right carousel-control" href="#main_carousel" data-slide="next">
							<span class="icon-next"></span>
						</a>
					</div>
				</div>
				<div class="col-sm-5">
					<fieldset>
						<legend>공지사항</legend>
						<table class="table">
							<c:forEach items="${noticeList}" var="k">
								<tr>
									<td><a href="bbsView.go?b_idx=${k.b_idx}&cPage=1&b_category=0">${k.title}</a></td>
									<td>${k.b_date}</td>
								</tr>
							</c:forEach>
						</table>
					</fieldset>
					<fieldset>
						<legend>뉴스</legend>
						<table class="table">
							<c:forEach items="${newsList}" var="k">
								<tr>
									<td><a href="bbsView.go?b_idx=${k.b_idx}&cPage=1&b_category=3">${k.title}</a></td>
									<td>${k.b_date}</td>
								</tr>
							</c:forEach>
						</table>
					</fieldset>
				</div>
			</div>
			<div class="row">
				
			</div>
		</div>
	</body>
</html>
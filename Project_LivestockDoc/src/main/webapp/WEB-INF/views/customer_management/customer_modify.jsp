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
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
		<script type="text/javascript">
			function modify_do(f) {
				if(f.name.value==""){
					alert("이름 값은 필수입니다.");
					return;
				}
				if(f.nickname.value==""){
					alert("별명 값은 필수입니다.");
					return;
				}
				$.ajax({
					url:"Rest/c_modify.do",
					type:"post",
					data:$("#c_modifyform").serialize(),	// 서블릿에 넘어가는 데이터
					dataType:"text",
					success:function(data){
						alert("수정 성공");
						location.href="customer_info.go?c_idx=${cvo_info.c_idx}";
					},
					error:function(){
						alert("수정 실패");
					}
				});
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
							<form id="c_modifyform">
								<table class="table">
									<tr>
										<td class="col-xs-4">아이디
											<input type="hidden" name="c_idx" value="${cvo_info.c_idx}">
										</td>
										<td class="col-xs-8">${cvo_info.id}</td>
									</tr>
									<tr>
										<td>이름</td>
										<td><input type="text" class="form-control" name="name" value="${cvo_info.name}"></td>
									</tr>
									<tr>
										<td>별명</td>
										<td><input type="text" class="form-control" name="nickname" value="${cvo_info.nickname}"></td>
									</tr>
									<tr>
										<td>이메일</td>
										<td><input type="text" class="form-control" name="email" value="${cvo_info.email}"></td>
									</tr>
									<tr>
										<td>전화번호</td>
										<td><input type="text" class="form-control" name="phone" value="${cvo_info.phone}"></td>
									</tr>
									<tr>
										<td>휴대폰번호</td>
										<td><input type="text" class="form-control" name="mobilephone" value="${cvo_info.mobilephone}"></td>
									</tr>
									<tr>
										<td>주소</td>
										<td>
											<div class="row">
												<div class="col-xs-8">
													<input type="text" name="addrnum" id="sample6_postcode" class="form-control" value="${cvo_info.addrnum}">
												</div>
												<div class="col-xs-4">
													<input type="button" class="btn btn-default" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br />
												</div>
											</div>
											<input type="text" name="addr" id="sample6_address" class="form-control" value="${cvo_info.addr}"><br />
										    <input type="text" name="addr2" id="sample6_address2" class="form-control" value="${cvo_info.addr2}"> 
										</td>
									</tr>
									<tr>
										<td>회원유형</td>
										<c:choose>
											<c:when test="${cvo.c_authority==0}">
												<td>
													<select name="c_authority" class="form-control">
														<c:choose>
															<c:when test="${cvo_info.c_authority==0}">
																<option value="0" selected="selected">관리자</option>
																<option value="1">의사</option>
																<option value="2">일반회원</option>
															</c:when>
															<c:when test="${cvo_info.c_authority==1}">
																<option value="0">관리자</option>
																<option value="1" selected="selected">의사</option>
																<option value="2">일반회원</option>
															</c:when>
															<c:when test="${cvo_info.c_authority==2}">
																<option value="0">관리자</option>
																<option value="1">의사</option>
																<option value="2" selected="selected">일반회원</option>
															</c:when>
														</c:choose>
													</select>
												</td>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${cvo_info.c_authority==1}">
														<td><input type="hidden" name="c_authority" value="1">의사</td>
													</c:when>
													<c:otherwise>
														<td><input type="hidden" name="c_authority" value="2">일반회원</td>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</tr>
									<tr>
										<td colspan="2">
											<input type="button" value="회원정보 수정" class="btn btn-primary" onclick="modify_do(this.form)" style="float: right;">
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</body>
		</c:otherwise>
	</c:choose>
</html>
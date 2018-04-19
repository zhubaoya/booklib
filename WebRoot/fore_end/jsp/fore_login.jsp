<%@ page language="java" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户登录</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  		
		<link rel="stylesheet" href="fore_end/css/fore_login.css" />
		<link rel="stylesheet" href="fore_end/css/carousel.css" />
		<link rel="stylesheet" href="fore_end/css/swiper.min.css" />
		
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<script type="text/javascript" src="fore_end/js/fore_login.js"></script>
		<script type="text/javascript" src="fore_end/js/swiper.min.js"></script>
		<script type="text/javascript" src="back_end/js/globalData.js"></script>
		
		<script type="text/javascript">
			$(function() {
				var swiper = new Swiper('.swiper-container', {
					pagination: '.swiper-pagination',
					paginationClickable: true,
					speed: 1500,
					loop: true,
					observer: true,
					observeParents: true,
					autoplayDisableOnInteraction: false,
					autoplay: 800
				});
			});
			
			function opneFindPassowrd(){
				window.open("fore_end/jsp/find_password.jsp", "找回密码", "height=250,width=600,top:100,left:100,toolbar=no,menubar=yes,scrollbars=no,resizable=no,location=no,status=no");
			}
		</script>
	</head>

	<body onload="showCursor('login_username')">
		<center>
			<div class="center">
				<div class="middle">
					<div id="left_img">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="logo_img/fore_lib1.jpg" /></div>
								<div class="swiper-slide"><img src="logo_img/fore_lib2.jpg" /> </div>
								<div class="swiper-slide"><img src="logo_img/fore_lib3.jpg" /></div>
								<div class="swiper-slide"><img src="logo_img/fore_lib4.jpg" /> </div>
							</div>
						</div>
					</div>
					<div id="rignt_login">
						<form method="post" action="foreLogin" id="login_form">
							<ul>
								<li>
									<img src="logo_img/login_username.png"  />
									<label for="login_username">用户名:
									<input type="text" name="login_username" id="login_username"  placeholder="用户名"  onblur="vali_username()" onfocus="getCursor(this.id)" maxlength="48"/><br>
									<span id="login_usernamespan"></span>
							</label>
								</li>
								<li>
									<img src="logo_img/login_password.png"  />
									<label for="login_password">密&nbsp;&nbsp;码:
									<input type="password" id="login_password" placeholder="密码" name="login_password" onblur="vali_password()" onfocus="getCursor(this.id)" maxlength="58"/><br>
									<span id="login_passwordspan"></span>
								</label>
								</li>
								<li>
									<div id="login">
										<input type="submit" value="登录" id="log" onclick="return vali_submit();return false;" />
										<input type="reset" value="重置" id="re" />
										<div id="find">
											<a href="Javascript:opneFindPassowrd();">找回密码 </a>
										</div>
									</div>
								</li>
								<li>
									<c:set var="err" value="${fore_login_err }"></c:set>
									<c:choose>
										<c:when test="${err != null }">
												<span id="result">${err}</span>
										</c:when>
										<c:otherwise>
												<span id="result"></span>
										</c:otherwise>
									</c:choose>
								</li>
							</ul>
						</form>
					</div>
				</div>
				<div class="footer">
					<hr />
					<p>@copyrigt  祝宝亚的毕设的云上图书</p>
				</div>
			</div>
		</center>
	</body>

</html>
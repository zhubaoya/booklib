<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>后台登录</title>

<style type="text/css">
	body{
		margin: 0;
	}
	#info{
		position:absolute;
		top:5%;
		border-radius:20px;
		border-color: black;
		background-color:#DCDCDC; 
	}

	.user_label{
		margin: 30px;
		
	}
	#back_login_name,#back_login_pass,#back_login_press{
		font: bold 15px/25px "楷体";
	}
	#sel{
		font: bold 16px/25px "楷体";
	}
	#back_login_namespan,#back_login_passspan,#back_login_pressspan{
		font-size: 5px;
		color: red;
	}
</style>

<script type="text/javascript" src="back_end/js/globalData.js"></script>
<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script type="text/javascript">

function validate(objId) {
	var obj = document.getElementById(objId);
	var objValue = obj.value;
	var objSpane = document.getElementById(objId + "span");
	if (objValue == "") {
		objSpane.innerHTML = obj.placeholder + "不能为空";
		objSpane.style.color = "red";
		return false;
	} else {
		objSpane.innerHTML = "";
		return true;
	}
}

function checkBackUsername(){
	return validate("back_login_name");
}

function checkBackPassword(){
	return validate("back_login_pass");
}

function checkBackLoginPress(){
	return validate("back_login_press");
}

function checkBackLogin(){
	if(checkBackUsername()==false||checkBackPassword()==false||checkBackLoginPress()==false){
		return false;
	}
	return true;
}

function init(){
	$("#info").animate({
		top:"140px",
		width: "450px",
		height:" 330px",
		left:"35%"
	},"3000",function(){
		$("#info").fadeIn("1000",function(){});
		showCursor('back_login_name');
	});
}
</script>
</head>
<body onload="init()">
	<div id="info">
		<form action="back_dologin" method="post">
			<div class="user_label">
				<label for="back_login_name">用户名：
					<input type="text" id="back_login_name" name="back_login_name" placeholder="用户名" maxlength="28" onblur="checkBackUsername()" onfocus="getCursor(this.id)">
					<span id="back_login_namespan"></span>
				</label>
			</div>
			<div class="user_label">
				<label for="back_login_pass">密&nbsp;&nbsp;码：
					<input type="password" id="back_login_pass" name="back_login_pass" placeholder="密码" maxlength="28" onblur="checkBackPassword()" onfocus="getCursor(this.id)">
					<span id="back_login_passspan"></span>
				</label>
			</div>
			<div class="user_label">
				<label for="back_login_press">图书馆：
					<input type="text" id="back_login_press" name="back_login_press" placeholder="图书馆" maxlength="48" onblur="checkBackPassword()" onfocus="getCursor(this.id)">
					<span id="back_login_pressspan"></span>
				</label>
			</div>
			<div class="user_label">
				<input type="submit" value="登录" style="font: bold 22px/30px '楷体';margin-left: 80px;" onclick="return checkBackLogin();return false;">
				<input type="reset" value="重置" style="font: bold 22px/30px '楷体';margin-left: 80px;">
			</div>
			<div>
				<c:set var="err" value="#{back_login_error}"></c:set>
				<c:choose>
					<c:when test="${err!=null}">
						<span style="font: bold 22px/30px '楷体';color:red;">${err}</span>									
					</c:when>
					<c:otherwise>
						<span id="result_span"></span><br>	
					</c:otherwise>
				</c:choose>						
			</div>
		</form>	
	</div>
</body>
</html>
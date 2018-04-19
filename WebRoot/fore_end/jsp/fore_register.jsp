<%@ page language="java" import="java.util.*,com.zby.books.utils.AutoRegisteredId"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<title>用户注册</title>

<script type="text/javascript" src="fore_end/js/fore_register.js"></script>
<script type="text/javascript" src="back_end/js/globalData.js"></script>
<link rel="stylesheet" href="fore_end/css/fore_register.css" />

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#nickname").keyup(function(){
			var nickname=$("#nickname").val();
			var reg = /^[\u4e00-\u9fa5]+$/;
			if(nickname != null && reg.test(nickname)){
				var url="checkUserName?method=chkUserName";
				var args={
						"nickname":nickname,
						time:new Date()
				}
				$.getJSON(url,args,function(data){
						if(data != null){
							$("#nicknamespan").html(data);
							$("#nickname").val("");
						}else{
							$("#nicknamespan").html("");
						}
				});
			}
		});
	});
	
	function load(){
		window.alert("请记住您的编号："+$("#user_id").val());
	}
</script>
</head>
<body onload="showCursor('nickname');createCode();load();">
	<center>
		<div id="register_info">
			<form action="foreregister" method="post" id="register_form">
				<table id="table"  >
					<tr>
						<td>
			 				<label for="">编&nbsp;&nbsp;&nbsp;&nbsp;号:</label>
						</td>
						<td>
							<input type="text" name="user_id" id="user_id" style=" width:200px; border: none;outline: medium;" value="<%=new AutoRegisteredId().getRegisteredId() %>"  readonly="readonly" maxlength="28" onfocus="getCursor(this.id)"></input>			
						</td>
					</tr>
					<tr>
						<td>
							<label for="nickname">昵&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
						</td>
						<td>
							<input type="text" name="nickname" id="nickname"  maxlength="48"  alt="昵称"  placeholder="用户名" onblur="validateUsername()" onfocus="getCursor(this.id)">
							<span id="nicknamespan" style="color: red"></span>
						</td>
					</tr>		
					<tr>
						<td>
							<label for="register_password">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
						</td>
						<td>
				  		<input type="password" name="register_password" id="register_password"  maxlength="58" alt="密码" placeholder="密码" onblur="validatePassword()" onfocus="getCursor(this.id)">
              <span id="register_passwordspan" style="color: red"></span>
						</td>
					</tr>
					<tr>
						<td>
							<label for="define_password">确认密码：</label>
						</td>
						<td>
				    		<input type="password" name="define_password" id="define_password"  maxlength="58"  alt="确认密码"  placeholder="请确认密码" onblur="validateDefinePassword()" onfocus="getCursor(this.id)">
             		<span id="define_passwordspan" style="color: red"></span>
						</td>
					</tr>	
					<tr>
						<td>
							<label for="phone">手机号码：</label>
						</td>
						<td>
							<input type="tel" name="phone" id="phone"  maxlength="11"  alt="手机号码"  placeholder="手机号码" onblur="validatePhone()" onfocus="getCursor(this.id)">
							<span id="phonespan" style="color: red;"></span>
						</td>
					</tr>
					<tr>
						<td>
							<label for="email">邮&nbsp;&nbsp;&nbsp;&nbsp;箱：</label>
						</td>
						<td>
							<input type="text"  name="email" id="email"  placeholder="邮箱" alt="邮箱" maxlength="48" onkeyup="showEmail(this.value)" onblur="validateEmail()" onfocus="getCursor(this.id)">
							<span id="emailspan" style="color: red;"></span>
							<div id="email_type" >
								<ul  onclick="chooseEmail()">
									<li >qq.com</li><hr/>
									<li >126.com</li><hr/>
									<li >136.com</li><hr/>
									<li >sina.com</li><hr/>
									<li >sohu.com</li><hr/>
									<li >aliyun.com</li><hr/>
									<li >139.com</li><hr/>
								</ul>
							</div>				
						</td>
					</tr>
					<tr>
						<td>
							<label for="sex">性&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
						</td>
						<td>
							<input type="radio" name="sex" id="boy" value="1" checked="checked" />男
							<input type="radio" name="sex" id="gril" value="2" />女
							<span id="sexspan" style="color: red;"></span>		
						</td>
					</tr>
					<tr>
						<td>
							<label for="code" onclick="createCode()">验&nbsp;证&nbsp;码：</label>
						</td>
						<td>
							<input type="text" id="code" maxlength="4" onblur="validateCode()">
							<span id="codespan"  style="background-image:url(logo_img/valid.gif);font:bold 20px/30px '楷体';" onclick= "createCode()"></span>
							<span id="result"  style="color: red;"></span>
						</td>
					</tr>
					<tr>
						<td colspan="2"  align="center">
							<strong id="ps" style="text-align: center;">请记住自己的编号，编号具有唯一性</strong>
						</td>
					</tr>
					<tr >
						<td colspan="2" align="center">
							<input type="submit" id="register_sub" value="注册" onclick="return validateAll();return false;">
							<input type="button" id="register_cancel" value="取消">
						</td>	
					</tr>
				</table>			
			</form>
		</div>
	</center>
</body>
</html>
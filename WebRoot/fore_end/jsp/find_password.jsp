<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%
	String path=request.getContextPath();
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>>">
	<title>找回密码</title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  	
<style type="text/css">
body {
	margin: 0;
}
form{
width: 500px;
height: 200px;
font-family: "楷体";
}
tr{
	height: 40px;
	font-size: 18px;
	font-family: "楷体";
}
span {
	color: red;
	font-size: 15px;
	font-family: "楷体";
}

#confirm,#cancel{
	font-size: 18px;
	text-align: center;
	width: 100px;
	border:none;
	padding: 2px;
}
input :hover{
	border: 1px red solid;
}
input{
	font:bold 15px/25px "楷体";
	border-radius:5px;
}
</style>
<script type="text/javascript">
function validate(objId, reg) {
	var obj = document.getElementById(objId);
	var objValue = obj.value;
	var objSpane = document.getElementById(objId + "spane");
	if (objValue == "") {
		objSpane.innerHTML = "*" + obj.alt + "不能为空！";
		objSpane.style.color = "red";
		return false;
	} else if (obj.length >= obj.maxlength) {
		objSpane.innerHTML = "*字符在" + obj.maxlength + "以内";
		objSpane.style.color = "red";
		return false;
	} else if (!reg.test(objValue)) {
		objSpane.innerHTML = "*不符合" + obj.alt + "格式";
		objSpane.style.color = "red";
		return false;
	} else {
		objSpane.innerHTML = "";
		return true;
	}
}

// 校验用户名
function validateUname() {
	var reg = /^[\u4e00-\u9fa5]{2,50}$/;
	validate("find_name", reg);
}

// check password
function validatePass() {
	var reg = /^\w{6,20}$/;
	validate("f_password", reg);
}

// check define password
function validateDefinePass() {
	var pw = document.getElementById("f_password").value;
	var defPw = document.getElementById("def_password").value;
	var defSpane = document.getElementById("def_passwordspane");
	if (defPw == "") {
		defSpane.innerHTML = "确认密码不能为空";
		defSpane.style.color = "red";
		return false;
	}
	if (defPw != pw) {
		defSpane.innerHTML = "两次密码输入的不正确";
		defSpane.style.color = "red";
		return false;
	} else {
		defSpane.innerHTML = "";
	}
	return true;
}

function validateAllCondition() {
	if(validateUname()==false||validatePass()==false||validateDefinePass()==false){
		return false;
	}
	return true;
}
</script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#find_name").keyup(function(){
		var find_name=$("#find_name").val();
		var reg = /^[\u4e00-\u9fa5]+$/;
		if(find_name != null && reg.test(find_name)){
			var url="checkUpdateName?method=chkUserName";
			var args={
					"find_name":find_name,
					time:new Date()
			}
			$.getJSON(url,args,function(data){
				//	console.log(data);
					if(data =="用户名不存在" ){
						$("#find_namespane").html(data);
						$("#find_namespane").css("color","red");
						$("#f_passwordspane").html("");
						$("#def_passwordspane").html("");
						$("#f_password").attr("disabled",true);
						$("#def_password").attr("disabled",true);
						$("#f_password").val("");
						$("#def_password").val("");	
						return ;
					}else{				
						$("#find_namespane").html("");
						$("#find_namespane").css("color","green");
						$("#f_password").attr("disabled",false);
						$("#def_password").attr("disabled",false);			
						return ;
					}
			});
		}
	});
});

</script>
</head>
<body>
	<center>
	<form action="fore_find_Password"  id="find_password" method="post">
	<table id="table" >		
			<tr>
				<td>
			<label for="findname">昵&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
				</td>
				<td>
					<input type="text" name="find_name" id="find_name"  maxlength="18"  alt="昵称"  placeholder="用户名" onblur="validateUname()">
					<span id="find_namespane" ></span>
				</td>
			</tr>
			
			<tr>
				<td>
			<label for="f_password">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
				</td>
				<td>
				  <input type="password" name="f_password " id="f_password"  maxlength="20" alt="密码"  placeholder="密码" onblur="validatePass()" disabled=" disabled">
                    <span id="f_passwordspane" ></span>
				</td>
			</tr>
			
			<tr>
				<td>
				<label for="def_password">确认密码：</label>
				</td>
				<td>
				    <input type="password" name="def_password" id="def_password"  maxlength="18"  alt="确认密码"  placeholder="确认密码" onblur="validateDefinePass()" disabled="disabled">
                    <span id="def_passwordspane" ></span>
				</td>
			</tr>
			<tr>
				<td colspan="2"  align="center">
					<input type="submit" value="确认" id="confirm" onclick="return validateAllCondition();return false;">
					<input type="reset" value="取消" id="cancel" >
				</td>
			</tr>
			</table>
	</form>
	</center>
</body>
</html>
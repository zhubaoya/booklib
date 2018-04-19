
function chooseEmail() {
	var email_type = document.getElementById("email_type");
	var lis = email_type.getElementsByTagName("li");
	for (var i = 0; i < lis.length; i++) {
		lis[i].onclick = function() {
			document.getElementById("email").value += this.innerHTML;
			email_type.style.display = "none";
		}
	}
}

// 当用户再输入@时，显示
function showEmail(str) {
	if (str.charAt(str.length - 1) == "@") {
		document.getElementById("email_type").style.display = "block";
	}else{
		document.getElementById("email_type").style.display = "none";
	}
}

// 创建验证码
function createCode() {
	var code = parseInt(Math.random() * 9000 + 1000);
	var codespane = document.getElementById("codespan");
	codespane.innerHTML = code;
}

function validateCode() {
	var codespane = document.getElementById("codespan").innerHTML;
	var codetext = document.getElementById("code").value;
	var result = document.getElementById("result");
	if (codetext == "" || codetext == null) {
		result.innerHTML = "验证码不能为空";
		result.style.color = "red";
		return false;
	}
	if (codetext != codespane) {
		result.innerHTML = "验证码不正确";
		result.style.color = "red";
		codetext = "";
		createCode();
		return false;
	} else {
		result.innerHTML = "";
		return true;
	}
}
function validate(objId, reg) {
	var obj = document.getElementById(objId);
	var objValue = obj.value;
	var objSpane = document.getElementById(objId + "span");
	if (objValue == "") {
		objSpane.innerHTML = obj.alt + "不能为空！";
		objSpane.style.color = "red";
		return false;
	}else if (!reg.test(objValue)) {
		objSpane.innerHTML = "不符合" + obj.alt + "格式";
		objSpane.style.color = "red";
		return false;
	} else {
		objSpane.innerHTML = "";
		return true;
	}
}

// 校验用户名
function validateUsername() {
	var reg = /^[\u4e00-\u9fa5]{2,50}$/;
	validate("nickname", reg);
}

// check password
function validatePassword() {
	var reg = /^\w{6,20}$/;
	validate("register_password", reg);
	var pass = document.getElementById("register_password");
}

// check define password
function validateDefinePassword() {
	var pw = document.getElementById("register_password").value;
	var defPw = document.getElementById("define_password").value;
	var defSpane = document.getElementById("define_passwordspan");
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

// check define phone
function validatePhone() {
	var reg = /^1(3|4|5|7|8)\d{9}$/;
	validate("phone", reg);
}

// check email
function validateEmail() {
	var reg = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	validate("email", reg);
}

function validateAll() {
	if ( validateDefinePassword() == false
			|| validateEmail() == false || validatePassword() == false 
			|| validatePhone() == false || validateUsername() == false) {
		return false;
	}
	return true;
}
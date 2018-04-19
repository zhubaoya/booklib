
			function vali_username() {
				var username = document.getElementById("login_username").value;
				var username_span = document.getElementById("login_usernamespan");
				if(username == "") {
					username_span.innerHTML = "用户名不能为空";
					username_span.style.color = "red";
					return false;
				} else {
					username_span.innerHTML = "";
					return true;
				}
			}

			function vali_password() {
				var password = document.getElementById("login_password").value;
				var password_span = document.getElementById("login_passwordspan");
				if(password == "") {
					password_span.innerHTML = "密码不能为空";
					password_span.style.color = "red";
					return false;
				} else {
					password_span.innerHTML = "";
					return true;
				}
			}

			function vali_submit() {
				if(false == vali_username() || false == vali_password()) {
					return false;
				}else{
					return true;
				}
			}
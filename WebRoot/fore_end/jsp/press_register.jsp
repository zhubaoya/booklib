<%@ page language="java" import="java.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>出版社注册</title>
    
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	
  	<style type="text/css">
  		#press_advice,#register_info{
  			position: absolute;
  			border:2px solid gray;
  			border-radius:5px;
  			background-color: white;
  			left: 10%;
  	
  			
  			font: narmal 18px/25px "仿宋";
  			
  		}
  	#press_advice{
  			
  			width: 10%;
  			z-index:100;
  	}
  	#press_advice label{
  		text-align: center;
  		margin-top: 10px;
  	}
  	#agress{
  		text-align: center;
  		font-size: 20px;
  		margin: 5px;		
  	}
  	
  	#register_info{
  		width: 80%;
  		height:95%;
  		display: none;
  	}
  	
  	.text_style {
			font: normal 16px/25px "楷体";
			outline: none;
			border-radius: 5px;
		}
		
		.tb_book {
			border-collapse: separate;
			border-spacing: 14px;
		}
		.set_class{
			border:none;
		}
		.basic_spain {
			font-size: 15px;
		}
		.btn_style {
	font: normal 20px/20px "楷体";
	outline: none;
	border-radius: 5px;
	background-color: white;
}
  	</style>
  	
  	<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
  	<script type="text/javascript" src="back_end/js/globalData.js"></script>
  	<script type="text/javascript">
  	
  	/* 执行回调函数 */
  		$(function(){
  			$("#agress").click(function(){
  				$("#press_advice").fadeToggle(1500,function(){
  					$("#register_info").fadeIn(1500);
  				});				
  			});
  		});
  	
  	/*  */
  	function show(){
  		$("#press_advice").animate({
  			left:'10%',
  			opacity:'0.95',
  			top:'5%',
  			height:'90%',
  			width:'80%',		    
  		},"5000");}
  	
  	
  	function pr_validate(objId, reg) {
  		var obj = document.getElementById(objId);
  		var objValue = obj.value;
  		var objSpane = document.getElementById(objId + "span");
  		if (objValue == "") {
  			objSpane.innerHTML = obj.alt + "不能为空！";
  			objSpane.style.color = "red";
  			return false;
  		}else if (!reg.test(objValue)) {
  			objSpane.style.color = "red";
				objSpane.innerHTML = "不符合" + "格式";
				return false;
			} 
  		return true;
  	}
  	
  	function pr_validateaddress(objId){
  		var reg=/^[\u4E00-\u9FA5a-zA-Z0-9_]{3,48}$/;
  		return pr_validate(objId, reg);
  	}
  	
  	function pr_validatepostcode(objId){
  		 var reg= /^[1-9][0-9]{5}$/;
  		 return pr_validate(objId,reg);
  	}
  	
  	
  	function pr_validatepressphone(objId){		 
  	   var reg=/(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
  		 return pr_validate(objId, reg);
  	}
  	
  	function pr_validatepurphone(objId){
  		var reg = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
  		 return pr_validate(objId, reg);
  	}
  	
  	function pr_validatewebsite(objId){
  		var reg=/^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;
  		return pr_validate(objId, reg);
  	}
  	
  	function pr_validateICP(objId){
  		var reg=/^[\u4E00-\u9FA5ICP0-9]{3,17}$/;
  		return pr_validate(objId,reg);
  	}
  	
  	function pr_validatePressLoginName(objId){
  		var reg=/^[\u4E00-\u9FA5a-zA-Z0-9_]{3,48}$/;
  		return pr_validate(objId,reg);
  	}
  	
  	function pr_validatePressPass(ObjId){
  		var reg=/^[a-zA-Z0-9]{6,20}$/;
  		return pr_validate(ObjId,reg);
  	}
  	
  	function pr_validateID(objId){
  		var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; 
  		return pr_validate(objId, reg);
  	}
  	
  	function pr_validateFile(objId){
  		var reg=/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/;
  		return pr_validate(objId,reg);
  	}
  	
  	function pr_validateDefinePassword() {
  		var pw = document.getElementById("pr_password").value;
  		var defPw = document.getElementById("pr_definepassword").value;
  		var defSpane = document.getElementById("pr_definepasswordspan");
  		if (defPw == "") {
  			defSpane.innerHTML = "验证密码不能为空";
  			defSpane.style.color = "red";
  			return false;
  		}
  		if (defPw != pw) {
  			defSpane.innerHTML = "两次密码输入的不正确";
  			defSpane.style.color = "red";
  			return false;
  		} 
  			defSpane.innerHTML = "";
  	
  		return true;
  	}
  	
  	function ajaxpressName(){
  		var pressname=$("#pr_pressname").val();
 			if(pressname == ""){
 				$("#pr_pressnamespan").text("图书馆名不能为空");
 				$("#pr_pressnamespan").css("color","red");
 				return false;
 			}else{
 				$.ajax({
 		  			type:"get",
 		  			url:"pressRegister?method=checkPressName",
 		  			data:{
 		  				"pressname":pressname,
 		  				"time":new Date()
 		  			},
 		  			dataType:"text",
 		  			success:function(result){
 		  				if(result=="err"){
 		  					$("#pr_pressname").val("");
 		  					$("#pr_pressnamespan").text(pressname+"已经注册，请您换个名称吧");
 		  	 				$("#pr_pressnamespan").css("color","red");
 		  				}
 		  			}
  			});
 			}
  	}
  	
  	$(function(){
  		
  		$("#individual_btn_submit").click(function(){ 	
  			var libname=$("#pr_pressname").val();
  	  	var libusername=$("#pr_username").val();
  	  	var libpassoword=$("#pr_password").val();
  	  	var libhandid=$("#pr_handid").val();
  	  	var libID=$("#pr_ID").val();
				if(ajaxpressName()==false||pr_validatePressLoginName("pr_username")==false
					||pr_validatePressPass("pr_password")==false||pr_validateDefinePassword()==false
					||pr_validateID("pr_ID")==false||pr_validateFile("pr_handid")==false){
					window.alert("请检查除灰色部分，其他文本框是否为空");
				}else{
					$.ajax({
						type:"get",
						url:"myindividual?method=registerMyIndividual",
						dataType:"text",
						data:{
							"libname":libname,
							"libusername":libusername,
							"libpassoword":libpassoword,
							"libhandid":libhandid,
							"libID":libID,
							"time":new Date()
						},
						success:function(result){
							if(result =="success"){
								if(window.confirm("恭喜您，开辟您的图书馆，前去后台登录？")){
									window.open("back_end/jsp/back_login.jsp","_blank");	
								}else{
									window.location.href="fore_end/jsp/fore_main.jsp";
								}	
							}else{
								window.alert("网络延迟，稍后再来");
							}
						}
					});
				}
  		}); 	
  	});
  	
    $(function(){		
  		$("#orgnized_btn_submit").click(function(){ 	
  			var libname=$("#pr_pressname").val();
  	  	var libAddress=$("#pr_address").val();
  	  	var libpostcode=$("#pr_postcode").val();
  	  	var libphone=$("#pr_pressphone").val();
  	  	var libmobile=$("#pr_purchasephone").val();
  	  	var libwebsite=$("#pr_website").val();
  	  	var libICPe=$("#pr_ICP").val();
  	  	var libusername=$("#pr_username").val();
  	  	var libpassoword=$("#pr_password").val();
				if(ajaxpressName()==false || pr_validatePressPass("pr_password")==false
					||pr_validateDefinePassword()==false || pr_validatePressLoginName("pr_username")==false
					||pr_validateaddress("pr_address")==false || pr_validateICP("pr_ICP")==false
					||pr_validatepostcode("pr_postcode")==false ||pr_validatepressphone("pr_pressphone")==false
					||pr_validatepurphone("pr_purchasephone")==false ||pr_validatewebsite("pr_website")==false){
					window.alert("请检查组织图书馆中，除灰色部分\r\n其他文本框是否为空.或者不符合格式");
				}else{
					$.ajax({
						type:"get",
						url:"myorganize?method=registerMyorganize",
						dataType:"text",
						data:{
							"libname":libname,
							"libusername":libusername,
							"libpassoword":libpassoword,
							"libAddress":libAddress,
							"libpostcode":libpostcode,
							"libphone":libphone,
							"libmobile":libmobile,
							"libwebsite":libwebsite,
							"libICPe":libICPe,			
							"time":new Date()
						},
						success:function(result){
							if(result =="success"){
								if(window.confirm("恭喜您，开辟您的图书馆，前去后台登录？")){
									window.open("back_end/jsp/back_login.jsp","_blank");	
								}else{
									window.location.href="fore_end/jsp/fore_main.jsp";
								}	
							}else{
								window.alert("网络延迟，稍后再来");
							}
						}
					});
				}
		
  		}); 	
  	});
  	
  	
  	$(function(){
  		$(".radio_basic").click(function(){
  			var radioVal=$("input[name='choose_type']:checked").val();
  			switch (radioVal) {
					case "1":
						$("#pr_address").attr("disabled","true");
						$("#pr_postcode").attr("disabled","true");
						$("#pr_pressphone").attr("disabled","true");
						$("#pr_purchasephone").attr("disabled","true");
						$("#pr_website").attr("disabled","true");
						$("#pr_ICP").attr("disabled","true");
						$("#pr_handid").removeAttr("disabled");
						$("#pr_ID").removeAttr("disabled");
				  	$("#pr_address").val("");
				  	$("#pr_postcode").val("");
				  	$("#pr_pressphone").val("");
				  	$("#pr_purchasephone").val("");
				  	$("#pr_website").val("");
				  	$("#pr_ICP").val("");
				  	$("#individual_btn_submit").css("display","block");
				  	$("#orgnized_btn_submit").css("display","none");
					break;
					case "2":
						$("#pr_address").removeAttr("disabled");
						$("#pr_postcode").removeAttr("disabled");
						$("#pr_pressphone").removeAttr("disabled");
						$("#pr_purchasephone").removeAttr("disabled");
						$("#pr_website").removeAttr("disabled");
						$("#pr_ICP").removeAttr("disabled");
						$("#pr_handid").attr("disabled","true");
						$("#pr_ID").attr("disabled","true");
						$("#pr_handid").val("");
					  $("#pr_ID").val("");
					  $("#individual_btn_submit").css("display","none");
					  $("#orgnized_btn_submit").css("display","block");
						break;
				}
  		});
  	})
  	</script>
  </head>
  
  <body onload="show()">
  
  	<div id="press_advice">
  		<center>
  			<label style="text-align: center;color: red;">您在注册出版社，须同意以下要求<br><br></label>
  		</center>
  		<span>
  			1、必须出具你个人图书馆或出版社的证明材料<br>
  				&nbsp;&nbsp;您的营业执照<br>
  				&nbsp;&nbsp;您手握身份证的照片<br><br>
  			2、能够上架的图书<br>
  				&nbsp;&nbsp;积极健康的图书<br>
  				&nbsp;&nbsp;教科书或与教科书有关的资料书<br>
  				&nbsp;&nbsp;促进社会和谐的图书<br><br>
  			3、不允许上架的图书<br>
  				&nbsp;&nbsp;具有色情或间接色情的图书<br>
  				&nbsp;&nbsp;违反社会和谐的图书，比如宣传法轮功等<br>
  				&nbsp;&nbsp;违反社会稳定的图书，比如宣传黑色会的图书<br><br>
  			4、惩罚力度<br>
  				&nbsp;&nbsp;如果您在短时间内，遭到多名用户的举报<br>
  					&nbsp;&nbsp;&nbsp;&nbsp;如果情节较轻，我们可以查封您的网上图书馆<br>
  					&nbsp;&nbsp;&nbsp;&nbsp;如果涉嫌违法，将由执法部门来对你，做出相应的惩罚<br><br>
  			5、审核时间<br>
  					&nbsp;&nbsp;自您提交注册申请之日起，我们将有7个工作日的审查时间。<br>
  					&nbsp;&nbsp;您可以在7个工作日之后，来与我们进行联系<br>
  					&nbsp;&nbsp;我们的联系方式为：13621664265<br> 			
  		</span>
  			<center>
  				<input type="radio" id="agress" value="同意">同意
  			</center>
  	</div>
  	<div id="register_info">
  		<form action="register_form" method="post" id="fore_action">
  			<fieldset class="set_class"style="border:none">
  				<legend>基本信息：
  				<input type="radio" class="radio_basic" value="1" name="choose_type" checked="checked">个人图书馆<sub style="color:red;font-size: 10px;">只用填图书馆名</sub>
  				<input type="radio" class="radio_basic" value="2" name="choose_type">组织图书馆<sub style="color:red;font-size: 10px;">不用填身份证和上传身份证图片</sub>
  				</legend>
  				<table class="tb_book">
  					<tr>
  						<td>
  							<label for="pr_pressname">图书馆名：</label>
								<input type="text" id="pr_pressname" maxlength="48" name="pr_pressname"  placeholder="图书馆名" class="text_style" onfocus="getCursor(this.id)" onblur="ajaxpressName()">
								<span id="pr_pressnamespan" class="basic_spain"></span> 						
  						</td> 						
  					</tr> 
  					<tr>
  						<td>
  							<label for="pr_address">出版地址：</label>
								<input type="text" id="pr_address" maxlength="48" name="pr_address"  placeholder="出版社地址" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validateaddress(this.id)" disabled="disabled">
								<span id="pr_addressspan" class="basic_spain"></span> 						
  						</td>	
  					</tr> 			
  					<tr>
  						<td>
  							<label for="pr_postcode">邮政编码：</label>
								<input type="number" min="100000"  value="100000" id="pr_postcode" maxlength="6" name="pr_postcode"  placeholder="邮政编码" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validatepostcode(this.id)" disabled="disabled">
								<span id="pr_postcodespan" class="basic_spain"></span> 						
  						</td> 						
  					</tr>
  					<tr>
  					<td>
  							<label for="pr_pressphone">移动电话：</label>
								<input type="tel" id="pr_pressphone" maxlength="11" name="pr_pressphone"  placeholder="移动电话" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validatepressphone(this.id)" disabled="disabled">
								<span id="pr_pressphonespan" class="basic_spain"></span> 						
  						</td>
  						</tr> 
  					<tr>
  						<td>
  							<label for="pr_purchasephone">租书电话：</label>
								<input type="text" id="pr_purchasephone" maxlength="11" name="pr_purchasephone"  placeholder="租书电话" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validatepurphone(this.id)" disabled="disabled">
								<span id="pr_purchasephonespan" class="basic_spain"></span> 						
  						</td> 						
  					</tr>
  					<tr>
  					<td>
  							<label for="pr_website">网&nbsp;&nbsp;&nbsp;&nbsp;址：</label>
								<input type="text" id="pr_website" maxlength="48" name="pr_website"  placeholder="网址" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validatewebsite(this.id)" disabled="disabled">
								<span id="pr_websitespan" class="basic_spain"></span> 						
  					</td>
  					</tr> 
  					<tr>
  						<td>
  							<label for="pr_ICP">备&nbsp;案&nbsp;号：</label>
								<input type="text" id="pr_ICP" maxlength="17" name="pr_ICP"  value="ICP" placeholder="备案号" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validateICP(this.id)" disabled="disabled">
								<span id="pr_ICPspan" class="basic_spain"></span> 						
  						</td>
  					</tr>
  				</table>
  			</fieldset> 
  			
  			<fieldset class="set_class"style="border:none">
  				<legend>登录信息：</legend>
  				<table class="tb_book">
  					<tr>
  						<td>
  							<label for="pr_username">登&nbsp;录&nbsp;名：</label>
								<input type="text" id="pr_username" maxlength="48" name="pr_username"  placeholder="登录名" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validatePressLoginName(this.id)">
								<span id="pr_usernamespan" class="basic_spain"></span> 						
  						</td>
  						<td>
  							<label for="pr_ID">身&nbsp;份&nbsp;证：</label>
								<input type="text" id="pr_ID" maxlength="18" name="pr_ID"  placeholder="身份证号" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validateID(this.id)">
								<span id="pr_IDspan" class="basic_spain"></span> 						
  						</td>
  					</tr>
  					<tr>
  						<td>
  							<label for="pr_password">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
								<input type="password" id="pr_password" maxlength="48" name="pr_password"  placeholder="密码" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validatePressPass(this.id)">
								<span id="pr_passwordspan" class="basic_spain"></span> 						
  						</td>
  						<td>
  							<label for="pr_definepassword">验证密码：</label>
								<input type="password" id="pr_definepassword" maxlength="48" name="pr_definepassword"  placeholder="验证密码" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validateDefinePassword()">
								<span id="pr_definepasswordspan" class="basic_spain"></span> 						
  						</td>
  					</tr>
  					<tr>
  						<td>
  							<label for="pr_handid">手握身份证的照片：</label>
								<input type="file" id="pr_handid" name="pr_handid"  placeholder="验证密码" class="text_style" onfocus="getCursor(this.id)" onblur="pr_validateFile(this.id)">
								<span id="pr_handidspan" class="basic_spain"></span> 						
  						</td>
  					</tr>  
  					<tr>
  						<td>
  								<input type="button" class="btn_style" id="individual_btn_submit" value="个人图书馆的数据提交">
  								<input type="button" class="btn_style" id="orgnized_btn_submit" style="display: none;" value="组织图书馆的数据提交">
  						</td>
  						<td>
  							<input type="reset" class="btn_style" value="重置" >	
  						</td>
  					</tr> 					
  				</table>
  			</fieldset> 					
  		</form>	
  	</div>
   
  </body>
</html>

<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		<title>主页的页眉</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
		
		<style type="text/css">		
			body{
				margin: 0;
			}
			#head_div{
				position: absolute;
				background-color:#C2C2C2;
				top:0;
				width: 100%;
				height: 4.5%;
				font: bold 16px/29px "仿宋";
				text-align: right;
				z-index:100;
			}
			#head_div a{
				text-decoration: none;
				color: black;
				
			}
			#head_div a:HOVER{
				color:red;
				text-decoration: underline;
			}
			#fore_become_member{
				margin-right: 2%;
			}
			#head_div label{
				color:red;
			}
		</style>
		
		<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#a_log_out").click(function(){
					var uid=$("#fore_uid").val();
					var uname=$("#fore_login").text();
					if(uname !="请您登录"){
						if(window.confirm("您确认注销该账号？请君三思")){
						var url="checkorderform?method=checkOrderForm";
						var args={
							"uid":uid,
							"time":new Date()
						}
						$.getJSON(url,args,function(data){
								if(data=="删除成功"){
									alert("删除成功");
									window.location.reload();
								}else{
									alert(data);
								}			
						});
						}
					}
				});
			});
			
			
			function createPress(){
				if(window.confirm("还没有图书馆的账号？前去注册")){
					window.open("fore_end/jsp/press_register.jsp", "_blank");
				}else{
					window.open("back_end/jsp/back_login.jsp","_blank");
				}
			}
		</script>
	</head>
	<body>
		<div id="head_div">
			<div style="position:absolute;top:1%;float: left;width: 120px;">
				<a href="javascript:createPress()" style="text-decoration: none;color: red;">创办您的图书馆</a>
			</div>
			<span id="head_welcome">欢迎光临云上图书</span>
			<c:set value="${fore_name }" var="uname"></c:set>
			<c:choose>
				<c:when test="${ uname != null}">
					<label id="fore_login">${uname}</label>
					<a href="fore_end/jsp/individual_center.jsp?uname=${uname }&uid=${fore_uid}" >个人中心</a>
					<a href="javascript:void(0)" style="margin-right: 2%;" id="a_log_out">注销</a>
					<input type="hidden" id="fore_uid" name="fore_uid" value="${fore_uid }">
				</c:when>
				<c:otherwise>
					<a href="fore_end/jsp/fore_login.jsp" id="fore_login">请您登录</a>
					<a href="fore_end/jsp/fore_register.jsp" id="fore_become_member">成为会员</a>
				</c:otherwise>
			</c:choose>

		</div>
	</body>
</html>
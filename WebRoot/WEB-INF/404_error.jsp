<%@ page language="java"%>

<%
	String bathPath = request.getScheme() + "://" + request.getServerName()
			+ ":" + request.getServerPort() + request.getContextPath()
			+ "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=bathPath%>">
<title>err page</title>

<style type="text/css">
body{
margin: 0
}
#img{
margin-left: 20%;
margin-top: 10%;
}
</style>

<script type="text/javascript">
function load() {
	//每隔一秒执行一次
	window.setInterval(function(){
		
		var data=document.getElementById("num");
		
		data.innerHTML=data.innerHTML-1;
		
		if(data.innerHTML==0){
			window.location.href="fore_end/jsp/fore_main.jsp";
			return ;
		}
	}, 1000);
}



</script>
</head>
<body >

	<div id="img"  >	
		<p style="width:100%;color: red;font:bold 60px '楷体'; text-align: center;">哇塞，您的路径迷路了</p>
	</div>

</body>
</html>
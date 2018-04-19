<%@ page language="java" import="java.*,java.sql.Date,java.text.SimpleDateFormat"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

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
<style type="text/css">

#name,#press{
	border:none;
	color: red;
	font-size: 18px;
	font-family:"楷体"; 
	text-decoration: none;
}
div{
	float: right;
	font-size: 20px;
	font-family:"楷体";
}
</style>
<script type="text/javascript">
	function startTime() {
		var today = new Date();
		var h = today.getHours();
		var m = today.getMinutes();
		var s = today.getSeconds();
		// add a zero in front of numbers<10
		m = checkTime(m);
		s = checkTime(s);
		document.getElementById("txt").innerHTML = h + ":" + m + ":" + s;
		window.setTimeout('startTime()', 1000); //递归，表示一秒之后调用自己，也就是递归
	}

	//函数，是将1变为01
	function checkTime(i) {
		if (i < 10) {
			i = "0" + i;
		}
		return i;
	}
	
	function log_out() {
		var value=document.getElementById("press").innerHTML;
		if(value!=null){
			if(window.confirm("确认退出后台管理?")){
				window.close();
			}
		}
	}
</script>
</head>
<body onload="startTime()">
	<div >
		<c:set var="press_name" value="${pressname }"></c:set>
		<c:choose>
			<c:when test="${press_name!=null }">
				<a id="press" onclick="log_out()">${press_name }</a>出版社的:
			</c:when>
			<c:otherwise>
				<a id="press"  href="javascript:void(0)"></a>
			</c:otherwise>
		</c:choose>
		<c:set var="login_name" value="${uname }"></c:set>
		<c:choose>
			<c:when test="${login_name!=null }">
				<a id="name" href="javascript:void(0)">${login_name }</a>
			</c:when>
			<c:otherwise>
				<a id="name" href="javascript:void(0)"></a>
			</c:otherwise>
		</c:choose>
		 欢迎您登录，当前时间为:<div id="txt" style="float: right "></div>
	</div>
</body>
</html>
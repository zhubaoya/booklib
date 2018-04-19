<%@ page language="java"%>

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
<title>后台主页</title>

</head>
<frameset frameborder="yes" border="1" bordercolor="gray"
	rows="5%,*,8%" framespacing="2" scrolling="Auto" noresize>
	<noframes>
		<p>很抱歉，您的浏览器暂不支持该框架</p>
	</noframes>

	<frame src="back_end/jsp/back_main_header.jsp"  name="_top">
	<frameset cols="18%,*" border="none" bordercolor="gray">
		<frame src="back_end/jsp/back_main_left.jsp">
		<frame src="back_end/jsp/back_main_right.jsp" name="back_main_right">
	</frameset>
	<frame src="back_end/jsp/back_main_footer.jsp">
</frameset>
</html>
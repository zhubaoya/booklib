<%@ page language="java" import="java.util.*"%>

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
<title>左侧导航栏</title>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
	overflow-x: hidden;
}

html,body {
	height: 100%;
}

img {
	border: none;
}

* {
	font-family: '微软雅黑';
	font-size: 12px;
	color: #f5f5f5 ;
}

dl,dt,dd {
	display: block;
	margin: 0;
}

a {
	text-decoration: none;
}

.container {
	width: 100%;
	height: 100%;
	margin: auto;
}

/*left*/
.leftsidebar_box {
	width: 210px;
	height: auto !important;
	overflow: visible !important;
	position: fixed;
	height: 100% !important;
	background-color: #3992d0;
}

.line {
	height: 2px;
	width: 100%;
	background-image: url(images/left/line_bg.png);
	background-repeat: repeat-x;
}

.leftsidebar_box dt {
	padding-left: 40px;
	padding-right: 10px;
	background-repeat: no-repeat;
	background-position: 10px center;
	color: #f5f5f5 ;
	font-size: 18px;
	position: relative;
	line-height: 48px;
	cursor: pointer;
}

.leftsidebar_box dd {
	background-color: #317eb4;
	padding-left: 40px;
}

.leftsidebar_box dd a {
	color: #f5f5f5;
	line-height: 20px;
}

.leftsidebar_box dt img {
	position: absolute;
	right: 10px;
	top: 20px;
}

.leftsidebar_box dl dd:last-child {
	padding-bottom: 10px;
}
</style>
</head>
<body id="bg">

	<div class="container">

		<div class="leftsidebar_box">
			<div class="line"></div>
			<dl class="book">
				<dt >图书管理</dt>
				<dd class="first_dd">
					<a href="back_end/jsp/book_add.jsp" target="back_main_right">图书上架</a>
				</dd>
				<dd>
					<a href="back_end/jsp/book_delete.jsp" target="back_main_right">图书下架</a>
				</dd>
				<dd>
					<a href="back_end/jsp/book_modify.jsp" target="back_main_right">修改图书</a>
				</dd>
				<dd>
					<a href="back_end/jsp/book_query.jsp" target="back_main_right">查找图书</a>
				</dd>
			</dl>

			<dl class="infor">
				<dt >反馈信息管理</dt>
				<dd class="first_dd">
					<a href="back_end/jsp/contact_admin.jsp" target="back_main_right">更新反馈信息</a>
				</dd>
			</dl>

			<dl class="order">
				<dt>订书管理</dt>
				<dd class="first_dd">
					<a href="back_end/jsp/order_query.jsp" target="back_main_right">查询订书信息</a>
				</dd>
			</dl>
		</div>

	</div>

	<script src="http://www.jq22.com/jquery/1.11.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(".leftsidebar_box dt").css({
			"background-color" : "#3992d0"
		});
		$(function() {
			$(".leftsidebar_box dd").hide();
			$(".leftsidebar_box dt").click(function() {
				$(".leftsidebar_box dt").css({
					"background-color" : "#3992d0"
				})
				$(this).css({
					"background-color" : "#317eb4"
				});
				$(this).parent().find('dd').removeClass("menu_chioce");
				$(".menu_chioce").slideUp();
				$(this).parent().find('dd').slideToggle();
				$(this).parent().find('dd').addClass("menu_chioce");
			});
		})
	</script>
</body>

</html>
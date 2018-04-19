<%@ page language="java" import="java.util.*,com.zby.books.model.po.*,com.zby.books.model.service.*,com.zby.books.contents.GlobalVariable"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	ContactAdmin admin=new ContactAdmin(1, GlobalVariable.pressName,null);
	List<ContactAdmin> admins=new ContactAdminService().queryContactAdmins(admin);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>联系管理员</title> 
		<style type="text/css">
			body {
				font-size: 30px;
				margin: 30px auto;
				font-family: "楷体";
				opacity: 1;
			}
			table {
				width: 600px;
				height: 80%;
				text-align: left;
				margin-top: 20px;
				margin-left: 20px;
			/*border: 1px solid black;*/
			}
		
			tr {
				height: 50px;
				width: 500px;
				font-size: 15px;
				font-family: "华文仿宋";
			}
		</style>
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
		<script language="JavaScript">
			$(function() {
				$(".cstatus").click(function() {
					$("#name").val("");
					$("#phone").val("");
					$("#content").val("");						
					$("#caid option:not(:first)").remove();
					var c_status = $("input[name='c_status']:checked").val();
					if (c_status != null) {
						var url = "contactIds?method=getStatus";
						var args = {
							"c_status" : c_status,
							"time" : new Date()
						}
						$.getJSON(url, args, function(data) {
							if (data.length == 0) {
								alert("暂无数据");
							} else {
								for (var i = 0; i < data.length; i++) {
									var Id = data[i].caid;
									$("#caid").append("<option value='"+Id+"'>" + Id + "</option>");
								}
							}
						});
					}
				});
			});

			$(function() {
				$("#caid").change(function() {			
					var c_id = $(this).val();
					if (c_id != null) {
						var url = "contactAdminSelect?method=getContactId";
						var args = {
							"c_id" : c_id,
							"time" : new Date()
						}
						$.getJSON(url, args, function(data) {
							var contactAdmin=data;						
							$("#name").val(contactAdmin.name);
							$("#phone").val(contactAdmin.phone);
							$("#content").val(contactAdmin.content);						
						});
					}
				});
			});
		</script>
</head>

<body >
		<form action="back_contact_admin" method="post" id="fm " >
			<div id="left">
				<table>
					<tr>
						<td width="100px">处理状态:</td>
						<td>
							<input type="radio" class="cstatus" name="c_status" id="pending" value="1" checked="checked"/>待处理
							<input type="radio" class="cstatus" name="c_status" id="Handled" value="2" />已处理
						</td>
					</tr>
					<tr>
						<td width="10px">信息编号:</td>
						<td>						
							<select name="caid" id="caid" style="width:175px">
								<option value="">请选择...</option>
								<c:forEach items="<%=admins %>"  var="admin">
									<option value="${ admin.caid}">${admin.caid}</option>
								</c:forEach>
							</select>
							
						</td>
					</tr>
					<tr>
						<td width="150px">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</td>
						<td>
							<input type="text" name="name" id="name" alt="姓名"  disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td width="150px">联系方式:</td>
						<td>
							<input type="text" name="phone" id="phone" alt="联系方式"  disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td width="150px">反馈内容:</td>
						<td>
							<textarea name="content"  id="content"  rows="5"  cols="70"  disabled="disabled"  style="resize:none;"></textarea>
						</td>
					</tr>	
					<tr>
						<td align="center">
							<input type="submit" value="更新"  id="btn"  style="color: black;"/></td>
						<td align="left">
							<input type="reset" value="重置 " id="cz"  style="color: black;"/></td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
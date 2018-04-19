<%@page import="com.zby.books.utils.MyDateTime"%>
<%@page language="java" 
		import="java.util.*,
						com.zby.books.contents.*,
						com.zby.books.model.po.*,
						com.zby.books.model.service.*,
						com.zby.books.utils.MyDateTime"
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String uname = UTF8Changer.changeIntoUTF8(request.getParameter("uname"));
	String uid = request.getParameter("uid");
	User user = new User(uid,null,null);
	User gotUser = new UserService().queryUser(user);
	String usex = gotUser.getUsex()==1?"男":"女";
	
	List<UserAddress> userAddresss=new UserAddressService().queryUserAddress(uid);
	OrderForm form=new OrderForm(null, uid, null, null);
	List<OrderForm> orderForms=new OrderFormService().queryOrderForm(form);
	
	Comment comment=new Comment(uid, null);
	List<Comment> comments=new CommentsService().queryComments(comment);
	
	Account account=new Account(uid, null);
	List<Account> accounts=new AccountService().queryAccount(account);
	Float totalMoney=new AccountService().queryAccountTotalMoney(uid);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<base href="<%=basePath%>">
		<title>${fore_name}的个人中心</title>
		
		<style type="text/css">
			.tb_hover{
				background-color: #BBFFFF;
			}
		</style>
		<link rel="stylesheet" href="fore_end/css/individual_center.css">
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#a_logout").click(function(){
					if(window.confirm("是否退出当前登录")){
						window.location.href="fore_end/jsp/log_out.jsp";
					}
				});
			});

			function openaddUserAddress(){
				var uid=$("#individual_uid").val();
				window.open("fore_end/jsp/add_user_address.jsp?uid="+uid, "找回密码", "height=250,width=600,top:100,left:100,toolbar=no,menubar=yes,scrollbars=no,resizable=no,location=no,status=no");
			}
			
			function tb_load(){
				$("#tb_orderform tr").hover(function(){   
					$(this).children("td").addClass("tb_hover")   
					},function(){   
						$(this).children("td").removeClass("tb_hover")  
				});
				
				$("#tb_address tr").hover(function(){   
					$(this).children("td").addClass("tb_hover")   
					},function(){   
						$(this).children("td").removeClass("tb_hover")  
				}); 
				
				$("#tb_recharge tr").hover(function(){   
					$(this).children("td").addClass("tb_hover")   
					},function(){   
						$(this).children("td").removeClass("tb_hover")  
				}); 
				
			}
		</script>
	</head>
	<body onload="tb_load()">
		<!-- 这是登出  -->
		<div id="log_out" >
			<a href="fore_end/jsp/user_advice.jsp">用户须知</a>
			&nbsp;&nbsp;<a href="javascript:void(0)" id="a_logout">退出该账号</a>
			
		</div>
		
		<!-- 这是个人信息 -->
		<div id="individual_info">
			<fieldset class="fs_set">
				<legend>个人信息</legend>
				<label class="individual_label">用户编号：<%=gotUser.getUid() %></label><br>
				<label class="individual_label">昵&nbsp;&nbsp;&nbsp;&nbsp;称：<%=gotUser.getUname()%></label><br>
				<label class="individual_label">手机号码：<%=gotUser.getUphone() %></label><br>
				<label class="individual_label">电子邮箱：<%=gotUser.getUemail() %></label><br>
				<label class="individual_label">性&nbsp;&nbsp;&nbsp;&nbsp;别：<%=usex %></label><br>
				<label class="individual_label">登录日期：<%=new MyDateTime().dateToString(gotUser.getLoginDateTime(), 1) %></label><br>
				<input type="hidden" value="<%=gotUser.getUid() %>" id="individual_uid">	
			</fieldset>
		</div>
		
		<!-- 这是地址信息 -->
		<div id="individual_user_address">
			<fieldset>
				<legend>在您账号下的地址信息</legend>
				<table border="none" id="tb_address">
					<tr>
						<th>用户名</th>
						<th>联系方式</th>
						<th>用户地址</th>
					</tr>
					<c:set value="<%=userAddresss %>" var="userAddresss"></c:set>
					<c:choose>
						<c:when test="${userAddresss != null }">
							<c:forEach items="${ userAddresss }" var="userAddress">
							<tr>
								<td>${userAddress.username }</td>
								<td>${userAddress.userphone }</td>
								<td>${userAddress.address }</td>
							</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${ userAddresss }" var="userAddress">
							<tr>
								<td colspan="3" style="color: red;font: normal 15px/25px '楷体'">没有地址信息，点击以下按钮，进行添加</tr>
							</tr>
							</c:forEach>					
						</c:otherwise>
					</c:choose>				
				</table>
				<div style="text-align: right">
					<a href="javascript:openaddUserAddress()" style="text-decoration: none" id="address_add">添加地址</a>
				</div>			
			</fieldset>
		</div>
		
		<!-- 这是订单记录 -->
		<div id="individual_order_form">
			<fieldset>
				<legend>在您账号下的订单记录</legend>
				<table border="none" id="tb_orderform">
					<tr>
						<th>书名</th>
						<th>用户名</th>
						<th>借书时间</th>
						<th>联系方式</th>
						<th>联系地址</th>
						<th>图书状态（1为已定，2为归还）</th>
					</tr>
					<c:set value="<%=orderForms %>" var="orderforms"></c:set>
					<c:choose>
						<c:when test="${orderforms != null }">
							<c:forEach items="${orderforms }" var="orderform">
									<tr>
										<td>${orderform.bookname }</td>
										<td>${orderform.username }</td>
										<td><fmt:formatDate value="${orderform.lendTime}" type="both"/></td>
										<td>${orderform.userAddress }</td>
										<td>${orderform.userphone }</td>
										<td>${orderform.bookStatus }</td>
									</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${orderforms }" var="orderform">
								<tr>
									<td colspan="6">您没有订任何书</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</fieldset>
		</div>
		
		<!-- 这是评论表 -->
		<div id="indivicdual_comment">
			<div>
				<strong>我的评论</strong>
			</div>
			<div>
				<table>
				<c:forEach items="<%=comments %>" var="comment">
					<tr>
						<td>
							<a href="fore_end/jsp/book_detail.jsp?bisbn=${comment.isbn}&bname=${comment.bookname}">${comment.bookname}</a>
						</td>
						<td>
							<span>评论时间：<fmt:formatDate value="${comment.commentDate}"  type="both" /></span>		
						</td>
						<td>
							<a href="delete_comments?method=deleteCommenById&id=${comment.id }">删除该评论</a>		
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;&nbsp;<span>${comment.comment}</span>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<!-- 我的订单记录  -->
		<div id="recharge_recorder">
			<fieldset>
				<legend>在您账号下的账单记录</legend>
				<table border="none" id="tb_recharge">
					<tr>
						<th>账单时间</th>
						<th>账单金额</th>
						<th>用途（1为收入，2为支出）</th>
						<th>总金额</th>
					</tr>
					<c:set value="<%=accounts %>" var="accounts"></c:set>
					<c:choose>
						<c:when test="${accounts != null }">
							<c:forEach items="${accounts }" var="account">
									<tr>
										<td><fmt:formatDate value="${account.datetime }" type="both"/></td>
										<td>${account.money }</td>
										<td>${account.note }</td>
									</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${accounts }" var="account">
								<tr>
									<td colspan="4">您没有订任何账单记录</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<tr>
						<td colspan="4" align="right" style="color:red"><%=totalMoney %></td>
					</tr>
				</table>
			</fieldset>
		</div>		
		<jsp:include page="fore_main_bottom.jsp"></jsp:include>
	</body>
</html>
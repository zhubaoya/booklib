<%@ page language="java"
		import="java.util.*,
						com.zby.books.model.po.*,
						com.zby.books.model.service.*"
 %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String bisbn=request.getParameter("bisbn");
	String bname=request.getParameter("bname");
	List<UserAddress> userAddresss= null;
	
	new BookService().updateBookClickedTime(bisbn);
	
	if(session.getAttribute("fore_uid").toString()!= null){
		String uid=session.getAttribute("fore_uid").toString();
		userAddresss=new UserAddressService().queryUserAddress(uid);
	}
	
	
	Book book=new Book(null, bisbn, null, null, null,null);
	Book gotBook=new BookService().queryBook(book);
	Press press=new PressService().queryPress(gotBook.getPressId().toString(),null);
	
 	Genres genres=new Genres(null,null,gotBook.getGenresId());
	Genres gotGenres=new GenresService().queryGenres(genres);
	
	Tag tag=new TagService().queryTag(gotGenres.getTid()); 
	
	Comment comment=new Comment(null, bisbn);
	List<Comment> comments=new CommentsService().queryComments(comment);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>图书信息</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  
  	<style type="text/css">
  		.tb_hover{
				background-color:#BBFFFF;
			}
  	</style>
  	
  	<!-- 所需的js插件 -->
  	<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
 <script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>  	<script type="text/javascript">
  	
  		var bookAddress;  //图书所在地
			var bookcode;    //图书所在地的编码
			var uid;           //用户编码
			var bookname;      //书名
			var isbn;          //isbn
			var username;
			var userphone;
			var userAddress;
			var pressname;
			var price;
		
		/* 打开添加用户地址的页面 */
  	function openaddUserAddress(){
			uid=$("#individual_uid").val();
			window.open("fore_end/jsp/add_user_address.jsp?uid="+uid, "添加用户地址", "height=250,width=600,top:100,left:100,toolbar=no,menubar=yes,scrollbars=no,resizable=no,location=no,status=no");
		}
  	
  	/* 显示面板 */
  	function addSendAdress(){
  		$("#choose_sendAddress").click(function(){
  			uid=$("#fore_uid").val();
  			if(uid == ""){
  				if(window.confirm("您还没有登录，请先登录才能选择地址")){
  					window.location.href="fore_end/jsp/fore_login.jsp";
  				}
  			}else{
  				document.getElementById("bd_mask").style.display = "block";
  	  		document.getElementById("individual_user_address").style.display = "block";
  	  		$("#tb_address tr").hover(function(){   
						$(this).children("td").addClass("tb_hover")   
						},function(){   
							$(this).children("td").removeClass("tb_hover")  
					});   
  			}
  		});
  	}
  
  	/* 隐藏面板 */
  	function cancelAddSendAddress(){
  		$("#cancel_sendAddress").click(function(){
  			document.getElementById("bd_mask").style.display = "none";
  			document.getElementById("individual_user_address").style.display = "none";
  		});
  	}
  	
  	/* 获取地址 */
  	function getIpPlace() {
  		var place=remote_ip_info["city"] + "市";
  		isbn=$("#bd_isbn").text();
  		document.getElementById("book_place").innerHTML=place;
  		
  		window.alert("您目前所在地为:"+place+"\r\n已自动为您删选上海所在的图书馆");
  		
  		$.ajax({
  			type:"get",
  			url:"IpPlace?method=getIpPlace",
  			data:{
  				"place":place,
  				"isbn":isbn,
  				"time":new Date()
  			},
  			dataType:"json",
  			async:false,
  			success:function(data){
  				if(data != "none"){
  					var bookCode;
  					var bookPlace;
  					
  					for(var i =0;i<data.length;i++){
  						bookCode=data[i].bookCode;
  						bookPlace=data[i].bookPlace;
  						
  						$("#bd_address_select").append(
								"<option value='"+bookPlace+"'>" + bookCode
										+ "</option>");
  					}
  					
  				}else{
  					if(window.alert("该出版社在这个城市中，还没有上架这本书，是否联系出版社")){
  						document.getElementsByTagName('BODY')[0].scrollTop=document.getElementsByTagName('BODY')[0].scrollHeight;
  					}
  				}
  			}
  		});
		 }
  	
  	/* 获取值 */
  	$(function(){
  		$("#bd_address_select").change(function(){
  	  	$("#bd_address_select:not(:first)").remove();
  	  	bookAddress=$(this).val();
  	  	bookcode=$("#bd_address_select option:selected").text();//选中的文本
  	  	bookAddress=="请选择..." ? $("#bd_bookcode_text").val():$("#bd_bookcode_text").val(bookAddress); 	  	
  	  });
  	});
  	
  	/* 跳转值 */
  	function defineOderBook(btn){
  		var tr = btn.parentNode.parentNode;
  		username=tr.cells[0].innerText;
  		userphone=tr.cells[1].innerText;
  		userAddress=tr.cells[2].innerText;
  		
  		bookAddress=$("#bd_bookcode_text").val();
  		uid=$("#fore_uid").val();
  		if(uid == ""){
				if(window.confirm("只有登录后，才能进行评论")){
					window.location.href="fore_end/jsp/fore_login.jsp";
				}
			}else{
				if(bookAddress == ""){
					window.alert("请选择图书所在地后，才能选择地址");
					$("#individual_user_address").css('display','none');
					$("#bd_mask").css('display','none'); 
				}else{
					bookname=$("#tb_orderform_bname").text();
					isbn=$("#tb_orderform_bisbn").text();
					$("#tb_orderform_bookcode").text(bookcode);
					$("#tb_orderform_bookAddress").text(bookAddress);
					$("#tb_orderform_uname").text(username);
					$("#tb_orderform_uphone").text(userphone);
					$("#tb_orderform_userAddress").text(userAddress);
					$("#tb_orderform_pressname").text($("#bd_pressname").text());
					$("#tb_orderform_price").text($("#bd_price").text());
					$("#show_orderformInfo").css('display','block');
					$("#bd_mask").css('display','block'); 
					$("#individual_user_address").css('display','none'); 
				}
			}
  	}
  	
  	/* 关闭订单表 */
  	function closeOrderForm(){
  		$("#show_orderformInfo").css('display','none');
			$("#bd_mask").css('display','none'); 
			$("#individual_user_address").css('display','none'); 
  	}
  	
  	/* 重新选择地址 */
  	function rechooseUserAddress(){
  		$("#show_orderformInfo").css('display','none');
  		$("#individual_user_address").css('display','block');
  	}
  	
  	/* 添加评论 */
  	$(function(){
  		$("#submit_comment").click(function(){
  			uid=$("#fore_uid").val();
  			if(uid == ""){
  				if(window.confirm("只有登录后，才能进行评论")){
  					window.location.href="fore_end/jsp/fore_login.jsp";
  				}
  			}else{
  				 bookname=$("#bd_bookname").text();
  				 isbn=$("#bd_isbn").text();
  				 var comment=$("#text_comment").val();
  				if(comment != ""){
  					var url="AddBookComment?method=addBookComment";
  					var args={
  						"uid":uid,
  						"bookname":bookname,
  						"isbn":isbn,
  						"comment":comment
  					}
  					$.getJSON(url,args,function(data){
  						if(data == "已经评论"){
									window.alert("您已经评论“"+bookname+"”这本书了，\r\n如果想继续评论，请到个人中心，\r\n删除评论后，再重新评论");				
									location.reload();
  						}else{
  							if(data = "评论成功"){
  								window.alert("图书“"+bookname+"”评论成功！");
  								location.reload();	
  							}else{
  								window.alert("网络延迟，请稍后评论");
  							}
  							
  						}
  					});
  				}else{
  					window.alert("请填写评论后，方可提交！");
  				}
  			}
  		});
  	});
  	
  	/* 前往个人中心 */
  	function goToIndividualCenter(param,username,uid){
  		if(window.confirm(param)){
				window.location.href="fore_end/jsp/individual_center.jsp?uname=" + username + "&uid=" +uid;
				closeOrderForm();
			}
  	}
  	
  	/* 添加订单 */
  	$(function(){
  		$("#bd_btn_define").click(function(){
  			var recharge=$("#span_recharge").text();
  			pressname=$("#tb_orderform_userAddress").text();
  			price=$("#tb_orderform_price").text();
  			var url="generateOrderForm?method=generateOrderForm";
  			var args={
  					"uid":uid,
  					"username":username,
  					"userphone":userphone,
  					"userAddress":userAddress,
  					"bookcode":bookcode,
  					"bookname":bookname,
  					"isbn":isbn,
  					"recharge":recharge,
  					"pressname":pressname,
  					"price":price,
  					"time":new Date()
  			}
  			$.getJSON(url,args,function(data){
  				if(data == "已经订书"){
  					goToIndividualCenter("您已经定过该书了，请前往个人中心查看",username,uid);
  				}else if(data == "请您充值"){
  					if(window.confirm("余额不足，请您充值")){
  						$("#show_orderformInfo").css("display","none");
  	  				$("#bd_recharge").css("display","block");
  					}else{
  						$("#show_orderformInfo").css("display","none");
  						$("#bd_mask").css('display','none'); 
  					}					
  				}else if(data == "订书成功"){
  					goToIndividualCenter("恭喜年，订书成功，请注意及时归还",username,uid);
  				}else{
  					window.alert("网络延时，请稍后订书");
  				}
  			});
  		});
  	});
  
  	/* 充值 */
  	$(function(){
  		$("#recharge_define").click(function(){
  			var money=$("#input_money").val();
  			if(money == ""){
  				$("#input_moneyspan").text("请填写充值金额");
  			}else{
  				if(window.confirm("确认充值金额为:"+money)){
  					var url="foreEndRecharge?method=getMoney";
  					var args={
  						"uid":uid,
  						"money":money
  					}
  					$.getJSON(url,args,function(data){
  						if(data == "充值成功"){		
  		  				window.alert("充值成功");
  		  				$("#bd_recharge").css("display","none");
  		  				location.reload();
  						}else{
  							window.alert("网络延迟");
  						}
  					});
  				}
  			}
  		})
  	});
  	
  	$(function(){
  		$("#recharge_cancel").click(function(){
  			$("#show_orderformInfo").css("display","block");
				$("#bd_recharge").css("display","none");
  		});
  	});
  	
  	
  	</script>
  	
  
		
  	<!-- 所需的css插件 -->
  	<link rel="stylesheet" href="fore_end/css/book_detail.css">
  
	</head>
	<body onload="getIpPlace()">
		<jsp:include page="fore_main_head.jsp" flush="true"></jsp:include>
		<div id="bd_body">
			<div id="bd_book">
				<div id="bd_book_img">
					<img alt="" src="<%=gotBook.getBimg() %>" width="360px" height="380px">
				</div>
				<div id="bd_book_info">
					<table id="book_table">
						<tr>
							<label class="book_detail">图书简介:</label>							
							<span class="book_content"><%=gotBook.getBabstract() %></span>
						</tr>
						<tr>
							<td>
								<label class="book_detail">书名:</label>							
								<span class="book_content" id="bd_bookname"><%=gotBook.getBname() %></span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<label class="book_detail">所属:</label>							
								<span class="book_content">
									<a href="fore_end/jsp/fore_main.jsp?tid=<%=tag.getTid() %>" ></a><%=tag.getTname() %>/<%=gotGenres.getGname() %>
								</span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<label class="book_detail">ISBN编号:</label>							
								<span class="book_content" id="bd_isbn"><%=gotBook.getBisbn() %></span>
							</td>
						</tr>
						<tr>
							<td>
								<label class="book_detail">出版社:</label>							
								<span class="book_content" id="bd_pressname"><%=press.getPname() %></span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<label class="book_detail">出版日期:</label>							
								<span class="book_content"><%=gotBook.getPublication() %></span>
							</td>
						</tr>
						<tr>
							<td>
								<label class="book_detail">价格(¥ ):</label>							
								<span class="book_content" id="bd_price"><%=gotBook.getBprice() %></span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<label class="book_detail">押金(¥ ):</label>							
								<span class="book_content" id="span_recharge"><%=gotBook.getEarnest() %></span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								<label class="book_detail">借阅次数:</label>							
								<span class="book_content"><%=gotBook.getBorrowedTime() %>次</span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<label class="book_detail">点击次数:</label>							
								<span class="book_content"><%=gotBook.getClickedTime() %>次</span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<label class="book_detail">您现在所在地：</label>							
								<span class="book_content" id="book_place" style="border:1px solid gray;border-radius:5px;color:red;font:bold 18px/21px '楷体'"></span>
								<span class="book_content" id="book_placeinfo"></span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td >
								<label class="book_detail">图书编码:</label>							
								<select id="bd_address_select" class="bd_select">>
									<option value="">请选择...</option>
								</select>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td >
							<td colspan="2">
								<label class="book_detail">图书所在地:</label>							
								<input id="bd_bookcode_text"  style="border-radius:5px;font:normal 15px/20px '仿宋'" value="" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>
								<a href="javascript:addSendAdress()" style="border-radius:5px;border:1px solid red;text-decoration: none;" id="choose_sendAddress">选择配送地址</a>
							</td>
						</tr>
					</table>				
				</div>
			</div>
		</div>
		
		<div id="bd_mask"></div>
		
		<!-- 图书所在地 -->
		<div id="individual_user_address">
			<fieldset>
				<legend>在您账号下的地址信息</legend>
					<table border="none" id="tb_address">
						<tr>
							<th>用户名</th>
							<th>联系方式</th>
							<th>用户地址</th>
							<th>请选择收货地址</th>
						</tr>
						<c:set value="<%=userAddresss %>" var="userAddresss"></c:set>
						<c:choose>
							<c:when test="${userAddresss != null }">
								<c:forEach items="${ userAddresss }" var="userAddress">
									<tr>
										<td>${userAddress.username }</td>
										<td>${userAddress.userphone }</td>
										<td>${userAddress.address }</td>
										<td>
											<input type="button" onclick="defineOderBook(this)" style="border: 1px solid gray;border-radius:5px;" value="确认">
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ userAddresss }" var="userAddress">
									<tr>
										<td colspan="3" style="color: red;font: normal 15px/25px '楷体'">
											<a href="javascript:openaddUserAddress()" style="text-decoration: none" id="address_add">添加地址</a>
										</td>
									</tr>
								</c:forEach>					
							</c:otherwise>
						</c:choose>						
						<a href="javascript:cancelAddSendAddress()" id="cancel_sendAddress" style="text-decoration: none">取消</a>			
					</table>		
			</fieldset>
		</div>
		
		<%
			String address=press.getAddress()!=null?press.getAddress():"无";
			Integer post=press.getPostcode()!=null?press.getPostcode():000000;
			String phone=press.getPhone()!=null?press.getPhone():"无";
			String purchase=press.getPurchasePhone()!=null?press.getPurchasePhone():"无";
			String ICP=press.getICP()!=null?press.getICP():"无";
			String web=press.getWebsite()!=null?press.getWebsite():"null";
		%>
		<!-- 出版社信息 -->
		<div id="bd_press">
			<strong class="on_hr_statement">出版社的详细信息</strong>
			<hr />
			<table id="press_table">
				<tr>
					<td>
						<label class="book_detail">出版社:</label>							
						<span class="book_content" id="bd_bookname"><%=press.getPname() %></span>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<label class="book_detail">地址:</label>							
						<span class="book_content"><%=address%></span>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<label class="book_detail">邮编:</label>							
						<span class="book_content" id="bd_isbn"><%=post %></span>
					</td>
				</tr>
				<tr>
					<td>
						<label class="book_detail">出版电话:</label>							
						<span class="book_content" id="bd_bookname"><%=phone %></span>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<label class="book_detail">销售电话:</label>							
						<span class="book_content" id="bd_bookname"><%=purchase %></span>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<label class="book_detail">ICP:</label>							
						<span class="book_content"><%=ICP %></span>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<label class="book_detail"><a href="<%=web%>" style="text-decoration: none;">前往官网</a></label>							
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 这本的评价 -->
		<div id="indivicdual_comment">
			<div>
				<strong class="on_hr_statement">用户对这本书的评论</strong>
				<hr />
			</div>
			<div>
				<table>
				<c:forEach items="<%=comments %>" var="comment">
					<tr>
						<td>
							<span>用户编号:${comment.uid }</span>
							&nbsp;&nbsp;
						</td>
						<td>
							<span>评论时间：<fmt:formatDate value="${comment.commentDate}"  type="both" /></span>		
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
		
		<!-- 评论这本书 -->
		<div id="bd_comments">
			<strong class="on_hr_statement">出版社的详细信息</strong>
			<hr />
			<textarea rows="2" cols="100" name="text_comments" id="text_comment"></textarea>
			<a href="javascript:void(0)" id="submit_comment" >提交评论</a>
		</div>
		
		<!-- 显示订单信息 -->
		<div id="show_orderformInfo">
			<table id="tb_oderform_info">
				<tr>
					<td colspan="3">
						<label class="book_detail">用户编号:</label>							
						<span class="book_content" id="tb_orderform_uid">${fore_uid }</span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">图书名称:</label>							
						<span class="book_content" id="tb_orderform_bname"><%=gotBook.getBname() %></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">图书编号:</label>							
						<span class="book_content" id="tb_orderform_bisbn"><%=gotBook.getBisbn() %></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">所在地编号:</label>							
						<span class="book_content" id="tb_orderform_bookcode"></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">图书所在地:</label>							
						<span class="book_content" id="tb_orderform_bookAddress"></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">用户名称:</label>							
						<span class="book_content" id="tb_orderform_uname"></span>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">手机号码:</label>							
						<span class="book_content" id="tb_orderform_uphone"></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">收货地址:</label>							
						<span class="book_content" id="tb_orderform_userAddress"></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">出版社名:</label>							
						<span class="book_content" id="tb_orderform_pressname"></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<label class="book_detail">价格:</label>							
						<span class="book_content" id="tb_orderform_price"></span>
					</td>
				</tr>
				<tr>
					<td>
						<input type="button"  align="center" value="确定" id="bd_btn_define">
					</td>
					<td>
						<input type="button"  align="center" value="重选地址" id="bd_btn_rechoose" onclick="rechooseUserAddress()">
					</td>
					<td>	
						<input type="button"  align="center" value="取消" id="bd_btn_cancel" onclick="closeOrderForm()">													
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 充值 -->
		<div id="bd_recharge" >
			<label for="input_money">充值金额：</label>
			<input type="number" id="input_money" placeholder="请输入金额" min="1">
			<span id="input_moneyspan" style="color:red;"></span>
			<br><br>
			&nbsp;&nbsp;<input type="button" id="recharge_define" style="border:1px solid gray;border-radius:2px; font:normal 18px/25px '楷体'" value="确定">
			&nbsp;&nbsp;<input type="button" id="recharge_cancel" style="border:1px solid gray;border-radius:2px; font:normal 18px/25px '楷体'" value="取消">
		</div>
		
		<!-- 联系该出版社 -->
		<div id="bd_contactAdmin">
			<strong class="on_hr_statement">联系<%=press.getPname()%>出版社</strong>
			<hr />
				<label for="admin_name">用&nbsp;户&nbsp;名：</label>
				<input id="admin_name" type="text" maxlength="48" placeholder="用户名" value="${fore_name }" >
					<span id="admin_namespan" style="color:red;font-size:15px;"></span><br><br>
			
				<label for="admin_phone">手机号码：</label>
				<input id="admin_phone" type="tel" maxlength="11" placeholder="号码"><br><br>
				<label>联系内容：</label>
				<textarea rows="2" cols="100" name="admin_content" id="admin_content" placeholder="联系内容..."></textarea>
				<a href="javascript:void(0)" id="submit_content" >提交评论</a>
		</div>
		
			<script type="text/javascript">
			$(function(){
				$("#submit_content").click(function(){
					var adminname=$("#admin_name").val();
					var adminphone=$("#admin_phone").val();
					var content=$("#admin_content").val();
					var pressname=$("#bd_bookname").text();
					var reg = /^1(3|4|5|7|8)\d{9}$/;
					if(adminname == "" || adminphone == "" ||content == ""){
						$("#admin_namespan").text("检查用户名、手机号、联系内容是否为空");
					}else if(!reg.test(adminphone)){
						$("#admin_namespan").text("手机号不符合规则");
						$("#admin_phone").val("");
					}else{
						var url="contactadmin?method=contactAdmin";
						var args={
							"adminname":adminname,
							"adminphone":adminphone,
							"content":content,
							"pressname":pressname,
							"time":new Date(),
						}
						$.getJSON(url,args,function(data){
							if(data=="success"){
								window.alert("联系出版社成功，在二十四小时之内，\r\n有人给你打电话，请确保您的电话畅通");
								$("#admin_phone").val("");
								$("#admin_content").val("");
							}
						})
					}
				});
			});
		
		</script>
		<jsp:include page="fore_main_bottom.jsp"></jsp:include>
	</body>
</html>
<%@ page language="java" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%= basePath%>">
		<title>删除图书</title>
		
		<style type="text/css">
			body{
				margin: 0;
			}
			
			.tb_hover{
				background-color: #BBFFFF;
			}
			
			/* 选择查询数据 */
			#choose_type_query fieldset{
				width: 96%;
				height: 20%;
				border:0;				
			}
			#input_info,#order_type{
				position: relative;
				margin-top: 1.5%;
			}
			.ch_distance{
				margin-right: 15%;
			}
			
			#define{
				width: 80px;
				height: 30px;
				font: normal 18px/25px "楷体";
				background-color: white;
				outline: none;
				float: right;
			}
			#define:HOVER{
				background-color:#D9D9D9;
			}
			/* 图书 */
		#show_Books {
			position: relative;
			margin-top:3%;
			width: 130%;
			border-radius:3px;
			height: 10%;
		}
		#show_Books fieldset{
			border:0;		
		}
		#show_Books table{
			width: 100%;
			height: 100%;
			border:none;
			text-align: left;
		}
		#show_Books table th{
			font:normal 20px/30px "楷体";
			border-radius:5px;
			border-bottom:none;
			border-color:	#FFFAFA;
			color: red;
		}
		#show_Books div a:HOVER{
			color: red;
		}
		
		.text_style {
			font: normal 18px/25px "楷体";
			outline: none;
			border-radius: 5px;
		}
		#mask{
			position: absolute;
			top: 0;
			z-index: 50;
			height: 100%;
			width: 130%;
			background: transparent;
			background-color: black;
			opacity: 0.1;
			display: none; 
		}
		#intact_div{

			position:absolute;
			left:30%;
			z-index: 60;
			top:20%;
			width: 360px;
			height: 240px;
			background-color: white;
			display: none;
			border-radius:5px; 
			
		}
		#intact{
			width: 80%;
			height: 10%;
			margin-top: 4%;
			font: normal 18px/25px "仿宋";
		}
		.span_s{
			color:red;
			font:bold 15px/18px "楷体";
		}
		
		/* 充值 */
#bd_recharge{
	position: absolute;
	top:20%;
	left:40%;
	border-radius:5px;
	background-color: white;
	z-index:60;
	border:1px solid gray;
	display: none;
}
#input_money{
	border-radius:2px;
	font: normal 18px/25px "楷体";

}
		</style>
		
		<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="back_end/js/globalData.js"></script>
		<script type="text/javascript">
			
			var bookName;
			var username;
			var lendtimeFrom;
			var lendtimeTo;
			var txtStatus;
			
			$(function(){
				$("#define").click(function(){
					$("#table_book tr:not(:first)").remove();
					bookName=$("#txt_bookname").val();
					username=$("#txt_username").val();
					lendtimeFrom=$("#txt_from").val();
					lendtimeTo=$("#txt_to").val();
					txtStatus=$("#txt_status").val();
					
					var from=new Date(lendtimeFrom.replace("-","/").replace("-","/"));
					var to=new Date(lendtimeTo.replace("-","/").replace("-","/"));
					
					if(bookName==""&& username==""&&lendtimeFrom==""&&lendtimeTo==""&& txtStatus==""){
						$("#show_info").text("请至少选择一样");
					}else if(txtStatus == ""){
						$("#show_info").text("请选择图书状态");
					} else if(from>to){
						$("#show_info").text("时间选择有误,请重新选择");
						$("#txt_from").val("");
						$("#txt_to").val("");
					}else {
						var url="orderformquery?method=queryorderforms";
						var args={
								"bookName":bookName,
								"username":username,
								"lendtimeFrom":lendtimeFrom,
								"lendtimeTo":lendtimeTo,
								"bStatus":txtStatus,
								"time":new Date()							
						}
						$.getJSON(url,args,function(data){
							if(data.length!=0){
								$("#show_info").text("");
								for(var i=0;i<data.length;i++){
									var oid=data[i].orderId;
									var uid=data[i].userId;
									var bname=data[i].bookname;
									var uname=data[i].username;
									var address=data[i].userAddress;
									var uphone=data[i].userphone;
									var timestamp=data[i].lendTime;
									var date=new Date();
									date.setTime(timestamp);
									var lend=date.toLocaleDateString();
									var fine=data[i].fine;
									var code=data[i].bookCode;
									var price=data[i].price;
									
									$("#table_book tbody").append(
											"<tr>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+oid+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+uid+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bname+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'><input type='text' maxvalue='48' value= '"+uname+"' style='border-radius:2px;width=100%;'></td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'><input type='text' maxvalue='98' value= '"+address+"' style='border-radius:2px;width=100%;'></td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'><input type='number' maxvalue='11' value= '"+uphone+"' style='border-radius:2px;width=100%;'></td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+lend+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+fine+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+code+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+price+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+
														"<input type='button' id='"+oid+"' onclick='updateOrderForm(this,this.id)' value='更新'>/"+
														"<input type='button' id='"+oid+"' onclick='returnBook(this,this.id)' value='还书'>"+
													"</td>"+
												"</tr>"
									);
									
									$("#table_book tr").hover(function(){   
										$(this).children("td").addClass("tb_hover")   
										},function(){   
											$(this).children("td").removeClass("tb_hover")  
									});
								}
							}else{
								$("#show_info").text("查询无果，请重新查找");
							}
						});
					}
				});
			});
		
			/* 更新图书信息 */
			function updateOrderForm(btn,id){
				var tr = btn.parentNode.parentNode;
			  var uname=tr.cells[3].firstChild.value;  //获取tr->td>input[type=text]的值
			  var address=tr.cells[4].firstChild.value; //获取tr->td>input[type=number]的值
			  var phone=tr.cells[5].firstChild.value;	
			  if(uname == ""){
			  		window.alert("用户名不能为空");
			  	}else if(address == ""){
			  		window.alert("地址不能为空");
			  	}else if(phone == ""){
			  		window.alert("手机号不能为空");
			  	}else if(id != null){
						if(window.confirm("确认修改地址")){
							var url="modifyorderform?method=modifyOrderform";
							var args={
								"id":id,
								"uname":uname,
								"address":address,
								"phone":phone,
								"time":new Date()
							}
							$.getJSON(url,args,function(data){
								if(data =="更新成功"){
									window.alert("已成功修改用户为“"+uname+"”的地址,请您刷新");
								}
							});
						}
					}
			}
			
			var id;
			var uid;
			var code;
			var bookintact; //图书损毁的费
			var price;
			/* 还书 */
			function returnBook(btn,btnid){
				var tr = btn.parentNode.parentNode;
			  id=btnid;  //获取tr->td>input的值
			  uid=tr.cells[1].innerText
			  bookName=tr.cells[2].innerText; 
			  code=tr.cells[8].innerText;
			  price=tr.cells[9].innerText;	
				$("#mask").css("display","block");
				$("#intact_div").css("display","block");
			}
			
			/* 提交数据  */
			$(function(){
				$("#intact").blur(function(){
					bookintact=$(this).val();
					if(bookintact > 4 || bookintact < 1){
						$("#numberlable").text("只能在1和4之间");
						$(this).val("");
					}else {
						$("#numberlable").text("");
						if(window.confirm("确认归还图书")){			
							var url="returnbook?method=returnBook";
							var args={
								"id":id,
								"uid":uid,
								"bname":bookName,
								"code":code,
								"bookintact":bookintact,
								"price":price,
								"time":new Date()
							}
							$.getJSON(url,args,function(data){
								if(data == 1){
									$("#bd_recharge").css("display","block");
									$("#intact_div").css("display","none");
								}else if(data == 2){
									alert("还书成功");
									$("#intact_div").css("display","none");
									$("#mask").css("display","none");
									$("#table_book tr:eq('"+id+"')").remove();
								}
							});
						}else{
							$("#mask").css("display","none");
							$("#intact_div").css("display","none");
						}
					}
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
		  		  				$("#intact_div").css("display","block");
		  		  				
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
		  			$("#bd_recharge").css("display","none");
		  			$("#mask").css("display","none");
		  		});
		  	});
		</script>
		
	</head>
	<body onload="showCursor('txt_bookname');">
		<div id="choose_type_query">
			<fieldset >
				<legend style="display:none;">图书查询</legend>
				
				<!-- 选择查询方式 -->
				<div id="input_info">
					<label class="lb_type">选择查询方式：</label>
					<input type="text" id="txt_bookname" class="text_style" placeholder="图书名称">
					<input type="text" id="txt_username" class="text_style" placeholder="用户名称">
					<input type="date" id="txt_from" class="text_style" placeholder="起始时间">
					<span id="line">-</span>
					<input type="date" id="txt_to" class="text_style" placeholder="抵达时间">
					<input type="number" min="1" max="2" id="txt_status" class="text_style" value="1" placeholder="图书状态" style="width: 100px">
				</div>
				
				<!-- 排序方式 -->
				<div id="order_type">
					<span id="show_info" style="font:bold 15px/20px solid;color:red;"></span>
					<input type="button" id="define" value="确认">
				</div>				
			</fieldset>
		</div>

		<!-- 展示信息 -->
		<div id="show_Books">
			<fieldset >
				<legend style="display: none;"></legend>
				<table id="table_book" border="1px solid gray">
					<tr>
						<th>编号</th>
						<th>用户编号</th>
						<th>书名</th>
						<th>用户名</th>						
						<th>地址</th>
						<th>手机号码</th>
						<th>借书时间</th>
						<th>罚金</th>					
						<th>图书编码</th>
						<th>价格</th>
						<th>操作</th>
					</tr>
			</table>
			</fieldset>			
		</div>
		
		<!-- 图书损失情况  -->
		<div id="mask"></div>
		<div id="intact_div">
				<input type="number" min="1" max="4" id="intact" placeholder="损坏情况:1/2/3/4">
				<br>
				<span id="numberlable" class="span_s"></span><br><br>
					<label>注意事项：</label><br>
					<span class="span_s">&nbsp;&nbsp;只能在1到4之间选择数字</span><br>
					<span class="span_s">&nbsp;&nbsp;1表示完好，不用赔偿</span><br>
					<span class="span_s">&nbsp;&nbsp;2表示70%左右完好，需要赔偿1元</span><br>
					<span class="span_s">&nbsp;&nbsp;3表示40%左右完好，需要原价赔偿</span><br>
					<span class="span_s">&nbsp;&nbsp;4表示损坏，需要两倍原价赔偿</span><br>
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
	</body>
</html>
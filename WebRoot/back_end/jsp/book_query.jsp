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
			width: 97%;
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
		</style>
		
		<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="back_end/js/globalData.js"></script>
		<script type="text/javascript">
			
			var bookName;
			var authorname;
			var publicationFrom;
			var publicationTo;
			var orderValue;
			var txtStatus;
			
			$(function(){
				$("#define").click(function(){
					$("#table_book tr:not(:first)").remove();
					bookName=$("#txt_bookname").val();
					authorname=$("#txt_authorname").val();
					publicationFrom=$("#txt_from").val();
					publicationTo=$("#txt_to").val();
					txtStatus=$("#txt_status").val();
					orderValue=$("input[name='order']:checked").val();
					
					var from=new Date(publicationFrom.replace("-","/").replace("-","/"));
					var to=new Date(publicationTo.replace("-","/").replace("-","/"));
					
					if(bookName==""&& authorname==""&&publicationFrom==""&&publicationTo==""&& txtStatus==""){
						var url="bookquery?method=queryAllBooks";
						var args={
								"orderValue":orderValue,
								"time":new Date()							
						}
						$.getJSON(url,args,function(data){
							if(data.length!=0){
								$("#show_info").text("");
								for(var i=0;i<data.length;i++){
									var bid=data[i].bid;
									var isbn=data[i].bisbn;
									var bname=data[i].bname;
									var aname=data[i].authorName;
									var pub=data[i].publication;
									var borrowed=data[i].borrowedTime;
									var click=data[i].clickedTime;
									var price=data[i].bprice;
									var num=data[i].bnumber;
									var earn=data[i].earnest;
									
									$("#table_book tbody").append(
											"<tr>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bid+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+isbn+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bname+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+aname+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+pub+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+borrowed+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+click+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+price+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+num+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+earn+"</td>"+
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
					} else if(from>to){
						$("#show_info").text("时间选择有误,请重新选择");
						$("#txt_from").val("");
						$("#txt_to").val("");
					}else if(bookName!=""|| authorname!=""||(publicationFrom!=""&&publicationTo!="")){
						var url="bookquery?method=queryBooks";
						var args={
								"bookName":bookName,
								"authorname":authorname,
								"publicationFrom":publicationFrom,
								"publicationTo":publicationTo,
								"orderValue":orderValue,
								"bStatus":txtStatus,
								"time":new Date()							
						}
						$.getJSON(url,args,function(data){
							if(data.length!=0){
								$("#show_info").text("");
								for(var i=0;i<data.length;i++){
									var bid=data[i].bid;
									var isbn=data[i].bisbn;
									var bname=data[i].bname;
									var aname=data[i].authorName;
									var pub=data[i].publication;
									var borrowed=data[i].borrowedTime;
									var click=data[i].clickedTime;
									var price=data[i].bprice;
									var num=data[i].bnumber;
									var earn=data[i].earnest;
									
									$("#table_book tbody").append(
											"<tr>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bid+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+isbn+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bname+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+aname+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+pub+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+borrowed+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+click+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+price+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+num+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+earn+"</td>"+
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
					<input type="text" id="txt_authorname" class="text_style" placeholder="作者名称">
					<input type="date" id="txt_from" class="text_style" placeholder="起始时间">
					<span id="line">-</span>
					<input type="date" id="txt_to" class="text_style" placeholder="抵达时间">
					<input type="number" min="1" max="2" id="txt_status" class="text_style" value="1" placeholder="图书状态" style="width: 100px">
				</div>
				
				<!-- 排序方式 -->
				<div id="order_type">
					<label class="lb_type">选择排序方式(默认降序)：</label>
					            点击次数<input type="radio" name="order" value="clickedtime" id="order_clicktime" class="ch_type" checked="checked">
					&nbsp;&nbsp;借阅次数<input type="radio" name="order" value="borrowedtime" id="order_borrowedtime" class="ch_type ">
					&nbsp;&nbsp;图书价格<input type="radio" name="order" value="bprice" id="ck_price" class="ch_type">
					&nbsp;&nbsp;<span id="show_info" style="font:bold 15px/20px solid;color:red;"></span>
					<input type="button" id="define" value="确认">
				</div>				
			</fieldset>
		</div>

		<!-- 相同isbn的某本图书下架 -->
		<div id="show_Books">
			<fieldset >
				<legend style="display: none;"></legend>
				<table id="table_book" border="1px solid gray">
					<tr>
						<th>编号</th>
						<th>isbn</th>
						<th>书名</th>
						<th>作者</th>
						<th>出版日期</th>
						<th>借阅次数</th>
						<th>点击次数</th>
						<th>价格</th>
						<th>数量</th>
						<th>租金</th>
					</tr>
			</table>
			</fieldset>
			
		</div>
	</body>
</html>
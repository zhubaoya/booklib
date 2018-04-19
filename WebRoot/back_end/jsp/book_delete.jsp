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
			
			/* 选择删除方式 */
			#choose_type_delete{
				position: absolute;
				top:0;
				width: 94%;
			}
			#choose_type_delete fieldset{
				border-radius:3px;
				width: 100%;
				font:normal 20px/30px "楷体";
				border-color: white;
			}
			#choose_type_delete table tr{
				height: 20px;
			}
			.border-modi{
				font:normal 18px/20px "楷体";
				border-radius:3px;
			}
			
			/* 所有图书 */
			#allBook{
				position: absolute;
				top:20%;
				width: 97%;
				border-top:1px solid gray;
				border-radius:3px;
				height: 10%;
			}
			#allBook label{
				width: 200px;
				border-right: 1px solid gray;
			}
			
			a{
				border-radius:2px;
				border:1px solid gray;
				text-decoration: none;
				font:normal 18px/20px "楷体";
			}
			
			/* 某本图书 */
		#delete_oneBook {
			position: absolute;
			top:20%;
			width: 97%;
			border-top:1px solid gray;
			border-radius:3px;
			height: 10%;
			display: none;
		}
		#delete_oneBook fieldset{
			border-color:#FFFFF0;
			border-radius:10px;
			font:normal 20px/30px "楷体";
		}
		#delete_oneBook table{
			width: 100%;
			height: 100%;
			border:none;
			text-align: left;
		}
		#delete_oneBook table th{
			font:normal 20px/30px "楷体";
			border-radius:5px;
			border-bottom:none;
			border-color:	#FFFAFA;
			color: red;
		}
		#delete_oneBook div a:HOVER{
			color: red;
		}
		</style>
		
		<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="back_end/js/globalData.js"></script>
		<script type="text/javascript">
		
		var type;  //选择类型
		
		/* 删除数据 */
		$(document).ready(function(){
			$("#bookname").blur(function(){
				$("#table_book tr:not(:first)").remove();
				var bookname = $(this).val();
				type = $("#select_type").val();
				if(bookname == ""){
					$("#booknamespan").text("不能为空");
				}else {
					var url="deleteBook?method=getBookName";
					var args = {
							"bookname":bookname,
							"type":type,
							time: new Date()
					}
					$.getJSON(url,args,function(data){
						if(data == "1") {
							$("#booknamespan").text("该图书不存在");
						} else {
							switch (type) {
							case "1":
								$("#span_bname").text(data.bname);
								$("#span_isbn").text(data.bisbn);
								$("#span_authorname").text(data.authorName);
								$("#span_booknumber").text(data.bnumber);
								break;
							case "2":
								for(var i = 0;i < data.length;i++){
									var id=data[i].id;
									var bookCode=data[i].bookCode;
									var isbn=data[i].isbn;
									var bookPlace=data[i].bookPlace;
									var integeractSituation=data[i].intactSituation;
									var integeract;
									switch (integeractSituation) {
										case "1":
											integeract="完好";
											break;
										case "2":
											integeract="70%完好";
											break;
										case "3":
											integeract="40%完好";
											break;
										case "4":
											integeract="受损";
											break;
										default:
											break;
									}
									
									$("#table_book tbody").append(
											"<tr class='order_tr'>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+id+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bookCode+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+isbn+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bookPlace+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+integeract+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'><a href='javascript:void(0)' id='"+bookCode+"' onclick='javascript:deleteOneBook(this.id,"+isbn+")'>删除</a></td>"+
											"</tr>"
									);
									
									$("#delete_oneBook tr").hover(function(){   
										$(this).children("td").addClass("tb_hover")   
										},function(){   
											$(this).children("td").removeClass("tb_hover")  
									});
								}
							default:
								break;
							}
						}
					});
				}
			});
		});
		
		/* 删除一本书 */
		function deleteOneBook(bookcode,isbn){
			if(bookcode!=null){
				if(window.confirm("确认删除该图书")){
					var url="deleteonebook?method=deleteOneBook";
					var args={
						"bookcode":bookcode,
						"isbn":isbn,
						"time":new Date()
					}
					$.getJSON(url,args,function(data){
						if(data =="删除成功"){
							window.alert("您已成功删除图书编号为“"+bookcode+"”的图书");
							$("#table_book tr:eq('"+bookcode+"')").remove();
						}
					});
				}
			}
		}
		
		/* 删除全部图书 */
		$(function(){
			$("#delete_allBook").click(function(){
				var isbn =$("#span_isbn").text();
				if(isbn == ""){
					window.alert("请再输入框中输入图书名");
				}else{
					if(window.confirm("请您确认:\r\n是否有图书还未归还，或者在运输途中\r\n删除后，图书信息无法查到")){
						var url="deleteallbook?method=deleteAllBook";
						var args = {
								"isbn":isbn,
								time:new Date()
						}
						$.getJSON(url,args,function(data){
							if(data == "删除成功"){
								$("#bookname").val("");
								$("#span_bname").text("");
								$("#span_isbn").text("");
								$("#span_authorname").text("");
								$("#span_booknumber").text("");
							}
						});
					}		
				}
			});
		});
		/* 设置选择项 */
		$(function(){
			$("#select_type").change(function(){
				type=$(this).val();
				switch (type) {
				case "1":
					$("#bookname").val("");
					$("#table_book tr:not(:first)").remove();  
					$("#allBook").css("display","block");
					$("#delete_oneBook").css("display","none");
					break;
				case "2":
					$("#bookname").val("");
					$("#span_bname").text("");
					$("#span_isbn").text("");
					$("#span_authorname").text("");
					$("#span_booknumber").text("");
					$("#allBook").css("display","none");
					$("#delete_oneBook").css("display","block");
					break;
				default:
					break;
				}
			});
		})
		</script>
		
	</head>
	<body onload="showCursor('bookname');tb_load()">
		<div id="choose_type_delete">
			<fieldset>
				<legend>图书下架</legend>
				<table>
					<tr>
						<td align="left">
							<label>下架方式：</label>
							<select id="select_type" class="border-modi">
								<option value="1">相同isbn的全部图书下架</option>
								<option value="2">相同isbn的某本图书下架</option> 
							</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						
						<td align="right">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="bookname" >图书书名：</label>
							<input type="text" class="border-modi" id="bookname"  maxlength="13" placeholder="书名" onfocus="getCursor(this.id)">
							<span id="booknamespan" style="color: red;font:normal 15px/20px '楷体'"></span>
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
		
		<!-- 相同isbn的全部图书下架 -->
		<div id="allBook">
			<label>书名：
				<span id="span_bname"></span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</label>
			&nbsp;&nbsp;
			<label>isbn：
				<span id="span_isbn"></span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</label>
			&nbsp;&nbsp;
			<label>作者：
				<span id="span_authorname"></span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</label>
			&nbsp;&nbsp;
			<label>图书数量：
				<span id="span_booknumber"></span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</label>
			&nbsp;&nbsp;
			<a href="javascript:void(0)" id="delete_allBook">删除</a>
		</div>
		
		<!-- 相同isbn的某本图书下架 -->
		<div id="delete_oneBook">
			<fieldset>
				<legend>选择要删除的图书</legend>
				<table id="table_book" border="1px solid gray">
					<tr>
						<th>库存编号</th>
						<th>图书编码</th>
						<th>图书isbn编号</th>
						<th>图书地址</th>
						<th>图书的完整情况</th>
						<th>操作</th>
					</tr>
			</table>
			</fieldset>
			
		</div>
	</body>
</html>
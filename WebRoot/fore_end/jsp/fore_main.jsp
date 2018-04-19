<%@page import="com.zby.books.utils.MyDateTime"%>
<%@page language="java" 
		import="java.util.*,
						com.zby.books.contents.*,
						com.zby.books.model.po.*,
						com.zby.books.model.service.*,
						com.zby.books.utils.MyDateTime"
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	List<Genres> gens=null;
	
	List<Tag> tags=new TagService().queryTags();
	
	/* 获取tag的tid数据 */	
	if(request.getParameter("tid") != null){
		Integer tid=Integer.parseInt(request.getParameter("tid"));	
		Genres genres=	new Genres(null, tid, null);
		gens=new GenresService().queryGenress(genres);
		genres = null;
	}
	
	Book book=null;
	String gid=request.getParameter("gid");
	if(gid != null){		
		book=new Book(Integer.parseInt(gid));		
	}else{
		book=new Book(null, null, null, null, null,null);
	}
	List<Book> books=new BookService().queryBooks(book);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>云上图书主页</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		
		<!-- 导入外部的css -->
		<link rel="stylesheet" href="fore_end/css/fore_main.css">
		<style type="text/css">
			.tb_hover{
				background-color: #BBFFFF;
			}
		</style>
		
		<!-- 导入外部的js -->
		<script type="text/javascript" src="back_end/js/globalData.js"></script>
		<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>		
		<script type="text/javascript">
		
		/*  */
			function tb_load(){
				$("#show_data tr").hover(function(){   
					$(this).children("td").addClass("tb_hover")   
					},function(){   
						$(this).children("td").removeClass("tb_hover")  
				});
				
				/* 当遍历每一个标签a时，执行一个函数 */
				$("a").each(function(){
					$(this).hover(function(){   
						$(this).addClass("tb_hover")   
					},function(){   
							$(this).removeClass("tb_hover")  
					});  
				});
			}
		
			function showAlert(){
				$(function(){
					if($("#fore_uid").val() == null){	
						$("#login_register").css("display","block");
			  		$("#div_mask").css("display","block");
					} 
				});			
			}
			
			/* 关闭对话框 */
			/* $(function(){
				$("#login_reg_a").click(function(){
					$("#login_register").css("display","none");
			  		$("#div_mask").css("display","none");
				});
			}) */
		
			/* 前去登录 */
			$(function(){
				$("#prompt_login").click(function(){
					$("#login_register").css("display","none");
			  	$("#div_mask").css("display","none");
			  	window.location.href="fore_end/jsp/fore_login.jsp";
				});
			});
			
			/* 前去登录 */
			$(function(){
				$("#prompt_register").click(function(){
					$("#login_register").css("display","none");
			  	$("#div_mask").css("display","none");
			  	window.location.href="fore_end/jsp/fore_register.jsp";
				});
			});
			
			var bname;  //书名
			var bisbn;  //图书编号
			
			$(function(){
				$("#txt_search").keyup(function(){
					var searchTxt=$(this).val();
					var selectVal=$("#select_type").val();
					var selectTxt= $("#select_type").find("option:selected").text();
					var reg = /^[0-9\u4e00-\u9fa5]+$/;
					if(searchTxt != "" && reg.test(searchTxt)){
						var url="fore_main_searchBox?method=getSearchTxt";
						var args={
								"searchTxt":searchTxt,
								"selectVal":selectVal,
								time:new Date()
						}
						$.getJSON(url,args,function(data){
							if(data.length != 0){
								$("#div_mask").css("display","block");
								$("#show_data").css("display","block");
								for(var i=0;i<data.length;i++){
									bname=data[i].bname;
									bisbn=data[i].bisbn;
									var authorName=data[i].authorName;
									
									$("#show_data tbody").append(
											"<tr>"+
												"<td style='font:normal 18px/25px 楷体';margin-right:100px;>"+bname+"</td>"+
												"<td style='font:normal 18px/25px 楷体';margin-right:100px;>"+authorName+"</td>"+
												"<td style='font:normal 18px/25px 楷体';margin-right:100px;><a href='fore_end/jsp/book_detail.jsp?bisbn=" + bisbn + "&bname=" + bname + "' style='text-decration:none;'>查看详情</a></td>"+
											"</tr>"
									);
								}
							}else{
								window.alert("没有该图书");
								$("#div_mask").css("display","none");
								$("#show_data").css("display","none");						
							}
						});
					}
				});
			});
			
			$(function(){
				$("#select_type").change(function(){
					$("#txt_search").val("");
				});
			});
			
		</script>
	</head>
	
	<body onload="showCursor('txt_search');tb_load();showAlert();">
		<jsp:include page="fore_main_head.jsp" flush="true"></jsp:include>
		
		<!-- 搜索框 -->
		<div id="div_search">
			<div id="serrch_img">
				<img alt="图标" src="logo_img/logo.png" width="200px" height="80px">
			</div>
			<div id="search_box">
				<table >
					<tr>
						<td id="td_txt">
							<input type="text" id="txt_search" name="txt_search" placeholder="请输入书名/作者/出版社" >						
						</td>
						<td id="td_select">
							<select id="select_type">
								<option value="1">书&nbsp;&nbsp;名</option>
								<option value="2">作者名</option>
								<option value="3">出版社</option>
							</select>
						</td>				
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 显示数据 -->
		<table id="show_data" border="1px solid blue">
			<tr>
				<td>				
				</td>
				<td>		
				</td>
				<td>		
				</td>
			</tr>
		</table>
		
		<!-- 图书标签 -->
		<div id="tag_div">
			<span>图书标签</span>
			<a href="fore_end/jsp/fore_main.jsp">全部</a>
			<c:forEach items="<%=tags %>" var="tag">
				<a href="fore_end/jsp/fore_main.jsp?tid=${tag.tid }&tname=${tag.tname}">${tag.tname }</a>
			</c:forEach>
		</div>
		
		<div id="genres_div">
			<span>图书类型</span>
			<c:forEach items="<%= gens %>" var="gen">
				<a href="fore_end/jsp/fore_main.jsp?gid=${gen.gid }&tname=${gen.gname}&tid=${gen.tid}">${gen.gname}</a>
			</c:forEach>
		</div>
		
		<!-- 分割线 -->
		<hr style="position: relative;width: 100%;border-color:gray;margin-top: 2px;">
		
		<!-- 蒙版 -->
		<div id="div_mask"></div>
		
		<!-- 展示图书 -->
		<div id="main_book">
			<article>
			 	<c:forEach items="<%=books %>" var="book">
					<figure> 
						<a href="fore_end/jsp/book_detail.jsp?bisbn=${book.bisbn}&bname=${book.bname}" id="book_href">
							<img src="${book.bimg }" id="imgId">
							<input type="hidden" id="record_bisbn" value="${book.bisbn}">
						</a> 
						<footer id="bname">${book.bname} </footer>
					 	<figcaption> 
					 		<a href="fore_end/jsp/book_detail.jsp?bisbn=${book.bisbn}&bname=${book.bname}" style="font-size: 13px; text-align: center;" id="bid">详情了解</a>
					 	</figcaption> 
					</figure>
				</c:forEach>
			</article>
		</div>
		
		<!-- 登录和注册 -->
		<div id="login_register">			
			<!-- <img alt="关闭窗口" src="logo_img/close.png" width="25px" height="25px" id="login_reg_a"><br> -->
			<span>您现在还未登录，请您先去登录/注册</span><br>
			<input type="button" id="prompt_login" class="prompt_login_register" value="前去登录">
			<input type="button" id="prompt_register" class="prompt_login_register" value="前去注册">			
		</div>
	<%-- 	<jsp:include page="fore_main_bottom.jsp"></jsp:include> --%>
	</body>
</html>
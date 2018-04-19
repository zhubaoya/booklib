<%@ page language="java" 
	import="java.util.*,
					com.zby.books.model.po.*,
					com.zby.books.model.service.*"
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<Tag> tags=new TagService().queryTags();
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
			#choose_type_modify{
				position: absolute;
				top:0;
				width: 94%;
			}
			#choose_type_modify fieldset{
				border-radius:3px;
				width: 100%;
				font:normal 20px/30px "楷体";
				border-color: white;
			}
			#choose_type_modify table tr{
				height: 20px;
			}
			.border-modi{
				font:normal 18px/20px "楷体";
				border-radius:3px;
			}
			
			/* 所有图书 */
			#modifyAllbook{
				position: absolute;
				top:20%;
				width: 97%;
				border-top:1px solid gray;
				border-radius:3px;
				height: 10%;
			}
			
			/* 某本图书 */
		#modify_oneBook {
			position: absolute;
			top:20%;
			width: 97%;
			border-top:1px solid gray;
			border-radius:3px;
			height: 10%;
			display: none;
		}
		#modify_oneBook fieldset,#modifyAllbook fieldset{
			border-color:#FFFFF0;
			border-radius:10px;
			font:normal 20px/30px "楷体";
		}
		#modify_oneBook table{
			width: 100%;
			height: 100%;
			border:none;
			text-align: left;
		}
		#modify_oneBook table th{
			font:normal 20px/30px "楷体";
			border-radius:5px;
			border-bottom:none;
			border-color:	#FFFAFA;
			color: red;
		}
		#modify_oneBook div a:HOVER{
			color: red;
		}
		
		/* 修改图书 */

		#ba_form {
			width: 100%;
			height: 100%;
		}

		.tb_book {
			border-collapse: separate;
			border-spacing: 10px;
		}
		
		.text_style {
			font: normal 18px/25px "楷体";
			outline: none;
			border-radius: 5px;
		}
		
		.select_style {
			font: normal 18px/25px "楷体";
			outline: none;
		}
		span {
			color: red;
			font: normal 15px/20px "楷体";
		}
		.btn_style {
			font: normal 20px/20px "楷体";
			outline: none;
			border-radius: 5px;
			background-color: white;
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
					var url="modifybook?method=getBookName";
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
								$("#ba_isbn").val(data.bisbn);
								$("#ba_bookname").val(data.bname);
								$("#ba_authorname").val(data.authorName);
								$("#ba_price").val(data.bprice);
								$("#ba_publication").val(data.publication);
								$("#ba_number").val(data.bnumber);
								$("#ba_earnest").val(data.earnest);
								$("#ba_abstract").val(data.babstract);
								$("#ba_status").val(data.bstatus);
								break;
							case "2":
								for(var i = 0;i < data.length;i++){
									var id=data[i].id;
									var bookCode=data[i].bookCode;
									var isbn=data[i].isbn;
									var bookPlace=data[i].bookPlace;
									var integeractSituation=data[i].intactSituation;
									
									$("#table_book tbody").append(
											"<tr class='order_tr'>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+id+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+bookCode+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'>"+isbn+"</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'><input type='text' value= '"+bookPlace+"' style='border-radius:2px;width=100%;'></td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'><input type='number' value= '"+integeractSituation+"' min='1' max='4' style='border-radius:2px'</td>"+
												"<td style='border-left: none;border-top: none;border-right: none;'><input type='button' id='"+bookCode+"' onclick='modifyOneBook(this,this.id,"+isbn+")' value='修改'></td>"+
											"</tr>"
									);
									
									$("#modify_oneBook tr").hover(function(){   
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
		
		/* 修改这本书 */
		function modifyOneBook(btn,objId,isbn){
			var tr = btn.parentNode.parentNode;
	  	var bookcodeplace=tr.cells[3].firstChild.value;  //获取tr->td>input[type=text]的值
	  	var intact=tr.cells[4].firstChild.value; //获取tr->td>input[type=number]的值
	  	if(bookcodeplace == ""){
	  		window.alert("图书地址不能为空");
	  	}else if(intact == ""){
	  		window.alert("图书完整情况不能为空");
	  	} else if(objId != null){
				if(window.confirm("确认修改该图书")){
					var url="modifyonebook?method=modifyOneBook";
					var args={
						"objId":objId,
						"bookcodeplace":bookcodeplace,
						"intact":intact,
						"isbn":isbn,
						"time":new Date()
					}
					$.getJSON(url,args,function(data){
						if(data =="修改成功"){
							window.alert("您已成功修改编号为“"+bookcode+"”的图书,请您刷新");
						}
					});
				}
			}
		}
		
		/* 设置选择项 */
		$(function(){
			$("#select_type").change(function(){
				type=$(this).val();
				switch (type) {
				case "1":
					$("#bookname").val("");
					$("#table_book tr:not(:first)").remove();  
					$("#modifyAllbook").css("display","block");
					$("#modify_oneBook").css("display","none");
					break;
				case "2":
					$("#ba_isbn").val("");
					$("#ba_bookname").val("");
					$("#ba_authorname").val("");
					$("#ba_price").val("");
					$("#ba_publication").val("");
					$("#ba_number").val("");
					$("#ba_earnest").val("");
					$("#ba_abstract").val("");
					$("#ba_status").val();
					$("#modifyAllbook").css("display","none");
					$("#modify_oneBook").css("display","block");
					break;
				default:
					break;
				}
			});
		});
		
		/* 选择图书标签 */
		$(function(){
			$("#ba_chooseTag").change(function(){
				$("#ba_chooseGenres option:not(:first)").remove();
				var tagId = $(this).val();
				if (tagId != null) {
					var url = "genresIdGotServlet?method=getGenresId";
					var args = {
						"tagId" : tagId,
						"time" : new Date()
					}
					$.getJSON(url, args, function(data) {
						if (data.length == 0) {
							if(window.confirm("当前标签下没有图书类型,是否添加该类型")){
								openDivMask("ba_mask", "div_addGenres");
							}
						} else {
							for (var i = 0; i < data.length; i++) {
								var genresId = data[i].gid;
								var gname = data[i].gname;
								$("#ba_chooseGenres").append(
										"<option value='"+genresId+"'>" + gname
												+ "</option>");
							}
						}
					});
				} 
			});
		});	
		
		</script>
		
		<!-- 修改图书 -->
	<script type="text/javascript">
	
	function validate(objId, reg) {
		var obj = document.getElementById(objId);
		var objValue = obj.value;
		var objSpane = document.getElementById(objId + "span");
		if (objValue == "") {
			objSpane.innerHTML = obj.placeholder + "不能为空！";
			return false;
		}else if (!reg.test(objValue)) {
			objSpane.innerHTML = "不符合" + "格式";
			return false;
		} else {
			objSpane.innerHTML = "";
			return true;
		}
	}
	
	/* 作者 */
	function validateAuthorName(objId){
		return	validate(objId,null);
	}
	
	/* 选择图书类型 */
	function validateGenres(objId){
		return validate(objId, null);
	}
	
	/* 价格 */
	function validatePrice(objId){
		var reg=/^[0-9]+(.[0-9]{2})?$/;
		return validate(objId, reg);
	}
	
	/* 图书数量 */
	function validateBookNumber(objId){
		var reg=/^\d{1,4}$/;
		return validate(objId, reg);
	}
	
	/*违约金 */
	function validateEarnest(objId){
		var reg=/^[0-9]+(.[0-9]{2})?$/;
		return validate(objId, reg);
	}
	
	//图书状态
	function validateStatus(objId){
		return validate(objId, null);
	}
	
	/* 图书评价 */
	function validateAbstruct(objId){
		return validate(objId, null);
	}
	
	function validateAll(){
		if(validateAuthorName("ba_authorname")==false || validatePrice("ba_price")
				|| validateBookNumber("ba_number")==false||validateEarnest("ba_earnest")==false 
				|| validateAbstruct("ba_abstract")==fals ||validateStatus("ba_status")==false
				|| validateGenres("ba_chooseGenres")== false){
			return false;
		}
		return true;
	}
	</script>
	</head>
	<body onload="showCursor('bookname');">
		<div id="choose_type_modify">
			<fieldset>
				<legend>图书修改</legend>
				<table>
					<tr>
						<td align="left">
							<label>下架方式：</label>
							<select id="select_type" class="border-modi">
								<option value="1">更新相同isbn的全部图书</option>
								<option value="2">更新相同isbn的某本图书</option> 
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
		<div id="modifyAllbook" class="div_style">
			<fieldset>
				<legend>修改部分图书</legend>			
					<form action="modify_book" method="post" id="ba_form">
						<table class="tb_book">
							<tr>
								<td>
									<label for="ba_isbn">图书编号&nbsp;</label>
									<input type="text" id="ba_isbn" name="ba_isbn" maxlength="13" placeholder="编号" class="text_style" readonly="readonly">
									<span id="ba_isbnspan"></span>
								</td>
								<td>
									<label for="ba_bookname">书&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;</label>
									<input type="text" id="ba_bookname" maxlength="48" name="ba_bookname" placeholder="书名" class="text_style" readonly="readonly">
									<span id="ba_booknamespan"></span>
								</td>
							</tr>
							<tr>
								<td>
									<label for="ba_chooseTag">选择标签&nbsp;</label>
									<select id="ba_chooseTag" class="select_style">
										<option value="">请选择...</option>
										<c:forEach items="<%=tags %>" var="tag">
											<option value="${tag.tid }">${ tag.tname}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<label for="ba_chooseGenres">选择类型</label>
									<select id="ba_chooseGenres" name="ba_chooseGenres" class="select_style">
										<option value="">请选择...</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<label for="ba_authorname">作&nbsp;&nbsp;&nbsp;&nbsp;者&nbsp;</label>
									<input type="text" id="ba_authorname" maxlength="28" name="ba_authorname" placeholder="作者" class="text_style" onfocus="getCursor(this.id)" onblur="validateAuthorName(this.id)">
									<span id="ba_authornamespan"></span>
								</td>
								<td>
									<label for="ba_price">价&nbsp;&nbsp;&nbsp;&nbsp;格&nbsp;</label>
									<input type="text" id="ba_price" name="ba_price" placeholder="价格" class="text_style" onfocus="getCursor(this.id)" onblur=" validatePrice(this.id)">
									<span id="ba_pricespan"></span>
								</td>
							</tr>
							<tr>
								<td>
									<label for="ba_publication">出版日期&nbsp;</label>
									<input type="month" id="ba_publication" name="ba_publication" placeholder="出版日期" class="text_style" readonly="readonly">
									<span id="ba_publicationspan"></span>
								</td>
								<td>
									<label for="ba_number">图书数量&nbsp;</label>
									<input type="number" min="1" id="ba_number" maxlength="3" name="ba_number" readonly="readonly" placeholder="数量" class="text_style" onfocus="getCursor(this.id)" onblur="validateBookNumber(this.id)">
									<span id="ba_numberspan"></span>
								</td>
							</tr>
							<tr>
								<td>
									<label for="ba_earnest">违&nbsp;约&nbsp;金&nbsp;</label>
									<input type="text" id="ba_earnest" maxlength="3" name="ba_earnest" placeholder="违约金" class="text_style" onfocus="getCursor(this.id)" onblur="validateEarnest(this.id)">
									<span id="ba_earnestspan"></span>
								</td>
								<td>
									<label for="ba_status">图书状态</label>
									<input type="number" id="ba_status" name="ba_status" min="1" max="2" class="text_style" onfocus="getCursor(this.id)" onblur="validateEarnest(this.id)">
									1为在库，2为借罄<span id="ba_statusspan"></span>
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<label for="ba_abstract">图书评价</label>
									<textarea rows="3" cols="80" id="ba_abstract" placeholder="评价" name="ba_abstract" class="text_style" onfocus="getCursor(this.id)" style="resize: none;" onblur=" validateAbstruct(this.id)"></textarea>
									<span id="ba_abstractspan"></span>
								</td>
							</tr>				
							<tr>
								<td>
									<input type="submit" value="确定" class="btn_style" onclick="return validateAll();return false;">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="reset" value="重写"  class="btn_style">
								</td>
							</tr>
						</table>
					</form>
				</fieldset>
			</div>

		
		<!-- 相同isbn的某本图书下架 -->
		<div id="modify_oneBook">
			<fieldset>
				<legend>选择要修改的图书</legend>
				<table id="table_book" border="1px solid gray">
					<tr>
						<th>库存编号</th>
						<th>图书编码</th>
						<th>图书isbn编号</th>
						<th>图书地址</th>
						<th>图书完整情况</th>
						<th>操作</th>
					</tr>
			</table>
			</fieldset>			
		</div>
	</body>
</html>
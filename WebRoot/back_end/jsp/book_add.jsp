<%@ page language="java" 
				 import="java.util.*,
						com.zby.books.model.po.*,
						com.zby.books.model.service.*"
%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	List<Tag> tags=new TagService().queryTags();
	
	List<BookProvince> bookProvinces=new BookProvinceService().queryBookProvince(null,null);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%= basePath%>">
	<title>添加图书</title>
	
	<!-- CSS样式 -->
	<link rel="stylesheet" href="back_end/css/book_add.css">
	
	<!-- JavaScript数据 -->
	<script type="text/javascript" src="back_end/js/globalData.js"></script>
	<script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	
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
		
		/* 打开标签和蒙版  */
		function openDivMask(mask,div){
			document.getElementById(mask).style.display = "block";
			document.getElementById(div).style.display = "block";
		}
		
		/* 关闭标签和蒙版 */
		function closeDivMask(mask,div){
			document.getElementById(mask).style.display = "none";
			document.getElementById(div).style.display = "none";
		}
		
		/* 关闭图书所在省、市、县等*/
		function closeProvinceCityCounty(divISBN,divBook){
			document.getElementById(divISBN).style.display = "block";
			document.getElementById(divBook).style.display = "none";
		}
		
		/* 打开图书所在省、市、县等 */
		function opneProvinceCityCounty(divISBN,divBook){
			document.getElementById(divISBN).style.display = "none";
			document.getElementById(divBook).style.display = "block";
		}
		
		/* 添加标签  */
		$(function(){
			$("#decine_addTag").click(function(){
				var tagName=$("#tag_txt").val();
				var reg = /^[\u4e00-\u9fa5]+$/;
				if(tagName == ""){
					$("#tag_txtspan").text("*不能为空");
				}else if(!reg.test(tagName)){
					$("#tag_txtspan").text("*只能输入中文");
				}else{
					$("#tag_txtspan").text("");
					var url="addTag?method=getTagName";
					var args={
							"tagName":tagName,
							time:new Date()
					}
					$.getJSON(url,args,function(data){
						if(data != null){
							window.alert("添加成功,请刷新网页");
							closeDivMask("ba_mask","div_addTag");
							window.location.href="back_end/jsp/book_add.jsp";
						} 
					});
				}
			});
		});
		
		
	
		/* 添加类型 */		
		var tagId;
		$(function(){
			$("#select_addGenres").change(function(){
				tagId=$("#select_addGenres").val();
				if(tagId == ""){
					window.alert("请选择图书标签");
				}
			});			
		});
			
		$(function(){
			$("#decine_addGenres").click(function(){
				var genresName=$("#genres_txt").val();
				var reg = /^[\u4e00-\u9fa5]+$/;			
				if(genresName == ""){
					$("#genres_txtspan").text("*不能为空");
				}else if(!reg.test(genresName)){
					$("#genres_txtspan").text("*只能输入中文");
				}else{
					$("#genres_txtspan").text("");
					var url="addGenres?method=getGenresName";
					var args={
							"tagId":tagId,
							"genresName":genresName,
							time:new Date()
					}
					$.getJSON(url,args,function(data){
						if(data != null){
							window.alert("添加成功,请刷新网页");
							closeDivMask("ba_mask","div_addGenres");
							window.location.href="back_end/jsp/book_add.jsp";
						} 
					});
				}
			});
		});
		
		/* 添加图书所在地 */
		$(function(){
			$("#btn_addbookplace").click(function(){
				$("#isbn_bookcodeNumber").val("");
				$("#ba_bookProvice").val("");
				$("#ba_bookcity").val("");
				$("#ba_bookcounty").val("");
				$("#isbn_bookplace").val("");
				openDivMask("ba_mask","div_addisbn");
				
			});
		});
		
		/* 验证isbn是否重复 */
		$(function(){
			$("#ba_isbn").blur(function(){
				var _isbn = $("#ba_isbn").val();
				if(_isbn != ""){
					var url="validateIsbnRepeated?method=validateISBN"
					var args={
							"isbn":_isbn,
							time :new Date()
					}
					$.getJSON(url,args,function(data){
						if(data == "该图书已经存在"){
							$("#ba_isbnspan").text("该图书已经存在");
							$("#ba_isbn").val("");
						}
					});
				}
			});
		});
		
		
		var bookTotalNumber ;
		var bookProvinceName;
		var	bookProvinceId;
		var bookCityName;
		var bookCityId;
		var bookCountyName;
		var bookCountyId;
		
		/* 判断该图书是否存在 */
		$(function(){
			$("#isbn_isbn").blur(function(){
				var _isbn = $("#isbn_isbn").val();
				if(_isbn != ""){
					var url="bookHasExist?method=getBookISBN"
					var args={
							"isbn":_isbn,
							time :new Date()
					}
					$.getJSON(url,args,function(data){
						if(data != null){
							$("#isbn_isbnspan").text("存在图书："+data.bname);
							$("#isbn_isbnspan").css("color","green");
							bookTotalNumber=data.bnumber;
							$("#totalBookNumber").text(bookTotalNumber);
						}else{
							$("#isbn_isbnspan").text("该图书不存在,请重新输入");
							$("#isbn_isbn").val("");
							$("#totalBookNumber").text("");
							$("#isbn_isbnspan").css("color","red");
						}
					});
				}
			});
		});
		
		/* 获取bookProvince */
		$(function(){
			$("#ba_bookProvice").change(function(){
				$("#ba_bookcity option:not(:first)").remove();
				bookProvinceId= $(this).val();
				bookProvinceName=  $(this).find("option:selected").text();
				if(bookProvinceId == "_0_"){
					opneProvinceCityCounty('div_addisbn','add_bookProvince');
				}else if (bookProvinceId != null) {
					var url = "bookProvince?method=getBookprovinceId";
					var args = {
						"bookProvinceId" : bookProvinceId,
						"time" : new Date()
					}
					$.getJSON(url, args, function(data) {
						if (data.length == 0) {
							if(window.confirm("当前没有该省份下的市,是否添加")){
								opneProvinceCityCounty('div_addisbn','add_bookCity');
							}
						} else {
							for (var i = 0; i < data.length; i++) {
								var CityId = data[i].cid;
								var CityName = data[i].cname;
								$("#ba_bookcity").append(
										"<option value='"+CityId+"'>" + CityName
												+ "</option>");
							}
							$("#ba_bookcity").append("<option value='_1_' class='select_add'>添加某市</option>");
						}
					});
				} 
			});
		});	
		
		/* 查找图书所在市  */
		$(function(){
			$("#ba_bookcity").change(function(){
				$("#ba_bookcounty option:not(:first)").remove();
				bookCityId = $(this).val();
				bookCityName =  $(this).find("option:selected").text();
				if(bookCityId == "_1_"){
					opneProvinceCityCounty('div_addisbn','add_bookCity');
				}else if (bookProvinceId != null) {
					var url = "bookCity?method=getBookCityId";
					var args = {
						"bookCityId" : bookCityId,
						"time" : new Date()
					}
					$.getJSON(url, args, function(data) {
						if (data.length == 0) {
							if(window.confirm("当前没有该市下的县,是否添加")){
								opneProvinceCityCounty('div_addisbn','add_bookCounty');
							}
						} else {
							for (var i = 0; i < data.length; i++) {
								var CountyId = data[i].id;
								var CountyName = data[i].name;
								$("#ba_bookcounty").append(
										"<option value='"+CountyId+"'>" + CountyName
												+ "</option>");
							}
							$("#ba_bookcounty").append("<option value='_2_' class='select_add'>添加某县</option>");
						}
					});
				} 
			});
		});	
		
		/* 获取bookcityid */
		$(function(){
			$("#ba_bookcounty").change(function(){
				var bookCountyId=$(this).val();
				bookCountyName=$(this).find("option:selected").text();
				if(bookCountyId == "_2_"){					
					opneProvinceCityCounty('div_addisbn','add_bookCounty');
				}
			});
		});
		
		/* 选择图书所在省bookchooseProvince */
		$(function(){
			$("#bookchooseProvince").change(function(){
				$("#isbn_bookchooseCity option:not(:first)").remove();
				bookProvinceId= $(this).val();
				bookProvinceName=  $(this).find("option:selected").text();
				if (bookProvinceId != null) {
					var url = "bookProvince?method=getBookprovinceId";
					var args = {
						"bookProvinceId" : bookProvinceId,
						"time" : new Date()
					}
					$.getJSON(url, args, function(data) {
						if (data.length == 0) {
							
						} else {
							for (var i = 0; i < data.length; i++) {
								var CityId = data[i].cid;
								var CityName = data[i].cname;
								$("#isbn_bookchooseCity").append(
										"<option value='"+CityId+"'>" + CityName
												+ "</option>");
							}
						}
					});
				} 
			});
		});	
		
		var reg = /^[\u4e00-\u9fa5]+$/;
		
		/* 添加图书所在省 */
		$(function(){
			$("#decine_addbookProvince").click(function(){
				bookProvinceName=$("#isbn_bookProvince").val();
				if(bookProvinceName == ""){
					$("#isbn_bookProvincespan").text("不能为空");
				}else if(!reg.test(bookProvinceName)){
					$("#isbn_bookProvincespan").text("只能输入中文");
				}else{
					var url="addBookProvince?method=addBookProvince";
					var args={
							"bookProvinceName":bookProvinceName,
							time:new Date()
					}
					$.getJSON(url,args,function(data){
						if(data == "已经添加"){
							$("#isbn_bookProvincespan").text("“" + bookProvinceName + "”已经存在");
							$("#isbn_bookProvince").val("");
						}else if(data == "添加成功"){
							 alert("添加成功");
							 closeProvinceCityCounty('div_addisbn','add_bookProvince');
						 }
					});
				}
			});
		});
		
		/* 添加图书所在市 */
		$(function(){
			$("#decine_addbookCity").click(function(){
				bookProvinceId=$("#isbn_bookchooseProvince").val();
				bookCityName=$("#isbn_bookcity").val();				
				if(bookCityName == ""){
					$("#isbn_bookcityspan").text("不能为空");
				}else if(!reg.test(bookCityName)){
					$("#isbn_bookcityspan").text("只能输入中文");
				}else {
					var url="addBookCity?method=addBookCity";
					var args={
							"bookCityName":bookCityName,
							"bookProvinceId":bookProvinceId,
							time:new Date()
					}
					$.getJSON(url,args,function(data){
						if(data == "已经存在"){
							$("#isbn_bookcityspan").text("该市已经存在");
						}else if(data == "添加成功"){
							alert("添加成功,请刷新页面");
							closeProvinceCityCounty('div_addisbn','add_bookCity');						
						}
					});
				}
			});
		});
		
		/* 添加图书所在县 */
		$(function(){
			$("#decine_addbookCounty").click(function(){
				bookCityId = $("#isbn_bookchooseCity").val();
				bookCountyName = $("#isbn_bookcounty").val();
				if(bookCityId == ""){
					$("#isbn_bookcountyspan").text("请选择图书所在市");
				}else if(bookCountyName == ""){
					$("#isbn_bookcountyspan").text("不能为空");
				}else if(!reg.test(bookCountyName)){
					$("#isbn_bookcountyspan").text("只能输入中文");
				}else{
					var url="addBookCounty?method=addBookCounty";
					var args={
							"bookCountyName":bookCountyName,
							"bookCityId":bookCityId,
							time:new Date()
					}
					$.getJSON(url,args,function(data){
						if(data == "已经存在"){
							$("#isbn_bookcityspan").text("该县已经存在");
						}else if(data == "添加成功"){
							alert("添加成功,请刷新页面");
							closeProvinceCityCounty('div_addisbn','add_bookCounty');						
						}
					});
				}
			});
		});
		
		/* 添加图书的isbn号 */
		var bookCodeNumber;
		$(function(){
			$("#decine_addbookplace").click(function(){
				var isbn = $("#isbn_isbn").val();
				bookProvinceName= $("#ba_bookProvice").find("option:selected").text();
				bookCityName=$("#ba_bookcity").find("option:selected").text();
				bookCountyName=$("#ba_bookcounty").find("option:selected").text();
				var particularAddress=$("#isbn_bookplace").val();
				var tempNumber = $("#totalBookNumber").text();
				bookCodeNumber=$("#isbn_bookcodeNumber").val();
				if(isbn == ""){
					$("#isbn_isbnspan").text("不能为空");
				}else if(particularAddress == ""){
					$("#isbn_bookplacespan").text("具体地址不能为空");
				}else if(bookCodeNumber == ""){
					$("#isbn_bookcodeNumberspan").text("不能为空");
				}else if(bookCountyId == ""){
					$("#isbn_bookplacespan").text("请选择省市县");
				}else if(tempNumber == "-1"){
					$("#isbn_bookcodeNumberspan").text("请重新选择数量");
				}else {
					$("#isbn_bookcodeNumber").val("");
					var url="addIsbnInfo?method=addISBN";
					var args = {
							"isbn":isbn,
							"bookProvinceName":bookProvinceName,
							"bookCityName":bookCityName,
							"bookCountyName":bookCountyName,
							"particularAddress":particularAddress,
							"bookCodeNumber":bookCodeNumber,
							time:new Date()
					}
					$.getJSON(url,args,function(data){
						if(data == "添加成功!"){
							if(window.confirm("是否继续添加图书？")){
								$("#isbn_bookcodeNumber").val("");
								$("#ba_bookProvice").val("");
								$("#ba_bookcity").val("");
								$("#ba_bookcounty").val("");
								$("#isbn_bookplace").val("");
							}else{
								closeDivMask('ba_mask','div_addisbn');
							}
						}
					});
				}
			});
		});
		
		$(function(){
			$("#isbn_bookcodeNumber").keyup(function(){
				bookCodeNumber=$(this).val();
				var temp= $("#totalBookNumber").text();
				var sub=temp-bookCodeNumber;
				if(bookCodeNumber<=0 ){
					$("#isbn_bookcodeNumberspan").text("不能小于0");
					$("#isbn_bookcodeNumber").val("");
				}
				if(bookCodeNumber == ""){
					$("#totalBookNumber").text(bookTotalNumber)
				}else{
					if(sub < 0){
						alert("您所添加的图书数量，不能超过可添加的图书数量");
						$("#totalBookNumber").text("-1");
					}else{
						$("#totalBookNumber").text(sub);
						
					}
				}
				
			});
		});
	</script>
	
	<!-- 添加图书 -->
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

	/* 图书编号 */
	function validateIsbn(objId){
		var reg=/^\d{13}$/;
	 return	validate(objId, reg);
	}
	
	/* 图书书名 */
	function validateBookName(objId){
	 return	validate(objId, null);
	}
	
	/* 作者 */
	function validateAuthorName(objId){
		return	validate(objId,null);
	}
	
	/* 价格 */
	function validatePrice(objId){
		var reg=/^[0-9]+(.[0-9]{2})?$/;
		return validate(objId, reg);
	}
	
	/* 出版日期 */
	function validatePublishdate(objId){
		return validate(objId,null);
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
	
	/* 图书图片 */
	function validateImg(objId){
		return validate(objId,null);
	}
	
	/* 图书评价 */
	function validateAbstruct(objId){
		return validate(objId, null);
	}
	
	function validateAll(){
		if(validateIsbn("ba_isbn")==false || validateBookName("ba_bookname")==false
				||validateAuthorName("ba_authorname")==false || validatePrice("ba_price")
				||validatePublishdate("ba_publication")==false || validateBookNumber("ba_number")==false
				||validateEarnest("ba_earnest")==false || validateAbstruct("ba_abstract")==false){
			return false;
		}
		return true;
	}
	</script>
</head>
<body onload="showCursor('ba_isbn');">

  <!-- 图书添加界面 -->
	<div id="ba_bookAdd" class="div_style">
		<form action="ba_bookAdd" method="post" id="ba_form">
			<table class="tb_book">
				<tr>
					<td>
						<label for="ba_isbn">图书编号&nbsp;</label>
						<input type="text" id="ba_isbn" name="ba_isbn" maxlength="13" placeholder="编号" class="text_style" onfocus="getCursor(this.id)" onblur="validateIsbn(this.id)">
						<span id="ba_isbnspan"></span>
					</td>
					<td>
						<label for="ba_bookname">书&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;</label>
						<input type="text" id="ba_bookname" maxlength="48" name="ba_bookname" placeholder="书名" class="text_style" onfocus="getCursor(this.id)" onblur="validateBookName(this.id)">
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
						<input type="button" id="addTag" class="btn_style" value="添加标签" onclick="openDivMask('ba_mask','div_addTag')">
					</td>
					<td>
						<label for="ba_chooseGenres">选择类型</label>
						<select id="ba_chooseGenres" name="ba_chooseGenres" class="select_style">
							<option value="">请选择...</option>
						</select>
						<input type="button" id="addGenrs" class="btn_style" value="添加类型" onclick="openDivMask('ba_mask','div_addGenres')">
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
						<input type="date" id="ba_publication" name="ba_publication" placeholder="出版日期" class="text_style" onfocus="getCursor(this.id)" onblur="validatePublishdate(this.id)">
						<span id="ba_publicationspan"></span>
					</td>
					<td>
						<label for="ba_number">图书数量&nbsp;</label>
						<input type="number" min="1" id="ba_number" maxlength="3" name="ba_number" placeholder="数量" class="text_style" onfocus="getCursor(this.id)" onblur="validateBookNumber(this.id)">
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
						<label for="bookImg">图书图片</label>
						<input type="file" name="bookImg" id="bookImg" placeholder="图片" class="text_style" onfocus="getCursor(this.id)" onblur="validateImg(this.id)">
						<span id="bookImgspan"></span>
					</td>
				</tr>
				<tr>
					<td colspan="6">
						<label for="ba_abstract">图书评价</label>
						<textarea rows="3" cols="80" maxlength="220" id="ba_abstract" placeholder="评价" name="ba_abstract" class="text_style" onfocus="getCursor(this.id)" style="resize: none;" onblur=" validateAbstruct(this.id)"></textarea>
						<span id="ba_abstractspan"></span>
					</td>
				</tr>				
				<tr>
					<td>
						<input type="submit" value="确定" class="btn_style" onclick="return validateAll();return false;">&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="添加图书所在地" id="btn_addbookplace" class="btn_style">
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- 添加图书的isbn数据 -->
	<div id="div_addisbn" class="div_style">
		<table class="tb_book">
			<tr>
				<td>
					<label for="isbn_isbn">图书编号</label>
					<input type="text" id="isbn_isbn" name="isbn_isbn" placeholder="图书编号" class="text_style" onfocus="getCursor(this.id)">
					<span id="isbn_isbnspan"></span>
				</td>
			</tr>
			<tr>
				<td>
					<label>书省市县</label>
					<select id="ba_bookProvice"  class="select_style">
						<option value="">请选择...</option>
						<c:forEach var="bookProvice" items="<%= bookProvinces %>">
							<option value="${bookProvice.pid }">${bookProvice.pname }</option>
						</c:forEach>
						<option value="_0_" class="select_add">添加省份</option>
					</select>
					&nbsp;
					<select id="ba_bookcity" class="select_style">
						<option value="">请选择...</option>
					</select>&nbsp;
					<select id="ba_bookcounty" class="select_style">
						<option value="">请选择...</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<label for="isbn_bookplace">具体地址</label>
					<input type="text" id="isbn_bookplace" name="isbn_bookplace" placeholder="具体地址" class="text_style" onfocus="getCursor(this.id)">
					<span id="isbn_bookplacespan"></span>
				</td>
			</tr>
			<tr>
				<td>
					<label for="isbn_bookcodeNumber">地区数量</label>
					<input type="number" id="isbn_bookcodeNumber" name="isbn_bookcodeNumber" placeholder="地区数量" min="1" class="text_style" onfocus="getCursor(this.id)">
					<span id="isbn_bookcodeNumberspan"></span>
				</td>
			</tr>
			<tr>
				<td>
					<label id="label_number">您可以添加的图书量:&nbsp;<span id="totalBookNumber" style="color:red;font:bold 20px/30px '楷体'"></span></label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" id="decine_addbookplace" class="btn_style" value="确认">
					<input type="button" id="cancel_addbookplace" class="btn_style" value="取消" onclick="closeDivMask('ba_mask','div_addisbn')">
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 添加蒙版 -->
	<div id="ba_mask"></div>
	
	<!-- 添加标签  -->
	<div id="div_addTag" class="div_style">
		<label for="tag_txt">图书标签:&nbsp;</label>
		<input type="text" id="tag_txt" placeholder="图书标签" class="text_style" onfocus="getCursor(this.id)">
		<span id="tag_txtspan"></span>
		<br>
		<input type="button" id="decine_addTag" class="btn_style" value="确认">
		<input type="button" id="cancel_addTag" class="btn_style" value="取消" onclick="closeDivMask('ba_mask','div_addTag')">
	</div>
	
	<!-- 添加类型 -->
	<div id="div_addGenres" class="div_style">
		<table >
			<tr>
				<td>
					<label for="select_addGenres">选择标签</label>
					<select id="select_addGenres" class="select_style">
						<option value="">请选择...</option>
						<c:forEach items="<%=tags %>" var="tag">
							<option value="${tag.tid}">${ tag.tname}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<label for="genres_txt">图书类型:&nbsp;</label>
					<input type="text" id="genres_txt" placeholder="图书类型" class="text_style" onfocus="getCursor(this.id)">
					<span id="genres_txtspan"></span>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" id="decine_addGenres" class="btn_style" value="确认">
					<input type="button" id="cancel_addGenres" class="btn_style" value="取消" onclick="closeDivMask('ba_mask','div_addGenres')">
				</td>
			</tr>
		</table>
	</div>

	<!-- 添加图书所在省 -->
	<div id="add_bookProvince" class="div_style">
		<table class="tb_book">
			<tr>
				<td>
					<label for="isbn_bookProvince">图书所在省份：</label>
					<input type="text" id="isbn_bookProvince" name="isbn_bookProvince" placeholder="图书所在省" class="text_style" onfocus="getCursor(this.id)">
					<span id="isbn_bookProvincespan"></span>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" id="decine_addbookProvince" class="btn_style" value="确认">
					<input type="button" id="cancel_addbookProvince" class="btn_style" value="取消" onclick="closeProvinceCityCounty('div_addisbn','add_bookProvince')">
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 添加图书所在市 -->
	<div id="add_bookCity" class="div_style">
		<table class="tb_book">
			<tr>
				<td>
					<label for="isbn_bookchooseProvince">选择省份：</label>
					<select id="isbn_bookchooseProvince" name="isbn_bookchooseProvince" class="select_style">
						<c:forEach items="<%=bookProvinces %>" var="bookProvince">
							<option value="${bookProvince.pid }">${bookProvince.pname }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<label for="isbn_bookcity">图书所在市：</label>
					<input type="text" id="isbn_bookcity" name="isbn_bookcity" placeholder="图书所在市" class="text_style" onfocus="getCursor(this.id)">
					<span id="isbn_bookcityspan"></span>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" id="decine_addbookCity" class="btn_style" value="确认">
					<input type="button" id="cancel_addbookCity" class="btn_style" value="取消" onclick="closeProvinceCityCounty('div_addisbn','add_bookCity')">
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 图书所在县 -->
	<div id="add_bookCounty" class="div_style">
		<table class="tb_book">
			<tr>
				<td>
					<label for="bookchooseProvince">选择省市：</label>
					<select id="bookchooseProvince" name="bookchooseProvince" class="select_style">
						<c:forEach items="<%=bookProvinces %>" var="bookProvince">
							<option value="${bookProvince.pid }">${bookProvince.pname }</option>
						</c:forEach>
					</select>&nbsp;&nbsp;
					<select id="isbn_bookchooseCity" name="isbn_bookchooseCity" class="select_style">
						<option value="">请选择...</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<label for="isbn_bookcounty">图书所在县：</label>
					<input type="text" id="isbn_bookcounty" name="isbn_bookcounty" placeholder="图书所在县" class="text_style" onfocus="getCursor(this.id)">
					<span id="isbn_bookcountyspan"></span>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" id="decine_addbookCounty" class="btn_style" value="确认">
					<input type="button" id="cancel_addbookCounty" class="btn_style" value="取消" onclick="closeProvinceCityCounty('div_addisbn','add_bookCounty')">
				</td>
			</tr>
		</table>
	</div>
	
</body>
</html>
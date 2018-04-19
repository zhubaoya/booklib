<%@ page language="java" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String uid=request.getParameter("uid");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%=basePath%>">
	<title>图书信息</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  
  <script src="fore_end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
	<script src="fore_end/js/Area.js" type="text/javascript"></script>
	<script src="fore_end/js/AreaData_min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function (){
			initComplexArea('seachprov', 'seachcity', 'seachdistrict', area_array, sub_array, '0', '0', '0');
		});

		//得到地区码
		function getAreaID(){
			var area = 0;          
			if($("#seachdistrict").val() != "0"){
				area = $("#seachdistrict").val();                
			}else if ($("#seachcity").val() != "0"){
				area = $("#seachcity").val();
			}else{
				area = $("#seachprov").val();
			}
			return area;
		}

		function showAreaID() {
			//地区码
			var areaID = getAreaID();
			//地区名
			var areaName = getAreaNamebyID(areaID) ;
			alert("您选择的地区码：" + areaID + "      地区名：" + areaName);            
		}

		//根据地区码查询地区名
		function getAreaNamebyID(areaID){
			var areaName = "";
			if(areaID.length == 2){
				areaName = area_array[areaID];
			}else if(areaID.length == 4){
				var index1 = areaID.substring(0, 2);
				areaName = area_array[index1] + sub_array[index1][areaID];
			}else if(areaID.length == 6){
				var index1 = areaID.substring(0, 2);
				var index2 = areaID.substring(0, 4);
				areaName = area_array[index1] + sub_array[index1][index2]  + sub_arr[index2][areaID];
			}
			return areaName;
		}
		
		/* 验证数据 */
		function address_validate(objId, reg) {
			var obj = document.getElementById(objId);
			var objValue = obj.value;
			var objSpane = document.getElementById(objId + "span");
			if (objValue == "") {
				objSpane.innerHTML = obj.placeholder + "不能为空！";
				return false;
			}else if (!reg.test(objValue)) {
				objSpane.innerHTML = "不符合" + obj.placeholder + "格式";
				return false;
			} else {
				objSpane.innerHTML = "";
				return true;
			}
		}

		// 校验用户名
		function address_validateUsername() {
			var reg = /^[\u4e00-\u9fa5]{2,50}$/;
			return address_validate("address_uname", reg);
		}
		
		/* 手机号码 */
		function address_validatePhone() {
			var reg = /^1(3|4|5|7|8)\d{9}$/;
			return address_validate("address_phone", reg);
		}
		
		function address_validateAddress(){
			address_validate("address_address", null); 
		}
		
		function address_validate_all(){
			if(address_validateAddress()==false||address_validatePhone()==false||address_validateUsername()==false){
				return false;
			}
			return true;
		}
		
		function getAreaName(){
			var areaID = getAreaID();
			//地区名
			var areaName = getAreaNamebyID(areaID) ;
			if(areaName==""){
				document.getElementById("address_addressspan").innerHTML="请选择省市县";
				return false;
			}else{
				document.getElementById("address_address").value=areaName;
				return true;
			}
			
		}
	</script>
	<script type="text/javascript" src="back_end/js/globalData.js"></script>
	<style type="text/css">
		#address_info{
			width: 100%;
			border-radius:10px;
		}
		#address_info input,#address_info select{
			font: normal 16px/28px "仿宋";
			border-radius:8px;
		}
		#address_info label{
			font: normal 17px/28px "仿宋";
			border-radius:8px;
		}
		#address_info span{
			font:normal 15px/25px "仿宋";
			color:red; 
		}
	</style>
</head>
<body onload="showCursor('address_uname')">
	<div id="address_info">
		<center >
			<form action="addUserAddress" method="post" >
				<input type="hidden" id="address_uid" name="address_uid" value="<%=uid%>">		
				<input type="hidden" id="address_sum" name="address_sum" >
				<table id="table" >		
				<tr>
					<td>
						<label for="address_uname">用&nbsp;户&nbsp;名：</label>
					</td>
					<td>
						<input type="text" name="address_uname" id="address_uname"  maxlength="48" placeholder="用户名" onfocus=" getCursor(this.id)" onblur="address_validateUsername()">
						<span id="address_unamespan" ></span>
					</td>
				</tr>		
				<tr>
					<td>
						<label for="address_phone">手机号码：</label>
					</td>
					<td>
				  	<input type="text" name="address_phone" id="address_phone"  maxlength="11" placeholder="手机号" onfocus=" getCursor(this.id)" onblur="address_validatePhone()">
          	<span id="address_phonespan" ></span>
					</td>
				</tr>
				<tr>
					<td>
						<label>选择地址:</label>
					</td>
					<td>
						<select id="seachprov" name="seachprov" onChange="changeComplexProvince(this.value, sub_array, 'seachcity', 'seachdistrict');"></select>&nbsp;&nbsp;
						<select id="seachcity" name="homecity" onChange="changeCity(this.value,'seachdistrict','seachdistrict');"></select>&nbsp;&nbsp;
						<span id="seachdistrict_div"><select id="seachdistrict" name="seachdistrict"></select></span>
					</td>
				</tr>		
				<tr>
					<td>
						<label for="address_address">收货地址：</label>
					</td>
					<td>
				   <input type="text" name="address_address" id="address_address"  maxlength="98"  placeholder="收货地址" onfocus="getAreaName()" onblur="address_validateAddress()">
           <span id="address_addressspan" ></span>
					</td>
				</tr>
				<tr>
					<td colspan="2"  align="center">
						<input type="submit" value="添加" id="confirm" onclick="return address_validate_all();return false;">
						<input type="reset" value="取消" id="cancel" >
					</td>
				</tr>
			</table>
		</form>
	</center>
</div>	
</body>
</html>
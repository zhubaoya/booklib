/**
 * 全局的初始化显示光标
 */
function showCursor(objId){
	document.getElementById(objId).focus();
}

function getCursor(objId) {
	document.getElementById(objId + "span").innerHTML = "";
}
<%
	String uid=session.getAttribute("fore_uid").toString();
	String uname=session.getAttribute("fore_name").toString();
	
	if(uname != null && uid != null){
		session.setAttribute("fore_uid", null);
		session.setAttribute("fore_name", null);
		response.sendRedirect(request.getContextPath()+"/fore_end/jsp/fore_main.jsp");
	}
%>
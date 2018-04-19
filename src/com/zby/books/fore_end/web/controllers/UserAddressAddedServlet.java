package com.zby.books.fore_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zby.books.model.po.UserAddress;
import com.zby.books.model.service.CommentsService;
import com.zby.books.model.service.UserAddressService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

@SuppressWarnings(value = "all")
public class UserAddressAddedServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String uid = req.getParameter("address_uid");
		String addres = req.getParameter("address_address");
		String uname = req.getParameter("address_uname");
		String uphone = req.getParameter("address_phone");

		UserAddress address = new UserAddress(addres, uid, uname, uphone);
		int result = new UserAddressService().insertUserAddress(address);

		resp.setContentType("text/html; charset=utf-8"); // 设置编码类型
		PrintWriter out = resp.getWriter();

		if (result == 1) {
			out.println("<script>alert('添加成功，请您刷新网页');self.close();</script>");
		} else {
			out.println("<script>alert('服务器繁忙，请稍后添加');self.close();</script>");
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodName = req.getParameter("method");
		new ReflectJSPServlet().excuteReflect(this, methodName, req, resp);
	}
	
	private void deleteCommenById(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException{
		
		int id=Integer.parseInt(req.getParameter("id"));
		
		int result=new CommentsService().deleteCommentsById(id);
		
		resp.setContentType("text/html; charset=utf-8"); // 设置编码类型
		PrintWriter out = resp.getWriter();

		String deleteInfo=null;
		if(result==1){
			resp.sendRedirect(req.getContextPath()+"/fore_end/jsp/delete_success.jsp");
		}else{
			resp.sendRedirect(req.getContextPath()+"/fore_end/jsp/delete_fail.jsp");
		}
	}
}

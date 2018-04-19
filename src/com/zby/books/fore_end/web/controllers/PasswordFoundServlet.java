package com.zby.books.fore_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.User;
import com.zby.books.model.service.UserService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

@SuppressWarnings("all")
public class PasswordFoundServlet extends HttpServlet {

	private String uname;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String newPass=req.getParameter("def_password");
		
		int result=new UserService().updateUserPass(newPass, uname);
		
		resp.setContentType("text/html; charset=utf-8"); // 设置编码类型

		PrintWriter out=resp.getWriter();
		
		if (result==1) {
			out.println("<script>alert('更新成功，请您登陆');self.close();</script>");
		} else {
			out.println("<script>alert('服务器繁忙，请稍后更新');self.close();</script>");
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method").toString();

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	/**
	 * 通过反射执行
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月1日 下午3:14:32
	 * @param request
	 * @param response
	 */
	private void chkUserName(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		uname = UTF8Changer.changeIntoUTF8(request
				.getParameter("find_name"));

		User user = new User(null, uname, null);

		User hasUser = new UserService().queryUser(user);

		response.setContentType("text/html;charset=utf-8");

		if (hasUser != null) {
			
			try {
				response.getWriter().print(
						new ObjectMapper().writeValueAsString("该用户名存在"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		} else {
			try {
				response.getWriter().write(
						new ObjectMapper().writeValueAsString("用户名不存在"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		}

	}

}

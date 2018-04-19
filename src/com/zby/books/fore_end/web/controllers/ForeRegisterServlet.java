package com.zby.books.fore_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.User;
import com.zby.books.model.service.UserService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

/**
 * 前台登录信息
 * 
 * @author 祝宝亚
 * @date 2018年3月1日
 * 
 */
@SuppressWarnings("all")
public class ForeRegisterServlet extends HttpServlet {

	private String uname;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);

	}

	/**
	 * 检查用户名是否重复
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月1日 下午11:22:18
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void chkUserName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		uname = UTF8Changer.changeIntoUTF8(request.getParameter("nickname"));

		User user = new User(null, uname, null);

		User hasUser = new UserService().queryUser(user);

		response.setContentType("text/html;charset=utf-8");

		if (hasUser != null) {

			try {
				response.getWriter().print(
						new ObjectMapper().writeValueAsString("该用户名已经存在"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		} else {
			try {
				response.getWriter().write(
						new ObjectMapper().writeValueAsString(null));
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String uid = req.getParameter("user_id");
		String newpass = req.getParameter("register_password");
		String uphone = req.getParameter("phone");
		String uemail = req.getParameter("email");
		Integer sex = Integer.parseInt( req.getParameter("sex").toString());
		
		System.out.println(uid+"\t"+newpass+"\t"+uphone+"\t"+uemail+"\t"+sex+"\t"+uname);
		
		User user=new User(uid, uname, newpass, uphone, uemail, sex, null);
		
		int result=new UserService().intserUser(user);
		
		PrintWriter out = resp.getWriter();

		resp.setContentType("text/html;charset=utf-8");
			
		if (result==1) {
			out.println("<script>alert('注册成功,前去登录');window.location.href='"+req.getContextPath()+"/fore_end/jsp/fore_login.jsp'</script>");
			return;
		}else {
			out.println("<script>alert('网络繁忙,请稍后注册');window.location.href='"+req.getContextPath()+"/fore_end/jsp/fore_main.jsp'</script>");
			return;
		}
	}
}

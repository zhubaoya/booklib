package com.zby.books.back_end.web.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zby.books.contents.GlobalVariable;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Admin;
import com.zby.books.model.po.Press;
import com.zby.books.model.service.AdminService;
import com.zby.books.model.service.PressService;
import com.zby.books.utils.cryption.Encryption;

/**
 * 后台登录页面
 * 
 * @author 祝宝亚
 * @date 2018年2月28日
 * 
 */
public class BackLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		resp.setContentType("text/html;charset=utf-8");

		String uname = req.getParameter(UTF8Changer
				.changeIntoUTF8("back_login_name"));
		String upass = Encryption.encrypt(req.getParameter("back_login_pass"));
		String pressname = req.getParameter("back_login_press");


		HttpSession session = req.getSession();
		HttpSession session2 = req.getSession();
		
		// 展示用户信息
		Press press = new PressService().queryPress(null, pressname);
		if (press != null) {

			Integer pid = press.getPid();

			Admin admin = new Admin(uname, upass, pid.toString());

			boolean result = new AdminService().queryAdmin(admin) != null ? true
					: false;

			// 给pressid赋初值
			GlobalVariable.pressId = pid;
			GlobalVariable.pressName = pressname;


		
			if (result) {
				session.setAttribute("pressname", pressname);
				session.setAttribute("uname", uname);
				resp.sendRedirect(req.getContextPath()
						+ "/back_end/jsp/back_main.jsp?pressId=" + pid
						+ "&pressName=" + GlobalVariable.pressName);
				return;
			} else {
				session.setAttribute("back_login_error", "用户名,密码或出版社名错误");
				resp.sendRedirect(req.getContextPath()
						+ "/back_end/jsp/back_login.jsp");
			}
		}else{
			session.setAttribute("back_login_error", "用户名,密码或出版社名错误");
			resp.sendRedirect(req.getContextPath()
					+ "/back_end/jsp/back_login.jsp");
		}
	}
}

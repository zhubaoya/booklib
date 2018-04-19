package com.zby.books.fore_end.web.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zby.books.model.po.User;
import com.zby.books.model.service.UserService;
import com.zby.books.utils.MyDateTime;
import com.zby.books.utils.cryption.Encryption;

@SuppressWarnings("all")
public class ForeLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String uname = req.getParameter("login_username");
		String upass = Encryption.encrypt(req.getParameter("login_password"));

		User user=new User(null, uname, upass);
		UserService service=new UserService();	
		
		User user1 = service.queryUser(user);
		
		resp.setContentType("text/html;charset=utf-8");
				
		HttpSession foreUid = req.getSession();
		HttpSession foreUname=req.getSession();
		
		if (user1 != null) {
			foreUid.setAttribute("fore_uid",user1.getUid());
			foreUid.setMaxInactiveInterval(86400);
			
			foreUname.setAttribute("fore_name", user1.getUname());
			foreUname.setMaxInactiveInterval(86400);
			
			updateUser(user1);
			
			resp.sendRedirect(req.getContextPath()+"/fore_end/jsp/fore_main.jsp");
			return ;
		}else{
			foreUname.setAttribute("fore_login_err", "用户名或密码失败");
			resp.sendRedirect(req.getContextPath()+"/fore_end/jsp/fore_login.jsp");
		}
	}
	
	/**
	 * 更新登录时间
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月1日 下午3:37:11 
	 * @param service
	 * @param user1
	 */
	private void updateUser(User user1){
		User user2 =new User(user1.getUid(), null, null, null, new MyDateTime().getDate(), null, null, null);
		new UserService().updateUser(user2);
	}
}

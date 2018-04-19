package com.zby.books.fore_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.model.po.Account;
import com.zby.books.model.po.OrderForm;
import com.zby.books.model.service.AccountService;
import com.zby.books.model.service.CommentsService;
import com.zby.books.model.service.OrderFormService;
import com.zby.books.model.service.UserAddressService;
import com.zby.books.model.service.UserService;
import com.zby.books.utils.MyDateTime;
import com.zby.books.utils.cryption.Descryption;
import com.zby.books.utils.reflect.ReflectJSPServlet;

@SuppressWarnings("all")
public class ForeLogOffServlet extends HttpServlet {

	private StringBuilder sendInfo;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	private void checkOrderForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String uid = req.getParameter("uid");

		PrintWriter out = resp.getWriter();

		HttpSession session = req.getSession();

		OrderForm form = new OrderForm(null, uid, null, null);
		List<OrderForm> forms = new OrderFormService().queryOrderForm(form);

		System.out.println(forms);
		
		Account account = new Account(uid, null);
		List<Account> accounts = new AccountService().queryAccount(account);

		System.out.println(forms.size());
		
		if (forms.size()!= 0) {
			sendInfo = new StringBuilder("您还有图书未归还：\r\n");
			for (OrderForm form2 : forms) {
				sendInfo.append(form2.getBookname() + "  借书时间: "
						+ new MyDateTime().dateToString(form2.getLendTime(),3)
						+ "\r\n");
			}

			sendInfo.append("请归还图书后,再注销该账号");

			out.println(new ObjectMapper().writeValueAsString(sendInfo));
			return ;

		} else {
			new UserService().deleteUser(uid);
			new UserAddressService().deleteUserAddressByUid(uid);
			new CommentsService().deleteCommentsByUid(uid);

			out.println(new ObjectMapper().writeValueAsString("删除成功"));

			if (session.getAttribute("fore_uid") != null
					&& session.getAttribute("fore_name") != null) {
				session.setAttribute("fore_uid", null);
				session.setAttribute("fore_name", null);
			}
			return ;
		}
		
	}
}

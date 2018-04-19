package com.zby.books.back_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.contents.GlobalVariable;
import com.zby.books.contents.Status;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Account;
import com.zby.books.model.po.Book;
import com.zby.books.model.po.ISBN;
import com.zby.books.model.po.OrderForm;
import com.zby.books.model.po.User;
import com.zby.books.model.service.AccountService;
import com.zby.books.model.service.BookService;
import com.zby.books.model.service.ISBNService;
import com.zby.books.model.service.OrderFormService;
import com.zby.books.model.service.UserService;
import com.zby.books.utils.MyDateTime;
import com.zby.books.utils.reflect.ReflectJSPServlet;

/**
 * 查询订单状态
 * 
 * @author 祝宝亚
 * @date 2018年4月1日
 * 
 */
@SuppressWarnings("all")
public class OrderFormServlet extends HttpServlet {

	private String bisbn;
	private String uid;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	/**
	 * 
	 * 查询订单状态
	 * 
	 * @author 祝宝亚
	 * @time 2018年4月1日 下午10:12:22
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void queryorderforms(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {

		String bookName = UTF8Changer.changeIntoUTF8(req
				.getParameter("bookName"));
		String username = UTF8Changer.changeIntoUTF8(req
				.getParameter("username"));
		String lendFrom = req.getParameter("lendtimeFrom");
		String lendTo = req.getParameter("lendtimeTo");
		Integer bStatus = Integer.parseInt(req.getParameter("bStatus"));

		if (!bookName.equals("")) {
			Book book = new Book(null, null, null, bookName, null, null);
			bisbn = new BookService().queryBook(book).getBisbn();
		}
		if (!username.equals("")) {
			User user = new User(null, username, null);
			uid = new UserService().queryUser(user).getUid();
		}

		OrderForm form = new OrderForm(uid, bisbn, bStatus,
				GlobalVariable.pressName, lendTo, lendFrom);

		List<OrderForm> forms = new OrderFormService()
				.queryBackEndOrderFroms(form);

		PrintWriter out = resp.getWriter();
		if (forms != null) {
			out.print(new ObjectMapper().writeValueAsString(forms));
			return;
		}
	}

	/**
	 * 更新订单信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年4月2日 上午12:09:50
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void modifyOrderform(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {

		Integer id = Integer.parseInt(req.getParameter("id"));
		String uname = UTF8Changer.changeIntoUTF8(req.getParameter("uname"));
		String uphone = req.getParameter("phone");
		String address = UTF8Changer
				.changeIntoUTF8(req.getParameter("address"));

		OrderForm form = new OrderForm(id, uphone, address, uname, null);

		int result = new OrderFormService().updateOrderForm(form);

		if (result == 1) {
			resp.getWriter().print(
					new ObjectMapper().writeValueAsString("更新成功"));
		}
	}

	/**
	 * 归还图书
	 * 
	 * @author 祝宝亚
	 * @time 2018年4月2日 下午2:30:07
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void returnBook(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		Integer orderId = Integer.parseInt(req.getParameter("id"));
		uid = req.getParameter("uid");
		String bname = UTF8Changer.changeIntoUTF8(req.getParameter("bname"));
		String code = req.getParameter("code");
		float price = Float.parseFloat(req.getParameter("price"));
		int intact = Integer.parseInt(req.getParameter("bookintact"));

		// System.out.println(orderId+uid+bname+code+price+intact);

		float fee = getFee(intact, price);
		float maxMoney = new AccountService().queryAccountTotalMoney(uid);

		PrintWriter out = resp.getWriter();
		ObjectMapper mapper = new ObjectMapper();

		String isbn=new BookService().queryBook(new Book(null, null, null, bname, null, null)).getBisbn();
		
		if (fee > maxMoney) {
			out.print(mapper.writeValueAsString(1)); // 余额不足，不能退款
			return ;
		} else {
			OrderForm form = new OrderForm(orderId, null, null, null,
					Status.two);
			int result = new OrderFormService().updateOrderForm(form);

			if (result == 1) {
				new ISBNService().updateISBN(new ISBN(null, code, Status.one, intact));
				new BookService().updateBookNumberPlus(isbn);
				new AccountService().insertAccount(new Account(uid, price, new MyDateTime().getDate(), 1, (float) 0.00));
				if(fee!= 0){
					new AccountService().insertAccount(new Account(uid, Float.parseFloat(("-"+fee)), new MyDateTime().getDate(), 2, (float) 0.00)); 
				}
				out.print(mapper.writeValueAsString(2)); // 还书成功
			}
		}

	}

	/**
	 * 根据前台出来的数值，来判断赔偿多少钱
	 * 
	 * @author 祝宝亚
	 * @time 2018年4月2日 下午5:30:00
	 * @param intact
	 * @return
	 */
	private float getFee(int intact, float price) {
		float fee = 0;
		switch (intact) {
		case 1:
			fee = 0;
			break;
		case 2:
			fee = 1;
			break;
		case 3:
			fee = price;
			break;
		case 4:
			fee = 2 * price;
			break;
		default:
			break;
		}
		return fee;
	}
}

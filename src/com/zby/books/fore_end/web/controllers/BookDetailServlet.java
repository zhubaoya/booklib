package com.zby.books.fore_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.contents.Status;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Account;
import com.zby.books.model.po.Comment;
import com.zby.books.model.po.ContactAdmin;
import com.zby.books.model.po.ISBN;
import com.zby.books.model.po.OrderForm;
import com.zby.books.model.po.Press;
import com.zby.books.model.service.AccountService;
import com.zby.books.model.service.BookService;
import com.zby.books.model.service.CommentsService;
import com.zby.books.model.service.ContactAdminService;
import com.zby.books.model.service.ISBNService;
import com.zby.books.model.service.OrderFormService;
import com.zby.books.utils.MyDateTime;
import com.zby.books.utils.reflect.ReflectJSPServlet;

@SuppressWarnings(value = "all")
public class BookDetailServlet extends HttpServlet {

	private String uid;
	private String isbn;
	private String bookname;
	PrintWriter out;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	/**
	 * 
	 * 添加评论
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月10日 下午2:21:35
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addBookComment(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		uid = req.getParameter("uid");
		bookname = UTF8Changer.changeIntoUTF8(req.getParameter("bookname"));
		isbn = req.getParameter("isbn");

		String comm = UTF8Changer.changeIntoUTF8(req.getParameter("comment"));

		Comment commentQueried = new Comment(uid, isbn);
		Comment commentInserted = new Comment(uid, isbn, comm,
				new MyDateTime().getDate(), bookname);

		List<Comment> comments = new CommentsService()
				.queryComments(commentQueried);

		if (comments.size() != 0) {
			out.print(new ObjectMapper().writeValueAsString("已经评论"));
			return;
		} else {
			int result = new CommentsService().insertComments(commentInserted);

			if (result == 1) {
				out.print(new ObjectMapper().writeValueAsString("评论成功"));

			} else {
				out.print(new ObjectMapper().writeValueAsString("评论失败"));
			}
		}
	}

	/**
	 * 在生成订单时，加入同步锁的，防止，多人同时订同一本书
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月16日 下午1:57:24 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private synchronized void generateOrderForm(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		uid = req.getParameter("uid");
		String username = UTF8Changer.changeIntoUTF8(req
				.getParameter("username"));
		String userphone = req.getParameter("userphone");
		String userAddress = UTF8Changer.changeIntoUTF8(req
				.getParameter("userAddress"));
		String bookcode = req.getParameter("bookcode");
		bookname = UTF8Changer.changeIntoUTF8(req.getParameter("bookname"));
		isbn = req.getParameter("isbn");
		Float recharge = Float.parseFloat(req.getParameter("recharge")); // 押金
		String pressname=UTF8Changer.changeIntoUTF8(req.getParameter("pressname"));
		Float price=Float.parseFloat(req.getParameter("price"));
		OrderForm formQueried = new OrderForm(null, uid, isbn, null);
		OrderForm formInserted = new OrderForm(uid, isbn,
				new MyDateTime().getDate(), bookcode, userphone, userAddress,
				username, bookname,pressname,price);

		List<OrderForm> forms = new OrderFormService()
				.queryOrderForm(formQueried);
		if (forms.size() != 0) {
			// 1表示这本书已经定过，不能重复订书
			out.print(new ObjectMapper().writeValueAsString("已经订书"));
		} else {
			float balance = new AccountService().queryAccountTotalMoney(uid);
			if (balance < recharge) {
				out.print(new ObjectMapper().writeValueAsString("请您充值"));
			} else {

				int result = new OrderFormService()
						.insertedOrderForm(formInserted);
				if (result == 1) {
					new BookService().updateBookNumber(isbn); // 更新图书数量

					// 更新图书状态
					ISBN isbnUpdated = new ISBN(null, bookcode, Status.two,
							null);
					new ISBNService().updateISBN(isbnUpdated);
					new BookService().updateBookBorrowedTime(isbn);
					new AccountService().insertAccount(new Account(uid,
							Float.parseFloat(("-" + recharge.toString())),
							new MyDateTime().getDate(), Status.two,
							(float) 0.00));

					out.print(new ObjectMapper().writeValueAsString("订书成功"));
				} else {
					// 表示订书失败
					out.print(new ObjectMapper().writeValueAsString("订书失败"));
				}
			}
		}
	}
	
	private void getMoney(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		uid=req.getParameter("uid");
		Float money =Float.parseFloat(req.getParameter("money"));
		
		Account account =new Account(uid, money, new MyDateTime().getDate(), Status.one, (float) 0.0);
		
		int result=new AccountService().insertAccount(account);
		
		if(result == 1){
			out.print(new ObjectMapper().writeValueAsString("充值成功"));
		}
	
	}
	
	/**
	 * 获取IP地址
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月16日 下午12:47:42 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getIpPlace(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException{
		
		String place=UTF8Changer.changeIntoUTF8(req.getParameter("place"));
		String isbn=req.getParameter("isbn");
		
		ISBN I_isbn=new ISBN(place, null, isbn, Status.one, null);
	
		List<ISBN> isbns=new ISBNService().queryISBN(I_isbn);
		
		resp.setContentType("text/html; charset=utf-8");
		out = resp.getWriter();
		ObjectMapper mapper=new ObjectMapper();
		if(isbns != null){
			out.write(mapper.writeValueAsString(isbns));
		}else{
			out.write(mapper.writeValueAsString("none"));
		}		
	}
	
	/**
	 * 联系后台管理员
	 * @author 祝宝亚
	 * @time   2018年4月16日 下午4:57:37 
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void contactAdmin(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		String adminname=UTF8Changer.changeIntoUTF8(request.getParameter("adminname"));
		String adminphone=request.getParameter("adminphone");
		String content=UTF8Changer.changeIntoUTF8(request.getParameter("content"));
		String pressname=UTF8Changer.changeIntoUTF8(request.getParameter("pressname"));
		
		ContactAdmin admin=new ContactAdmin(adminname, adminphone, content, pressname);
		
		int result=new ContactAdminService().insertContactAdmin(admin);
		
		response.setContentType("text/html; charset=utf-8");
		out = response.getWriter();
		ObjectMapper mapper=new ObjectMapper();
		if(result == 1){
			out.print(mapper.writeValueAsString("success"));
		}else{
			out.print(mapper.writeValueAsString("wrong"));
		}
		
		
	}
}

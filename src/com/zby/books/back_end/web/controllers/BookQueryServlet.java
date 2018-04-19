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
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Book;
import com.zby.books.model.service.BookService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

/**
 * 查询图书
 * 
 * @author 祝宝亚
 * @date 2018年4月1日
 * 
 */
@SuppressWarnings("all")
public class BookQueryServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	/**
	 * 查询图书
	 * 
	 * @author 祝宝亚
	 * @time 2018年4月1日 下午2:40:59
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void queryBooks(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String bname = UTF8Changer.changeIntoUTF8(req.getParameter("bookName"));
		String authorName = UTF8Changer.changeIntoUTF8(req
				.getParameter("authorname"));
		String publicationFrom = req.getParameter("publicationFrom");
		String publicationTo = req.getParameter("publicationTo");
		String orderType = req.getParameter("orderValue");
		
		Integer bstatus = Integer.parseInt(req.getParameter("bStatus"));
		Integer pressId = GlobalVariable.pressId;

		Book book = new Book(authorName, bname, bstatus, publicationFrom,
				publicationTo, pressId, orderType);

		List<Book> books = new BookService().queryBookOrder(book);

		PrintWriter out = resp.getWriter();
		resp.setContentType("text/html;charset=utf-8");
		if (books!=null) {
			out.print(new ObjectMapper().writeValueAsString(books));
			return ;
		} 
	}
	
	/**
	 * 查询全部图书
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月9日 下午4:56:22 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void queryAllBooks(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{
		String orderType = req.getParameter("orderValue");
		Integer pressId = GlobalVariable.pressId;
		
		Book book = new Book(null, null, null, null,null, pressId, orderType);

		List<Book> books = new BookService().queryBookOrder(book);

		PrintWriter out = resp.getWriter();
		resp.setContentType("text/html;charset=utf-8");
		if (books!=null) {
			out.print(new ObjectMapper().writeValueAsString(books));
			return ;
		} 
	}
}

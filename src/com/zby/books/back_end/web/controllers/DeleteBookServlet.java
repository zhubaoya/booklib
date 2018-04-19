package com.zby.books.back_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.contents.GlobalVariable;
import com.zby.books.contents.Status;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Book;
import com.zby.books.model.po.ISBN;
import com.zby.books.model.service.BookService;
import com.zby.books.model.service.ISBNService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

@SuppressWarnings("all")
public class DeleteBookServlet extends HttpServlet {

	private String bookname;
	private Integer type;
	private Book book;
	private PrintWriter out;
	private ObjectMapper mapper = new ObjectMapper();
	private int pressId;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	/**
	 * 获取图书名
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月24日 下午3:23:24
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getBookName(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		bookname = UTF8Changer.changeIntoUTF8(req.getParameter("bookname"));
		type = Integer.parseInt(req.getParameter("type"));

		book = new Book(null, null, null, bookname, null, GlobalVariable.pressId);
		book = new BookService().queryBook(book);

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (book == null) {
			out.print(mapper.writeValueAsString("1")); // 图书不存在
		} else {
			switch (type) {
			case 1:
				out.print(mapper.writeValueAsString(book));
				break;
			case 2:

				ISBN isbn = new ISBN(null, null, book.getBisbn(), Status.one,
						null);
				List<ISBN> isbns = new ISBNService().queryISBN(isbn);
				if (isbns.size() != 0) {
					out.print(mapper.writeValueAsString(isbns));
				}
			default:
				break;
			}
		}
	}
	
	/**
	 * 删除一本书
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月24日 下午4:54:02 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteOneBook(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{
		String isbn=req.getParameter("isbn");
		String bookCode=req.getParameter("bookcode");
		
		int result=new ISBNService().deleteISBNByBookCode(bookCode);
		
		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();
		
		if(result == 1){
			new BookService().updateBookNumber(isbn);
			out.print(mapper.writeValueAsString("删除成功"));
		}
	}
	
	/**
	 * 删除所有图书
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月24日 下午5:36:52 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteAllBook(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{
		
		String isbn=req.getParameter("isbn");
	
		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();
		
		int result =new BookService().deleteBook(isbn);
		
		if(result == 1){
			new ISBNService().deleteISBNByISBN(isbn);
			out.print(mapper.writeValueAsString("删除成功"));
		}	
	}
}

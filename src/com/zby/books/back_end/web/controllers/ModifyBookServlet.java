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
import com.zby.books.model.po.Book;
import com.zby.books.model.po.ISBN;
import com.zby.books.model.service.BookService;
import com.zby.books.model.service.ISBNService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

/**
 * 修改图书类
 * 
 * @author 祝宝亚
 * @date 2018年3月24日
 * 
 */
@SuppressWarnings("all")
public class ModifyBookServlet extends HttpServlet {

	private String bookname;
	private Integer type;
	private Book book;
	private PrintWriter out;
	private ObjectMapper mapper = new ObjectMapper();
	private ISBN isbn;
		
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	/**
	 * 修改信息
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月24日 下午10:42:22 
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
	 * 修改一本图书
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月24日 下午11:28:45 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void modifyOneBook(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{
		String bookCode=req.getParameter("objId");
		String bookplace=UTF8Changer.changeIntoUTF8(req.getParameter("bookcodeplace"));
		Integer intact=Integer.parseInt(req.getParameter("intact"));
		
		isbn =new ISBN(bookplace, bookCode, null, intact);
		
		int result=new ISBNService().updateISBN(isbn);
		
		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();
		
		if(result == 1){
			out.print(mapper.writeValueAsString("修改成功"));
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String bisbn = req.getParameter("ba_isbn");
		String authorName = req.getParameter("ba_authorname");
		Float bprice = Float.parseFloat(req.getParameter("ba_price"));
		String babstract = req.getParameter("ba_abstract");
		Float earnest = Float.parseFloat(req.getParameter("ba_earnest"));
		Integer bstatus=Integer.parseInt(req.getParameter("ba_status"));
		
		book =new Book();
		
		book.setAuthorName(authorName);
		book.setBisbn(bisbn);
		book.setBprice(bprice);
		book.setBstatus(bstatus);
		book.setBabstract(babstract);
		book.setEarnest(earnest);
	
		int result=new BookService().updateBook(book);
		
		System.out.println(result);
		
		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();
		
		if(result == 1){
			out.print("<script>window.alert('更新成功');window.location.href='"
					+ req.getContextPath()
					+ "/back_end/jsp/book_modify.jsp'</script>");
		}
	}
}

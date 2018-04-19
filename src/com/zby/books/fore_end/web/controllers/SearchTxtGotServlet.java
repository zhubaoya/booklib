package com.zby.books.fore_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Book;
import com.zby.books.model.service.BookService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

@SuppressWarnings(value = "all")
public class SearchTxtGotServlet extends HttpServlet {

	private Book book;
	private List<Book> books;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String methodParam = req.getParameter("method");
		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	private void getSearchTxt(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		PrintWriter out=resp.getWriter();
		resp.setContentType("text/html;charset=utf8");
		
		String searchTxt = UTF8Changer.changeIntoUTF8(req.getParameter("searchTxt"));
		int selectVal = Integer.parseInt(req.getParameter("selectVal").toString());

		initBooks(selectVal, searchTxt);
		
		if(books.size() != 0){
			out.print(new ObjectMapper().writeValueAsString(books));
		}
		
	}

	/**
	 * 初始化books的数值
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月13日 下午11:07:33 
	 * @param selectVal
	 * @param searchTxt
	 */
	private void initBooks(int selectVal,String searchTxt){
		switch (selectVal) {
		case 1:         // 书名
			book=new Book(null, null, null, searchTxt, null, null);
			books=new BookService().queryBooks(book);
			book=null;
			break;
		case 2:         // 作者名
			book=new Book(null, null, searchTxt, null, null, null);
			books=new BookService().queryBooks(book);
			book=null;
			break;
		case 3:         // 出版社
			books=new BookService().queryBooksByPress(searchTxt);
			break;
		default:
			break;
		}
	}
}

package com.zby.books.back_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zby.books.contents.GlobalVariable;
import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Book;
import com.zby.books.model.po.BookCity;
import com.zby.books.model.po.BookCounty;
import com.zby.books.model.po.BookProvince;
import com.zby.books.model.po.Genres;
import com.zby.books.model.po.ISBN;
import com.zby.books.model.po.Tag;
import com.zby.books.model.service.BookCityService;
import com.zby.books.model.service.BookCountyService;
import com.zby.books.model.service.BookProvinceService;
import com.zby.books.model.service.BookService;
import com.zby.books.model.service.GenresService;
import com.zby.books.model.service.ISBNService;
import com.zby.books.model.service.TagService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

/**
 * 给天机图书的数量
 * 
 * @author 祝宝亚
 * @date 2018年3月14日
 * 
 */
@SuppressWarnings("all")
public class BookAddedServlet extends HttpServlet {

	private PrintWriter out;
	private ObjectMapper mapper = new ObjectMapper();
	private int result;
	private String bookTotalNumber;
	private String bookProvinceName;
	private Integer bookProvinceId;
	private String bookCityName;
	private Integer bookCityId;
	private String bookCountyName;
	private Integer bookCountyId;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		Integer pressId = GlobalVariable.pressId; // 全局变量
		String bisbn = req.getParameter("ba_isbn");
		String authorName = req.getParameter("ba_authorname");
		Integer genresId = Integer
				.parseInt(req.getParameter("ba_chooseGenres"));
		String bname = req.getParameter("ba_bookname");
		Float bprice = Float.parseFloat(req.getParameter("ba_price"));
		String publication = req.getParameter("ba_publication");
		Integer bnumber = Integer.parseInt(req.getParameter("ba_number"));
		String babstract = req.getParameter("ba_abstract");
		Float earnest = Float.parseFloat(req.getParameter("ba_earnest"));
		String bimg = null; // 图片日后再做

		Map<String, String> map = new HashMap<String, String>();
		map.put("9787323415013", "bookimgs/9787323415013_1.png");
		map.put("9787325187513", "bookimgs/9787325187513_1.png");
		map.put("9787505742413", "bookimgs/9787505742413_1.png");

		Book book = new Book(bisbn, authorName, genresId, bname, bprice,
				pressId, publication, bnumber, map.get(bisbn), babstract,
				earnest);

		result = new BookService().insertBook(book);

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (result == 1) {
			out.println("<input type='hidden' id='dataIsbnFromServlet' value='"
					+ bisbn + "'>");
			out.print("<script>window.alert('图书添加成功');window.location.href='"
					+ req.getContextPath()
					+ "/back_end/jsp/book_add.jsp'</script>");
		}
	}

	
	/**
	 * 获取类型genres的id
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月16日 下午3:53:35
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getGenresId(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		Integer tagId = Integer.parseInt(req.getParameter("tagId"));

		Genres genres = new Genres(null, tagId, null);
		List<Genres> gens = new GenresService().queryGenress(genres);

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (gens.size() != 0) {
			out.println(mapper.writeValueAsString(gens));
		}
	}

	/**
	 * 获取标签名，便于注册用
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月16日 下午8:56:13
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getTagName(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String tagName = UTF8Changer
				.changeIntoUTF8(req.getParameter("tagName"));

		result = new TagService().insertTag(new Tag(tagName));

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (result == 1) {
			out.print(mapper.writeValueAsString("您已成功的添加标签"));
		}
	}

	/**
	 * 添加数据到类型表中
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月16日 下午9:34:17
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getGenresName(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		Integer tagId = Integer.parseInt(req.getParameter("tagId"));
		String genresName = UTF8Changer.changeIntoUTF8(req
				.getParameter("genresName"));

		result = new GenresService()
				.insertGenres(new Genres(genresName, tagId));

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (result == 1) {
			out.print(mapper.writeValueAsString("您已成功的添加图书类型"));
		}
	}

	/**
	 * 验证isbn是否重复
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月18日 下午6:10:11
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void validateISBN(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String bisbn = req.getParameter("isbn");
		Book book = new BookService().queryBook(new Book(null, bisbn, null,
				null, null, null));

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (book != null) {
			out.print(mapper.writeValueAsString("该图书已经存在"));
		}
	}

	/**
	 * 判断图书是否存在
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月19日 下午4:06:35
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getBookISBN(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String bisbn = req.getParameter("isbn");
		int booktotalNumber;
		List<ISBN> isbnList = new ISBNService().queryISBN(new ISBN(null, null,
				bisbn, null, null));
		Book book = new BookService().queryBook(new Book(null, bisbn, null,
				null, null, null));

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (book != null) {
			if (isbnList.size() == 0) {
				booktotalNumber = book.getBnumber();
			} else {
				booktotalNumber = book.getBnumber() - isbnList.size();
			}
			book.setBnumber(booktotalNumber);

			out.print(mapper.writeValueAsString(book));

		} else {
			out.print(mapper.writeValueAsString(null));
		}
	}

	/**
	 * 图书所在省
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月19日 下午6:22:41
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getBookprovinceId(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {

		Integer pid = Integer.parseInt(req.getParameter("bookProvinceId"));

		BookCity bookCity = new BookCity(null, pid);
		List<BookCity> bookCities = new BookCityService()
				.queryBookCity(bookCity);

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (bookCities != null) {
			out.print(mapper.writeValueAsString(bookCities));
		}
	}

	/**
	 * 图书所在市
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月19日 下午6:59:15
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getBookCityId(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Integer cid = Integer.parseInt(req.getParameter("bookCityId"));

		BookCounty bookCounty = new BookCounty(null, cid);
		List<BookCounty> bookCounties = new BookCountyService()
				.queryBookCounty(bookCounty);

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (bookCounties != null) {
			out.print(mapper.writeValueAsString(bookCounties));
		}
	}

	/**
	 * 添加图书所在省
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月22日 下午2:24:26
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addBookProvince(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		bookProvinceName = UTF8Changer.changeIntoUTF8(req
				.getParameter("bookProvinceName"));

		List<BookProvince> bookProvinces = new BookProvinceService()
				.queryBookProvince(null, bookProvinceName);

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (bookProvinces.size() != 0) {
			out.print(mapper.writeValueAsString("已经添加"));
		} else {
			result = new BookProvinceService()
					.insertBookProvince(new BookProvince(bookProvinceName));
			if (result == 1) {
				out.println(mapper.writeValueAsString("添加成功"));
			}
		}
	}

	/**
	 * 添加图书所在市
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月22日 下午6:29:06
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addBookCity(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		bookProvinceId = Integer.parseInt(req.getParameter("bookProvinceId"));
		bookCityName = UTF8Changer.changeIntoUTF8(req
				.getParameter("bookCityName"));

		BookCity bookCity = new BookCity(bookCityName, bookProvinceId);

		List<BookCity> bookCities = new BookCityService()
				.queryBookCity(bookCity);

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (bookCities.size() != 0) {
			out.print(mapper.writeValueAsString("已经存在"));
		} else {
			result = new BookCityService().insertBookCity(bookCity);
			if (result == 1) {
				out.print(mapper.writeValueAsString("添加成功"));
			}
		}
	}

	/**
	 * 添加图书所在县
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月22日 下午7:09:29
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addBookCounty(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		bookCityId = Integer.parseInt(req.getParameter("bookCityId"));
		bookCountyName = UTF8Changer.changeIntoUTF8(req
				.getParameter("bookCountyName"));

		BookCounty bookCounty = new BookCounty(bookCountyName, bookCityId);

		List<BookCounty> bookCounties = new BookCountyService()
				.queryBookCounty(bookCounty);

		if (bookCounties.size() != 0) {
			out.print(mapper.writeValueAsString("已经存在"));
		} else {
			result = new BookCountyService().insertBookCounty(bookCounty);
			if (result == 1) {
				out.print(mapper.writeValueAsString("添加成功"));
			}
		}
	}

	/**
	 * 添加isbn数据
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月22日 下午11:09:21
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addISBN(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String isbn = req.getParameter("isbn");
		bookProvinceName = UTF8Changer.changeIntoUTF8(req
				.getParameter("bookProvinceName"));
		bookCityName = UTF8Changer.changeIntoUTF8(req
				.getParameter("bookCityName"));
		bookCountyName = UTF8Changer.changeIntoUTF8(req
				.getParameter("bookCountyName"));
		String particularAddress = bookProvinceName
				+ bookCityName
				+ bookCountyName
				+ UTF8Changer.changeIntoUTF8(req
						.getParameter("particularAddress"));
		Integer bookCodeNumber = Integer.parseInt(req
				.getParameter("bookCodeNumber"));

		List<ISBN> list = new ISBNService().queryISBN(new ISBN(null, null,
				isbn, null, null));

		resp.setContentType("text/html;charset=utf-8");
		out = resp.getWriter();

		if (list.size() == 0) {
			new ISBNService(0, bookCodeNumber).insertBetchISBN(
					particularAddress, isbn);
		} else {
			int maxCode = new ISBNService().queryMaxBookcode(isbn);
			new ISBNService(maxCode, bookCodeNumber).insertBetchISBN(
					particularAddress, isbn);
		}
		out.print(mapper.writeValueAsString("添加成功!"));

	}
}

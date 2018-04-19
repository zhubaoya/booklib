package com.zby.books.back_end.web.filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.zby.books.model.po.Press;
import com.zby.books.model.service.PressService;

public class InitPress implements Filter{

	@Override
	public void destroy() {
		
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		response.setCharacterEncoding("UTF-8");
		
		request.setCharacterEncoding("UTF-8");
		
		List<Press> presss=new PressService().queryPresss();
		
		request.setAttribute("presss", presss);
		
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
		
	}

}

package com.zby.books.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharSetFilter implements Filter {

	private String encoding = null;

	@Override
	public void init(FilterConfig config) throws ServletException {
		encoding = config.getInitParameter("encode");
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {

		req.setCharacterEncoding(encoding);

		resp.setCharacterEncoding(encoding);

		chain.doFilter(req, resp);
	}

	@Override
	public void destroy() {

	}

}

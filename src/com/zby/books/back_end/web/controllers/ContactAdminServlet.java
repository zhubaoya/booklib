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
import com.zby.books.model.po.ContactAdmin;
import com.zby.books.model.service.ContactAdminService;
import com.zby.books.utils.reflect.ReflectJSPServlet;

public class ContactAdminServlet extends HttpServlet {

	private Integer c_id;
	private ContactAdmin admin;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		admin = new ContactAdmin(c_id, 2);
		int result = new ContactAdminService().updateContactAdmin(admin);

		PrintWriter out = resp.getWriter();
		if (result == 1) {
			out.write("<script>window.alert('状态更新成功');window.location.href='"
					+ req.getContextPath()
					+ "/back_end/jsp/contact_admin.jsp'</script>");
			return;
		} else {
			out.write("<script>windiow.alert('状态更新失败')</script>");
			return;
		}

	}

	/**
	 * 获取contactadmin的id的集合
	 * 
	 * @author 祝宝亚
	 * @time 2018年4月1日 下午6:02:35
	 * @param req
	 * @param resp
	 * @throws JsonProcessingException
	 * @throws IOException
	 */
	private void getStatus(HttpServletRequest req, HttpServletResponse resp)
			throws JsonProcessingException, IOException {

		Integer status = Integer.parseInt(req.getParameter("c_status"));
		admin = new ContactAdmin(status, GlobalVariable.pressName, null);
		List<ContactAdmin> admins = new ContactAdminService()
				.queryContactAdmins(admin);
		if (admins != null) {
			resp.getWriter().write(
					new ObjectMapper().writeValueAsString(admins));
			return;
		}

	}

	/**
	 * 通过id，来获取某个对象
	 * 
	 * @author 祝宝亚
	 * @time 2018年4月1日 下午6:03:00
	 * @param req
	 * @param resp
	 * @throws IOException
	 * @throws JsonProcessingException
	 */
	private void getContactId(HttpServletRequest req, HttpServletResponse resp)
			throws JsonProcessingException, IOException {

		c_id = Integer.parseInt(req.getParameter("c_id"));
		admin = new ContactAdmin(null, GlobalVariable.pressName, c_id);
		ContactAdmin contactAdmin = new ContactAdminService()
				.queryContactAdmin(admin);

		if (contactAdmin != null) {
			resp.getWriter().write(
					new ObjectMapper().writeValueAsString(contactAdmin));
		}

	}
}

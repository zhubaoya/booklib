package com.zby.books.fore_end.web.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zby.books.contents.UTF8Changer;
import com.zby.books.model.po.Admin;
import com.zby.books.model.po.Press;
import com.zby.books.model.service.AdminService;
import com.zby.books.model.service.PressService;
import com.zby.books.utils.cryption.Encryption;
import com.zby.books.utils.reflect.ReflectJSPServlet;

public class PressRegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private Press press;
	
	private String libname;
	private String libAddress;
	private Integer libpostcode;
	private String libphone;
	private String libmobile;
	private String libwebsite;
	private String libICPe;
	private String libusername;
	private String libpassoword;
	private String libhandid;
	private String libID;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String methodParam = req.getParameter("method");

		new ReflectJSPServlet().excuteReflect(this, methodParam, req, resp);
	}
	
	private void checkPressName(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String pressname=UTF8Changer.changeIntoUTF8(req.getParameter("pressname"));
		
		Press pre=new PressService().queryPress(null,pressname);
		
		PrintWriter out=resp.getWriter();
		if(pre != null){
			out.print("err");
			return ;
		}	
	}
	
	/**
	 * 注册个人信息
	 * @author 祝宝亚
	 * @time   2018年4月19日 下午1:58:55 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void registerMyIndividual(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{
		
		libname=UTF8Changer.changeIntoUTF8(req.getParameter("libname"));
		libusername=UTF8Changer.changeIntoUTF8(req.getParameter("libusername"));
		libpassoword=req.getParameter("libpassoword");
		libID=req.getParameter("libID");
		libhandid="headimg/hand_id.jpg";
		
		Press press=new Press(libname, null, null, null, null, null, null);
		int result =new PressService().insertPress(press);
		
		PrintWriter out=resp.getWriter();
		if(result ==1 ){
			Integer pressid=new PressService().queryPress(null, libname).getPid();
			Admin admin=new Admin(libusername, libpassoword, pressid.toString(), libID, libhandid);
			int result1 =new AdminService().insertAdmin(admin);
			
			
			if(result1==1){
				out.print("success");
				return ;
			}
		}
		
	}
	
	/**
	 * 注册组织信息
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月19日 下午1:59:07
	 */
	private void registerMyorganize(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{
		
		libname=UTF8Changer.changeIntoUTF8(req.getParameter("libname"));
		libusername=UTF8Changer.changeIntoUTF8(req.getParameter("libusername"));
		libpassoword=UTF8Changer.changeIntoUTF8(req.getParameter("libpassoword"));
		libAddress=UTF8Changer.changeIntoUTF8(req.getParameter("libAddress"));
		libpostcode=Integer.parseInt(req.getParameter("libpostcode"));
		libphone=req.getParameter("libphone");
		libwebsite=UTF8Changer.changeIntoUTF8(req.getParameter("libwebsite"));
		libICPe=UTF8Changer.changeIntoUTF8(req.getParameter("libICPe"));
		libmobile=req.getParameter("libmobile");
		
		Press press=new Press(libname, libAddress, libpostcode, libphone, libmobile, libwebsite, libICPe);
		int result =new PressService().insertPress(press);
		
		PrintWriter out=resp.getWriter();
		if(result ==1 ){
			Integer pressid=new PressService().queryPress(null, libname).getPid();
			Admin admin=new Admin(libusername, libpassoword, pressid.toString(), null, null);
			int result1 =new AdminService().insertAdmin(admin);
			
			
			if(result1==1){
				out.print("success");
				return ;
			}
		}
		
		
	}
}

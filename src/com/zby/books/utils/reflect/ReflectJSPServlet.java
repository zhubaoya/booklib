package com.zby.books.utils.reflect;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 这是用以操作jsp页面参数的servlet的实现类
 * 
 * @author 祝宝亚
 * @date 2018年1月21日
 * 
 */
public class ReflectJSPServlet extends Reflect {

	@Override
	public void excuteReflect(Object object, String methodParam,
			HttpServletRequest req, HttpServletResponse resp) {

		Class<?>[] typeParams = this.getParameterTypes(
				HttpServletRequest.class, HttpServletResponse.class);

		try {
			Method method = object.getClass().getDeclaredMethod(methodParam,
					typeParams);
			method.setAccessible(true);
			method.invoke(object, req, resp);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

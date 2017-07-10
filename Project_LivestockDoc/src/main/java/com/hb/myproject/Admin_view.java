package com.hb.myproject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.*;

import com.hb.db.DAO;

@Controller
@RequestMapping(value="/admin")
public class Admin_view {
	@Autowired
	private DAO dao;
	public DAO getDao() {
		return this.dao;
	}
	public void setDao(DAO dao) {
		this.dao = dao;
	}

	@RequestMapping(value="/customer")
	public ModelAndView goCustomerManagementPage(HttpServletRequest request,HttpServletResponse httpServletResponse){
		ModelAndView mv = new ModelAndView("customer_management/customer_management");
		mv.addObject("cvoList", dao.getSelectAllCustomers());
		return mv;
	}
	
	@RequestMapping(value="/customer_info.go")
	public ModelAndView goCustomerInfoPage(HttpServletRequest request,HttpServletResponse httpServletResponse){
		ModelAndView mv = new ModelAndView("customer_management/customer_info");
		mv.addObject("cvo_info", dao.getOneCustomer(request.getParameter("c_idx")));
		return mv;
	}
	@RequestMapping(value="/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		if (!request.getSession().getAttribute("loginchk").equals("-1")) {
			System.out.println("로그아웃");
			request.getSession().invalidate();
			request.getSession().setAttribute("loginchk", Integer.valueOf(-1));
		}
		return mv;
	}
}

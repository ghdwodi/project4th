package com.hb.myproject;

import com.hb.db.CounselVO;
import com.hb.db.CustomerVO;
import com.hb.db.DAO;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Controller_view
{
	@Autowired
	private DAO dao;
	@Autowired
	private Paging paging;

	public DAO getDao() {
		return this.dao;
	}
	public void setDao(DAO dao) {
		this.dao = dao;
	}
	public Paging getPaging() {
		return paging;
	}
	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	@RequestMapping({ "/" })
	public ModelAndView main_go(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		if (request.getSession().getAttribute("loginchk") == null) {
			System.out.println("첫 접속");
			request.getSession().setAttribute("loginchk", Integer.valueOf(-1));
		}
		mv.addObject("noticeList", dao.getNotice());
		mv.addObject("newsList", dao.getNews());
		return mv;
	}
	@RequestMapping({ "/main.go" })
	public ModelAndView main_go2(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		if (request.getSession().getAttribute("loginchk") == null) {
			System.out.println("첫 접속");
			request.getSession().setAttribute("loginchk", Integer.valueOf(-1));
		}
		mv.addObject("noticeList", dao.getNotice());
		mv.addObject("newsList", dao.getNews());
		return mv;
	}

	@RequestMapping({ "/intro.go" })
	public ModelAndView intro_go(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("intro");
		String cmd = request.getParameter("cmd");
		mv.addObject("cmd", cmd);
		return mv;
	}

	@RequestMapping({ "/login.go" })
	public ModelAndView login_do(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}
	@RequestMapping({ "/loginpage.go" })
	public ModelAndView loginPage_go(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("loginpage");
		return mv;
	}
	
	@RequestMapping(value="/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("redirect:/");
		if (!request.getSession().getAttribute("loginchk").equals("-1")) {
			System.out.println("로그아웃");
			request.getSession().invalidate();
			request.getSession().setAttribute("loginchk", Integer.valueOf(-1));
		}
		return mv;
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
		request.getSession().setAttribute("cvo_info", dao.getOneCustomer(request.getParameter("c_idx")));
		return mv;
	}
	
	@RequestMapping(value="/customer_modify.go")
	public ModelAndView goCustomerModifyPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("customer_management/customer_modify");
		return mv;
	}
	
	@RequestMapping(value="/personalpage.go")
	public ModelAndView goPersonalPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("personal_view/personal_page");
		mv.addObject("cmd", 0);	// 개인정보 페이지
		return mv;
	}
	
	@RequestMapping(value="/personalpost.go")
	public ModelAndView goPersonalPostPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("personal_view/personal_page");
		mv.addObject("cmd", 1);	// 쪽지 페이지
		String cPage = request.getParameter("cPage");
		if(cPage != null){
			paging.setNowPage(Integer.parseInt(cPage));
		}else{
			cPage="1";
			paging.setNowPage(1);
		}
		paging.setTotalRecord(dao.getMsgCount(request.getParameter("c_idx")));
		System.out.println("총 쪽지 수 : "+dao.getMsgCount(request.getParameter("c_idx")));
		paging.setTotalPage();
		paging.setNumPerPage(10);
		paging.setPagePerBlock(2);
		paging.setBegin();
		paging.setEnd();
		paging.setBeginPage();
		paging.setEndPage();
		paging.setMap();
		Map<String, Integer> map = paging.getMap();
		map.put("c_idx", Integer.parseInt(request.getParameter("c_idx")));
		mv.addObject("msgList",dao.getMsgList(map));
		mv.addObject("p", paging);
		mv.addObject("c_idx", Integer.parseInt(request.getParameter("c_idx")));
		return mv;
	}
	
	@RequestMapping(value="/personalcounsel.go")
	public ModelAndView goPersonalCounselPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("personal_view/personal_page");
		mv.addObject("counselList", dao.selectCounselList(request.getParameter("c_idx")));
		mv.addObject("cmd", 2);	// 상담 페이지
		return mv;
	}
	
	@RequestMapping(value="/counselmanagement.go")
	public ModelAndView goCounselManagementPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("counsel_management/counsel_list");
		mv.addObject("newCounselList", dao.getAllNewCounselList());
		return mv;
	}
	
	@RequestMapping(value="/counselview.go")
	public ModelAndView goCounselViewPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("counsel_management/counsel_view");
		mv.addObject("counselVO", dao.selectOneCounsel(request.getParameter("counsel_idx")));
		return mv;
	}
	
	@RequestMapping(value="/diseasemap.go")
	public ModelAndView goDiseaseMapPage(){
		return new ModelAndView("diseasemap");
	}
	
	@RequestMapping(value="/bbs.go")
	public ModelAndView goBBSPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("table_views/bbs");
		String b_category = request.getParameter("b_category");
		String cPage = request.getParameter("cPage");
		if(cPage != null){
			paging.setNowPage(Integer.parseInt(cPage));
		}else{
			cPage="1";
			paging.setNowPage(1);
		}
		paging.setTotalRecord(dao.getTotalCount(b_category));
		System.out.println("총 게시물 수 : "+dao.getTotalCount(b_category));
		paging.setTotalPage();
		paging.setBegin();
		paging.setEnd();
		paging.setBeginPage();
		paging.setEndPage();
		paging.setMap();
//		request.getSession().setAttribute("cPage", cPage);
		
		System.out.println("게시판유형 : "+b_category+", 현재 페이지 : "+cPage);
		request.getSession().setAttribute("cPage", cPage);
		request.getSession().setAttribute("b_category", b_category);
		Map<String, Integer> map = paging.getMap();
		map.put("b_category", Integer.parseInt(b_category));
		mv.addObject("p", paging);
		mv.addObject("bbsVOList", dao.getBBSList(map));
		return mv;
	}
	
	@RequestMapping(value="/bbsView.go")
	public ModelAndView goBBSViewPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("table_views/bbs_view");
		String b_idx = request.getParameter("b_idx");
		String cPage = request.getParameter("cPage");
		String b_category = request.getParameter("b_category");
		mv.addObject("bbsVO", dao.getBBSView(b_idx));
		mv.addObject("repVOList", dao.getReplyList(b_idx));
		dao.updateBBSHit(b_idx);
		mv.addObject("cPage", cPage);
		mv.addObject("b_category", b_category);
		return mv;
	}
	
	@RequestMapping(value="bbs_insert.go")
	public ModelAndView goBBSInsertPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("table_views/bbs_insert");
		String b_category = request.getParameter("b_category");
		mv.addObject("b_category", b_category);
		return mv;
	}
	@RequestMapping(value="bbs_modify.go")
	public ModelAndView goBBSModifyPage(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("table_views/bbs_modify");
		String b_idx = request.getParameter("b_idx");
		mv.addObject("bbsVO", dao.getBBSView(b_idx));
		return mv;
	}
}

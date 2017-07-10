package com.hb.myproject;

import com.hb.db.BBS_VO;
import com.hb.db.CounselVO;
import com.hb.db.CustomerVO;
import com.hb.db.DAO;
import com.hb.db.MsgVO;
import com.hb.db.Reply_VO;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@RestController
@RequestMapping(value = "/Rest")
public class Controller_Rest {
	@Autowired
	private DAO dao;

	public DAO getDao() {
		return this.dao;
	}

	public void setDao(DAO dao) {
		this.dao = dao;
	}
	
	@RequestMapping({ "/login.do" })
	public String login_do(HttpServletRequest request,CustomerVO cvo2) {
		String res="";
		if(dao.login(cvo2)==null){
			res = "fail";
		}else{
			CustomerVO cvo = dao.login(cvo2);
			request.getSession().setAttribute("cvo", cvo);
			int newMsgCount = dao.getNewMsgCount(cvo.getC_idx());
			System.out.println(cvo.getC_idx()+"번 회원 "+cvo.getId()+" 로그인했습니다.");
			System.out.println("안읽은쪽지개수 : "+newMsgCount);
			if(cvo.getC_authority().equals("0")){
				request.getSession().setAttribute("loginchk", Integer.valueOf(0));
			}else if(cvo.getC_authority().equals("1")){
				request.getSession().setAttribute("loginchk", Integer.valueOf(1));
			}else{
				request.getSession().setAttribute("loginchk", Integer.valueOf(2));
			}
			request.getSession().setAttribute("newMsgCount", newMsgCount);
			res = "success";
		}
		return res;
	}

	@RequestMapping(value="/idchk.do")
	public String idCheck(String id) {
		return dao.idCheck(id);
	}

	@RequestMapping(value = "/join.do")
	public String customer_Join(CustomerVO cvo) {
		int result = this.dao.join(cvo);
		String res = "가입 실패";
		if (result > 0) {
			res = "가입 성공";
		}
		System.out.println(res);
		return res;
	}
	
	@RequestMapping(value="/c_modify.do")
	public String customer_modify(CustomerVO cvo){
		int result = dao.customerModify(cvo);
		String res = "수정 실패";
		if (result > 0) {
			res = "수정 성공";
		}
		System.out.println(res);
		return res;
	}
	@RequestMapping(value="/c_delete.do")
	public String customer_delete(String c_idx){
		int result = dao.customerDelete(c_idx);
		String res = "삭제 실패";
		if (result > 0) {
			res = "삭제 성공";
		}
		System.out.println(res);
		return res;
	}
	
	@RequestMapping(value="/insertcounsel.do")
	public String insertCounsel(CounselVO counselVO){
		dao.insertCounsel(counselVO);
		return counselVO.getC_idx();
	}
	@RequestMapping(value="/answercounsel.do")
	public String answerCounsel(CounselVO counselVO){
		dao.answerCounsel(counselVO);
		MsgVO mvo = new MsgVO();
		mvo.setC_idx(counselVO.getC_idx());
		mvo.setC_idx_sender("0");
		mvo.setM_content("상담 답변이 완료되었습니다. 확인바랍니다.");
		dao.insertMsg(mvo);
		return counselVO.getAnswerer();
	}
	@RequestMapping(value="updatecounselScore.do")
	public String scoreCounsel(CounselVO counselVO){
		dao.scoreCounsel(counselVO);
		return "";
	}
	
	@RequestMapping(value="/bbs_insert.do")
	public String insertBBS(BBS_VO bvo){
		dao.insertBBS(bvo);
		return bvo.getB_category();
	}
	
	@RequestMapping(value="/bbs_delete.do")
	public String deleteBBS(String b_idx){
		dao.deleteBBS(b_idx);
		return "삭제 성공";
	}
	
	@RequestMapping(value="/bbs_modify.do")
	public String modifyBBS(BBS_VO bvo){
		dao.modifyBBS(bvo);
		return "수정 성공";
	}
	
	@RequestMapping(value="/reply_insert.do")
	public String insertReply(String b_idx,String c_idx, String content){
		Reply_VO rvo = new Reply_VO();
		rvo.setB_idx(b_idx);
		rvo.setC_idx(c_idx);
		rvo.setContent(content);
		dao.insertReply(rvo);
		return "답글 달기 성공";
	}
	@RequestMapping(value="/reply_delete.do")
	public String deleteReply(String r_idx){
		dao.deleteReply(r_idx);
		return "삭제 성공";
	}
	
	@RequestMapping(value="/msg_insert.do")
	public String insertMsg(MsgVO mvo){
		dao.insertMsg(mvo);
		return "전송 성공";
	}
	
	@RequestMapping(value="/msg_view.do", produces="application/text;charset=utf8")
	public String viewMsg(String m_idx, String c_idx, HttpServletRequest request){
		MsgVO mvo = dao.getMsg(m_idx);
		System.out.println("쪽지보는회원 번호 : "+c_idx);
		dao.updateMsgReadChk(m_idx);
		request.getSession().setAttribute("newMsgCount", dao.getNewMsgCount(c_idx));
		String res = mvo.getC_idx()+"#++#"+mvo.getC_idx_sender()+"#++#"+mvo.getC_sender_nickname()+"#++#"+mvo.getM_content();
		return res;
	}
	
	@RequestMapping(value="/mapping.do")
	public ArrayList<String> livestockDiseaseData(HttpServletRequest request, HttpServletResponse response){
		ArrayList<String> res = new ArrayList<String>();
		String cmd = request.getParameter("cmd");
		System.out.println("명령 : "+cmd);
		String command = "";
		try {
			if(cmd.equals("0")){
			}else if(cmd.equals("1")){
				command="?LKNTS_NM="+URLEncoder.encode("결핵병","utf-8");
			}else if(cmd.equals("2")){
				command="?LKNTS_NM="+URLEncoder.encode("고병원성조류인플루엔자","utf-8");
			}else if(cmd.equals("3")){
				command="?LKNTS_NM="+URLEncoder.encode("구제역","utf-8");
			}else if(cmd.equals("4")){
				command="?LKNTS_NM="+URLEncoder.encode("돼지열병","utf-8");
			}else if(cmd.equals("5")){
				command="?LKNTS_NM="+URLEncoder.encode("브루셀라병","utf-8");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println(command);
		DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
		try {
			String url = "http://data.mafra.go.kr:7080/openapi/59b8562426e598d34bad37835a94736c23205ab31f14808b6003978930bb873a/xml/Grid_20151204000000000316_1/1/5"+command;
			DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
			Document document = docBuilder.parse(url);
			Element rootElement = document.getDocumentElement();
			
			NodeList nodeList = rootElement.getElementsByTagName("totalCnt");
			System.out.println("totalCnt : "+nodeList.item(0).getTextContent());
			int lastIndex = Integer.parseInt(nodeList.item(0).getTextContent());
			int firstIndex = 1;
			if(lastIndex>=1000){
				firstIndex = lastIndex-999;
			}else{
				firstIndex = 1;
			}
			String newUrl = "http://data.mafra.go.kr:7080/openapi/59b8562426e598d34bad37835a94736c23205ab31f14808b6003978930bb873a/xml/Grid_20151204000000000316_1/"+firstIndex+"/"+lastIndex+command;
			System.out.println(newUrl);
			document = docBuilder.parse(newUrl);
			rootElement = document.getDocumentElement();
			nodeList = rootElement.getElementsByTagName("row");
			System.out.println("열 수 : "+nodeList.getLength());
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH,-1);
			System.out.println("기준날짜 : "+(cal.get(Calendar.MONTH)+1)+"/"+cal.get(Calendar.DAY_OF_MONTH));
			for(int j=0;j<nodeList.getLength();j++){
				NodeList childNodes = nodeList.item(j).getChildNodes();
				for(int i=0;i<childNodes.getLength();i++){
					Node info = childNodes.item(i);
					if(info.getNodeType()==Node.ELEMENT_NODE){
						String resLine="";
						if(info.getNodeName().equals("OCCRRNC_DE")){
							Element el = (Element)info;
							SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
							Date d = df.parse(el.getTextContent());
							System.out.println(d);
							System.out.println(d.compareTo(cal.getTime()));
							if(d.compareTo(cal.getTime())>=0){
								String addrCode = childNodes.item(i-4).getTextContent().substring(0, 5)+"00000";
								String addr = childNodes.item(i-2).getTextContent();
								String diseaseName = childNodes.item(i-8).getTextContent();
								String date = childNodes.item(i).getTextContent();
								System.out.println(addrCode);		// 법정동 코드
								System.out.println(addr);			// 실제 주소
								System.out.println(diseaseName);	// 병명
								System.out.println(date);			// 발병일
								resLine += addrCode+","+addr+","+diseaseName+","+date;
								res.add(resLine);
							}
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		request.getSession().setAttribute("res", res);
		return res;
	}
}
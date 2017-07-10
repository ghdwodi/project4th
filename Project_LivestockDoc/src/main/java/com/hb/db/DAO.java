package com.hb.db;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public class DAO {
	private SqlSessionTemplate template;

	public SqlSessionTemplate getTemplate() {
		return this.template;
	}

	public void setTemplate(SqlSessionTemplate template) {
		this.template = template;
	}

	// 회원관리
	public List<CustomerVO> getSelectAllCustomers() {
		return this.template.selectList("selectAllCustomer");
	}

	public CustomerVO login(CustomerVO cvo) {
		return (CustomerVO) this.template.selectOne("login", cvo);
	}

	public String idCheck(String id) {
		List<CustomerVO> one = this.template.selectList("idcheck", id);
		String res = "ok";
		if (one.size() > 0) {
			res = "error";
		}
		return res;
	}
	public int join(CustomerVO cvo) {
		return this.template.insert("join", cvo);
	}
	
	public CustomerVO getOneCustomer(String c_idx){
		return template.selectOne("selectOneCustomer",c_idx);
	}
	
	public int customerModify(CustomerVO cvo){
		return template.update("c_modify",cvo);
	}
	
	public int customerDelete(String c_idx){
		return template.update("c_delete",c_idx);
	}
	// 쪽지목록 불러오기
	public List<MsgVO> getMsgList(Map<String, Integer> map){
		return template.selectList("selectMsgList", map);
	}
	// 쪽지 불러오기
	public MsgVO getMsg(String m_idx){
		return template.selectOne("selectMsg", m_idx);
	}
	// 쪽지 보내기
	public void insertMsg(MsgVO mvo){
		template.insert("insertMsg", mvo);
	}
	// 쪽지 개수 반환
	public int getMsgCount(String c_idx){
		return template.selectOne("totalMsgcount",c_idx);
	}
	// 안 읽은 쪽지 개수 반환
	public int getNewMsgCount(String c_idx){
		return template.selectOne("newMsgCount",c_idx);
	}
	// 쪽지 읽음 표시
	public void updateMsgReadChk(String m_idx){
		template.update("msgReadChk",m_idx);
	}
	// 쪽지 지우기
	public void deleteMsg(String m_idx){
		template.update("deleteMsg",m_idx);
	}
	
	//// 상담 ////
	// 모든 미답변 상담 목록 불러오기
	public List<CounselVO> getAllNewCounselList(){
		return template.selectList("select_all_counsel");
	}
	// 상담 목록 불러오기
	public List<CounselVO> selectCounselList(String c_idx){
		return template.selectList("select_personal_counsel", c_idx);
	}
	// 상담 불러오기
	public CounselVO selectOneCounsel(String counsel_idx){
		return template.selectOne("selectOneCounsel", counsel_idx);
	}
	// 상담 입력
	public void insertCounsel(CounselVO counselVO){
		template.insert("insert_personal_counsel", counselVO);
	}
	// 상담 답변
	public void answerCounsel(CounselVO counselVO){
		template.update("answerCounsel",counselVO);
	}
	// 상담 점수주기
	public void scoreCounsel(CounselVO counselVO){
		template.update("scoreCounsel",counselVO);
	}
	
	//// 게시판 ////
	// 글 목록 불러오기
	public List<BBS_VO> getBBSList(Map<String, Integer> map){
		return template.selectList("select_bbs",map);
	}
	// 공지사항 뿌리기
	public List<BBS_VO> getNotice(){
		return template.selectList("select_notice_for_main");
	}
	public List<BBS_VO> getNews(){
		return template.selectList("select_news_for_main");
	}
	// 게시글 수
	public int getTotalCount(String b_category){
		return template.selectOne("totalbbscount",b_category);
	}
	// 글 열람
	public BBS_VO getBBSView(String b_idx){
		return template.selectOne("select_bbs_view",b_idx);
	}
	// 히트수 갱신
	public void updateBBSHit(String b_idx){
		template.update("bbs_hit",b_idx);
	}
	// 글쓰기
	public void insertBBS(BBS_VO bvo){
		template.insert("bbs_insert",bvo);
	}
	// 글 지우기
	public void deleteBBS(String b_idx){
		template.update("bbs_delete",b_idx);
	}
	// 글 수정하기
	public void modifyBBS(BBS_VO bvo){
		template.update("bbs_modify", bvo);
	}
	// 댓글 불러오기
	public List<Reply_VO> getReplyList(String b_idx){
		return template.selectList("select_reply", b_idx);
	}
	// 댓글 달기
	public void insertReply(Reply_VO rvo){
		template.insert("insert_reply",rvo);
	}
	// 댓글 삭제
	public void deleteReply(String r_idx){
		template.update("delete_reply", r_idx);
	}
}

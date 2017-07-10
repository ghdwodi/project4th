package com.hb.db;

public class CounselVO {
	private String counsel_idx,c_idx,c_name,counsel_category,counsel_answer,title,counsel_content,answered,answerer,answer_name,req_date,answer_date;
	private int counsel_score;
	public CounselVO() {}
	public CounselVO(String counsel_idx, String c_idx, String c_name, String counsel_category,
			String counsel_answer, String title, String counsel_content, String answered, String answerer,
			String answer_name, String req_date,	String answer_date, int counsel_score) {
		super();
		this.counsel_idx = counsel_idx;
		this.c_idx = c_idx;
		this.c_name = c_name;
		this.counsel_category = counsel_category;
		this.counsel_answer = counsel_answer;
		this.title = title;
		this.counsel_content = counsel_content;
		this.answered = answered;
		this.answerer = answerer;
		this.answer_name = answer_name;
		this.req_date = req_date;
		this.answer_date = answer_date;
		this.counsel_score = counsel_score;
	}
	public String getCounsel_idx() {
		return counsel_idx;
	}
	public void setCounsel_idx(String counsel_idx) {
		this.counsel_idx = counsel_idx;
	}
	public String getC_idx() {
		return c_idx;
	}
	public void setC_idx(String c_idx) {
		this.c_idx = c_idx;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getCounsel_category() {
		return counsel_category;
	}
	public void setCounsel_category(String counsel_category) {
		this.counsel_category = counsel_category;
	}
	public String getCounsel_answer() {
		return counsel_answer;
	}
	public void setCounsel_answer(String counsel_answer) {
		this.counsel_answer = counsel_answer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCounsel_content() {
		return counsel_content;
	}
	public void setCounsel_content(String counsel_content) {
		this.counsel_content = counsel_content;
	}
	public String getAnswered() {
		return answered;
	}
	public void setAnswered(String answered) {
		this.answered = answered;
	}
	public String getAnswerer() {
		return answerer;
	}
	public void setAnswerer(String answerer) {
		this.answerer = answerer;
	}
	public String getReq_date() {
		return req_date;
	}
	public void setReq_date(String req_date) {
		this.req_date = req_date;
	}
	public String getAnswer_date() {
		return answer_date;
	}
	public void setAnswer_date(String answer_date) {
		this.answer_date = answer_date;
	}
	public int getCounsel_score() {
		return counsel_score;
	}
	public void setCounsel_score(int counsel_score) {
		this.counsel_score = counsel_score;
	}
	public String getAnswer_name() {
		return answer_name;
	}
	public void setAnswer_name(String answer_name) {
		this.answer_name = answer_name;
	}
}
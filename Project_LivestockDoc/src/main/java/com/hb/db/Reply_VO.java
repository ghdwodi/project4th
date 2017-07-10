package com.hb.db;

public class Reply_VO {
	private String r_idx,b_idx,content,c_idx,r_date,c_nickname;
	private int groups,step,lev;
	public Reply_VO() {}
	public Reply_VO(String r_idx, String b_idx, String content, String c_idx, String r_date, String c_nickname,
			int groups, int step, int lev) {
		super();
		this.r_idx = r_idx;
		this.b_idx = b_idx;
		this.content = content;
		this.c_idx = c_idx;
		this.r_date = r_date;
		this.c_nickname = c_nickname;
		this.groups = groups;
		this.step = step;
		this.lev = lev;
	}
	public String getR_idx() {
		return r_idx;
	}
	public void setR_idx(String r_idx) {
		this.r_idx = r_idx;
	}
	public String getB_idx() {
		return b_idx;
	}
	public void setB_idx(String b_idx) {
		this.b_idx = b_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getC_idx() {
		return c_idx;
	}
	public void setC_idx(String c_idx) {
		this.c_idx = c_idx;
	}
	public String getR_date() {
		return r_date;
	}
	public void setR_date(String r_date) {
		this.r_date = r_date;
	}
	public String getC_nickname() {
		return c_nickname;
	}
	public void setC_nickname(String c_nickname) {
		this.c_nickname = c_nickname;
	}
	public int getGroups() {
		return groups;
	}
	public void setGroups(int groups) {
		this.groups = groups;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
}

package com.hb.db;

public class BBS_VO {
	private String b_idx,title,b_pwd,hit,content,c_idx,c_nickname,b_date,b_category,deleted;
	public BBS_VO() {}
	public BBS_VO(String b_idx, String title, String b_pwd, String hit, String content, String c_idx, String c_nickname,
			String b_date, String b_category, String deleted) {
		super();
		this.b_idx = b_idx;
		this.title = title;
		this.b_pwd = b_pwd;
		this.hit = hit;
		this.content = content;
		this.c_idx = c_idx;
		this.c_nickname = c_nickname;
		this.b_date = b_date;
		this.b_category = b_category;
		this.deleted = deleted;
	}
	public String getB_idx() {
		return b_idx;
	}
	public void setB_idx(String b_idx) {
		this.b_idx = b_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getB_pwd() {
		return b_pwd;
	}
	public void setB_pwd(String b_pwd) {
		this.b_pwd = b_pwd;
	}
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
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
	public String getC_nickname() {
		return c_nickname;
	}
	public void setC_nickname(String c_nickname) {
		this.c_nickname = c_nickname;
	}
	public String getB_date() {
		return b_date;
	}
	public void setB_date(String b_date) {
		this.b_date = b_date;
	}
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	@Override
	public String toString() {
		return "BBS_VO [b_idx=" + b_idx + ", title=" + title + ", b_pwd=" + b_pwd + ", hit=" + hit + ", content="
				+ content + ", c_idx=" + c_idx + ", c_nickname=" + c_nickname + ", b_date=" + b_date + ", b_category="
				+ b_category + "]";
	}
}

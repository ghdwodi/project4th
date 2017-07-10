package com.hb.db;

public class MsgVO {
	String m_idx,c_idx,c_idx_sender,m_content,m_date,c_nickname,c_sender_nickname;
	int readchk;
	public MsgVO() {}
	public MsgVO(String m_idx, String c_idx, String c_idx_sender, String m_content, String m_date, String c_nickname,
			String c_sender_nickname,int readchk) {
		super();
		this.m_idx = m_idx;
		this.c_idx = c_idx;
		this.c_idx_sender = c_idx_sender;
		this.m_content = m_content;
		this.m_date = m_date;
		this.c_nickname = c_nickname;
		this.c_sender_nickname = c_sender_nickname;
		this.readchk = readchk;
	}
	public String getM_idx() {
		return m_idx;
	}
	public void setM_idx(String m_idx) {
		this.m_idx = m_idx;
	}
	public String getC_idx() {
		return c_idx;
	}
	public void setC_idx(String c_idx) {
		this.c_idx = c_idx;
	}
	public String getC_idx_sender() {
		return c_idx_sender;
	}
	public void setC_idx_sender(String c_idx_sender) {
		this.c_idx_sender = c_idx_sender;
	}
	public String getM_content() {
		return m_content;
	}
	public void setM_content(String m_content) {
		this.m_content = m_content;
	}
	public String getM_date() {
		return m_date;
	}
	public void setM_date(String m_date) {
		this.m_date = m_date;
	}
	public String getC_nickname() {
		return c_nickname;
	}
	public void setC_nickname(String c_nickname) {
		this.c_nickname = c_nickname;
	}
	public String getC_sender_nickname() {
		return c_sender_nickname;
	}
	public void setC_sender_nickname(String c_sender_nickname) {
		this.c_sender_nickname = c_sender_nickname;
	}
	public int getReadchk() {
		return readchk;
	}
	public void setReadchk(int readchk) {
		this.readchk = readchk;
	}
}

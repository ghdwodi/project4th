package com.hb.myproject;

import java.util.HashMap;
import java.util.Map;

public class Paging {
	int nowPage;
	int nowBlock;
	int totalRecord;
	int numPerPage;
	int pagePerBlock;
	int totalPage;
	int totalBlock;
	int begin;
	int end;
	int beginPage;
	int endPage;
	Map<String, Integer> map;

	public Paging() {
		this.nowPage = 1;
		this.nowBlock = 1;
		this.numPerPage = 10;
		this.pagePerBlock = 10;
	}

	public void setBeginPage() {
		beginPage = (int)((nowPage-1)/pagePerBlock)*pagePerBlock+1;
		System.out.println("시작 페이지 : "+beginPage);
	}

	public void setEndPage() {
		this.endPage = (this.beginPage + this.pagePerBlock - 1);
		if (this.endPage > this.totalPage) {
			this.endPage = this.totalPage;
		}
		System.out.println("끝 페이지 : "+endPage);
	}

	public int getNowPage() {
		return this.nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getNowBlock() {
		return this.nowBlock;
	}

	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}

	public int getTotalRecord() {
		return this.totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getNumPerPage() {
		return this.numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public int getPagePerBlock() {
		return this.pagePerBlock;
	}

	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}

	public int getTotalPage() {
		return this.totalPage;
	}

	public void setTotalPage() {
		this.totalPage = (this.totalRecord / this.numPerPage);
		if (this.totalRecord % this.numPerPage != 0) {
			this.totalPage += 1;
		}
		System.out.println("총 페이지수 : "+totalPage);
	}

	public int getTotalBlock() {
		return this.totalBlock;
	}

	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}

	public int getBegin() {
		return this.begin;
	}

	public void setBegin() {
		this.begin = ((this.nowPage - 1) * this.numPerPage + 1);
		System.out.println("시작 : "+begin);
	}

	public int getEnd() {
		return this.end;
	}

	public void setEnd() {
		this.end = (this.begin - 1 + this.numPerPage);
		System.out.println("끝 : "+end);
	}

	public int getBeginPage() {
		return this.beginPage;
	}

	public int getEndPage() {
		return this.endPage;
	}

	public Map<String, Integer> getMap() {
		return this.map;
	}

	public void setMap() {
		this.map = new HashMap<String, Integer>();
		this.map.put("begin", Integer.valueOf(this.begin));
		this.map.put("end", Integer.valueOf(this.end));
	}
}

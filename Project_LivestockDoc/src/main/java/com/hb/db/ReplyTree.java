package com.hb.db;

public class ReplyTree {
	public String insertReply(int i, String name, String content){
		String replydiv = "<div class='media rep_"+i+"'>";
		replydiv += "<div class='media-body'>";
		replydiv += "<p>"+name+"</p>";
		replydiv += content+"</div></div>";
		return replydiv;
	}
}

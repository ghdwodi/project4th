package com.hb.db;

public class CustomerVO
{
  private String c_idx,id,pwd,name,nickname,email,phone,mobilephone,addrnum,addr,addr2,mailservice,smsservice,c_category,c_authority;
  
  public CustomerVO() {}
  public CustomerVO(String c_idx, String id, String pwd, String name, String nickname, String email, String phone, String mobilephone, String addrnum, String addr, String addr2, String mailservice, String smsservice, String c_category, String c_authority)
  {
    this.c_idx = c_idx;
    this.id = id;
    this.pwd = pwd;
    this.name = name;
    this.nickname = nickname;
    this.email = email;
    this.phone = phone;
    this.mobilephone = mobilephone;
    this.addrnum = addrnum;
    this.addr = addr;
    this.addr2 = addr2;
    this.mailservice = mailservice;
    this.smsservice = smsservice;
    this.c_category = c_category;
    this.c_authority = c_authority;
  }
  
  public String getC_idx()
  {
    return this.c_idx;
  }
  
  public void setC_idx(String c_idx)
  {
    this.c_idx = c_idx;
  }
  
  public String getId()
  {
    return this.id;
  }
  
  public void setId(String id)
  {
    this.id = id;
  }
  
  public String getPwd()
  {
    return this.pwd;
  }
  
  public void setPwd(String pwd)
  {
    this.pwd = pwd;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getNickname()
  {
    return this.nickname;
  }
  
  public void setNickname(String nickname)
  {
    this.nickname = nickname;
  }
  
  public String getEmail()
  {
    return this.email;
  }
  
  public void setEmail(String email)
  {
    this.email = email;
  }
  
  public String getPhone()
  {
    return this.phone;
  }
  
  public void setPhone(String phone)
  {
    this.phone = phone;
  }
  
  public String getMobilephone()
  {
    return this.mobilephone;
  }
  
  public void setMobilephone(String mobilephone)
  {
    this.mobilephone = mobilephone;
  }
  
  public String getAddrnum()
  {
    return this.addrnum;
  }
  
  public void setAddrnum(String addrnum)
  {
    this.addrnum = addrnum;
  }
  
  public String getAddr()
  {
    return this.addr;
  }
  
  public void setAddr(String addr)
  {
    this.addr = addr;
  }
  
  public String getAddr2()
  {
    return this.addr2;
  }
  
  public void setAddr2(String addr2)
  {
    this.addr2 = addr2;
  }
  
  public String getMailservice()
  {
    return this.mailservice;
  }
  
  public void setMailservice(String mailservice)
  {
    this.mailservice = mailservice;
  }
  
  public String getSmsservice()
  {
    return this.smsservice;
  }
  
  public void setSmsservice(String smsservice)
  {
    this.smsservice = smsservice;
  }
  
  public String getC_category()
  {
    return this.c_category;
  }
  
  public void setC_category(String c_category)
  {
    this.c_category = c_category;
  }
  
  public String getC_authority()
  {
    return this.c_authority;
  }
  
  public void setC_authority(String c_authority)
  {
    this.c_authority = c_authority;
  }
  
  public String toString()
  {
    return 
    
      "CustomerVO [c_idx=" + this.c_idx + ", id=" + this.id + ", pwd=" + this.pwd + ", name=" + this.name + ", nickname=" + this.nickname + ", email=" + this.email + ", phone=" + this.phone + ", mobilephone=" + this.mobilephone + ", addrnum=" + this.addrnum + ", addr=" + this.addr + ", addr2=" + this.addr2 + ", mailservice=" + this.mailservice + ", smsservice=" + this.smsservice + ", c_category=" + this.c_category + ", c_authority=" + this.c_authority + "]";
  }
}
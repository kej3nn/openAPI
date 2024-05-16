package egovframework.admin.stat.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class StatUseFB extends CommVo implements Serializable{
	private String yyyyMmDd;
	private String userCnt;
	private String keyCnt;
	private String reCnt;
	private String qaCnt;
	private String gaCnt;
	private String pubDttmFrom;
	private String pubDttmTo;
	
	private String columnNm;
	private String columnNmEng;
	public String getYyyyMmDd() {
		return yyyyMmDd;
	}
	public void setYyyyMmDd(String yyyyMmDd) {
		this.yyyyMmDd = yyyyMmDd;
	}
	public String getUserCnt() {
		return userCnt;
	}
	public void setUserCnt(String userCnt) {
		this.userCnt = userCnt;
	}
	public String getKeyCnt() {
		return keyCnt;
	}
	public void setKeyCnt(String keyCnt) {
		this.keyCnt = keyCnt;
	}
	public String getReCnt() {
		return reCnt;
	}
	public void setReCnt(String reCnt) {
		this.reCnt = reCnt;
	}
	public String getQaCnt() {
		return qaCnt;
	}
	public void setQaCnt(String qaCnt) {
		this.qaCnt = qaCnt;
	}
	public String getGaCnt() {
		return gaCnt;
	}
	public void setGaCnt(String gaCnt) {
		this.gaCnt = gaCnt;
	}
	public String getPubDttmFrom() {
		return pubDttmFrom;
	}
	public void setPubDttmFrom(String pubDttmFrom) {
		this.pubDttmFrom = pubDttmFrom;
	}
	public String getPubDttmTo() {
		return pubDttmTo;
	}
	public void setPubDttmTo(String pubDttmTo) {
		this.pubDttmTo = pubDttmTo;
	}
	public String getColumnNm() {
		return columnNm;
	}
	public void setColumnNm(String columnNm) {
		this.columnNm = columnNm;
	}
	public String getColumnNmEng() {
		return columnNmEng;
	}
	public void setColumnNmEng(String columnNmEng) {
		this.columnNmEng = columnNmEng;
	}
	
	
	
}

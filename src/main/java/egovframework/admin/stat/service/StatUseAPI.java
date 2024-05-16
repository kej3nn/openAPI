package egovframework.admin.stat.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class StatUseAPI extends CommVo implements Serializable{
	private String yyyyMmDd;
	private String infCnt;
	private String callCnt;
	private String rowCnt;
	private String avgLt;
	private String dbSize;
	private String outSize;
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
	public String getInfCnt() {
		return infCnt;
	}
	public void setInfCnt(String infCnt) {
		this.infCnt = infCnt;
	}
	public String getCallCnt() {
		return callCnt;
	}
	public void setCallCnt(String callCnt) {
		this.callCnt = callCnt;
	}
	public String getRowCnt() {
		return rowCnt;
	}
	public void setRowCnt(String rowCnt) {
		this.rowCnt = rowCnt;
	}
	public String getAvgLt() {
		return avgLt;
	}
	public void setAvgLt(String avgLt) {
		this.avgLt = avgLt;
	}
	public String getDbSize() {
		return dbSize;
	}
	public void setDbSize(String dbSize) {
		this.dbSize = dbSize;
	}
	public String getOutSize() {
		return outSize;
	}
	public void setOutSize(String outSize) {
		this.outSize = outSize;
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

package egovframework.portal.service.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class OpenInfLog implements Serializable {
	
	private String sysTag;
	private String srvCd;
	private String userCd;
	private String userIp;
	private String saveExt;
	private int rowCnt;
	private String leadTime;
	private long dbSize;
	private long outSize;
	private String infId ;
	private int infSeq;
	private int fileSeq;
	private int fileSizeKb;
	private int fileSize;
	private int linkSeq;
	private String menuUrl;
	private String menuNm;
	private int totCnt;
	private String regDttm;
	private String logCnt;
	
	
	public String getSysTag() {
		return sysTag;
	}
	public void setSysTag(String sysTag) {
		this.sysTag = sysTag;
	}
	public String getUserCd() {
		return userCd;
	}
	public void setUserCd(String userCd) {
		this.userCd = userCd;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public String getSaveExt() {
		return saveExt;
	}
	public void setSaveExt(String saveExt) {
		this.saveExt = saveExt;
	}
	public int getRowCnt() {
		return rowCnt;
	}
	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
	}
	public String getLeadTime() {
		return leadTime;
	}
	public void setLeadTime(String leadTime) {
		this.leadTime = leadTime;
	}
	public long getDbSize() {
		return dbSize;
	}
	public void setDbSize(long dbSize) {
		this.dbSize = dbSize;
	}
	public long getOutSize() {
		return outSize;
	}
	public void setOutSize(long outSize) {
		this.outSize = outSize;
	}
	public String getInfId() {
		return infId;
	}
	public void setInfId(String infId) {
		this.infId = infId;
	}
	public int getInfSeq() {
		return infSeq;
	}
	public void setInfSeq(int infSeq) {
		this.infSeq = infSeq;
	}
	public String getSrvCd() {
		return srvCd;
	}
	public void setSrvCd(String srvCd) {
		this.srvCd = srvCd;
	}
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public int getFileSizeKb() {
		return fileSizeKb;
	}
	public void setFileSizeKb(int fileSizeKb) {
		this.fileSizeKb = fileSizeKb;
	}
	public int getLinkSeq() {
		return linkSeq;
	}
	public void setLinkSeq(int linkSeq) {
		this.linkSeq = linkSeq;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public int getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getLogCnt() {
		return logCnt;
	}
	public void setLogCnt(String logCnt) {
		this.logCnt = logCnt;
	}
	
}
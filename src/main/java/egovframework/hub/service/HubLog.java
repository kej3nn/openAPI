package egovframework.hub.service;

import java.io.Serializable;

/**
 * OPEN API LOG getting,setting class
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */
public class HubLog extends HubApiMsg implements Serializable {

	private static final long serialVersionUID = 1L;
	private int userCd;
	private int keySeq;
	private String userIp;
	private int reqCnt;
	private int rowCnt;
	private String leadTime;
	private long dbSize;
	private long outSize;
	
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public int getReqCnt() {
		return reqCnt;
	}
	public void setReqCnt(int reqCnt) {
		this.reqCnt = reqCnt;
	}
	public int getRowCnt() {
		return rowCnt;
	}
	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
	}
	public long getDbSize() {
		return dbSize;
	}
	public void setDbSize(long dbSize) {
		this.dbSize = dbSize;
	}
	
	public String getLeadTime() {
		return leadTime;
	}
	public void setLeadTime(String leadTime) {
		this.leadTime = leadTime;
	}
	public long getOutSize() {
		return outSize;
	}
	public void setOutSize(long outSize) {
		this.outSize = outSize;
	}
	
	public int getUserCd() {
		return userCd;
	}
	public void setUserCd(int userCd) {
		this.userCd = userCd;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getKeySeq() {
		return keySeq;
	}
	public void setKeySeq(int keySeq) {
		this.keySeq = keySeq;
	}
}

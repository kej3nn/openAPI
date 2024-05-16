package egovframework.admin.mainmng.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

public class MainMngOrder extends CommVo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4669619546917261675L;

	private String seqceNo;
	private String srvTit;
	private String homeTagCd;
	private String homeTagNm;
	private String strtDttm;
	private String endDttm;
	private String linkUrl;
	private String saveFileNm;
	private String subSaveFileNm;
	private String popupYn;
	private String vOrder;
	private String useYn;

	public String getSrvTit() {
		return srvTit;
	}

	public void setSrvTit(String srvTit) {
		this.srvTit = srvTit;
	}

	public String getHomeTagCd() {
		return homeTagCd;
	}

	public void setHomeTagCd(String homeTagCd) {
		this.homeTagCd = homeTagCd;
	}

	public String getStrtDttm() {
		return strtDttm;
	}

	public void setStrtDttm(String strtDttm) {
		this.strtDttm = strtDttm;
	}

	public String getEndDttm() {
		return endDttm;
	}

	public void setEndDttm(String endDttm) {
		this.endDttm = endDttm;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}

	public String getSaveFileNm() {
		return saveFileNm;
	}

	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}

	public String getPopupYn() {
		return popupYn;
	}

	public void setPopupYn(String popupYn) {
		this.popupYn = popupYn;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getSeqceNo() {
		return seqceNo;
	}

	public void setSeqceNo(String seqceNo) {
		this.seqceNo = seqceNo;
	}

	public String getvOrder() {
		return vOrder;
	}

	public void setvOrder(String vOrder) {
		this.vOrder = vOrder;
	}

	public String getHomeTagNm() {
		return homeTagNm;
	}

	public void setHomeTagNm(String homeTagNm) {
		this.homeTagNm = homeTagNm;
	}

	public String getSubSaveFileNm() {
		return subSaveFileNm;
	}

	public void setSubSaveFileNm(String subSaveFileNm) {
		this.subSaveFileNm = subSaveFileNm;
	}
	
	
	
}

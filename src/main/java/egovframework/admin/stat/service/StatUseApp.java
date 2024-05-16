package egovframework.admin.stat.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class StatUseApp extends CommVo implements Serializable{
	private String yyyyMmDd;
	private String infId;
	private String infNm;
	private String reVal;
	private String open_dttm;
	private String srvCd;
	private String cateId;
	private String cateNm;
	private String cateFullNm;
	private String dtId;
	private String dtNm;
	private String orgCd;
	private String orgNm;
	private String usrCd;
	private String usrNm;
	
	private String pubDttmFrom;
	private String pubDttmTo;
	private String openDttm;
	
	private Integer userCnt;
	private Integer keyCnt;
	private Integer reCnt;
	private Integer qaCnt;
	private Integer gaCnt;
	
	
	public Integer getUserCnt() {
		return userCnt;
	}
	public void setUserCnt(Integer userCnt) {
		this.userCnt = userCnt;
	}
	public Integer getKeyCnt() {
		return keyCnt;
	}
	public void setKeyCnt(Integer keyCnt) {
		this.keyCnt = keyCnt;
	}
	public Integer getReCnt() {
		return reCnt;
	}
	public void setReCnt(Integer reCnt) {
		this.reCnt = reCnt;
	}
	public Integer getQaCnt() {
		return qaCnt;
	}
	public void setQaCnt(Integer qaCnt) {
		this.qaCnt = qaCnt;
	}
	public Integer getGaCnt() {
		return gaCnt;
	}
	public void setGaCnt(Integer gaCnt) {
		this.gaCnt = gaCnt;
	}
	public String getYyyyMmDd() {
		return yyyyMmDd;
	}
	public void setYyyyMmDd(String yyyyMmDd) {
		this.yyyyMmDd = yyyyMmDd;
	}
	public String getInfId() {
		return infId;
	}
	public void setInfId(String infId) {
		this.infId = infId;
	}
	public String getInfNm() {
		return infNm;
	}
	public void setInfNm(String infNm) {
		this.infNm = infNm;
	}
	public String getReVal() {
		return reVal;
	}
	public void setReVal(String reVal) {
		this.reVal = reVal;
	}
	public String getOpen_dttm() {
		return open_dttm;
	}
	public void setOpen_dttm(String open_dttm) {
		this.open_dttm = open_dttm;
	}
	public String getSrvCd() {
		return srvCd;
	}
	public void setSrvCd(String srvCd) {
		this.srvCd = srvCd;
	}
	public String getCateId() {
		return cateId;
	}
	public void setCateId(String cateId) {
		this.cateId = cateId;
	}
	public String getCateNm() {
		return cateNm;
	}
	public void setCateNm(String cateNm) {
		this.cateNm = cateNm;
	}
	public String getCateFullNm() {
		return cateFullNm;
	}
	public void setCateFullNm(String cateFullNm) {
		this.cateFullNm = cateFullNm;
	}
	public String getDtId() {
		return dtId;
	}
	public void setDtId(String dtId) {
		this.dtId = dtId;
	}
	public String getDtNm() {
		return dtNm;
	}
	public void setDtNm(String dtNm) {
		this.dtNm = dtNm;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	public String getOrgNm() {
		return orgNm;
	}
	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}
	public String getUsrCd() {
		return usrCd;
	}
	public void setUsrCd(String usrCd) {
		this.usrCd = usrCd;
	}
	public String getUsrNm() {
		return usrNm;
	}
	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
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
	public String getOpenDttm() {
		return openDttm;
	}
	public void setOpenDttm(String openDttm) {
		this.openDttm = openDttm;
	}
		
	
}

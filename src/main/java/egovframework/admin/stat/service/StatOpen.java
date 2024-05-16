package egovframework.admin.stat.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class StatOpen extends CommVo implements Serializable{
	private String mode;
	private String yyyyMmDd;
	private String dd;
	private String mm;
	private String yy;
	private String cateId;
	private String cateNm;
	private String dtId;
	private String dtNm;
	private String orgCd;
	private String orgNm;
	private String infCnt;
	private String srvCnt;
	private String sCnt;
	private String tCnt;
	private String cCnt;
	private String mCnt;
	private String fCnt;
	private String lCnt;
	private String aCnt;

	private String pubDttmFrom;
	private String pubDttmTo;
	private String yColQuery;
	private String xColQuery;
	private String colId;
	
	private String columnNm;
	
	private String vCnt;
	//private String vnCnt;
	//private String ctCnt;
	
	private String cateNmTop;
	
	public String getyColQuery() {
		return yColQuery;
	}
	public void setyColQuery(String yColQuery) {
		this.yColQuery = yColQuery;
	}
	public String getxColQuery() {
		return xColQuery;
	}
	public void setxColQuery(String xColQuery) {
		this.xColQuery = xColQuery;
	}
	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
	}		
	public String getYyyyMmDd() {
		return yyyyMmDd;
	}
	public void setYyyyMmDd(String yyyyMmDd) {
		this.yyyyMmDd = yyyyMmDd;
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
	public String getInfCnt() {
		return infCnt;
	}
	public void setInfCnt(String infCnt) {
		this.infCnt = infCnt;
	}
	public String getSrvCnt() {
		return srvCnt;
	}
	public void setSrvCnt(String srvCnt) {
		this.srvCnt = srvCnt;
	}
	public String getsCnt() {
		return sCnt;
	}
	public void setsCnt(String sCnt) {
		this.sCnt = sCnt;
	}
	public String gettCnt() {
		return tCnt;
	}
	public void settCnt(String tCnt) {
		this.tCnt = tCnt;
	}
	public String getcCnt() {
		return cCnt;
	}
	public void setcCnt(String cCnt) {
		this.cCnt = cCnt;
	}
	public String getmCnt() {
		return mCnt;
	}
	public void setmCnt(String mCnt) {
		this.mCnt = mCnt;
	}
	public String getfCnt() {
		return fCnt;
	}
	public void setfCnt(String fCnt) {
		this.fCnt = fCnt;
	}
	public String getlCnt() {
		return lCnt;
	}
	public void setlCnt(String lCnt) {
		this.lCnt = lCnt;
	}
	public String getaCnt() {
		return aCnt;
	}
	public void setaCnt(String aCnt) {
		this.aCnt = aCnt;
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
	public String getDd() {
		return dd;
	}
	public void setDd(String dd) {
		this.dd = dd;
	}
	public String getMm() {
		return mm;
	}
	public void setMm(String mm) {
		this.mm = mm;
	}
	public String getYy() {
		return yy;
	}
	public void setYy(String yy) {
		this.yy = yy;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getvCnt() {
		return vCnt;
	}
	public void setvCnt(String vCnt) {
		this.vCnt = vCnt;
	}
	public String getCateNmTop() {
		return cateNmTop;
	}
	public void setCateNmTop(String cateNmTop) {
		this.cateNmTop = cateNmTop;
	}
	
	
}

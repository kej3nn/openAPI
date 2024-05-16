package egovframework.admin.stat.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class StatUse extends CommVo implements Serializable{
	private String yyyyMmDd;
	private String mode;
	private String cateId;
	private String cateNm;
	private String dtId;
	private String dtNm;
	private String orgCd;
	private String orgNm;
	private String totUseCnt;
	private String sUseCnt;
	private String tUseCnt;
	private String cUseCnt;
	private String mUseCnt;
	private String fUseCnt;
	private String lUseCnt;
	private String aUseCnt;
	
	private String vUseCnt;        
	private String excelCnt;
	private String csvCnt;
	private String jsonCnt;
	private String xmlCnt;
	private String txtCnt;
	private String fileUseCnt;
	private String linkUseCnt;
	private String apiUseCnt;
	private String apisUseCnt;
	
	private String pubDttmFrom;
	private String pubDttmTo;
	
	private String columnNm;
	private String columnNmEng;
	
	private String vnCnt;
	
	private String infNm;
	
	private String cateNmTop;
	
	public String getvUseCnt() {
		return vUseCnt;
	}
	public void setvUseCnt(String vUseCnt) {
		this.vUseCnt = vUseCnt;
	}
	public String getExcelCnt() {
		return excelCnt;
	}
	public void setExcelCnt(String excelCnt) {
		this.excelCnt = excelCnt;
	}
	public String getCsvCnt() {
		return csvCnt;
	}
	public void setCsvCnt(String csvCnt) {
		this.csvCnt = csvCnt;
	}
	public String getJsonCnt() {
		return jsonCnt;
	}
	public void setJsonCnt(String jsonCnt) {
		this.jsonCnt = jsonCnt;
	}
	public String getXmlCnt() {
		return xmlCnt;
	}
	public void setXmlCnt(String xmlCnt) {
		this.xmlCnt = xmlCnt;
	}
	public String getTxtCnt() {
		return txtCnt;
	}
	public void setTxtCnt(String txtCnt) {
		this.txtCnt = txtCnt;
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
	public String getTotUseCnt() {
		return totUseCnt;
	}
	public void setTotUseCnt(String totUseCnt) {
		this.totUseCnt = totUseCnt;
	}
	public String getsUseCnt() {
		return sUseCnt;
	}
	public void setsUseCnt(String sUseCnt) {
		this.sUseCnt = sUseCnt;
	}
	public String gettUseCnt() {
		return tUseCnt;
	}
	public void settUseCnt(String tUseCnt) {
		this.tUseCnt = tUseCnt;
	}
	public String getcUseCnt() {
		return cUseCnt;
	}
	public void setcUseCnt(String cUseCnt) {
		this.cUseCnt = cUseCnt;
	}
	public String getmUseCnt() {
		return mUseCnt;
	}
	public void setmUseCnt(String mUseCnt) {
		this.mUseCnt = mUseCnt;
	}
	public String getfUseCnt() {
		return fUseCnt;
	}
	public void setfUseCnt(String fUseCnt) {
		this.fUseCnt = fUseCnt;
	}
	public String getlUseCnt() {
		return lUseCnt;
	}
	public void setlUseCnt(String lUseCnt) {
		this.lUseCnt = lUseCnt;
	}
	public String getaUseCnt() {
		return aUseCnt;
	}
	public void setaUseCnt(String aUseCnt) {
		this.aUseCnt = aUseCnt;
	}
	
	public String getFileUseCnt() {
		return fileUseCnt;
	}
	public void setFileUseCnt(String fileUseCnt) {
		this.fileUseCnt = fileUseCnt;
	}
	public String getLinkUseCnt() {
		return linkUseCnt;
	}
	public void setLinkUseCnt(String linkUseCnt) {
		this.linkUseCnt = linkUseCnt;
	}
	public String getApiUseCnt() {
		return apiUseCnt;
	}
	public void setApiUseCnt(String apiUseCnt) {
		this.apiUseCnt = apiUseCnt;
	}
	public String getApisUseCnt() {
		return apisUseCnt;
	}
	public void setApisUseCnt(String apisUseCnt) {
		this.apisUseCnt = apisUseCnt;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getVnCnt() {
		return vnCnt;
	}
	public void setVnCnt(String vnCnt) {
		this.vnCnt = vnCnt;
	}
	public String getInfNm() {
		return infNm;
	}
	public void setInfNm(String infNm) {
		this.infNm = infNm;
	}
	public String getCateNmTop() {
		return cateNmTop;
	}
	public void setCateNmTop(String cateNmTop) {
		this.cateNmTop = cateNmTop;
	}

	
	
}

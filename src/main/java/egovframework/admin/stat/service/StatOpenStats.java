package egovframework.admin.stat.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;

/**
 * 개방 및 활용 통계 
 * @since 2014.10.23
 * @author jyson
 *
 */

@SuppressWarnings("serial")
public class StatOpenStats extends CommVo implements Serializable{

	private String orgCd;  
	private String orgNm; //제공기관
	private String dtCnt; //보유데이터 (건)
	private String infCnt;  //공공데이터(건) 
	private String srvTot;  // 전체서비스(건)
	private String sheetCnt;  // Sheet(수)
	private String chartCnt;  // Chart(수)
	private String mapCnt;  // Map(수)
	private String fileCnt;  // File(수)
	private String linkCnt;  // Link(수)
	private String openApiCnt;  // Open API(수)
	private String vCnt;  // 멀티미디어(수)
	
	
	
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



	public String getDtCnt() {
		return dtCnt;
	}



	public void setDtCnt(String dtCnt) {
		this.dtCnt = dtCnt;
	}



	public String getInfCnt() {
		return infCnt;
	}



	public void setInfCnt(String infCnt) {
		this.infCnt = infCnt;
	}



	public String getSrvTot() {
		return srvTot;
	}



	public void setSrvTot(String srvTot) {
		this.srvTot = srvTot;
	}



	



	



	public String getChartCnt() {
		return chartCnt;
	}



	public void setChartCnt(String chartCnt) {
		this.chartCnt = chartCnt;
	}



	public String getMapCnt() {
		return mapCnt;
	}



	public void setMapCnt(String mapCnt) {
		this.mapCnt = mapCnt;
	}



	public String getFileCnt() {
		return fileCnt;
	}



	public void setFileCnt(String fileCnt) {
		this.fileCnt = fileCnt;
	}



	public String getLinkCnt() {
		return linkCnt;
	}



	public void setLinkCnt(String linkCnt) {
		this.linkCnt = linkCnt;
	}



	public String getOpenApiCnt() {
		return openApiCnt;
	}



	public void setOpenApiCnt(String openApiCnt) {
		this.openApiCnt = openApiCnt;
	}



	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}



	public String getSheetCnt() {
		return sheetCnt;
	}



	public void setSheetCnt(String sheetCnt) {
		this.sheetCnt = sheetCnt;
	}



	public String getvCnt() {
		return vCnt;
	}



	public void setvCnt(String vCnt) {
		this.vCnt = vCnt;
	}
}

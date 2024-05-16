package egovframework.admin.stat.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.common.grid.CommVo;
import lombok.Getter;
import lombok.Setter;

public class StatsStddTblItm extends CommVo implements Serializable {
	private List<StatsStddTblItm> list;
	private String chk;
	private String stddItmNm;
	private String status;
	private String statblId;
	private int datano;
	private int parDatano;
	private String itmTag;
	private int itmId;
	private String itmNm;
	private String viewItmNm;
	private String engViewItmNm;
	private String chartItmNm;
	private String EngChartItmNm;
	private String dummyYn;
	private String chckCd;
	private String uiId;
	private String uiNm;
	private String cmmtIdtfr;
	private String cmmtCont;
	private String engCmmtCont;
	private String inputNeedYn;
	private String defSelYn;
	private String cDefSelYn;
	private String seriesCd;
	private String useYn;
	private int vOrder;
	private String regId;
	private String updId;
	private int depth;
	private String sumavgYn;
	private String refCd;
	private String dmpointCd;
	private String itmStartYm;
	private String itmEndYm;
	
	private String gb;
	private String usrId;
	
	public List<StatsStddTblItm> getList() {
		List<StatsStddTblItm> aliList;
		if ( list != null && list.size() > 0 ) {
			aliList = new ArrayList<StatsStddTblItm>();
			for (StatsStddTblItm itm : list) {
				aliList.add(itm);
			}
			return aliList;
		}
		else {
			return null;
		}
	}
	
	public void setList(List<StatsStddTblItm> list) {
		if ( list.size() > 0 ) {
			this.list = new ArrayList<StatsStddTblItm> ();
			for ( StatsStddTblItm itm : list ) {
				this.list.add(itm);
			}
		}
		else {
			this.list = null;
		}
	}
	public String getChk() {
		return chk;
	}
	public void setChk(String chk) {
		this.chk = chk;
	}
	public String getStddItmNm() {
		return stddItmNm;
	}
	public void setStddItmNm(String stddItmNm) {
		this.stddItmNm = stddItmNm;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatblId() {
		return statblId;
	}
	public void setStatblId(String statblId) {
		this.statblId = statblId;
	}
	public int getDatano() {
		return datano;
	}
	public void setDatano(int datano) {
		this.datano = datano;
	}
	public int getParDatano() {
		return parDatano;
	}
	public void setParDatano(int parDatano) {
		this.parDatano = parDatano;
	}
	public String getItmTag() {
		return itmTag;
	}
	public void setItmTag(String itmTag) {
		this.itmTag = itmTag;
	}
	public int getItmId() {
		return itmId;
	}
	public void setItmId(int itmId) {
		this.itmId = itmId;
	}
	public String getItmNm() {
		return itmNm;
	}
	public void setItmNm(String itmNm) {
		this.itmNm = itmNm;
	}
	public String getViewItmNm() {
		return viewItmNm;
	}
	public void setViewItmNm(String viewItmNm) {
		this.viewItmNm = viewItmNm;
	}
	public String getDummyYn() {
		return dummyYn;
	}
	public void setDummyYn(String dummyYn) {
		this.dummyYn = dummyYn;
	}
	public String getChckCd() {
		return chckCd;
	}
	public void setChckCd(String chckCd) {
		this.chckCd = chckCd;
	}
	public String getUiId() {
		return uiId;
	}
	public void setUiId(String uiId) {
		this.uiId = uiId;
	}
	public String getUiNm() {
		return uiNm;
	}
	public void setUiNm(String uiNm) {
		this.uiNm = uiNm;
	}
	public String getCmmtIdtfr() {
		return cmmtIdtfr;
	}
	public void setCmmtIdtfr(String cmmtIdtfr) {
		this.cmmtIdtfr = cmmtIdtfr;
	}
	public String getCmmtCont() {
		return cmmtCont;
	}
	public void setCmmtCont(String cmmtCont) {
		this.cmmtCont = cmmtCont;
	}
	public String getInputNeedYn() {
		return inputNeedYn;
	}
	public void setInputNeedYn(String inputNeedYn) {
		this.inputNeedYn = inputNeedYn;
	}
	public String getDefSelYn() {
		return defSelYn;
	}
	public void setDefSelYn(String defSelYn) {
		this.defSelYn = defSelYn;
	}
	public String getSeriesCd() {
		return seriesCd;
	}
	public void setSeriesCd(String seriesCd) {
		this.seriesCd = seriesCd;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public int getvOrder() {
		return vOrder;
	}
	public void setvOrder(int vOrder) {
		this.vOrder = vOrder;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getUpdId() {
		return updId;
	}
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getEngViewItmNm() {
		return engViewItmNm;
	}
	public void setEngViewItmNm(String engViewItmNm) {
		this.engViewItmNm = engViewItmNm;
	}
	public String getChartItmNm() {
		return chartItmNm;
	}
	public void setChartItmNm(String chartItmNm) {
		this.chartItmNm = chartItmNm;
	}
	public String getEngChartItmNm() {
		return EngChartItmNm;
	}
	public void setEngChartItmNm(String engChartItmNm) {
		EngChartItmNm = engChartItmNm;
	}
	public String getEngCmmtCont() {
		return engCmmtCont;
	}
	public void setEngCmmtCont(String engCmmtCont) {
		this.engCmmtCont = engCmmtCont;
	}
	public String getSumavgYn() {
		return sumavgYn;
	}
	public void setSumavgYn(String sumavgYn) {
		this.sumavgYn = sumavgYn;
	}
	public String getRefCd() {
		return refCd;
	}
	public void setRefCd(String refCd) {
		this.refCd = refCd;
	}
	public String getGb() {
		return gb;
	}
	public void setGb(String gb) {
		this.gb = gb;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getDmpointCd() {
		return dmpointCd;
	}
	public void setDmpointCd(String dmpointCd) {
		this.dmpointCd = dmpointCd;
	}
	public String getItmStartYm() {
		return itmStartYm;
	}
	public void setItmStartYm(String itmStartYm) {
		this.itmStartYm = itmStartYm;
	}
	public String getItmEndYm() {
		return itmEndYm;
	}
	public void setItmEndYm(String itmEndYm) {
		this.itmEndYm = itmEndYm;
	}
	public String getcDefSelYn() {
		return cDefSelYn;
	}
	public void setcDefSelYn(String cDefSelYn) {
		this.cDefSelYn = cDefSelYn;
	}
	
}

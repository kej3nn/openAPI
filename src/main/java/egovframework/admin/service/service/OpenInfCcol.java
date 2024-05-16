package egovframework.admin.service.service;

import java.io.Serializable;
import java.util.Date;

import egovframework.common.util.UtilString;

@SuppressWarnings("serial")
public class OpenInfCcol extends OpenInfSrv implements Serializable {

    private String xaxisYn;
    private String seriesCd;
    private String yaxisPos;
    private String sortTag;
    private String vOrder;
    private String viewYn;
    private String condYn;
    private String condOp;
    private String condVar;
    private String filtYn;
    private String filtCd;
    private int filtMaxDay;
    private String filtTblCd;
    private String filtTblCc;
    private String filtTblCn;
    private String filtCode;
    private String filtDefault;
    private String filtNeed;
    private String useYn;
    private String regId;
    private Date regDttm;
    private String updId;
    private Date updDttm;
    private String coptSet;
    private String colId;
    private String colNm;
    private String colNmEnm;
    private String filtDefault1;
    private String filtDefault2;
    private String filtNeed1;
    private String filtNeed2;
    private String ditcCd;
    private String ditcNm;
    private String ditcNmEng;
    private String valueNm;
    private String seriesNm;
    private String fsYn;
    private String fsCd;
    private String filtDefaultNm;
    private String filtDefaultVal;
    private String srcColNm;
    private String unitCd;
    private String unitNm;

    public String getXaxisYn() {
        return xaxisYn;
    }

    public void setXaxisYn(String xaxisYn) {
        this.xaxisYn = xaxisYn;
    }

    public String getSeriesCd() {
        return seriesCd;
    }

    public void setSeriesCd(String seriesCd) {
        this.seriesCd = seriesCd;
    }

    public String getYaxisPos() {
        return yaxisPos;
    }

    public void setYaxisPos(String yaxisPos) {
        this.yaxisPos = yaxisPos;
    }

    public String getSortTag() {
        return sortTag;
    }

    public void setSortTag(String sortTag) {
        this.sortTag = sortTag;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }

    public String getViewYn() {
        return viewYn;
    }

    public void setViewYn(String viewYn) {
        this.viewYn = viewYn;
    }

    public String getCondYn() {
        return condYn;
    }

    public void setCondYn(String condYn) {
        this.condYn = condYn;
    }

    public String getCondOp() {
        return condOp;
    }

    public void setCondOp(String condOp) {
        this.condOp = condOp;
    }

    public String getCondVar() {
        return condVar;
    }

    public void setCondVar(String condVar) {
        this.condVar = condVar;
    }

    public String getFiltYn() {
        return filtYn;
    }

    public void setFiltYn(String filtYn) {
        this.filtYn = filtYn;
    }

    public String getFiltCd() {
        return filtCd;
    }

    public void setFiltCd(String filtCd) {
        this.filtCd = filtCd;
    }

    public int getFiltMaxDay() {
        return filtMaxDay;
    }

    public void setFiltMaxDay(int filtMaxDay) {
        this.filtMaxDay = filtMaxDay;
    }

    public String getFiltTblCd() {
        return filtTblCd;
    }

    public void setFiltTblCd(String filtTblCd) {
        this.filtTblCd = UtilString.SQLInjectionFilter(filtTblCd);
    }

    public String getFiltTblCc() {
        return filtTblCc;
    }

    public void setFiltTblCc(String filtTblCc) {
        this.filtTblCc = filtTblCc;
    }

    public String getFiltTblCn() {
        return filtTblCn;
    }

    public void setFiltTblCn(String filtTblCn) {
        this.filtTblCn = filtTblCn;
    }

    public String getFiltCode() {
        return filtCode;
    }

    public void setFiltCode(String filtCode) {
        this.filtCode = filtCode;
    }

    public String getFiltDefault() {
        return filtDefault;
    }

    public void setFiltDefault(String filtDefault) {
        this.filtDefault = filtDefault;
    }

    public String getFiltNeed() {
        return filtNeed;
    }

    public void setFiltNeed(String filtNeed) {
        this.filtNeed = filtNeed;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public Date getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(Date regDttm) {
        this.regDttm = regDttm;
    }

    public String getUpdId() {
        return updId;
    }

    public void setUpdId(String updId) {
        this.updId = updId;
    }

    public Date getUpdDttm() {
        return updDttm;
    }

    public void setUpdDttm(Date updDttm) {
        this.updDttm = updDttm;
    }

    public String getCoptSet() {
        return coptSet;
    }

    public void setCoptSet(String coptSet) {
        this.coptSet = coptSet;
    }

    public String getColId() {
        return colId;
    }

    public void setColId(String colId) {
        this.colId = colId;
    }

    public String getColNm() {
        return colNm;
    }

    public void setColNm(String colNm) {
        this.colNm = colNm;
    }

    public String getColNmEnm() {
        return colNmEnm;
    }

    public void setColNmEnm(String colNmEnm) {
        this.colNmEnm = colNmEnm;
    }

    public String getFiltDefault1() {
        return filtDefault1;
    }

    public void setFiltDefault1(String filtDefault1) {
        this.filtDefault1 = filtDefault1;
    }

    public String getFiltDefault2() {
        return filtDefault2;
    }

    public void setFiltDefault2(String filtDefault2) {
        this.filtDefault2 = filtDefault2;
    }

    public String getFiltNeed1() {
        return filtNeed1;
    }

    public void setFiltNeed1(String filtNeed1) {
        this.filtNeed1 = filtNeed1;
    }

    public String getFiltNeed2() {
        return filtNeed2;
    }

    public void setFiltNeed2(String filtNeed2) {
        this.filtNeed2 = filtNeed2;
    }

    public String getDitcCd() {
        return ditcCd;
    }

    public void setDitcCd(String ditcCd) {
        this.ditcCd = ditcCd;
    }

    public String getDitcNm() {
        return ditcNm;
    }

    public void setDitcNm(String ditcNm) {
        this.ditcNm = ditcNm;
    }

    public String getDitcNmEng() {
        return ditcNmEng;
    }

    public void setDitcNmEng(String ditcNmEng) {
        this.ditcNmEng = ditcNmEng;
    }

    public String getValueNm() {
        return valueNm;
    }

    public void setValueNm(String valueNm) {
        this.valueNm = valueNm;
    }

    public String getSeriesNm() {
        return seriesNm;
    }

    public void setSeriesNm(String seriesNm) {
        this.seriesNm = seriesNm;
    }

    public String getFsYn() {
        return fsYn;
    }

    public void setFsYn(String fsYn) {
        this.fsYn = fsYn;
    }

    public String getFsCd() {
        return fsCd;
    }

    public void setFsCd(String fsCd) {
        this.fsCd = fsCd;
    }

    public String getFiltDefaultNm() {
        return filtDefaultNm;
    }

    public void setFiltDefaultNm(String filtDefaultNm) {
        this.filtDefaultNm = filtDefaultNm;
    }

    public String getFiltDefaultVal() {
        return filtDefaultVal;
    }

    public void setFiltDefaultVal(String filtDefaultVal) {
        this.filtDefaultVal = UtilString.SQLInjectionFilter(filtDefaultVal);
    }

    public String getSrcColNm() {
        return srcColNm;
    }

    public void setSrcColNm(String srcColNm) {
        this.srcColNm = UtilString.SQLInjectionFilter(srcColNm);
    }

    public String getUnitCd() {
        return unitCd;
    }

    public void setUnitCd(String unitCd) {
        this.unitCd = unitCd;
    }

    public String getUnitNm() {
        return unitNm;
    }

    public void setUnitNm(String unitNm) {
        this.unitNm = unitNm;
    }

}

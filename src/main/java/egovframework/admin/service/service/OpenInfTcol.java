package egovframework.admin.service.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class OpenInfTcol extends OpenInfSrv implements Serializable {
    private String colId;
    private String colNm;
    private String viewYn;
    private String useYn;
    private String condYn;
    private String condOp;
    private String condVar;
    private String colCd;
    private String vOrder;
    private String toptSet;
    private String chartYn;
    private String itemCd;
    private String statYn;
    private String srcColId;

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

    public String getViewYn() {
        return viewYn;
    }

    public void setViewYn(String viewYn) {
        this.viewYn = viewYn;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
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

    public String getColCd() {
        return colCd;
    }

    public void setColCd(String colCd) {
        this.colCd = colCd;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }

    public String getToptSet() {
        return toptSet;
    }

    public void setToptSet(String toptSet) {
        this.toptSet = toptSet;
    }

    public String getChartYn() {
        return chartYn;
    }

    public void setChartYn(String chartYn) {
        this.chartYn = chartYn;
    }

    public String getItemCd() {
        return itemCd;
    }

    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }

    public String getStatYn() {
        return statYn;
    }

    public void setStatYn(String statYn) {
        this.statYn = statYn;
    }

    public String getSrcColId() {
        return srcColId;
    }

    public void setSrcColId(String srcColId) {
        this.srcColId = srcColId;
    }

}
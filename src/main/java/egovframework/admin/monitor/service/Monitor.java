package egovframework.admin.monitor.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class Monitor extends CommVo implements Serializable {


    private String dsIdName;
    private String dsTitle;
    private String systemCode;
    private String sDbCode;
    private String tDbCode;
    private String cateNmm;
    private String cApiDay;
    private String batchSchedule;
    private String batchDay;
    private String batchTm;
    private int totCnt;

    private String srcTableNm;
    private String tgtTableNm;
    private String srcTableDivNm;
    private String startTm;
    private String endTm;
    private String jobTm;
    private Integer totalCnt;
    private Integer processCnt;
    private Integer insertCnt;
    private Integer updateCnt;
    private Integer deleteCnt;
    private Integer errorCnt;
    private String status;
    private String errorMsq;

    private String searchWord;
    private String searchWd;

    private String fnlLoadDtm;
    private String fnlLoadEndDtm;

    public String getDsIdName() {
        return dsIdName;
    }

    public void setDsIdName(String dsIdName) {
        this.dsIdName = dsIdName;
    }

    public String getDsTitle() {
        return dsTitle;
    }

    public void setDsTitle(String dsTitle) {
        this.dsTitle = dsTitle;
    }

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public String getsDbCode() {
        return sDbCode;
    }

    public void setsDbCode(String sDbCode) {
        this.sDbCode = sDbCode;
    }

    public String gettDbCode() {
        return tDbCode;
    }

    public void settDbCode(String tDbCode) {
        this.tDbCode = tDbCode;
    }

    public String getCateNmm() {
        return cateNmm;
    }

    public void setCateNmm(String cateNmm) {
        this.cateNmm = cateNmm;
    }

    public String getcApiDay() {
        return cApiDay;
    }

    public void setcApiDay(String cApiDay) {
        this.cApiDay = cApiDay;
    }

    public String getBatchSchedule() {
        return batchSchedule;
    }

    public void setBatchSchedule(String batchSchedule) {
        this.batchSchedule = batchSchedule;
    }

    public String getBatchDay() {
        return batchDay;
    }

    public void setBatchDay(String batchDay) {
        this.batchDay = batchDay;
    }

    public String getBatchTm() {
        return batchTm;
    }

    public void setBatchTm(String batchTm) {
        this.batchTm = batchTm;
    }

    public String getSrcTableNm() {
        return srcTableNm;
    }

    public void setSrcTableNm(String srcTableNm) {
        this.srcTableNm = srcTableNm;
    }

    public String getTgtTableNm() {
        return tgtTableNm;
    }

    public void setTgtTableNm(String tgtTableNm) {
        this.tgtTableNm = tgtTableNm;
    }

    public String getSrcTableDivNm() {
        return srcTableDivNm;
    }

    public void setSrcTableDivNm(String srcTableDivNm) {
        this.srcTableDivNm = srcTableDivNm;
    }

    public String getStartTm() {
        return startTm;
    }

    public void setStartTm(String startTm) {
        this.startTm = startTm;
    }

    public String getEndTm() {
        return endTm;
    }

    public void setEndTm(String endTm) {
        this.endTm = endTm;
    }

    public String getJobTm() {
        return jobTm;
    }

    public void setJobTm(String jobTm) {
        this.jobTm = jobTm;
    }

    public Integer getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(Integer totalCnt) {
        this.totalCnt = totalCnt;
    }

    public Integer getProcessCnt() {
        return processCnt;
    }

    public void setProcessCnt(Integer processCnt) {
        this.processCnt = processCnt;
    }

    public Integer getInsertCnt() {
        return insertCnt;
    }

    public void setInsertCnt(Integer insertCnt) {
        this.insertCnt = insertCnt;
    }

    public Integer getUpdateCnt() {
        return updateCnt;
    }

    public void setUpdateCnt(Integer updateCnt) {
        this.updateCnt = updateCnt;
    }

    public Integer getDeleteCnt() {
        return deleteCnt;
    }

    public void setDeleteCnt(Integer deleteCnt) {
        this.deleteCnt = deleteCnt;
    }

    public Integer getErrorCnt() {
        return errorCnt;
    }

    public void setErrorCnt(Integer errorCnt) {
        this.errorCnt = errorCnt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getErrorMsq() {
        return errorMsq;
    }

    public void setErrorMsq(String errorMsq) {
        this.errorMsq = errorMsq;
    }

    public int getTotCnt() {
        return totCnt;
    }

    public void setTotCnt(int totCnt) {
        this.totCnt = totCnt;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getSearchWd() {
        return searchWd;
    }

    public void setSearchWd(String searchWd) {
        this.searchWd = searchWd;
    }

    public String getFnlLoadDtm() {
        return fnlLoadDtm;
    }

    public void setFnlLoadDtm(String fnlLoadDtm) {
        this.fnlLoadDtm = fnlLoadDtm;
    }

    public String getFnlLoadEndDtm() {
        return fnlLoadEndDtm;
    }

    public void setFnlLoadEndDtm(String fnlLoadEndDtm) {
        this.fnlLoadEndDtm = fnlLoadEndDtm;
    }

}

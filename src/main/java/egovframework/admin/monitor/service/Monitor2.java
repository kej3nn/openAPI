package egovframework.admin.monitor.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

public class Monitor2 extends CommVo implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 8486479705092568273L;

    private int totalCnt;
    private String fromDB;
    private String toDB;
    private String workPlan;
    private String startDttm;
    private String endDttm;
    private String workTime;
    private String total;
    private String prcCnt;
    private String ins;
    private String mod;
    private String del;
    private String errCnt;
    private String successYN;
    private String errorMsg;
    private String progenitorId;
    private String tbNm;

    private String gubun;
    private String time;
    private String jobNm;
    private String totalTbCnt;
    private String totalRowCnt;

    private String social;
    private String foreign;
    private String passport;
    private String liense;
    private String credit;
    private String account;
    private String mobile;
    private String phone;
    private String email;
    private String corp;
    private String business;
    private String healthInsurance;
    private String keyword;

    private String num;
    private String prfCnt;
    private String anaCnt;
    private String esnErCnt;
    private String brCnt;
    private String brAnaCnt;
    private String brErCnt;
    private String kindCd;
    private String commDtlCdNm;
    private String dbcTblKorNm;

    private String orgNm;
    private String dsType;
    private String procCnt;
    private String jobMsg;
    private String colNm;

    private String refineNo;
    private String ownerCd;
    private String dsId;
    private String dsNm;
    private String totCnt;
    private String valCnt;
    private String wrCnt;
    private String procCd;

    private String failCnt;
    private String successCnt;
    private String workDttm;
    private String workResult;

    private String searchType;
    private String ptocNm;

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getDsType() {
        return dsType;
    }

    public void setDsType(String dsType) {
        this.dsType = dsType;
    }

    public String getProcCnt() {
        return procCnt;
    }

    public void setProcCnt(String procCnt) {
        this.procCnt = procCnt;
    }

    public String getJobMsg() {
        return jobMsg;
    }

    public void setJobMsg(String jobMsg) {
        this.jobMsg = jobMsg;
    }

    public String getKindCd() {
        return kindCd;
    }

    public void setKindCd(String kindCd) {
        this.kindCd = kindCd;
    }

    public String getCommDtlCdNm() {
        return commDtlCdNm;
    }

    public void setCommDtlCdNm(String commDtlCdNm) {
        this.commDtlCdNm = commDtlCdNm;
    }

    public String getDbcTblKorNm() {
        return dbcTblKorNm;
    }

    public void setDbcTblKorNm(String dbcTblKorNm) {
        this.dbcTblKorNm = dbcTblKorNm;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getPrfCnt() {
        return prfCnt;
    }

    public void setPrfCnt(String prfCnt) {
        this.prfCnt = prfCnt;
    }

    public String getAnaCnt() {
        return anaCnt;
    }

    public void setAnaCnt(String anaCnt) {
        this.anaCnt = anaCnt;
    }

    public String getEsnErCnt() {
        return esnErCnt;
    }

    public void setEsnErCnt(String esnErCnt) {
        this.esnErCnt = esnErCnt;
    }

    public String getBrCnt() {
        return brCnt;
    }

    public void setBrCnt(String brCnt) {
        this.brCnt = brCnt;
    }

    public String getBrAnaCnt() {
        return brAnaCnt;
    }

    public void setBrAnaCnt(String brAnaCnt) {
        this.brAnaCnt = brAnaCnt;
    }

    public String getBrErCnt() {
        return brErCnt;
    }

    public void setBrErCnt(String brErCnt) {
        this.brErCnt = brErCnt;
    }

    public String getSocial() {
        return social;
    }

    public void setSocial(String social) {
        this.social = social;
    }

    public String getForeign() {
        return foreign;
    }

    public void setForeign(String foreign) {
        this.foreign = foreign;
    }

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

    public String getLiense() {
        return liense;
    }

    public void setLiense(String liense) {
        this.liense = liense;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCorp() {
        return corp;
    }

    public void setCorp(String corp) {
        this.corp = corp;
    }

    public String getBusiness() {
        return business;
    }

    public void setBusiness(String business) {
        this.business = business;
    }

    public String getHealthInsurance() {
        return healthInsurance;
    }

    public void setHealthInsurance(String healthInsurance) {
        this.healthInsurance = healthInsurance;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getJobNm() {
        return jobNm;
    }

    public void setJobNm(String jobNm) {
        this.jobNm = jobNm;
    }

    public String getTotalTbCnt() {
        return totalTbCnt;
    }

    public void setTotalTbCnt(String totalTbCnt) {
        this.totalTbCnt = totalTbCnt;
    }

    public String getTotalRowCnt() {
        return totalRowCnt;
    }

    public void setTotalRowCnt(String totalRowCnt) {
        this.totalRowCnt = totalRowCnt;
    }

    public String getScanRowCnt() {
        return scanRowCnt;
    }

    public void setScanRowCnt(String scanRowCnt) {
        this.scanRowCnt = scanRowCnt;
    }

    public String getDetRowCnt() {
        return detRowCnt;
    }

    public void setDetRowCnt(String detRowCnt) {
        this.detRowCnt = detRowCnt;
    }

    public String getIndvdlInfoResltSn() {
        return indvdlInfoResltSn;
    }

    public void setIndvdlInfoResltSn(String indvdlInfoResltSn) {
        this.indvdlInfoResltSn = indvdlInfoResltSn;
    }

    private String scanRowCnt;
    private String detRowCnt;
    private String indvdlInfoResltSn;

    private String searchWord;

    public String getFromDB() {
        return fromDB;
    }

    public void setFromDB(String fromDB) {
        this.fromDB = fromDB;
    }

    public String getToDB() {
        return toDB;
    }

    public void setToDB(String toDB) {
        this.toDB = toDB;
    }

    public String getWorkPlan() {
        return workPlan;
    }

    public void setWorkPlan(String workPlan) {
        this.workPlan = workPlan;
    }

    public String getStartDttm() {
        return startDttm;
    }

    public void setStartDttm(String startDttm) {
        this.startDttm = startDttm;
    }

    public String getEndDttm() {
        return endDttm;
    }

    public void setEndDttm(String endDttm) {
        this.endDttm = endDttm;
    }

    public String getWorkTime() {
        return workTime;
    }

    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getPrcCnt() {
        return prcCnt;
    }

    public void setPrcCnt(String prcCnt) {
        this.prcCnt = prcCnt;
    }

    public String getIns() {
        return ins;
    }

    public void setIns(String ins) {
        this.ins = ins;
    }

    public String getMod() {
        return mod;
    }

    public void setMod(String mod) {
        this.mod = mod;
    }

    public String getDel() {
        return del;
    }

    public void setDel(String del) {
        this.del = del;
    }

    public String getErrCnt() {
        return errCnt;
    }

    public void setErrCnt(String errCnt) {
        this.errCnt = errCnt;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public String getProgenitorId() {
        return progenitorId;
    }

    public void setProgenitorId(String progenitorId) {
        this.progenitorId = progenitorId;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getTbNm() {
        return tbNm;
    }

    public void setTbNm(String tbNm) {
        this.tbNm = tbNm;
    }

    public String getSuccessYN() {
        return successYN;
    }

    public void setSuccessYN(String successYN) {
        this.successYN = successYN;
    }

    public String getGubun() {
        return gubun;
    }

    public void setGubun(String gubun) {
        this.gubun = gubun;
    }

    public String getColNm() {
        return colNm;
    }

    public void setColNm(String colNm) {
        this.colNm = colNm;
    }

    public String getRefineNo() {
        return refineNo;
    }

    public void setRefineNo(String refineNo) {
        this.refineNo = refineNo;
    }

    public String getOwnerCd() {
        return ownerCd;
    }

    public void setOwnerCd(String ownerCd) {
        this.ownerCd = ownerCd;
    }

    public String getDsId() {
        return dsId;
    }

    public void setDsId(String dsId) {
        this.dsId = dsId;
    }

    public String getDsNm() {
        return dsNm;
    }

    public void setDsNm(String dsNm) {
        this.dsNm = dsNm;
    }

    public String getTotCnt() {
        return totCnt;
    }

    public void setTotCnt(String totCnt) {
        this.totCnt = totCnt;
    }

    public String getValCnt() {
        return valCnt;
    }

    public void setValCnt(String valCnt) {
        this.valCnt = valCnt;
    }

    public String getWrCnt() {
        return wrCnt;
    }

    public void setWrCnt(String wrCnt) {
        this.wrCnt = wrCnt;
    }

    public String getProcCd() {
        return procCd;
    }

    public void setProcCd(String procCd) {
        this.procCd = procCd;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public String getFailCnt() {
        return failCnt;
    }

    public void setFailCnt(String failCnt) {
        this.failCnt = failCnt;
    }

    public String getSuccessCnt() {
        return successCnt;
    }

    public void setSuccessCnt(String successCnt) {
        this.successCnt = successCnt;
    }

    public String getWorkDttm() {
        return workDttm;
    }

    public void setWorkDttm(String workDttm) {
        this.workDttm = workDttm;
    }

    public String getWorkResult() {
        return workResult;
    }

    public void setWorkResult(String workResult) {
        this.workResult = workResult;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getPtocNm() {
        return ptocNm;
    }

    public void setPtocNm(String ptocNm) {
        this.ptocNm = ptocNm;
    }

}

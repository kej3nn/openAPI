package egovframework.admin.openinf.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenOrgUsrRel extends CommVo implements Serializable {

    private String del;
    private String status;
    private String orgNm;
    private String orgCd;
    private String usrNm;
    private String usrCd;
    private String jobCd;
    private String infId;
    private String rpstYn;
    private String prssAccCd;

    private String srcViewYn;
    private String useYn;

    private String expDttm;
    private Integer seqceNo;

    public String getExpDttm() {
        return expDttm;
    }

    public void setExpDttm(String expDttm) {
        this.expDttm = expDttm;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getUsrCd() {
        return usrCd;
    }

    public void setUsrCd(String usrCd) {
        this.usrCd = usrCd;
    }

    public String getJobCd() {
        return jobCd;
    }

    public void setJobCd(String jobCd) {
        this.jobCd = jobCd;
    }

    public String getInfId() {
        return infId;
    }

    public void setInfId(String infId) {
        this.infId = infId;
    }

    public String getDel() {
        return del;
    }

    public void setDel(String del) {
        this.del = del;
    }

    public Integer getSeqceNo() {
        return seqceNo;
    }

    public void setSeqceNo(Integer seqceNo) {
        this.seqceNo = seqceNo;
    }

    public String getRpstYn() {
        return rpstYn;
    }

    public void setRpstYn(String rpstYn) {
        this.rpstYn = rpstYn;
    }

    public String getPrssAccCd() {
        return prssAccCd;
    }

    public void setPrssAccCd(String prssAccCd) {
        this.prssAccCd = prssAccCd;
    }

    public String getSrcViewYn() {
        return srcViewYn;
    }

    public void setSrcViewYn(String srcViewYn) {
        this.srcViewYn = srcViewYn;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }


}
package egovframework.admin.openinf.service;

import java.io.Serializable;
import java.util.Date;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenInfRe extends CommVo implements Serializable {
    private String infId;
    private String infNm;
    private int reSeq;
    private int reSeqPar;
    private int reVal;
    private String reCont;
    private int userCd;
    private String userNm;
    private String delYn;
    private String delId;
    private String delDttm;
    private String sysTag;
    private String regId;
    private String regDttm;

    private String orgCd;
    private String orgNm;
    private String usrCd;
    private String usrNm;
    private String pubDttmFrom;
    private String pubDttmTo;
    private String searchWd;
    private String searchWord;
    private String status;


    public String getDelDttm() {
        return delDttm;
    }

    public void setDelDttm(String delDttm) {
        this.delDttm = delDttm;
    }

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
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

    public int getReSeq() {
        return reSeq;
    }

    public void setReSeq(int reSeq) {
        this.reSeq = reSeq;
    }

    public int getReSeqPar() {
        return reSeqPar;
    }

    public void setReSeqPar(int reSeqPar) {
        this.reSeqPar = reSeqPar;
    }

    public int getReVal() {
        return reVal;
    }

    public void setReVal(int reVal) {
        this.reVal = reVal;
    }

    public String getReCont() {
        return reCont;
    }

    public void setReCont(String reCont) {
        this.reCont = reCont;
    }

    public int getUserCd() {
        return userCd;
    }

    public void setUserCd(int userCd) {
        this.userCd = userCd;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getDelYn() {
        return delYn;
    }

    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }

    public String getDelId() {
        return delId;
    }

    public void setDelId(String delId) {
        this.delId = delId;
    }

    public String getSysTag() {
        return sysTag;
    }

    public void setSysTag(String sysTag) {
        this.sysTag = sysTag;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
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

    public String getSearchWd() {
        return searchWd;
    }

    public void setSearchWd(String searchWd) {
        this.searchWd = searchWd;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
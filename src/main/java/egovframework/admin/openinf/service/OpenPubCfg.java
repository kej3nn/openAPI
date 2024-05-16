package egovframework.admin.openinf.service;

import java.io.Serializable;
import java.util.Date;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenPubCfg extends CommVo implements Serializable {

    private String pubId;
    private String pubNm;
    private String pubNmEng;
    private String langTag;
    private String pubTag;
    private String basisMm;
    private String basisDd;
    private String basisWk;
    private String basisWd;
    private String basisHhmm;
    private String basisMode;
    private String autoYn;
    private String pubExp;
    private String pubExpEng;
    private String orgCd;
    private String usrCd;
    private String refDsId;
    private String refDsIdDup;
    private String refColId;
    private String refColIdYn;
    private String refColOp;
    private String refColVar;
    private String startDttm;
    private String useYn;
    private String pubTagSetYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;

    private String pubTagCheck;
    private String monthCheck;
    private String weekCheck;
    private String dayCheck;
    private String pubTagMonth;
    private String pubTagWeek;
    private String pubTagDay;

    private String dsNm;
    private String refDsNm;
    private String orgNm;
    private String orgFullNm;
    private String usrNm;

    private String dsId;
    private String srcColId;
    private String colNm;

    private int retval;
    private String retmsg;

    private int MstSeq;
    private int colSeq;

    private int res;

    public String getPubId() {
        return pubId;
    }

    public void setPubId(String pubId) {
        this.pubId = pubId;
    }

    public String getPubNm() {
        return pubNm;
    }

    public void setPubNm(String pubNm) {
        this.pubNm = pubNm;
    }

    public String getPubNmEng() {
        return pubNmEng;
    }

    public void setPubNmEng(String pubNmEng) {
        this.pubNmEng = pubNmEng;
    }

    public String getLangTag() {
        return langTag;
    }

    public void setLangTag(String langTag) {
        this.langTag = langTag;
    }

    public String getPubTag() {
        return pubTag;
    }

    public void setPubTag(String pubTag) {
        this.pubTag = pubTag;
    }

    public String getBasisMm() {
        return basisMm;
    }

    public void setBasisMm(String basisMm) {
        this.basisMm = basisMm;
    }

    public String getBasisDd() {
        return basisDd;
    }

    public void setBasisDd(String basisDd) {
        this.basisDd = basisDd;
    }

    public String getBasisWk() {
        return basisWk;
    }

    public void setBasisWk(String basisWk) {
        this.basisWk = basisWk;
    }

    public String getBasisWd() {
        return basisWd;
    }

    public void setBasisWd(String basisWd) {
        this.basisWd = basisWd;
    }

    public String getBasisHhmm() {
        return basisHhmm;
    }

    public void setBasisHhmm(String basisHhmm) {
        this.basisHhmm = basisHhmm;
    }

    public String getBasisMode() {
        return basisMode;
    }

    public void setBasisMode(String basisMode) {
        this.basisMode = basisMode;
    }

    public String getAutoYn() {
        return autoYn;
    }

    public void setAutoYn(String autoYn) {
        this.autoYn = autoYn;
    }

    public String getPubExp() {
        return pubExp;
    }

    public void setPubExp(String pubExp) {
        this.pubExp = pubExp;
    }

    public String getPubExpEng() {
        return pubExpEng;
    }

    public void setPubExpEng(String pubExpEng) {
        this.pubExpEng = pubExpEng;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getUsrCd() {
        return usrCd;
    }

    public void setUsrCd(String usrCd) {
        this.usrCd = usrCd;
    }

    public String getRefDsId() {
        return refDsId;
    }

    public void setRefDsId(String refDsId) {
        this.refDsId = refDsId;
    }

    public String getRefDsIdDup() {
        return refDsIdDup;
    }

    public void setRefDsIdDup(String refDsIdDup) {
        this.refDsIdDup = refDsIdDup;
    }

    public String getRefColId() {
        return refColId;
    }

    public void setRefColId(String refColId) {
        this.refColId = refColId;
    }

    public String getRefColOp() {
        return refColOp;
    }

    public void setRefColOp(String refColOp) {
        this.refColOp = refColOp;
    }

    public String getRefColVar() {
        return refColVar;
    }

    public void setRefColVar(String refColVar) {
        this.refColVar = refColVar;
    }

    public String getStartDttm() {
        return startDttm;
    }

    public void setStartDttm(String startDttm) {
        this.startDttm = startDttm;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getPubTagSetYn() {
        return pubTagSetYn;
    }

    public void setPubTagSetYn(String pubTagSetYn) {
        this.pubTagSetYn = pubTagSetYn;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }

    public String getUpdId() {
        return updId;
    }

    public void setUpdId(String updId) {
        this.updId = updId;
    }

    public String getUpdDttm() {
        return updDttm;
    }

    public void setUpdDttm(String updDttm) {
        this.updDttm = updDttm;
    }

    public String getPubTagCheck() {
        return pubTagCheck;
    }

    public void setPubTagCheck(String pubTagCheck) {
        this.pubTagCheck = pubTagCheck;
    }

    public String getMonthCheck() {
        return monthCheck;
    }

    public void setMonthCheck(String monthCheck) {
        this.monthCheck = monthCheck;
    }

    public String getWeekCheck() {
        return weekCheck;
    }

    public void setWeekCheck(String weekCheck) {
        this.weekCheck = weekCheck;
    }

    public String getDayCheck() {
        return dayCheck;
    }

    public void setDayCheck(String dayCheck) {
        this.dayCheck = dayCheck;
    }

    public String getPubTagMonth() {
        return pubTagMonth;
    }

    public void setPubTagMonth(String pubTagMonth) {
        this.pubTagMonth = pubTagMonth;
    }

    public String getPubTagWeek() {
        return pubTagWeek;
    }

    public void setPubTagWeek(String pubTagWeek) {
        this.pubTagWeek = pubTagWeek;
    }

    public String getPubTagDay() {
        return pubTagDay;
    }

    public void setPubTagDay(String pubTagDay) {
        this.pubTagDay = pubTagDay;
    }

    public String getDsNm() {
        return dsNm;
    }

    public void setDsNm(String dsNm) {
        this.dsNm = dsNm;
    }

    public String getRefDsNm() {
        return refDsNm;
    }

    public void setRefDsNm(String refDsNm) {
        this.refDsNm = refDsNm;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getOrgFullNm() {
        return orgFullNm;
    }

    public void setOrgFullNm(String orgFullNm) {
        this.orgFullNm = orgFullNm;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getDsId() {
        return dsId;
    }

    public void setDsId(String dsId) {
        this.dsId = dsId;
    }

    public String getSrcColId() {
        return srcColId;
    }

    public void setSrcColId(String srcColId) {
        this.srcColId = srcColId;
    }

    public String getColNm() {
        return colNm;
    }

    public void setColNm(String colNm) {
        this.colNm = colNm;
    }

    public int getRetval() {
        return retval;
    }

    public void setRetval(int retval) {
        this.retval = retval;
    }

    public String getRetmsg() {
        return retmsg;
    }

    public void setRetmsg(String retmsg) {
        this.retmsg = retmsg;
    }

    public int getRes() {
        return res;
    }

    public void setRes(int res) {
        this.res = res;
    }

    public int getMstSeq() {
        return MstSeq;
    }

    public void setMstSeq(int mstSeq) {
        MstSeq = mstSeq;
    }

    public String getRefColIdYn() {
        return refColIdYn;
    }

    public void setRefColIdYn(String refColIdYn) {
        this.refColIdYn = refColIdYn;
    }

    public int getColSeq() {
        return colSeq;
    }

    public void setColSeq(int colSeq) {
        this.colSeq = colSeq;
    }


}
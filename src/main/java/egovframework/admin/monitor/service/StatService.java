package egovframework.admin.monitor.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

public class StatService extends CommVo implements Serializable {
    private String infId;
    private String dtNm;
    private String infNm;
    private String cclNm;
    private String cateNm;
    private String cateFullNm;
    private String useDeptNm;
    private String openDttm;
    private String infTag;
    private String infState;
    private String openSrv;
    private String startDttm;
    private String endDttm;
    private int totalCnt;
    private String searchWord;
    private String searchWd;
    private String cateId;

    //////////////////////

    private String infCnt;
    private String apprCnt;
    private String apprGrade;
    private String infSeq;
    private String scolInfSeq;
    private String ccolInfSeq;
    private String mcolInfSeq;
    private String fileInfSeq;
    private String acolInfSeq;
    private String linkInfSeq;
    private String srvCd;
    private String metaImagFileNm;
    private String cateSaveFileNm;
    private String infExp;
    private String apprVal;
    private String topCateId;
    private String topCateNm;
    private String loadDttm;
    private String orgNm;
    private String loadNm;
    private String usrNm;
    private String usrTel;
    private String useUsrCnt;
    private String srcExp;
    private String cclCd;
    private String cclExp;
    private String dataCondDttm;
    private String topCateId2;
    private String CateNm2;
    private String useOrgCnt;

    private String appr; // apprCnt와 apprGrade를 합칠 필드명

    //메타다운로드
    private String niaId;
    private String mospaSysCd;
    private String basisLaw;
    private String domainUrl;
    private String keyword1;
    private String keyword2;
    private String keyword3;
    private String dbExp;
    private String mngId;
    private String copyright3Yn;
    private String copyright3CclYn;
    private String copyright3CclFile;
    private String chngLoadDttm;
    private String chargeYn;
    private String chargeAmt;
    private String chargeCd;
    private String chargeCdFile;
    private String dataCd;
    private String dataUrl;
    private String dataMediaCd;
    private String dataMediaCnt;
    private String dataMediaExt;
    private String langCd;
    private String note;
    private String dataFileYn;


    public StatService() {
    }

    public String getInfId() {
        return infId;
    }

    public void setInfId(String infId) {
        this.infId = infId;
    }

    public String getDtNm() {
        return dtNm;
    }

    public void setDtNm(String dtNm) {
        this.dtNm = dtNm;
    }

    public String getInfNm() {
        return infNm;
    }

    public void setInfNm(String infNm) {
        this.infNm = infNm;
    }

    public String getCclNm() {
        return cclNm;
    }

    public void setCclNm(String cclNm) {
        this.cclNm = cclNm;
    }

    public String getCateNm() {
        return cateNm;
    }

    public void setCateNm(String cateNm) {
        this.cateNm = cateNm;
    }

    public String getCateFullNm() {
        return cateFullNm;
    }

    public void setCateFullNm(String cateFullNm) {
        this.cateFullNm = cateFullNm;
    }

    public String getUseDeptNm() {
        return useDeptNm;
    }

    public void setUseDeptNm(String useDeptNm) {
        this.useDeptNm = useDeptNm;
    }

    public String getOpenDttm() {
        return openDttm;
    }

    public void setOpenDttm(String openDttm) {
        this.openDttm = openDttm;
    }

    public String getInfTag() {
        return infTag;
    }

    public void setInfTag(String infTag) {
        this.infTag = infTag;
    }

    public String getOpenSrv() {
        return openSrv;
    }

    public void setOpenSrv(String openSrv) {
        this.openSrv = openSrv;
    }

    public String getInfState() {
        return infState;
    }

    public void setInfState(String infState) {
        this.infState = infState;
    }

    public String getNiaId() {
        return niaId;
    }

    public void setNiaId(String niaId) {
        this.niaId = niaId;
    }

    public String getMospaSysCd() {
        return mospaSysCd;
    }

    public void setMospaSysCd(String mospaSysCd) {
        this.mospaSysCd = mospaSysCd;
    }

    public String getBasisLaw() {
        return basisLaw;
    }

    public void setBasisLaw(String basisLaw) {
        this.basisLaw = basisLaw;
    }

    public String getDomainUrl() {
        return domainUrl;
    }

    public void setDomainUrl(String domainUrl) {
        this.domainUrl = domainUrl;
    }

    public String getKeyword1() {
        return keyword1;
    }

    public void setKeyword1(String keyword1) {
        this.keyword1 = keyword1;
    }

    public String getKeyword2() {
        return keyword2;
    }

    public void setKeyword2(String keyword2) {
        this.keyword2 = keyword2;
    }

    public String getKeyword3() {
        return keyword3;
    }

    public void setKeyword3(String keyword3) {
        this.keyword3 = keyword3;
    }

    public String getDbExp() {
        return dbExp;
    }

    public void setDbExp(String dbExp) {
        this.dbExp = dbExp;
    }

    public String getMngId() {
        return mngId;
    }

    public void setMngId(String mngId) {
        this.mngId = mngId;
    }

    public String getCopyright3Yn() {
        return copyright3Yn;
    }

    public void setCopyright3Yn(String copyright3Yn) {
        this.copyright3Yn = copyright3Yn;
    }

    public String getCopyright3CclYn() {
        return copyright3CclYn;
    }

    public void setCopyright3CclYn(String copyright3CclYn) {
        this.copyright3CclYn = copyright3CclYn;
    }

    public String getCopyright3CclFile() {
        return copyright3CclFile;
    }

    public void setCopyright3CclFile(String copyright3CclFile) {
        this.copyright3CclFile = copyright3CclFile;
    }

    public String getChngLoadDttm() {
        return chngLoadDttm;
    }

    public void setChngLoadDttm(String chngLoadDttm) {
        this.chngLoadDttm = chngLoadDttm;
    }

    public String getChargeYn() {
        return chargeYn;
    }

    public void setChargeYn(String chargeYn) {
        this.chargeYn = chargeYn;
    }

    public String getChargeAmt() {
        return chargeAmt;
    }

    public void setChargeAmt(String chargeAmt) {
        this.chargeAmt = chargeAmt;
    }

    public String getChargeCd() {
        return chargeCd;
    }

    public void setChargeCd(String chargeCd) {
        this.chargeCd = chargeCd;
    }

    public String getChargeCdFile() {
        return chargeCdFile;
    }

    public void setChargeCdFile(String chargeCdFile) {
        this.chargeCdFile = chargeCdFile;
    }

    public String getDataCd() {
        return dataCd;
    }

    public void setDataCd(String dataCd) {
        this.dataCd = dataCd;
    }

    public String getDataUrl() {
        return dataUrl;
    }

    public void setDataUrl(String dataUrl) {
        this.dataUrl = dataUrl;
    }

    public String getDataMediaCd() {
        return dataMediaCd;
    }

    public void setDataMediaCd(String dataMediaCd) {
        this.dataMediaCd = dataMediaCd;
    }

    public String getDataMediaCnt() {
        return dataMediaCnt;
    }

    public void setDataMediaCnt(String dataMediaCnt) {
        this.dataMediaCnt = dataMediaCnt;
    }

    public String getDataMediaExt() {
        return dataMediaExt;
    }

    public void setDataMediaExt(String dataMediaExt) {
        this.dataMediaExt = dataMediaExt;
    }

    public String getLangCd() {
        return langCd;
    }

    public void setLangCd(String langCd) {
        this.langCd = langCd;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getDataFileYn() {
        return dataFileYn;
    }

    public void setDataFileYn(String dataFileYn) {
        this.dataFileYn = dataFileYn;
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

    public String getSearchWd() {
        return searchWd;
    }

    public void setSearchWd(String searchWd) {
        this.searchWd = searchWd;
    }

    public String getCateId() {
        return cateId;
    }

    public void setCateId(String cateId) {
        this.cateId = cateId;
    }


    public String getLoadDttm() {
        return loadDttm;
    }

    public void setLoadDttm(String loadDttm) {
        this.loadDttm = loadDttm;
    }

    public String getInfCnt() {
        return infCnt;
    }

    public void setInfCnt(String infCnt) {
        this.infCnt = infCnt;
    }

    public String getApprCnt() {
        return apprCnt;
    }

    public void setApprCnt(String apprCnt) {
        this.apprCnt = apprCnt;
    }

    public String getApprGrade() {
        return apprGrade;
    }

    public void setApprGrade(String apprGrade) {
        this.apprGrade = apprGrade;
    }

    public String getInfSeq() {
        return infSeq;
    }

    public void setInfSeq(String infSeq) {
        this.infSeq = infSeq;
    }

    public String getScolInfSeq() {
        return scolInfSeq;
    }

    public void setScolInfSeq(String scolInfSeq) {
        this.scolInfSeq = scolInfSeq;
    }

    public String getCcolInfSeq() {
        return ccolInfSeq;
    }

    public void setCcolInfSeq(String ccolInfSeq) {
        this.ccolInfSeq = ccolInfSeq;
    }

    public String getMcolInfSeq() {
        return mcolInfSeq;
    }

    public void setMcolInfSeq(String mcolInfSeq) {
        this.mcolInfSeq = mcolInfSeq;
    }

    public String getFileInfSeq() {
        return fileInfSeq;
    }

    public void setFileInfSeq(String fileInfSeq) {
        this.fileInfSeq = fileInfSeq;
    }

    public String getAcolInfSeq() {
        return acolInfSeq;
    }

    public void setAcolInfSeq(String acolInfSeq) {
        this.acolInfSeq = acolInfSeq;
    }

    public String getLinkInfSeq() {
        return linkInfSeq;
    }

    public void setLinkInfSeq(String linkInfSeq) {
        this.linkInfSeq = linkInfSeq;
    }

    public String getSrvCd() {
        return srvCd;
    }

    public void setSrvCd(String srvCd) {
        this.srvCd = srvCd;
    }

    public String getMetaImagFileNm() {
        return metaImagFileNm;
    }

    public void setMetaImagFileNm(String metaImagFileNm) {
        this.metaImagFileNm = metaImagFileNm;
    }

    public String getCateSaveFileNm() {
        return cateSaveFileNm;
    }

    public void setCateSaveFileNm(String cateSaveFileNm) {
        this.cateSaveFileNm = cateSaveFileNm;
    }

    public String getInfExp() {
        return infExp;
    }

    public void setInfExp(String infExp) {
        this.infExp = infExp;
    }

    public String getApprVal() {
        return apprVal;
    }

    public void setApprVal(String apprVal) {
        this.apprVal = apprVal;
    }

    public String getTopCateId() {
        return topCateId;
    }

    public void setTopCateId(String topCateId) {
        this.topCateId = topCateId;
    }

    public String getTopCateNm() {
        return topCateNm;
    }

    public void setTopCateNm(String topCateNm) {
        this.topCateNm = topCateNm;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getLoadNm() {
        return loadNm;
    }

    public void setLoadNm(String loadNm) {
        this.loadNm = loadNm;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getUsrTel() {
        return usrTel;
    }

    public void setUsrTel(String usrTel) {
        this.usrTel = usrTel;
    }

    public String getUseUsrCnt() {
        return useUsrCnt;
    }

    public void setUseUsrCnt(String useUsrCnt) {
        this.useUsrCnt = useUsrCnt;
    }

    public String getSrcExp() {
        return srcExp;
    }

    public void setSrcExp(String srcExp) {
        this.srcExp = srcExp;
    }

    public String getCclCd() {
        return cclCd;
    }

    public void setCclCd(String cclCd) {
        this.cclCd = cclCd;
    }

    public String getCclExp() {
        return cclExp;
    }

    public void setCclExp(String cclExp) {
        this.cclExp = cclExp;
    }

    public String getDataCondDttm() {
        return dataCondDttm;
    }

    public void setDataCondDttm(String dataCondDttm) {
        this.dataCondDttm = dataCondDttm;
    }

    public String getTopCateId2() {
        return topCateId2;
    }

    public void setTopCateId2(String topCateId2) {
        this.topCateId2 = topCateId2;
    }

    public String getCateNm2() {
        return CateNm2;
    }

    public void setCateNm2(String cateNm2) {
        CateNm2 = cateNm2;
    }

    public String getAppr() {
        return appr;
    }

    public void setAppr(String appr) {
        this.appr = appr;
    }

    public String getUseOrgCnt() {
        return useOrgCnt;
    }

    public void setUseOrgCnt(String useOrgCnt) {
        this.useOrgCnt = useOrgCnt;
    }

    @Override
    public String toString() {
        return "StatService [infId=" + infId + ", dtNm=" + dtNm + ", infNm="
                + infNm + ", cclNm=" + cclNm + ", cateNm=" + cateNm
                + ", cateFullNm=" + cateFullNm + ", useDeptNm=" + useDeptNm
                + ", openDttm=" + openDttm + ", infTag=" + infTag
                + ", infState=" + infState + ", openSrv=" + openSrv
                + ", startDttm=" + startDttm + ", endDttm=" + endDttm
                + ", totalCnt=" + totalCnt + ", searchWord=" + searchWord
                + ", searchWd=" + searchWd + ", cateId=" + cateId + ", infCnt="
                + infCnt + ", apprCnt=" + apprCnt + ", apprGrade=" + apprGrade
                + ", infSeq=" + infSeq + ", scolInfSeq=" + scolInfSeq
                + ", ccolInfSeq=" + ccolInfSeq + ", mcolInfSeq=" + mcolInfSeq
                + ", fileInfSeq=" + fileInfSeq + ", acolInfSeq=" + acolInfSeq
                + ", linkInfSeq=" + linkInfSeq + ", srvCd=" + srvCd
                + ", metaImagFileNm=" + metaImagFileNm + ", cateSaveFileNm="
                + cateSaveFileNm + ", infExp=" + infExp + ", apprVal="
                + apprVal + ", topCateId=" + topCateId + ", topCateNm="
                + topCateNm + ", loadDttm=" + loadDttm + ", orgNm=" + orgNm
                + ", loadNm=" + loadNm + ", usrNm=" + usrNm + ", usrTel="
                + usrTel + ", useUsrCnt=" + useUsrCnt + ", srcExp=" + srcExp
                + ", cclCd=" + cclCd + ", cclExp=" + cclExp + ", dataCondDttm="
                + dataCondDttm + ", topCateId2=" + topCateId2 + ", CateNm2="
                + CateNm2 + ", useOrgCnt=" + useOrgCnt + ", appr=" + appr
                + ", niaId=" + niaId + ", mospaSysCd=" + mospaSysCd
                + ", basisLaw=" + basisLaw + ", domainUrl=" + domainUrl
                + ", keyword1=" + keyword1 + ", keyword2=" + keyword2
                + ", keyword3=" + keyword3 + ", dbExp=" + dbExp + ", mngId="
                + mngId + ", copyright3Yn=" + copyright3Yn
                + ", copyright3CclYn=" + copyright3CclYn
                + ", copyright3CclFile=" + copyright3CclFile
                + ", chngLoadDttm=" + chngLoadDttm + ", chargeYn=" + chargeYn
                + ", chargeAmt=" + chargeAmt + ", chargeCd=" + chargeCd
                + ", chargeCdFile=" + chargeCdFile + ", dataCd=" + dataCd
                + ", dataUrl=" + dataUrl + ", dataMediaCd=" + dataMediaCd
                + ", dataMediaCnt=" + dataMediaCnt + ", dataMediaExt="
                + dataMediaExt + ", langCd=" + langCd + ", note=" + note
                + ", dataFileYn=" + dataFileYn + "]";
    }


}

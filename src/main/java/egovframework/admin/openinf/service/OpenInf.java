package egovframework.admin.openinf.service;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.Date;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenInf extends CommVo implements Serializable {

    private String infId;
    private String infNm;
    private String infNmEng;
    private Integer dtId;
    private String dsId;
    private String dsNm;
    private String cateId;
    private String infTag;
    private String infUrl;
    private String infExp;
    private String infExpEng;
    private String openDttm;
    private String orgCd;
    private String cclCd;
    private String loadCd;
    private Date loadDttm;
    private String loadDttmStr;
    private String prssState;
    private String infState;
    private String infStateNm;
    private String korYn;
    private String engYn;
    private String korMobileYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;
    private String openCd;
    private String causeCd;
    private String causeInfo;
    private String infTagEng;
    private String usrCd;
    private String dtNm;
    private String dtNmEng;
    private String cateNm;
    private String cateFullNm;
    private String orgNm;
    private String topOrgNm;
    private String topOrgnmEng;
    private String cclNm;
    private String usrNm;
    private String orgFullnm;
    private String tbId;
    private String tbNm;
    private String openSrv;
    private String cancelSrv;
    private String orgFullnmEng;
    private String orgNmEng;
    private String cateNmEng;
    private String srcUrl;
    private String srcExp;
    private String srcExpEng;
    private String loadNm;
    private String searchWord;
    private String searchWd;
    private String searchWd2;
    private String srvCd;
    private String srvYn;
    private String viewLang;
    private String oldState;
    private String newState;
    private String prssExp;
    private String prssStateNm;
    private String prssGubun;
    private String orgCdMod;
    private String usrCdMod;
    private String post;
    private String cateFullnm;
    private String cateFullnmEng;
    private String orgTopNm;
    private String cateList;
    private String cateIdTop;
    private String orgCdTop;
    private String orgList;
    private String cateTopNm;
    private String cateTopNmEng;
    private String searchId;
    private String searchGubun;
    private String cclNmCd;
    private String loadNmCd;
    private String orgTopNmEng;
    private String sortBy;
    private String tag;
    private String cols;
    private String tagEng;
    private String apiRes;
    private String sgrpCd;
    private String useOrgCnt;
    private String useUsrCnt;
    private String aprvProcYn;

    //추천순위
    private String fvtDataOrder;
    private String fvtDataYn;

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

    private int wiseopenCnt;

    private String orderBy;
    private String loadDate;
    private String gssYn;
    private String endInfo;

    private String dataCondDttm;
    private String useDeptNm;
    private int seqceNo;
    private String usrId;
    private String accCd;


    private String srcViewYn;
    private String useYn;

    private String themeCate;

    private String saCate;

    private String cateId2;


    private String infSrv;

    private String cateNm2;

    private String tCd;
    private String lCd;


    private String emdYn;
    private String prssAccCd;

    private String SysInpGbn;
    private String inpOrgCd;
    private int inpUsrCd;

    public String gettCd() {
        return tCd;
    }

    public void settCd(String tCd) {
        this.tCd = tCd;
    }

    public String getlCd() {
        return lCd;
    }

    public void setlCd(String lCd) {
        this.lCd = lCd;
    }

    public String[] getThemeCd() {
        String[] ret = null;
        if (this.themeCd != null) {
            ret = new String[this.themeCd.length];
            for (int i = 0; i < this.themeCd.length; i++) {
                ret[i] = this.themeCd[i];
            }
        }
        return ret;
    }

    public void setThemeCd(String[] themeCd) {
        //this.themeCd = themeCd;
        this.themeCd = new String[themeCd.length];
        for (int i = 0; i < themeCd.length; i++) {
            this.themeCd[i] = themeCd[i];
        }
    }

    public String[] getSaCd() {
        String[] ret = null;
        if (this.saCd != null) {
            ret = new String[this.saCd.length];
            for (int i = 0; i < this.saCd.length; i++) {
                ret[i] = this.saCd[i];
            }
        }
        return ret;
    }

    public void setSaCd(String[] saCd) {
        //this.saCd = saCd;
        this.saCd = new String[saCd.length];
        for (int i = 0; i < saCd.length; i++) {
            this.saCd[i] = saCd[i];
        }
    }

    private String[] themeCd;
    private String[] saCd;

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

    public String getInfNmEng() {
        return infNmEng;
    }

    public void setInfNmEng(String infNmEng) {
        this.infNmEng = infNmEng;
    }

    public Integer getDtId() {
        return dtId;
    }

    public void setDtId(Integer dtId) {
        this.dtId = dtId;
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

    public String getCateId() {
        return cateId;
    }

    public void setCateId(String cateId) {
        this.cateId = cateId;
    }

    public String getInfTag() {
        return infTag;
    }

    public void setInfTag(String infTag) {
        this.infTag = infTag;
    }

    public String getInfUrl() {
        return infUrl;
    }

    public void setInfUrl(String infUrl) {
        this.infUrl = infUrl;
    }

    public String getInfExp() {
        return infExp;
    }

    public void setInfExp(String infExp) {
        this.infExp = infExp;
    }

    public String getInfExpEng() {
        return infExpEng;
    }

    public void setInfExpEng(String infExpEng) {
        this.infExpEng = infExpEng;
    }

    public String getOpenDttm() {
        return openDttm;
    }

    public void setOpenDttm(String openDttm) {
        this.openDttm = openDttm;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getCclCd() {
        return cclCd;
    }

    public void setCclCd(String cclCd) {
        this.cclCd = cclCd;
    }

    public String getLoadCd() {
        return loadCd;
    }

    public void setLoadCd(String loadCd) {
        this.loadCd = loadCd;
    }

    public Date getLoadDttm() {
        return loadDttm;
    }

    public void setLoadDttm(Date loadDttm) {
        this.loadDttm = loadDttm;
    }

    public String getLoadDttmStr() {
        return loadDttmStr;
    }

    public void setLoadDttmStr(String loadDttmStr) {
        this.loadDttmStr = loadDttmStr;
    }

    public String getPrssState() {
        return prssState;
    }

    public void setPrssState(String prssState) {
        this.prssState = prssState;
    }

    public String getInfState() {
        return infState;
    }

    public void setInfState(String infState) {
        this.infState = infState;
    }

    public String getInfStateNm() {
        return infStateNm;
    }

    public void setInfStateNm(String infStateNm) {
        this.infStateNm = infStateNm;
    }

    public String getKorYn() {
        return korYn;
    }

    public void setKorYn(String korYn) {
        this.korYn = korYn;
    }

    public String getEngYn() {
        return engYn;
    }

    public void setEngYn(String engYn) {
        this.engYn = engYn;
    }

    public String getKorMobileYn() {
        return korMobileYn;
    }

    public void setKorMobileYn(String korMobileYn) {
        this.korMobileYn = korMobileYn;
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

    public String getOpenCd() {
        return openCd;
    }

    public void setOpenCd(String openCd) {
        this.openCd = openCd;
    }

    public String getCauseCd() {
        return causeCd;
    }

    public void setCauseCd(String causeCd) {
        this.causeCd = causeCd;
    }

    public String getCauseInfo() {
        return causeInfo;
    }

    public void setCauseInfo(String causeInfo) {
        this.causeInfo = causeInfo;
    }

    public String getInfTagEng() {
        return infTagEng;
    }

    public void setInfTagEng(String infTagEng) {
        this.infTagEng = infTagEng;
    }

    public String getUsrCd() {
        return usrCd;
    }

    public void setUsrCd(String usrCd) {
        this.usrCd = usrCd;
    }

    public String getDtNm() {
        return dtNm;
    }

    public void setDtNm(String dtNm) {
        this.dtNm = dtNm;
    }

    public String getDtNmEng() {
        return dtNmEng;
    }

    public void setDtNmEng(String dtNmEng) {
        this.dtNmEng = dtNmEng;
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

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getTopOrgNm() {
        return topOrgNm;
    }

    public void setTopOrgNm(String topOrgNm) {
        this.topOrgNm = topOrgNm;
    }

    public String getTopOrgnmEng() {
        return topOrgnmEng;
    }

    public void setTopOrgnmEng(String topOrgnmEng) {
        this.topOrgnmEng = topOrgnmEng;
    }

    public String getCclNm() {
        return cclNm;
    }

    public void setCclNm(String cclNm) {
        this.cclNm = cclNm;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getOrgFullnm() {
        return orgFullnm;
    }

    public void setOrgFullnm(String orgFullnm) {
        this.orgFullnm = orgFullnm;
    }

    public String getTbId() {
        return tbId;
    }

    public void setTbId(String tbId) {
        this.tbId = tbId;
    }

    public String getTbNm() {
        return tbNm;
    }

    public void setTbNm(String tbNm) {
        this.tbNm = tbNm;
    }

    public String getOpenSrv() {
        return openSrv;
    }

    public void setOpenSrv(String openSrv) {
        this.openSrv = openSrv;
    }

    public String getCancelSrv() {
        return cancelSrv;
    }

    public void setCancelSrv(String cancelSrv) {
        this.cancelSrv = cancelSrv;
    }

    public String getOrgFullnmEng() {
        return orgFullnmEng;
    }

    public void setOrgFullnmEng(String orgFullnmEng) {
        this.orgFullnmEng = orgFullnmEng;
    }

    public String getOrgNmEng() {
        return orgNmEng;
    }

    public void setOrgNmEng(String orgNmEng) {
        this.orgNmEng = orgNmEng;
    }

    public String getCateNmEng() {
        return cateNmEng;
    }

    public void setCateNmEng(String cateNmEng) {
        this.cateNmEng = cateNmEng;
    }

    public String getSrcUrl() {
        return srcUrl;
    }

    public void setSrcUrl(String srcUrl) {
        this.srcUrl = srcUrl;
    }

    public String getSrcExp() {
        return srcExp;
    }

    public void setSrcExp(String srcExp) {
        this.srcExp = srcExp;
    }

    public String getSrcExpEng() {
        return srcExpEng;
    }

    public void setSrcExpEng(String srcExpEng) {
        this.srcExpEng = srcExpEng;
    }

    public String getLoadNm() {
        return loadNm;
    }

    public void setLoadNm(String loadNm) {
        this.loadNm = loadNm;
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

    public String getSearchWd2() {
        return searchWd2;
    }

    public void setSearchWd2(String searchWd2) {
        this.searchWd2 = searchWd2;
    }

    public String getSrvCd() {
        return srvCd;
    }

    public void setSrvCd(String srvCd) {
        this.srvCd = srvCd;
    }

    public String getSrvYn() {
        return srvYn;
    }

    public void setSrvYn(String srvYn) {
        this.srvYn = srvYn;
    }

    public String getViewLang() {
        return viewLang;
    }

    public void setViewLang(String viewLang) {
        this.viewLang = viewLang;
    }

    public String getOldState() {
        return oldState;
    }

    public void setOldState(String oldState) {
        this.oldState = oldState;
    }

    public String getNewState() {
        return newState;
    }

    public void setNewState(String newState) {
        this.newState = newState;
    }

    public String getPrssExp() {
        return prssExp;
    }

    public void setPrssExp(String prssExp) {
        this.prssExp = prssExp;
    }

    public String getPrssStateNm() {
        return prssStateNm;
    }

    public void setPrssStateNm(String prssStateNm) {
        this.prssStateNm = prssStateNm;
    }

    public String getPrssGubun() {
        return prssGubun;
    }

    public void setPrssGubun(String prssGubun) {
        this.prssGubun = prssGubun;
    }

    public String getOrgCdMod() {
        return orgCdMod;
    }

    public void setOrgCdMod(String orgCdMod) {
        this.orgCdMod = orgCdMod;
    }

    public String getUsrCdMod() {
        return usrCdMod;
    }

    public void setUsrCdMod(String usrCdMod) {
        this.usrCdMod = usrCdMod;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getCateFullnm() {
        return cateFullnm;
    }

    public void setCateFullnm(String cateFullnm) {
        this.cateFullnm = cateFullnm;
    }

    public String getCateFullnmEng() {
        return cateFullnmEng;
    }

    public void setCateFullnmEng(String cateFullnmEng) {
        this.cateFullnmEng = cateFullnmEng;
    }

    public String getOrgTopNm() {
        return orgTopNm;
    }

    public void setOrgTopNm(String orgTopNm) {
        this.orgTopNm = orgTopNm;
    }

    public String getCateList() {
        return cateList;
    }

    public void setCateList(String cateList) {
        this.cateList = cateList;
    }

    public String getCateIdTop() {
        return cateIdTop;
    }

    public void setCateIdTop(String cateIdTop) {
        this.cateIdTop = cateIdTop;
    }

    public String getOrgCdTop() {
        return orgCdTop;
    }

    public void setOrgCdTop(String orgCdTop) {
        this.orgCdTop = orgCdTop;
    }

    public String getOrgList() {
        return orgList;
    }

    public void setOrgList(String orgList) {
        this.orgList = orgList;
    }

    public String getCateTopNm() {
        return cateTopNm;
    }

    public void setCateTopNm(String cateTopNm) {
        this.cateTopNm = cateTopNm;
    }

    public String getCateTopNmEng() {
        return cateTopNmEng;
    }

    public void setCateTopNmEng(String cateTopNmEng) {
        this.cateTopNmEng = cateTopNmEng;
    }

    public String getSearchId() {
        return searchId;
    }

    public void setSearchId(String searchId) {
        this.searchId = searchId;
    }

    public String getSearchGubun() {
        return searchGubun;
    }

    public void setSearchGubun(String searchGubun) {
        this.searchGubun = searchGubun;
    }

    public String getCclNmCd() {
        return cclNmCd;
    }

    public void setCclNmCd(String cclNmCd) {
        this.cclNmCd = cclNmCd;
    }

    public String getLoadNmCd() {
        return loadNmCd;
    }

    public void setLoadNmCd(String loadNmCd) {
        this.loadNmCd = loadNmCd;
    }

    public String getOrgTopNmEng() {
        return orgTopNmEng;
    }

    public void setOrgTopNmEng(String orgTopNmEng) {
        this.orgTopNmEng = orgTopNmEng;
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getCols() {
        return cols;
    }

    public void setCols(String cols) {
        this.cols = cols;
    }

    public String getTagEng() {
        return tagEng;
    }

    public void setTagEng(String tagEng) {
        this.tagEng = tagEng;
    }

    public String getApiRes() {
        return apiRes;
    }

    public void setApiRes(String apiRes) {
        this.apiRes = apiRes;
    }

    public String getSgrpCd() {
        return sgrpCd;
    }

    public void setSgrpCd(String sgrpCd) {
        this.sgrpCd = sgrpCd;
    }

    public String getUseOrgCnt() {
        return useOrgCnt;
    }

    public void setUseOrgCnt(String useOrgCnt) {
        this.useOrgCnt = useOrgCnt;
    }

    public String getUseUsrCnt() {
        return useUsrCnt;
    }

    public void setUseUsrCnt(String useUsrCnt) {
        this.useUsrCnt = useUsrCnt;
    }

    public String getAprvProcYn() {
        return aprvProcYn;
    }

    public void setAprvProcYn(String aprvProcYn) {
        this.aprvProcYn = aprvProcYn;
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

    public int getWiseopenCnt() {
        return wiseopenCnt;
    }

    public void setWiseopenCnt(int wiseopenCnt) {
        this.wiseopenCnt = wiseopenCnt;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getLoadDate() {
        return loadDate;
    }

    public void setLoadDate(String loadDate) {
        this.loadDate = loadDate;
    }

    public String getGssYn() {
        return gssYn;
    }

    public void setGssYn(String gssYn) {
        this.gssYn = gssYn;
    }

    public String getEndInfo() {
        return endInfo;
    }

    public void setEndInfo(String endInfo) {
        this.endInfo = endInfo;
    }

    public String getDataCondDttm() {
        return dataCondDttm;
    }

    public void setDataCondDttm(String dataCondDttm) {
        this.dataCondDttm = dataCondDttm;
    }

    public String getUseDeptNm() {
        return useDeptNm;
    }

    public void setUseDeptNm(String useDeptNm) {
        this.useDeptNm = useDeptNm;
    }


    public String getEmdYn() {
        return emdYn;
    }

    public void setEmdYn(String emdYn) {
        this.emdYn = emdYn;
    }

    @Override
    public String toString() {
        return "OpenInf [infId=" + infId + ", infNm=" + infNm + ", infNmEng="
                + infNmEng + ", dtId=" + dtId + ", dsId=" + dsId + ", dsNm="
                + dsNm + ", cateId=" + cateId + ", infTag=" + infTag
                + ", infUrl=" + infUrl + ", infExp=" + infExp + ", infExpEng="
                + infExpEng + ", openDttm=" + openDttm + ", orgCd=" + orgCd
                + ", cclCd=" + cclCd + ", loadCd=" + loadCd + ", loadDttm="
                + loadDttm + ", loadDttmStr=" + loadDttmStr + ", prssState="
                + prssState + ", infState=" + infState + ", infStateNm="
                + infStateNm + ", korYn=" + korYn + ", engYn=" + engYn
                + ", korMobileYn=" + korMobileYn + ", regId=" + regId
                + ", regDttm=" + regDttm + ", updId=" + updId + ", updDttm="
                + updDttm + ", openCd=" + openCd + ", causeCd=" + causeCd
                + ", causeInfo=" + causeInfo + ", infTagEng=" + infTagEng
                + ", usrCd=" + usrCd + ", dtNm=" + dtNm + ", dtNmEng="
                + dtNmEng + ", cateNm=" + cateNm + ", cateFullNm=" + cateFullNm
                + ", orgNm=" + orgNm + ", topOrgNm=" + topOrgNm
                + ", topOrgnmEng=" + topOrgnmEng + ", cclNm=" + cclNm
                + ", usrNm=" + usrNm + ", orgFullnm=" + orgFullnm + ", tbId="
                + tbId + ", tbNm=" + tbNm + ", openSrv=" + openSrv
                + ", cancelSrv=" + cancelSrv + ", orgFullnmEng=" + orgFullnmEng
                + ", orgNmEng=" + orgNmEng + ", cateNmEng=" + cateNmEng
                + ", srcUrl=" + srcUrl + ", srcExp=" + srcExp + ", srcExpEng="
                + srcExpEng + ", loadNm=" + loadNm + ", searchWord="
                + searchWord + ", searchWd=" + searchWd + ", searchWd2="
                + searchWd2 + ", srvCd=" + srvCd + ", srvYn=" + srvYn
                + ", viewLang=" + viewLang + ", oldState=" + oldState
                + ", newState=" + newState + ", prssExp=" + prssExp
                + ", prssStateNm=" + prssStateNm + ", prssGubun=" + prssGubun
                + ", orgCdMod=" + orgCdMod + ", usrCdMod=" + usrCdMod
                + ", post=" + post + ", cateFullnm=" + cateFullnm
                + ", cateFullnmEng=" + cateFullnmEng + ", orgTopNm=" + orgTopNm
                + ", cateList=" + cateList + ", cateIdTop=" + cateIdTop
                + ", orgCdTop=" + orgCdTop + ", orgList=" + orgList
                + ", cateTopNm=" + cateTopNm + ", cateTopNmEng=" + cateTopNmEng
                + ", searchId=" + searchId + ", searchGubun=" + searchGubun
                + ", cclNmCd=" + cclNmCd + ", loadNmCd="
                + loadNmCd + ", orgTopNmEng=" + orgTopNmEng + ", sortBy="
                + sortBy + ", tag=" + tag + ", cols=" + cols + ", tagEng="
                + tagEng + ", apiRes=" + apiRes + ", sgrpCd=" + sgrpCd
                + ", useOrgCnt=" + useOrgCnt + ", useUsrCnt=" + useUsrCnt
                + ", aprvProcYn=" + aprvProcYn + ", niaId=" + niaId
                + ", mospaSysCd=" + mospaSysCd + ", basisLaw=" + basisLaw
                + ", domainUrl=" + domainUrl + ", keyword1=" + keyword1
                + ", keyword2=" + keyword2 + ", keyword3=" + keyword3
                + ", dbExp=" + dbExp + ", mngId=" + mngId + ", copyright3Yn="
                + copyright3Yn + ", copyright3CclYn=" + copyright3CclYn
                + ", copyright3CclFile=" + copyright3CclFile
                + ", chngLoadDttm=" + chngLoadDttm + ", chargeYn=" + chargeYn
                + ", chargeAmt=" + chargeAmt + ", chargeCd=" + chargeCd
                + ", chargeCdFile=" + chargeCdFile + ", dataCd=" + dataCd
                + ", dataUrl=" + dataUrl + ", dataMediaCd=" + dataMediaCd
                + ", dataMediaCnt=" + dataMediaCnt + ", dataMediaExt="
                + dataMediaExt + ", langCd=" + langCd + ", note=" + note
                + ", dataFileYn=" + dataFileYn + ", wiseopenCnt=" + wiseopenCnt
                + ", orderBy=" + orderBy + ", loadDate=" + loadDate
                + ", gssYn=" + gssYn
                + ", endInfo=" + endInfo
                + ", dataCondDttm=" + dataCondDttm
                + ", useDeptNm=" + useDeptNm + ", seqceNo=" + seqceNo
                + ", usrId=" + usrId + ", accCd=" + accCd + ", themeCate="
                + themeCate + ", saCate=" + saCate + ", cateId2=" + cateId2
                + ", infSrv=" + infSrv
                + ", cateNm2=" + cateNm2 + ", tCd=" + tCd + ", lCd=" + lCd
                + ", emdYn=" + emdYn + "]";
    }

    /**
     * 메타정보에서 한글꺠짐 발생으로 encodeURIComponent() 로 Param 전송 --> Java에서 깨짐 --> Decode
     */
    public void decodeURIEncoding() {
        try {
            if (infNm != null) infNm = URLDecoder.decode(infNm, "UTF-8");
            if (cateNm != null) cateNm = URLDecoder.decode(cateNm, "UTF-8");
            if (dtNm != null) dtNm = URLDecoder.decode(dtNm, "UTF-8");
            if (causeInfo != null) causeInfo = URLDecoder.decode(causeInfo, "UTF-8");
            if (infTag != null) infTag = URLDecoder.decode(infTag, "UTF-8");
            //if(infExp != null) infExp=URLDecoder.decode(infExp.replaceAll("%", "%25"),"UTF-8");
            if (infExp != null) infExp = URLDecoder.decode(infExp, "UTF-8");
            if (dataCondDttm != null) dataCondDttm = URLDecoder.decode(dataCondDttm, "UTF-8");

            if (useDeptNm != null) useDeptNm = URLDecoder.decode(useDeptNm, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            EgovWebUtil.exLogging(e);
        }
    }

    public int getSeqceNo() {
        return seqceNo;
    }

    public void setSeqceNo(int seqceNo) {
        this.seqceNo = seqceNo;
    }

    public String getUsrId() {
        return usrId;
    }

    public void setUsrId(String usrId) {
        this.usrId = usrId;
    }

    public String getAccCd() {
        return accCd;
    }

    public void setAccCd(String accCd) {
        this.accCd = accCd;
    }

    public String getThemeCate() {
        return themeCate;
    }

    public void setThemeCate(String themeCate) {
        this.themeCate = themeCate;
    }

    public String getSaCate() {
        return saCate;
    }

    public void setSaCate(String saCate) {
        this.saCate = saCate;
    }

    public String getCateId2() {
        return cateId2;
    }

    public void setCateId2(String cateId2) {
        this.cateId2 = cateId2;
    }

    public String getInfSrv() {
        return infSrv;
    }

    public void setInfSrv(String infSrv) {
        this.infSrv = infSrv;
    }

    public String getCateNm2() {
        return cateNm2;
    }

    public void setCateNm2(String cateNm2) {
        this.cateNm2 = cateNm2;
    }

    public String getPrssAccCd() {
        return prssAccCd;
    }

    public void setPrssAccCd(String prssAccCd) {
        this.prssAccCd = prssAccCd;
    }

    public String getFvtDataOrder() {
        return fvtDataOrder;
    }

    public void setFvtDataOrder(String fvtDataOrder) {
        this.fvtDataOrder = fvtDataOrder;
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

    public String getFvtDataYn() {
        return fvtDataYn;
    }

    public void setFvtDataYn(String fvtDataYn) {
        this.fvtDataYn = fvtDataYn;
    }

    public String getSysInpGbn() {
        return SysInpGbn;
    }

    public void setSysInpGbn(String sysInpGbn) {
        SysInpGbn = sysInpGbn;
    }

    public String getInpOrgCd() {
        return inpOrgCd;
    }

    public void setInpOrgCd(String inpOrgCd) {
        this.inpOrgCd = inpOrgCd;
    }

    public int getInpUsrCd() {
        return inpUsrCd;
    }

    public void setInpUsrCd(int inpUsrCd) {
        this.inpUsrCd = inpUsrCd;
    }


}
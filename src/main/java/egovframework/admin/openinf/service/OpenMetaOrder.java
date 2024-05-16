package egovframework.admin.openinf.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenMetaOrder extends CommVo implements Serializable {
    private String itemCd;
    private String cateId;
    private String itemNm;
    private String itemLevel;
    private String itemType;
    private String sysLang;
    private String vOrder;
    private String itemState;
    private String infState;
    //private String dsCd;
    private String openSrv;
    private String openDttm;


    private String infNm;
    private String dtNm;
    private String cclNm;
    private String orgNm;
    private String cateNm;
    private String cateFullnm;
    private String usrNm;
    private String infTag;
    private String useOrgCnt;
    private String aprvProcYn;
    private String fvtDataOrder;
    private String searchWord;

    private String saCd;
    private String themeCd;
    private String Cd;


    private String cateCd;

    private String cateDivTag;
    private String cateId2;


    public String getCateDivTag() {
        return cateDivTag;
    }

    public void setCateDivTag(String cateDivTag) {
        this.cateDivTag = cateDivTag;
    }

    public String getCateId2() {
        return cateId2;
    }

    public void setCateId2(String cateId2) {
        this.cateId2 = cateId2;
    }

    public String getSaCd() {
        return saCd;
    }

    public void setSaCd(String saCd) {
        this.saCd = saCd;
    }

    public String getThemeCd() {
        return themeCd;
    }

    public void setThemeCd(String themeCd) {
        this.themeCd = themeCd;
    }

    public String getItemCd() {
        return itemCd;
    }

    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }

    public String getItemNm() {
        return itemNm;
    }

    public void setItemNm(String itemNm) {
        this.itemNm = itemNm;
    }

    public String getItemLevel() {
        return itemLevel;
    }

    public void setItemLevel(String itemLevel) {
        this.itemLevel = itemLevel;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public String getSysLang() {
        return sysLang;
    }

    public void setSysLang(String sysLang) {
        this.sysLang = sysLang;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }

    public String getItemState() {
        return itemState;
    }

    public void setItemState(String itemState) {
        this.itemState = itemState;
    }

    public String getInfState() {
        return infState;
    }

    public void setInfState(String infState) {
        this.infState = infState;
    }

    public String getOpenSrv() {
        return openSrv;
    }

    public void setOpenSrv(String openSrv) {
        this.openSrv = openSrv;
    }

    public String getOpenDttm() {
        return openDttm;
    }

    public void setOpenDttm(String openDttm) {
        this.openDttm = openDttm;
    }

    public String getCateId() {
        return cateId;
    }

    public void setCateId(String cateId) {
        this.cateId = cateId;
    }

    private String infId;

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

    public String getDtNm() {
        return dtNm;
    }

    public void setDtNm(String dtNm) {
        this.dtNm = dtNm;
    }

    public String getCclNm() {
        return cclNm;
    }

    public void setCclNm(String cclNm) {
        this.cclNm = cclNm;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getCateNm() {
        return cateNm;
    }

    public void setCateNm(String cateNm) {
        this.cateNm = cateNm;
    }

    public String getCateFullnm() {
        return cateFullnm;
    }

    public void setCateFullnm(String cateFullnm) {
        this.cateFullnm = cateFullnm;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getInfTag() {
        return infTag;
    }

    public void setInfTag(String infTag) {
        this.infTag = infTag;
    }

    public String getUseOrgCnt() {
        return useOrgCnt;
    }

    public void setUseOrgCnt(String useOrgCnt) {
        this.useOrgCnt = useOrgCnt;
    }

    public String getAprvProcYn() {
        return aprvProcYn;
    }

    public void setAprvProcYn(String aprvProcYn) {
        this.aprvProcYn = aprvProcYn;
    }

    public String getFvtDataOrder() {
        return fvtDataOrder;
    }

    public void setFvtDataOrder(String fvtDataOrder) {
        this.fvtDataOrder = fvtDataOrder;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getCateCd() {
        return cateCd;
    }

    public void setCateCd(String cateCd) {
        this.cateCd = cateCd;
    }

    public String getCd() {
        return Cd;
    }

    public void setCd(String Cd) {
        this.Cd = Cd;
    }


}
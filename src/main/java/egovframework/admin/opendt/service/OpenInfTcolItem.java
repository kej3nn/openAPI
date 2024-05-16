package egovframework.admin.opendt.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenInfTcolItem extends CommVo implements Serializable {
    private String itemCd;
    private String itemNm;
    private String itemNmEng;
    private String dtNm;
    private String dtId;
    private String itemCdCheck;
    private String vOrder;
    private String dummyYn;
    private String unitCd;
    private String unitSubCd;
    private String itemExp;
    private String itemExpEng;
    private String useYn;
    private String itemCdPar;
    private String itemNav;
    private String itemLevel;
    private String prnItemNm;
    private String prnItemNmEng;
    private String itemLvl;
    private String defaultCheckYn;

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

    public String getItemNmEng() {
        return itemNmEng;
    }

    public void setItemNmEng(String itemNmEng) {
        this.itemNmEng = itemNmEng;
    }

    public String getDtNm() {
        return dtNm;
    }

    public void setDtNm(String dtNm) {
        this.dtNm = dtNm;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getDtId() {
        return dtId;
    }

    public void setDtId(String dtId) {
        this.dtId = dtId;
    }

    public String getItemCdCheck() {
        return itemCdCheck;
    }

    public void setItemCdCheck(String itemCdCheck) {
        this.itemCdCheck = itemCdCheck;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }

    public String getDummyYn() {
        return dummyYn;
    }

    public void setDummyYn(String dummyYn) {
        this.dummyYn = dummyYn;
    }

    public String getUnitCd() {
        return unitCd;
    }

    public void setUnitCd(String unitCd) {
        this.unitCd = unitCd;
    }

    public String getItemExp() {
        return itemExp;
    }

    public void setItemExp(String itemExp) {
        this.itemExp = itemExp;
    }

    public String getItemExpEng() {
        return itemExpEng;
    }

    public void setItemExpEng(String itemExpEng) {
        this.itemExpEng = itemExpEng;
    }

    public String getItemCdPar() {
        return itemCdPar;
    }

    public void setItemCdPar(String itemCdPar) {
        this.itemCdPar = itemCdPar;
    }

    public String getItemNav() {
        return itemNav;
    }

    public void setItemNav(String itemNav) {
        this.itemNav = itemNav;
    }

    public String getItemLevel() {
        return itemLevel;
    }

    public void setItemLevel(String itemLevel) {
        this.itemLevel = itemLevel;
    }

    public String getPrnItemNm() {
        return prnItemNm;
    }

    public void setPrnItemNm(String prnItemNm) {
        this.prnItemNm = prnItemNm;
    }

    public String getPrnItemNmEng() {
        return prnItemNmEng;
    }

    public void setPrnItemNmEng(String prnItemNmEng) {
        this.prnItemNmEng = prnItemNmEng;
    }

    public String getItemLvl() {
        return itemLvl;
    }

    public void setItemLvl(String itemLvl) {
        this.itemLvl = itemLvl;
    }

    public String getUnitSubCd() {
        return unitSubCd;
    }

    public void setUnitSubCd(String unitSubCd) {
        this.unitSubCd = unitSubCd;
    }

    public String getDefaultCheckYn() {
        return defaultCheckYn;
    }

    public void setDefaultCheckYn(String defaultCheckYn) {
        this.defaultCheckYn = defaultCheckYn;
    }

}
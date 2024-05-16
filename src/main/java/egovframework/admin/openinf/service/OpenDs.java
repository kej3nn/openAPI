package egovframework.admin.openinf.service;

import java.io.Serializable;
import java.util.Date;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenDs extends CommVo implements Serializable {

    private String searchWd2;
    private String colNmm;
    private String srcColNm;
    private String dsId;
    private String dsNm;
    private String dsNmEng;
    private String ownerCd;
    private Integer dtId;
    private String dtNm;
    private String searchWord;
    private String searchWd;
    private String tableName;
    private String owner;
    private String ownTabId;
    private String srcExp;
    private String dsExp;
    private String dsExpEng;
    //private String dsCd;
    private String useYn;
    private String pubYn;
    private String pubYnExp;
    private String regId;
    private Date regDttm;
    private String updId;
    private Date updDttm;
    private String tableComments;
    private String fsYn;
    private String fsCd;
    private String isLock;

    private String bcpDsId;
    private String keyDbYn;
    private String stddDsYn;
    private String conntyCd;
    private String loadCd;
    private String autoAccYn;
    private String bcpOwnerCd;
    private String searchGubun;
    private String searchVal;
    private String lddataCd;

    private String backTableName;

    public String getBcpDsId() {
        return bcpDsId;
    }

    public void setBcpDsId(String bcpDsId) {
        this.bcpDsId = bcpDsId;
    }

    public String getKeyDbYn() {
        return keyDbYn;
    }

    public void setKeyDbYn(String keyDbYn) {
        this.keyDbYn = keyDbYn;
    }

    public String getStddDsYn() {
        return stddDsYn;
    }

    public void setStddDsYn(String stddDsYn) {
        this.stddDsYn = stddDsYn;
    }


    public String getIsLock() {
        return isLock;
    }

    public void setIsLock(String isLock) {
        this.isLock = isLock;
    }

    public String getFsYn() {
        return fsYn;
    }

    public void setFsYn(String fsYn) {
        this.fsYn = fsYn;
    }

    public String getFsCd() {
        return fsCd;
    }

    public void setFsCd(String fsCd) {
        this.fsCd = fsCd;
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

    public String getDsNmEng() {
        return dsNmEng;
    }

    public void setDsNmEng(String dsNmEng) {
        this.dsNmEng = dsNmEng;
    }

    public String getOwnerCd() {
        return ownerCd;
    }

    public void setOwnerCd(String ownerCd) {
        this.ownerCd = ownerCd;
    }

    public Integer getDtId() {
        return dtId;
    }

    public void setDtId(Integer dtId) {
        this.dtId = dtId;
    }

    public String getDtNm() {
        return dtNm;
    }

    public void setDtNm(String dtNm) {
        this.dtNm = dtNm;
    }

    public String getDsExp() {
        return dsExp;
    }

    public void setDsExp(String dsExp) {
        this.dsExp = dsExp;
    }

    public String getDsExpEng() {
        return dsExpEng;
    }

    public void setDsExpEng(String dsExpEng) {
        this.dsExpEng = dsExpEng;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public Date getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(Date regDttm) {
        this.regDttm = regDttm;
    }

    public String getUpdId() {
        return updId;
    }

    public void setUpdId(String updId) {
        this.updId = updId;
    }

    public Date getUpdDttm() {
        return updDttm;
    }

    public void setUpdDttm(Date updDttm) {
        this.updDttm = updDttm;
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

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getOwnTabId() {
        return ownTabId;
    }

    public void setOwnTabId(String ownTabId) {
        this.ownTabId = ownTabId;
    }

    public String getSrcExp() {
        return srcExp;
    }

    public void setSrcExp(String srcExp) {
        this.srcExp = srcExp;
    }

    public String getTableComments() {
        return tableComments;
    }

    public void setTableComments(String tableComments) {
        this.tableComments = tableComments;
    }

    public String getPubYn() {
        return pubYn;
    }

    public void setPubYn(String pubYn) {
        this.pubYn = pubYn;
    }

    public String getPubYnExp() {
        return pubYnExp;
    }

    public void setPubYnExp(String pubYnExp) {
        this.pubYnExp = pubYnExp;
    }

    public String getSrcColNm() {
        return srcColNm;
    }

    public void setSrcColNm(String srcColNm) {
        this.srcColNm = srcColNm;
    }

    public String getColNmm() {
        return colNmm;
    }

    public void setColNmm(String colNmm) {
        this.colNmm = colNmm;
    }

    public String getSearchWd2() {
        return searchWd2;
    }

    public void setSearchWd2(String searchWd2) {
        this.searchWd2 = searchWd2;
    }

    public String getBackTableName() {
        return backTableName;
    }

    public void setBackTableName(String backTableName) {
        this.backTableName = backTableName;
    }

    public String getConntyCd() {
        return conntyCd;
    }

    public void setConntyCd(String conntyCd) {
        this.conntyCd = conntyCd;
    }

    public String getLoadCd() {
        return loadCd;
    }

    public void setLoadCd(String loadCd) {
        this.loadCd = loadCd;
    }

    public String getAutoAccYn() {
        return autoAccYn;
    }

    public void setAutoAccYn(String autoAccYn) {
        this.autoAccYn = autoAccYn;
    }

    public String getBcpOwnerCd() {
        return bcpOwnerCd;
    }

    public void setBcpOwnerCd(String bcpOwnerCd) {
        this.bcpOwnerCd = bcpOwnerCd;
    }

    public String getSearchGubun() {
        return searchGubun;
    }

    public void setSearchGubun(String searchGubun) {
        this.searchGubun = searchGubun;
    }

    public String getSearchVal() {
        return searchVal;
    }

    public void setSearchVal(String searchVal) {
        this.searchVal = searchVal;
    }

    public String getLddataCd() {
        return lddataCd;
    }

    public void setLddataCd(String lddataCd) {
        this.lddataCd = lddataCd;
    }


}
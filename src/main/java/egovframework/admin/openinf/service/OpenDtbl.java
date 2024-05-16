package egovframework.admin.openinf.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class OpenDtbl extends OpenDt implements Serializable {

    private String ownerCd;
    private String dsId;
    private String tbId;
    private String tbNm;
    private String srcTblCd;
    private String linkCd;
    private String prssCd;
    private String createCd;
    private String loadCd;
    private String ftLoadDttm;
    private String ltLoadDttm;
    private String prLoadDttm;
    private String ownTabId;
    private String owner;
    private String tableName;
    private String tDelChk;

    //	private Integer dtId;
    public String gettDelChk() {
        return tDelChk;
    }

    public void settDelChk(String tDelChk) {
        this.tDelChk = tDelChk;
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

    public String getSrcTblCd() {
        return srcTblCd;
    }

    public void setSrcTblCd(String srcTblCd) {
        this.srcTblCd = srcTblCd;
    }

    public String getLinkCd() {
        return linkCd;
    }

    public void setLinkCd(String linkCd) {
        this.linkCd = linkCd;
    }

    public String getPrssCd() {
        return prssCd;
    }

    public void setPrssCd(String prssCd) {
        this.prssCd = prssCd;
    }

    public String getCreateCd() {
        return createCd;
    }

    public void setCreateCd(String createCd) {
        this.createCd = createCd;
    }

    public String getLoadCd() {
        return loadCd;
    }

    public void setLoadCd(String loadCd) {
        this.loadCd = loadCd;
    }

    public String getFtLoadDttm() {
        return ftLoadDttm;
    }

    public void setFtLoadDttm(String ftLoadDttm) {
        this.ftLoadDttm = ftLoadDttm;
    }

    public String getLtLoadDttm() {
        return ltLoadDttm;
    }

    public void setLtLoadDttm(String ltLoadDttm) {
        this.ltLoadDttm = ltLoadDttm;
    }

    public String getPrLoadDttm() {
        return prLoadDttm;
    }

    public void setPrLoadDttm(String prLoadDttm) {
        this.prLoadDttm = prLoadDttm;
    }

    public String getOwnTabId() {
        return ownTabId;
    }

    public void setOwnTabId(String ownTabId) {
        this.ownTabId = ownTabId;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
//	public Integer getDtId() {
//		return dtId;
//	}
//	public void setDtId(Integer dtId) {
//		this.dtId = dtId;
//	}


}

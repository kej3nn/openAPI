package egovframework.admin.openinf.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class OpenDscol extends OpenDs implements Serializable {

    //	private String dsId;
    private Integer colSeq;
    private String colId;
    private String colNm;
    private String colNmEng;
    private String unitCd;
    private Integer vOrder;
    private String srcColId;
    private String srcColType;
    private Integer srcColSize;
    private Integer srcColScale;
    private String pkYn;
    private String indexYn;
    private String nullYn;
    //private String statYn;
    private String colExp;
    private String colExpEng;
    //	private String useYn;
//	private String regId;
//	private Date regDttm;
//	private String updId;
//	private Date updDttm;
    private String columnName;

    private String columnComments;
    private String dataType;
    private String dataLength;
    private String dataTypeLeng;
    //	private String owner;
//	private String tableName;
    private Integer columnId;
    private String viewLang;
    private Integer termSeq;
    private String bbsTit;
    private String bbsCont;

    private String dbcColNm;
    private String dbcColKorNm;
    private String commDtlCdNm;
    private String anaCnt;
    private String esnErCnt;
    private String colErrRate;

    private Integer resdntergNoCnt;
    private Integer frgnrNoCnt;
    private Integer driveLicenceNoCnt;
    private Integer passportNoCnt;
    private Integer emailNoCnt;
    private Integer telNoCnt;
    private Integer mphonNoCnt;
    private Integer accntNoCnt;
    private Integer cardNoCnt;
    private Integer coprtnNoCnt;
    private Integer bizmanNoCnt;
    private Integer healthInsrncNoCnt;
    private String beginDtm;
    private String endDtm;

    private String jsCd;

    private Integer verifyId;
    private String needYn;
    private String addrCd;
    private String colRefCd;


    public String getColRefCd() {
        return colRefCd;
    }

    public void setColRefCd(String colRefCd) {
        this.colRefCd = colRefCd;
    }

    public Integer getResdntergNoCnt() {
        return resdntergNoCnt;
    }

    public void setResdntergNoCnt(Integer resdntergNoCnt) {
        this.resdntergNoCnt = resdntergNoCnt;
    }

    public Integer getFrgnrNoCnt() {
        return frgnrNoCnt;
    }

    public void setFrgnrNoCnt(Integer frgnrNoCnt) {
        this.frgnrNoCnt = frgnrNoCnt;
    }

    public Integer getDriveLicenceNoCnt() {
        return driveLicenceNoCnt;
    }

    public void setDriveLicenceNoCnt(Integer driveLicenceNoCnt) {
        this.driveLicenceNoCnt = driveLicenceNoCnt;
    }

    public Integer getPassportNoCnt() {
        return passportNoCnt;
    }

    public void setPassportNoCnt(Integer passportNoCnt) {
        this.passportNoCnt = passportNoCnt;
    }

    public Integer getEmailNoCnt() {
        return emailNoCnt;
    }

    public void setEmailNoCnt(Integer emailNoCnt) {
        this.emailNoCnt = emailNoCnt;
    }

    public Integer getTelNoCnt() {
        return telNoCnt;
    }

    public void setTelNoCnt(Integer telNoCnt) {
        this.telNoCnt = telNoCnt;
    }

    public Integer getMphonNoCnt() {
        return mphonNoCnt;
    }

    public void setMphonNoCnt(Integer mphonNoCnt) {
        this.mphonNoCnt = mphonNoCnt;
    }

    public Integer getAccntNoCnt() {
        return accntNoCnt;
    }

    public void setAccntNoCnt(Integer accntNoCnt) {
        this.accntNoCnt = accntNoCnt;
    }

    public Integer getCardNoCnt() {
        return cardNoCnt;
    }

    public void setCardNoCnt(Integer cardNoCnt) {
        this.cardNoCnt = cardNoCnt;
    }

    public Integer getCoprtnNoCnt() {
        return coprtnNoCnt;
    }

    public void setCoprtnNoCnt(Integer coprtnNoCnt) {
        this.coprtnNoCnt = coprtnNoCnt;
    }

    public Integer getBizmanNoCnt() {
        return bizmanNoCnt;
    }

    public void setBizmanNoCnt(Integer bizmanNoCnt) {
        this.bizmanNoCnt = bizmanNoCnt;
    }

    public Integer getHealthInsrncNoCnt() {
        return healthInsrncNoCnt;
    }

    public void setHealthInsrncNoCnt(Integer healthInsrncNoCnt) {
        this.healthInsrncNoCnt = healthInsrncNoCnt;
    }

    public String getBeginDtm() {
        return beginDtm;
    }

    public void setBeginDtm(String beginDtm) {
        this.beginDtm = beginDtm;
    }

    public String getEndDtm() {
        return endDtm;
    }

    public void setEndDtm(String endDtm) {
        this.endDtm = endDtm;
    }

    //	public String getDsId() {
//		return dsId;
//	}
//	public void setDsId(String dsId) {
//		this.dsId = dsId;
//	}
    public Integer getColSeq() {
        return colSeq;
    }

    public void setColSeq(Integer colSeq) {
        this.colSeq = colSeq;
    }

    public String getColId() {
        return colId;
    }

    public void setColId(String colId) {
        this.colId = colId;
    }

    public String getColNm() {
        return colNm;
    }

    public void setColNm(String colNm) {
        this.colNm = colNm;
    }

    public String getColNmEng() {
        return colNmEng;
    }

    public void setColNmEng(String colNmEng) {
        this.colNmEng = colNmEng;
    }

    public String getUnitCd() {
        return unitCd;
    }

    public void setUnitCd(String unitCd) {
        this.unitCd = unitCd;
    }

    public Integer getvOrder() {
        return vOrder;
    }

    public void setvOrder(Integer vOrder) {
        this.vOrder = vOrder;
    }

    public String getSrcColId() {
        return srcColId;
    }

    public void setSrcColId(String srcColId) {
        this.srcColId = srcColId;
    }

    public String getSrcColType() {
        return srcColType;
    }

    public void setSrcColType(String srcColType) {
        this.srcColType = srcColType;
    }

    public Integer getSrcColSize() {
        return srcColSize;
    }

    public void setSrcColSize(Integer srcColSize) {
        this.srcColSize = srcColSize;
    }

    public Integer getSrcColScale() {
        return srcColScale;
    }

    public void setSrcColScale(Integer srcColScale) {
        this.srcColScale = srcColScale;
    }

    public String getPkYn() {
        return pkYn;
    }

    public void setPkYn(String pkYn) {
        this.pkYn = pkYn;
    }

    public String getIndexYn() {
        return indexYn;
    }

    public void setIndexYn(String indexYn) {
        this.indexYn = indexYn;
    }

    public String getNullYn() {
        return nullYn;
    }

    public void setNullYn(String nullYn) {
        this.nullYn = nullYn;
    }

    public String getColExp() {
        return colExp;
    }

    public void setColExp(String colExp) {
        this.colExp = colExp;
    }

    public String getColExpEng() {
        return colExpEng;
    }

    public void setColExpEng(String colExpEng) {
        this.colExpEng = colExpEng;
    }

    //	public String getUseYn() {
//		return useYn;
//	}
//	public void setUseYn(String useYn) {
//		this.useYn = useYn;
//	}
//	public String getRegId() {
//		return regId;
//	}
//	public void setRegId(String regId) {
//		this.regId = regId;
//	}
//	public Date getRegDttm() {
//		return regDttm;
//	}
//	public void setRegDttm(Date regDttm) {
//		this.regDttm = regDttm;
//	}
//	public String getUpdId() {
//		return updId;
//	}
//	public void setUpdId(String updId) {
//		this.updId = updId;
//	}
//	public Date getUpdDttm() {
//		return updDttm;
//	}
//	public void setUpdDttm(Date updDttm) {
//		this.updDttm = updDttm;
//	}
    public String getDataTypeLeng() {
        return dataTypeLeng;
    }

    public void setDataTypeLeng(String dataTypeLeng) {
        this.dataTypeLeng = dataTypeLeng;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnComments() {
        return columnComments;
    }

    public void setColumnComments(String columnComments) {
        this.columnComments = columnComments;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getDataLength() {
        return dataLength;
    }

    public void setDataLength(String dataLength) {
        this.dataLength = dataLength;
    }

    //	public String getOwner() {
//		return owner;
//	}
//	public void setOwner(String owner) {
//		this.owner = owner;
//	}
//	public String getTableName() {
//		return tableName;
//	}
//	public void setTableName(String tableName) {
//		this.tableName = tableName;
//	}
    public Integer getColumnId() {
        return columnId;
    }

    public void setColumnId(Integer columnId) {
        this.columnId = columnId;
    }

    public String getViewLang() {
        return viewLang;
    }

    public void setViewLang(String viewLang) {
        this.viewLang = viewLang;
    }

    public Integer getTermSeq() {
        return termSeq;
    }

    public void setTermSeq(Integer termSeq) {
        this.termSeq = termSeq;
    }

    public String getBbsTit() {
        return bbsTit;
    }

    public void setBbsTit(String bbsTit) {
        this.bbsTit = bbsTit;
    }

    public String getBbsCont() {
        return bbsCont;
    }

    public void setBbsCont(String bbsCont) {
        this.bbsCont = bbsCont;
    }

    public String getDbcColNm() {
        return dbcColNm;
    }

    public void setDbcColNm(String dbcColNm) {
        this.dbcColNm = dbcColNm;
    }

    public String getDbcColKorNm() {
        return dbcColKorNm;
    }

    public void setDbcColKorNm(String dbcColKorNm) {
        this.dbcColKorNm = dbcColKorNm;
    }

    public String getCommDtlCdNm() {
        return commDtlCdNm;
    }

    public void setCommDtlCdNm(String commDtlCdNm) {
        this.commDtlCdNm = commDtlCdNm;
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

    public String getColErrRate() {
        return colErrRate;
    }

    public void setColErrRate(String colErrRate) {
        this.colErrRate = colErrRate;
    }

    public String getJsCd() {
        return jsCd;
    }

    public void setJsCd(String jsCd) {
        this.jsCd = jsCd;
    }

    public Integer getVerifyId() {
        return verifyId;
    }

    public void setVerifyId(Integer verifyId) {
        this.verifyId = verifyId;
    }

    public String getNeedYn() {
        return needYn;
    }

    public void setNeedYn(String needYn) {
        this.needYn = needYn;
    }

    public String getAddrCd() {
        return addrCd;
    }

    public void setAddrCd(String addrCd) {
        this.addrCd = addrCd;
    }


}

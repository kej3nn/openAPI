package egovframework.admin.openinf.service;

import java.io.Serializable;
import java.util.Date;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenPublish extends CommVo implements Serializable {

    private String status;
    private String pubYy;
    private String pubId;
    private String pubNm;
    private String dsNm;
    private String langTag;
    private String pubYmd;
    private String pubHhmm;
    private String pubDttm;
    private String pubDttmCheck;
    private String pubDttmFrom;
    private String pubDttmTo;
    private String fileYn;
    private String pubExp;
    private String refColId;
    private String refColNm;
    private String orgCd;
    private String orgFullNm;
    private String usrCd;
    private String usrNm;
    private String usrTel;
    private String pubokYn;
    private String pubokDttm;
    private String viewCnt;
    private String autoYn;
    private String useYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;
    private int arrFileSeq;
    private String pubNmEng;
    private String pubExpEng;
    private String orgNm;
    private String dsId;
    private String refDsId;
    private String refDsNm;

    private Integer fileSeq;
    private Integer fileSize;
    private String srcFileNm;
    private String saveFileNm;
    private String viewFileNm;
    private Integer fileCnt;
    private String fileExt;

    private String today;
    private String infNm;
    private String infUrl;
    private Integer MstSeq;
    private String dataModified;

    public String getPubYy() {
        return pubYy;
    }

    public void setPubYy(String pubYy) {
        this.pubYy = pubYy;
    }

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

    public String getDsNm() {
        return dsNm;
    }

    public void setDsNm(String dsNm) {
        this.dsNm = dsNm;
    }

    public String getLangTag() {
        return langTag;
    }

    public void setLangTag(String langTag) {
        this.langTag = langTag;
    }

    public String getPubYmd() {
        return pubYmd;
    }

    public void setPubYmd(String pubYmd) {
        this.pubYmd = pubYmd;
    }

    public String getPubHhmm() {
        return pubHhmm;
    }

    public void setPubHhmm(String pubHhmm) {
        this.pubHhmm = pubHhmm;
    }

    public String getPubDttm() {
        return pubDttm;
    }

    public void setPubDttm(String pubDttm) {
        this.pubDttm = pubDttm;
    }

    public String getPubDttmCheck() {
        return pubDttmCheck;
    }

    public void setPubDttmCheck(String pubDttmCheck) {
        this.pubDttmCheck = pubDttmCheck;
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

    public String getFileYn() {
        return fileYn;
    }

    public void setFileYn(String fileYn) {
        this.fileYn = fileYn;
    }

    public String getPubExp() {
        return pubExp;
    }

    public void setPubExp(String pubExp) {
        this.pubExp = pubExp;
    }

    public String getRefColId() {
        return refColId;
    }

    public void setRefColId(String refColId) {
        this.refColId = refColId;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getOrgFullNm() {
        return orgFullNm;
    }

    public void setOrgFullNm(String orgFullNm) {
        this.orgFullNm = orgFullNm;
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

    public String getUsrTel() {
        return usrTel;
    }

    public void setUsrTel(String usrTel) {
        this.usrTel = usrTel;
    }

    public String getPubokYn() {
        return pubokYn;
    }

    public void setPubokYn(String pubokYn) {
        this.pubokYn = pubokYn;
    }

    public String getPubokDttm() {
        return pubokDttm;
    }

    public void setPubokDttm(String pubokDttm) {
        this.pubokDttm = pubokDttm;
    }

    public String getViewCnt() {
        return viewCnt;
    }

    public void setViewCnt(String viewCnt) {
        this.viewCnt = viewCnt;
    }

    public String getAutoYn() {
        return autoYn;
    }

    public void setAutoYn(String autoYn) {
        this.autoYn = autoYn;
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

    public String getPubNmEng() {
        return pubNmEng;
    }

    public void setPubNmEng(String pubNmEng) {
        this.pubNmEng = pubNmEng;
    }

    public String getPubExpEng() {
        return pubExpEng;
    }

    public void setPubExpEng(String pubExpEng) {
        this.pubExpEng = pubExpEng;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getRefDsId() {
        return refDsId;
    }

    public void setRefDsId(String refDsId) {
        this.refDsId = refDsId;
    }

    public String getRefDsNm() {
        return refDsNm;
    }

    public void setRefDsNm(String refDsNm) {
        this.refDsNm = refDsNm;
    }

    public String getSrcFileNm() {
        return srcFileNm;
    }

    public void setSrcFileNm(String srcFileNm) {
        this.srcFileNm = srcFileNm;
    }

    public String getFileExt() {
        return fileExt;
    }

    public void setFileExt(String fileExt) {
        this.fileExt = fileExt;
    }

    public String getSaveFileNm() {
        return saveFileNm;
    }

    public void setSaveFileNm(String saveFileNm) {
        this.saveFileNm = saveFileNm;
    }

    public String getViewFileNm() {
        return viewFileNm;
    }

    public void setViewFileNm(String viewFileNm) {
        this.viewFileNm = viewFileNm;
    }

    public Integer getMstSeq() {
        return MstSeq;
    }

    public void setMstSeq(Integer mstSeq) {
        MstSeq = mstSeq;
    }

    public Integer getFileCnt() {
        return fileCnt;
    }

    public String getDataModified() {
        return dataModified;
    }

    public void setDataModified(String dataModified) {
        this.dataModified = dataModified;
    }

    public String getToday() {
        return today;
    }

    public void setToday(String today) {
        this.today = today;
    }

    public String getDsId() {
        return dsId;
    }

    public void setDsId(String dsId) {
        this.dsId = dsId;
    }

    public Integer getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    public Integer getFileSize() {
        return fileSize;
    }

    public void setFileSize(Integer fileSize) {
        this.fileSize = fileSize;
    }

    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }

    public String getRefColNm() {
        return refColNm;
    }

    public void setRefColNm(String refColNm) {
        this.refColNm = refColNm;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getArrFileSeq() {
        return arrFileSeq;
    }

    public void setArrFileSeq(int arrFileSeq) {
        this.arrFileSeq = arrFileSeq;
    }

    public String getInfNm() {
        return infNm;
    }

    public void setInfNm(String infNm) {
        this.infNm = infNm;
    }

    public String getInfUrl() {
        return infUrl;
    }

    public void setInfUrl(String infUrl) {
        this.infUrl = infUrl;
    }


}
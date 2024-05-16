package egovframework.admin.service.service;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

@SuppressWarnings("serial")
public class OpenInfVcol extends OpenInfSrv implements Serializable {

    private String colId;
    private String colNm;
    private String colNmEnm;
    private String viewCd;
    private String vOrder;
    private String useYn;
    private String condYn;
    private String condOp;
    private String condVar;
    private String filtCode;
    private String fileExp;
    private String aoptSet;
    private String ditcCd;
    private String ditcNm;
    private String ditcNmEng;
    private String reqOp;
    private String reqVar;
    private String reqNeed;
    private String reqType;


    private int mediaNo;
    private String mediaMtdCd;
    private String mediaTypeCd;
    private String downYn;
    private int fileSeq;
    private int arrFileSeq;
    private String srcFileNm;
    private String saveFileNm;
    private String viewFileNm;
    private String streamUrl;
    private String prodNm;
    private String telNo;
    private String tmnlImgFile;
    private String siteNm;
    private String cclCd;
    private String tranDesc;
    private String ftCrDttm;
    private String ltCrDttm;
    private String viewLang;
    private String detlSubject;
    private int mediaDetailNo;
    private int vistnSeq;
    private String vistnUrl;
    private String vistnExp;
    private String prdNm;
    private String vistnTyNm;
    private String regDttm;


    public String getReqYn() {
        return reqYn;
    }

    public void setReqYn(String reqYn) {
        this.reqYn = reqYn;
    }

    private String reqYn;

    public String getReqNeed() {
        return reqNeed;
    }

    public void setReqNeed(String reqNeed) {
        this.reqNeed = reqNeed;
    }

    public String getReqType() {
        return reqType;
    }

    public void setReqType(String reqType) {
        this.reqType = reqType;
    }

    public String getReqVar() {
        return reqVar;
    }

    public void setReqVar(String reqVar) {
        this.reqVar = reqVar;
    }

    public String getReqOp() {
        return reqOp;
    }

    public void setReqOp(String reqOp) {
        this.reqOp = reqOp;
    }

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }

    public String getPrdNm() {
        return prdNm;
    }

    public void setPrdNm(String prdNm) {
        this.prdNm = prdNm;
    }

    public String getVistnTyNm() {
        return vistnTyNm;
    }

    public void setVistnTyNm(String vistnTyNm) {
        this.vistnTyNm = vistnTyNm;
    }

    public String getVistnUrl() {
        return vistnUrl;
    }

    public void setVistnUrl(String vistnUrl) {
        this.vistnUrl = vistnUrl;
    }

    public String getVistnExp() {
        return vistnExp;
    }

    public void setVistnExp(String vistnExp) {
        this.vistnExp = vistnExp;
    }

    public int getVistnSeq() {
        return vistnSeq;
    }

    public void setVistnSeq(int vistnSeq) {
        this.vistnSeq = vistnSeq;
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

    public String getColNmEnm() {
        return colNmEnm;
    }

    public void setColNmEnm(String colNmEnm) {
        this.colNmEnm = colNmEnm;
    }

    public String getViewCd() {
        return viewCd;
    }

    public void setViewCd(String viewCd) {
        this.viewCd = viewCd;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getCondYn() {
        return condYn;
    }

    public void setCondYn(String condYn) {
        this.condYn = condYn;
    }

    public String getCondOp() {
        return condOp;
    }

    public void setCondOp(String condOp) {
        this.condOp = condOp;
    }

    public String getCondVar() {
        return condVar;
    }

    public void setCondVar(String condVar) {
        this.condVar = condVar;
    }

    public String getFiltCode() {
        return filtCode;
    }

    public void setFiltCode(String filtCode) {
        this.filtCode = filtCode;
    }

    public String getFileExp() {
        return fileExp;
    }

    public void setFileExp(String fileExp) {
        this.fileExp = fileExp;
    }

    public String getAoptSet() {
        return aoptSet;
    }

    public void setAoptSet(String aoptSet) {
        this.aoptSet = aoptSet;
    }

    public String getDitcCd() {
        return ditcCd;
    }

    public void setDitcCd(String ditcCd) {
        this.ditcCd = ditcCd;
    }

    public String getDitcNm() {
        return ditcNm;
    }

    public void setDitcNm(String ditcNm) {
        this.ditcNm = ditcNm;
    }

    public String getDitcNmEng() {
        return ditcNmEng;
    }

    public void setDitcNmEng(String ditcNmEng) {
        this.ditcNmEng = ditcNmEng;
    }

    public int getMediaNo() {
        return mediaNo;
    }

    public void setMediaNo(int mediaNo) {
        this.mediaNo = mediaNo;
    }

    public String getMediaMtdCd() {
        return mediaMtdCd;
    }

    public void setMediaMtdCd(String mediaMtdCd) {
        this.mediaMtdCd = mediaMtdCd;
    }

    public String getMediaTypeCd() {
        return mediaTypeCd;
    }

    public void setMediaTypeCd(String mediaTypeCd) {
        this.mediaTypeCd = mediaTypeCd;
    }

    public String getDownYn() {
        return downYn;
    }

    public void setDownYn(String downYn) {
        this.downYn = downYn;
    }

    public int getArrFileSeq() {
        return arrFileSeq;
    }

    public void setArrFileSeq(int arrFileSeq) {
        this.arrFileSeq = arrFileSeq;
    }

    public int getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(int fileSeq) {
        this.fileSeq = fileSeq;
    }

    public String getSrcFileNm() {
        return srcFileNm;
    }

    public void setSrcFileNm(String srcFileNm) {
        this.srcFileNm = srcFileNm;
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

    public String getStreamUrl() {
        return streamUrl;
    }

    public void setStreamUrl(String streamUrl) {
        this.streamUrl = streamUrl;
    }

    public String getProdNm() {
        return prodNm;
    }

    public void setProdNm(String prodNm) {
        this.prodNm = prodNm;
    }

    public String getTelNo() {
        return telNo;
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getTmnlImgFile() {
        return tmnlImgFile;
    }

    public void setTmnlImgFile(String tmnlImgFile) {
        this.tmnlImgFile = tmnlImgFile;
    }

    public String getSiteNm() {
        return siteNm;
    }

    public void setSiteNm(String siteNm) {
        this.siteNm = siteNm;
    }

    public String getCclCd() {
        return cclCd;
    }

    public void setCclCd(String cclCd) {
        this.cclCd = cclCd;
    }

    public String getTranDesc() {
        return tranDesc;
    }

    public void setTranDesc(String tranDesc) {
        this.tranDesc = tranDesc;
    }

    public String getFtCrDttm() {
        return ftCrDttm;
    }

    public void setFtCrDttm(String ftCrDttm) {
        this.ftCrDttm = ftCrDttm;
    }

    public String getLtCrDttm() {
        return ltCrDttm;
    }

    public void setLtCrDttm(String ltCrDttm) {
        this.ltCrDttm = ltCrDttm;
    }

    public String getViewLang() {
        return viewLang;
    }

    public void setViewLang(String viewLang) {
        this.viewLang = viewLang;
    }

    public String getDetlSubject() {
        return detlSubject;
    }

    public void setDetlSubject(String detlSubject) {
        this.detlSubject = detlSubject;
    }

    public int getMediaDetailNo() {
        return mediaDetailNo;
    }

    public void setMediaDetailNo(int mediaDetailNo) {
        this.mediaDetailNo = mediaDetailNo;
    }
}
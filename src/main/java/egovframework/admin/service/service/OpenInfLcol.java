package egovframework.admin.service.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class OpenInfLcol extends OpenInfSrv implements Serializable {

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
    private String reqYn;
    private String reqOp;
    private String reqVar;
    private String reqNeed;
    private String reqType;
    private String aoptSet;
    private String ditcCd;
    private String ditcNm;
    private int linkSeq;
    private String tmnlImgFile;
    private String linkUrl;
    private String linkExp;
    private String regDttm;
    private String fileExt;
    private String srcFileNm;


    public String getFileExt() {
        return fileExt;
    }

    public void setFileExt(String fileExt) {
        this.fileExt = fileExt;
    }

    public String getSrcFileNm() {
        return srcFileNm;
    }

    public void setSrcFileNm(String srcFileNm) {
        this.srcFileNm = srcFileNm;
    }

    public String getTmnlImgFile() {
        return tmnlImgFile;
    }

    public void setTmnlImgFile(String tmnlImgFile) {
        this.tmnlImgFile = tmnlImgFile;
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

    public String getViewCd() {
        return viewCd;
    }

    public void setViewCd(String viewCd) {
        this.viewCd = viewCd;
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

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
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

    public String getColNmEnm() {
        return colNmEnm;
    }

    public void setColNmEnm(String colNmEnm) {
        this.colNmEnm = colNmEnm;
    }

    public String getReqYn() {
        return reqYn;
    }

    public void setReqYn(String reqYn) {
        this.reqYn = reqYn;
    }

    public String getReqOp() {
        return reqOp;
    }

    public void setReqOp(String reqOp) {
        this.reqOp = reqOp;
    }

    public String getReqVar() {
        return reqVar;
    }

    public void setReqVar(String reqVar) {
        this.reqVar = reqVar;
    }

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

    public int getLinkSeq() {
        return linkSeq;
    }

    public void setLinkSeq(int linkSeq) {
        this.linkSeq = linkSeq;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getLinkExp() {
        return linkExp;
    }

    public void setLinkExp(String linkExp) {
        this.linkExp = linkExp;
    }

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }


}
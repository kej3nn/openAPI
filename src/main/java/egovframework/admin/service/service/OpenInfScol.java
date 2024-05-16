package egovframework.admin.service.service;

import java.io.Serializable;

import javax.mail.Multipart;

import org.springframework.web.multipart.MultipartFile;

import egovframework.common.util.UtilString;

@SuppressWarnings("serial")
public class OpenInfScol extends OpenInfSrv implements Serializable {

    private String colId;
    private String colNm;
    private String colNmEnm;
    private String viewCd;
    private String vOrder;
    private String alignTag;
    private String viewSize;
    private String sortTag;
    private String viewYn;
    private String useYn;
    private String condYn;
    private String condOp;
    private String condVar;
    private String filtYn;
    private String filtCd;
    private String filtCode;
    private String filtDefault;
    private String filtDefault1;
    private String filtDefault2;
    private String filtNeed;
    private String filtNeed1;
    private String filtNeed2;
    private String downYn;
    private String filtTblCd;
    private String filtTblCc;
    private String filtTblCn;
    private String soptSet;
    private String filtMaxDay;
    private String ditcCd;
    private String ditcNm;
    private String ditcNmEng;
    private String formatText;
    private String ellipsisText;
    private String filtDefaultNm;
    private String filtDefaultVal;
    private String srcColNm;
    private String allowNull;
    private String saveTmnlNm;
    private String tmnlImgFile;
    private MultipartFile uploadTmnlfile;


    public MultipartFile getUploadTmnlfile() {
        return uploadTmnlfile;
    }

    public void setUploadTmnlfile(MultipartFile uploadTmnlfile) {
        this.uploadTmnlfile = uploadTmnlfile;
    }

    public String getTmnlImgFile() {
        return tmnlImgFile;
    }

    public void setTmnlImgFile(String tmnlImgFile) {
        this.tmnlImgFile = tmnlImgFile;
    }

    public String getSaveTmnlNm() {
        return saveTmnlNm;
    }

    public void setSaveTmnlNm(String saveTmnlNm) {
        this.saveTmnlNm = saveTmnlNm;
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

    public String getAlignTag() {
        return alignTag;
    }

    public void setAlignTag(String alignTag) {
        this.alignTag = alignTag;
    }

    public String getViewSize() {
        return viewSize;
    }

    public void setViewSize(String viewSize) {
        this.viewSize = viewSize;
    }

    public String getSortTag() {
        return sortTag;
    }

    public void setSortTag(String sortTag) {
        this.sortTag = sortTag;
    }

    public String getViewYn() {
        return viewYn;
    }

    public void setViewYn(String viewYn) {
        this.viewYn = viewYn;
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

    public String getFiltCd() {
        return filtCd;
    }

    public void setFiltCd(String filtCd) {
        this.filtCd = filtCd;
    }

    public String getFiltCode() {
        return filtCode;
    }

    public void setFiltCode(String filtCode) {
        this.filtCode = filtCode;
    }

    public String getFiltDefault() {
        return filtDefault;
    }

    public void setFiltDefault(String filtDefault) {
        this.filtDefault = filtDefault;
    }

    public String getFiltNeed() {
        return filtNeed;
    }

    public void setFiltNeed(String filtNeed) {
        this.filtNeed = filtNeed;
    }

    public String getDownYn() {
        return downYn;
    }

    public void setDownYn(String downYn) {
        this.downYn = downYn;
    }

    public String getFiltTblCd() {
        return filtTblCd;
    }

    public void setFiltTblCd(String filtTblCd) {
        this.filtTblCd = UtilString.SQLInjectionFilter(filtTblCd);
    }

    public String getFiltTblCc() {
        return filtTblCc;
    }

    public void setFiltTblCc(String filtTblCc) {
        this.filtTblCc = filtTblCc;
    }

    public String getFiltTblCn() {
        return filtTblCn;
    }

    public void setFiltTblCn(String filtTblCn) {
        this.filtTblCn = filtTblCn;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }

    public String getSoptSet() {
        return soptSet;
    }

    public void setSoptSet(String soptSet) {
        this.soptSet = soptSet;
    }

    public String getFiltYn() {
        return filtYn;
    }

    public void setFiltYn(String filtYn) {
        this.filtYn = filtYn;
    }

    public String getFiltMaxDay() {
        return filtMaxDay;
    }

    public void setFiltMaxDay(String filtMaxDay) {
        this.filtMaxDay = filtMaxDay;
    }

    public String getFiltDefault1() {
        return filtDefault1;
    }

    public void setFiltDefault1(String filtDefault1) {
        this.filtDefault1 = filtDefault1;
    }

    public String getFiltDefault2() {
        return filtDefault2;
    }

    public void setFiltDefault2(String filtDefault2) {
        this.filtDefault2 = filtDefault2;
    }

    public String getFiltNeed1() {
        return filtNeed1;
    }

    public void setFiltNeed1(String filtNeed1) {
        this.filtNeed1 = filtNeed1;
    }

    public String getFiltNeed2() {
        return filtNeed2;
    }

    public void setFiltNeed2(String filtNeed2) {
        this.filtNeed2 = filtNeed2;
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

    public String getDitcNmEng() {
        return ditcNmEng;
    }

    public void setDitcNmEng(String ditcNmEng) {
        this.ditcNmEng = ditcNmEng;
    }

    public String getFormatText() {
        return formatText;
    }

    public void setFormatText(String formatText) {
        this.formatText = formatText;
    }

    public String getEllipsisText() {
        return ellipsisText;
    }

    public void setEllipsisText(String ellipsisText) {
        this.ellipsisText = ellipsisText;
    }

    public String getFiltDefaultNm() {
        return filtDefaultNm;
    }

    public void setFiltDefaultNm(String filtDefaultNm) {
        this.filtDefaultNm = filtDefaultNm;
    }

    public String getFiltDefaultVal() {
        return filtDefaultVal;
    }

    public void setFiltDefaultVal(String filtDefaultVal) {
        this.filtDefaultVal = filtDefaultVal;
    }

    public String getSrcColNm() {
        return srcColNm;
    }

    public void setSrcColNm(String srcColNm) {
        this.srcColNm = UtilString.SQLInjectionFilter(srcColNm);
    }

    public String getAllowNull() {
        return allowNull;
    }

    public void setAllowNull(String allowNull) {
        this.allowNull = allowNull;
    }

}
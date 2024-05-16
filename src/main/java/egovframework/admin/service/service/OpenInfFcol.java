package egovframework.admin.service.service;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

@SuppressWarnings("serial")
public class OpenInfFcol extends OpenInfSrv implements Serializable {

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
    private int fileSeq;
    private int arrFileSeq;
    private String fileCd;
    private String srcFileNm;
    private String dpSrcFileNm;
    private String saveFileNm;
    private String viewFileNm;
    private String dpViewFileNm;
    private String viewFileNmEng;
    private int fileSize;
    private float fileSizeKb;
    private String fileSizeKmb;
    private String fileSizeMb;
    private String fileExt;
    private String ftCrDttm;
    private String ltCrDttm;
    private String fileCdNm;
    private String fsclYy;
    private String fsclYyNm;
    private String wrtNm;


    public String getDpSrcFileNm() {
        return dpSrcFileNm;
    }

    public void setDpSrcFileNm(String dpSrcFileNm) {
        this.dpSrcFileNm = dpSrcFileNm;
    }

    public String getDpViewFileNm() {
        return dpViewFileNm;
    }

    public void setDpViewFileNm(String dpViewFileNm) {
        this.dpViewFileNm = dpViewFileNm;
    }

    public String getWrtNm() {
        return wrtNm;
    }

    public void setWrtNm(String wrtNm) {
        this.wrtNm = wrtNm;
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

    public String getDitcNmEng() {
        return ditcNmEng;
    }

    public void setDitcNmEng(String ditcNmEng) {
        this.ditcNmEng = ditcNmEng;
    }

    public int getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(int fileSeq) {
        this.fileSeq = fileSeq;
    }

    public String getFileCd() {
        return fileCd;
    }

    public void setFileCd(String fileCd) {
        this.fileCd = fileCd;
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

    public int getFileSize() {
        return fileSize;
    }

    public void setFileSize(int fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileExt() {
        return fileExt;
    }

    public void setFileExt(String fileExt) {
        this.fileExt = fileExt;
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

    public String getViewFileNmEng() {
        return viewFileNmEng;
    }

    public void setViewFileNmEng(String viewFileNmEng) {
        this.viewFileNmEng = viewFileNmEng;
    }

    public int getArrFileSeq() {
        return arrFileSeq;
    }

    public void setArrFileSeq(int arrFileSeq) {
        this.arrFileSeq = arrFileSeq;
    }

    public float getFileSizeKb() {
        return fileSizeKb;
    }

    public void setFileSizeKb(float fileSizeKb) {
        this.fileSizeKb = fileSizeKb;
    }

    public String getFileExp() {
        return fileExp;
    }

    public void setFileExp(String fileExp) {
        this.fileExp = fileExp;
    }

    public String getFileCdNm() {
        return fileCdNm;
    }

    public void setFileCdNm(String fileCdNm) {
        this.fileCdNm = fileCdNm;
    }

    public String getFileSizeMb() {
        return fileSizeMb;
    }

    public void setFileSizeMb(String fileSizeMb) {
        this.fileSizeMb = fileSizeMb;
    }

    public String getFileSizeKmb() {
        return fileSizeKmb;
    }

    public void setFileSizeKmb(String fileSizeKmb) {
        this.fileSizeKmb = fileSizeKmb;
    }

    public String getFsclYy() {
        return fsclYy;
    }

    public void setFsclYy(String fsclYy) {
        this.fsclYy = fsclYy;
    }

    public String getFsclYyNm() {
        return fsclYyNm;
    }

    public void setFsclYyNm(String fsclYyNm) {
        this.fsclYyNm = fsclYyNm;
    }


}
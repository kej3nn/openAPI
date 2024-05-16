package egovframework.admin.opendt.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class OpenCate extends CommVo implements Serializable {
    private String cateId;
    private String cateNm;
    private String cateNmEng;
    private String cateIdPar;
    private String cateIdTop;
    private String cateLvl;
    private String tImgNm;
    private String niaId;
    private String ditcCd;
    private String ditcNm;
    private String useYn;
    private String vOrder;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;
    private String cateIdCheck;
    private String cateNav;
    private String cateNmPar;
    private String cateCib;
    private int updlvl;
    private String topPrev;
    private String cateIdParKEM;
    private String sysLang;

    private String cateFullnm;
    private String cateFullnmEng;

    private String saveFileNm;
    private String srcFileNm;

    private String delYnVal;

    private String delYnVal2;
    private Integer delYn0;
    private Integer delYn1;
    private Integer delYn2;
    private Integer delYn3;
    private Integer delYn4;
    private Integer delYn5;
    private Integer delYn6;
    private Integer delYn7;
    private Integer delCount;


    public String getCateId() {
        return cateId;
    }

    public void setCateId(String cateId) {
        this.cateId = cateId;
    }

    public String getCateNmEng() {
        return cateNmEng;
    }

    public void setCateNmEng(String cateNmEng) {
        this.cateNmEng = cateNmEng;
    }

    public String getCateIdPar() {
        return cateIdPar;
    }

    public void setCateIdPar(String cateIdPar) {
        this.cateIdPar = cateIdPar;
    }

    public String getCateIdTop() {
        return cateIdTop;
    }

    public void setCateIdTop(String cateIdTop) {
        this.cateIdTop = cateIdTop;
    }

    public String getCateLvl() {
        return cateLvl;
    }

    public void setCateLvl(String cateLvl) {
        this.cateLvl = cateLvl;
    }

    public String gettImgNm() {
        return tImgNm;
    }

    public void settImgNm(String tImgNm) {
        this.tImgNm = tImgNm;
    }

    public String getNiaId() {
        return niaId;
    }

    public void setNiaId(String niaId) {
        this.niaId = niaId;
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

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
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

    public String getCateIdCheck() {
        return cateIdCheck;
    }

    public void setCateIdCheck(String cateIdCheck) {
        this.cateIdCheck = cateIdCheck;
    }

    public String getCateNav() {
        return cateNav;
    }

    public void setCateNav(String cateNav) {
        this.cateNav = cateNav;
    }

    public String getCateNmPar() {
        return cateNmPar;
    }

    public void setCateNmPar(String cateNmPar) {
        this.cateNmPar = cateNmPar;
    }

    public String getCateCib() {
        return cateCib;
    }

    public void setCateCib(String cateCib) {
        this.cateCib = cateCib;
    }

    public int getUpdlvl() {
        return updlvl;
    }

    public void setUpdlvl(int updlvl) {
        this.updlvl = updlvl;
    }

    public String getTopPrev() {
        return topPrev;
    }

    public void setTopPrev(String topPrev) {
        this.topPrev = topPrev;
    }

    public String getCateFullnm() {
        return cateFullnm;
    }

    public void setCateFullnm(String cateFullnm) {
        this.cateFullnm = cateFullnm;
    }

    public String getCateFullnmEng() {
        return cateFullnmEng;
    }

    public void setCateFullnmEng(String cateFullnmEng) {
        this.cateFullnmEng = cateFullnmEng;
    }

    public String getCateNm() {
        return cateNm;
    }

    public void setCateNm(String cateNm) {
        this.cateNm = cateNm;
    }

    public String getCateIdParKEM() {
        return cateIdParKEM;
    }

    public void setCateIdParKEM(String cateIdParKEM) {
        this.cateIdParKEM = cateIdParKEM;
    }

    public String getSysLang() {
        return sysLang;
    }

    public void setSysLang(String sysLang) {
        this.sysLang = sysLang;
    }

    public String getSaveFileNm() {
        return saveFileNm;
    }

    public void setSaveFileNm(String saveFileNm) {
        this.saveFileNm = saveFileNm;
    }

    public String getSrcFileNm() {
        return srcFileNm;
    }

    public void setSrcFileNm(String srcFileNm) {
        this.srcFileNm = srcFileNm;
    }

    public String getDelYnVal() {
        return delYnVal;
    }

    public void setDelYnVal(String delYnVal) {
        this.delYnVal = delYnVal;
    }

    public String getDelYnVal2() {
        return delYnVal2;
    }

    public void setDelYnVal2(String delYnVal2) {
        this.delYnVal2 = delYnVal2;
    }

    public Integer getDelYn0() {
        return delYn0;
    }

    public void setDelYn0(Integer delYn0) {
        this.delYn0 = delYn0;
    }

    public Integer getDelYn1() {
        return delYn1;
    }

    public void setDelYn1(Integer delYn1) {
        this.delYn1 = delYn1;
    }

    public Integer getDelYn2() {
        return delYn2;
    }

    public void setDelYn2(Integer delYn2) {
        this.delYn2 = delYn2;
    }

    public Integer getDelYn3() {
        return delYn3;
    }

    public void setDelYn3(Integer delYn3) {
        this.delYn3 = delYn3;
    }

    public Integer getDelYn4() {
        return delYn4;
    }

    public void setDelYn4(Integer delYn4) {
        this.delYn4 = delYn4;
    }

    public Integer getDelYn5() {
        return delYn5;
    }

    public void setDelYn5(Integer delYn5) {
        this.delYn5 = delYn5;
    }

    public Integer getDelYn6() {
        return delYn6;
    }

    public void setDelYn6(Integer delYn6) {
        this.delYn6 = delYn6;
    }

    public Integer getDelYn7() {
        return delYn7;
    }

    public void setDelYn7(Integer delYn7) {
        this.delYn7 = delYn7;
    }

    public Integer getDelCount() {
        return delCount;
    }

    public void setDelCount(Integer delCount) {
        this.delCount = delCount;
    }


}
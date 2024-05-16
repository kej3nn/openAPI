package egovframework.admin.basicinf.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

public class CommUsrSearch extends CommVo implements Serializable {

    private int usrCd;
    private String usrNm;
    private String usrNmEng;
    private String orgCd;
    private String orgNm;
    private String orgNmEng;
    private String orgFullNm;
    private String orgSearchWd;
    private String usrSearchWd;
    private String orgCdTop;
    private String orgCdPar;
    private String orgLvl;

    public int getUsrCd() {
        return usrCd;
    }

    public void setUsrCd(int usrCd) {
        this.usrCd = usrCd;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getUsrNmEng() {
        return usrNmEng;
    }

    public void setUsrNmEng(String usrNmEng) {
        this.usrNmEng = usrNmEng;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getOrgSearchWd() {
        return orgSearchWd;
    }

    public void setOrgSearchWd(String orgSearchWd) {
        this.orgSearchWd = orgSearchWd;
    }

    public String getUsrSearchWd() {
        return usrSearchWd;
    }

    public void setUsrSearchWd(String usrSearchWd) {
        this.usrSearchWd = usrSearchWd;
    }

    public String getOrgFullNm() {
        return orgFullNm;
    }

    public void setOrgFullNm(String orgFullNm) {
        this.orgFullNm = orgFullNm;
    }

    public String getOrgCdTop() {
        return orgCdTop;
    }

    public void setOrgCdTop(String orgCdTop) {
        this.orgCdTop = orgCdTop;
    }

    public String getOrgCdPar() {
        return orgCdPar;
    }

    public void setOrgCdPar(String orgCdPar) {
        this.orgCdPar = orgCdPar;
    }

    public String getOrgNmEng() {
        return orgNmEng;
    }

    public void setOrgNmEng(String orgNmEng) {
        this.orgNmEng = orgNmEng;
    }

    public String getOrgLvl() {
        return orgLvl;
    }

    public void setOrgLvl(String orgLvl) {
        this.orgLvl = orgLvl;
    }

}

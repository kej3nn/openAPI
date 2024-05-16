package egovframework.admin.basicinf.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

/**
 * @author 공통서비스 개발팀 박지욱
 * @version 1.0
 * @Class Name : CommUsr.java
 * @Description : CommUsr class
 * @Modification Information
 * @
 * @ 수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.03    박지욱          최초 생성
 * @see
 * @since 2009.03.03
 */
@SuppressWarnings("serial")
public class CommUsrAdmin extends CommVo implements Serializable {

    //private static final long serialVersionUID = -8274004534207618049L;

    private int usrCd;
    private String usrId;
    private String usrNm;
    private String usrNmEng;
    private String usrEmail;
    private String usrTel;
    private String orgCd;
    private String orgNm;
    private String orgFullNm;
    private String accYn;
    private String accCd;
    private String accNm;
    private String accokYn;
    private String accokYnDesc;
    private String accUsrId;
    private String accokDttm;
    private String accCnDttm;
    private String useYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;
    private String ip;
    private String usrPw;
    private String menuUrl;
    private String jobCd;
    private String jobNm;
    private String emailYn;
    private String emailId;
    private String emailDomain;
    private String firUsrTel;
    private String midUsrTel;
    private String lastUsrTel;
    private String usrHp;
    private String firUsrHp;
    private String midUsrHp;
    private String lastUsrHp;
    private int maxUsrCd;
    private String searchWd;
    private String searchWord;
    private String hpYn;
    private String usrPki;
    private String pkiDttm;
    private String accIp;
    private String usrGb;
    private String initialPw;
    private int initialPwResult;
    // 알림시간 추가위해 사용
    private String notiHhCd;
    private String notiStartHh;
    private String notiEndHh;
    private String notiHh;
    private String usrWork;


    private String deptNm;
    private String isAdmin;


    public String getNotiHh() {
        return notiHh;
    }

    public void setNotiHh(String notiHh) {
        this.notiHh = notiHh;
    }

    public String getNotiHhCd() {
        return notiHhCd;
    }

    public void setNotiHhCd(String notiHhCd) {
        this.notiHhCd = notiHhCd;
    }

    public String getNotiStartHh() {
        return notiStartHh;
    }

    public void setNotiStartHh(String notiStartHh) {
        this.notiStartHh = notiStartHh;
    }

    public String getNotiEndHh() {
        return notiEndHh;
    }

    public void setNotiEndHh(String notiEndHh) {
        this.notiEndHh = notiEndHh;
    }

    public String getUsrWork() {
        return usrWork;
    }

    public void setUsrWork(String usrWork) {
        this.usrWork = usrWork;
    }

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

    public String getUsrEmail() {
        return usrEmail;
    }

    public void setUsrEmail(String usrEmail) {
        this.usrEmail = usrEmail;
    }

    public String getUsrTel() {
        return usrTel;
    }

    public void setUsrTel(String usrTel) {
        this.usrTel = usrTel;
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

    public String getAccYn() {
        return accYn;
    }

    public void setAccYn(String accYn) {
        this.accYn = accYn;
    }

    public String getAccCd() {
        return accCd;
    }

    public void setAccCd(String accCd) {
        this.accCd = accCd;
    }

    public String getAccNm() {
        return accNm;
    }

    public void setAccNm(String accNm) {
        this.accNm = accNm;
    }

    public String getAccokYn() {
        return accokYn;
    }

    public void setAccokYn(String accokYn) {
        this.accokYn = accokYn;
    }

    public String getAccUsrId() {
        return accUsrId;
    }

    public void setAccUsrId(String accUsrId) {
        this.accUsrId = accUsrId;
    }

    public String getAccokDttm() {
        return accokDttm;
    }

    public void setAccokDttm(String accokDttm) {
        this.accokDttm = accokDttm;
    }

    public String getAccCnDttm() {
        return accCnDttm;
    }

    public void setAccCnDttm(String accCnDttm) {
        this.accCnDttm = accCnDttm;
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

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUsrPw() {
        return usrPw;
    }

    public void setUsrPw(String usrPw) {
        this.usrPw = usrPw;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public String getJobCd() {
        return jobCd;
    }

    public void setJobCd(String jobCd) {
        this.jobCd = jobCd;
    }

    public String getEmailYn() {
        return emailYn;
    }

    public void setEmailYn(String emailYn) {
        this.emailYn = emailYn;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getEmailDomain() {
        return emailDomain;
    }

    public void setEmailDomain(String emailDomain) {
        this.emailDomain = emailDomain;
    }

    public String getFirUsrTel() {
        return firUsrTel;
    }

    public void setFirUsrTel(String firUsrTel) {
        this.firUsrTel = firUsrTel;
    }

    public String getMidUsrTel() {
        return midUsrTel;
    }

    public void setMidUsrTel(String midUsrTel) {
        this.midUsrTel = midUsrTel;
    }

    public String getLastUsrTel() {
        return lastUsrTel;
    }

    public void setLastUsrTel(String lastUsrTel) {
        this.lastUsrTel = lastUsrTel;
    }

    public String getFirUsrHp() {
        return firUsrHp;
    }

    public void setFirUsrHp(String firUsrHp) {
        this.firUsrHp = firUsrHp;
    }

    public String getMidUsrHp() {
        return midUsrHp;
    }

    public void setMidUsrHp(String midUsrHp) {
        this.midUsrHp = midUsrHp;
    }

    public String getLastUsrHp() {
        return lastUsrHp;
    }

    public void setLastUsrHp(String lastUsrHp) {
        this.lastUsrHp = lastUsrHp;
    }

    public int getMaxUsrCd() {
        return maxUsrCd;
    }

    public void setMaxUsrCd(int maxUsrCd) {
        this.maxUsrCd = maxUsrCd;
    }

    public String getSearchWd() {
        return searchWd;
    }

    public void setSearchWd(String searchWd) {
        this.searchWd = searchWd;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getJobNm() {
        return jobNm;
    }

    public void setJobNm(String jobNm) {
        this.jobNm = jobNm;
    }

    public String getHpYn() {
        return hpYn;
    }

    public void setHpYn(String hpYn) {
        this.hpYn = hpYn;
    }

    public String getUsrPki() {
        return usrPki;
    }

    public void setUsrPki(String usrPki) {
        this.usrPki = usrPki;
    }

    public String getPkiDttm() {
        return pkiDttm;
    }

    public void setPkiDttm(String pkiDttm) {
        this.pkiDttm = pkiDttm;
    }

    public String getUsrId() {
        return usrId;
    }

    public void setUsrId(String usrId) {
        this.usrId = usrId;
    }

    public String getAccIp() {
        return accIp;
    }

    public void setAccIp(String accIp) {
        this.accIp = accIp;
    }

    public String getUsrHp() {
        return usrHp;
    }

    public void setUsrHp(String usrHp) {
        this.usrHp = usrHp;
    }

    public String getOrgFullNm() {
        return orgFullNm;
    }

    public void setOrgFullNm(String orgFullNm) {
        this.orgFullNm = orgFullNm;
    }

    public String getUsrGb() {
        return usrGb;
    }

    public void setUsrGb(String usrGb) {
        this.usrGb = usrGb;
    }

    public String getAccokYnDesc() {
        return accokYnDesc;
    }

    public void setAccokYnDesc(String accokYnDesc) {
        this.accokYnDesc = accokYnDesc;
    }

    public String getInitialPw() {
        return initialPw;
    }

    public void setInitialPw(String initialPw) {
        this.initialPw = initialPw;
    }

    public int getInitialPwResult() {
        return initialPwResult;
    }

    public void setInitialPwResult(int initialPwResult) {
        this.initialPwResult = initialPwResult;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(String isAdmin) {
        this.isAdmin = isAdmin;
    }


}

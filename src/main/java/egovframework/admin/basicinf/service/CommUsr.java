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
public class CommUsr extends CommVo implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = -8274004534207618049L;

    private int usrCd;
    private String usrId;
    private String usrNm;
    private String usrNmEng;
    private String usrEmail;
    private String usrTel;
    private String orgCd;
    private String orgNm;
    private String accYn;
    private String accCd;
    private String accUsrId;
    private String accDttm;
    private String accCnDttm;
    private String useYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;
    private String ip;
    private String usrPw;
    private String menuUrl;
    private String menuParam;
    private boolean menuTop;
    private String jobCd;
    private String jobNm;
    private String emailYn;
    private String emailId;
    private String emailDomain;
    private String emailDttm;
    private String firUsrTel;
    private String midUsrTel;
    private String lastUsrTel;
    private String firUsrHp;
    private String midUsrHp;
    private String lastUsrHp;
    private int maxUsrCd;
    private String searchWd;
    private String searchWord;
    private int failCnt;
    private String pwdCurr;
    private String pwdNew1;
    private String pwdNew2;
    private String reqPwYn;
    private String pwDttm;
    private String pkiDnVal;
    private String usrPki;
    private String hpYn;
    private String accokYn;

    private String rauthYn;        //실명인증 여부

    private String usrIp; // 관리자 로그인 접속이력 ip 
    private String usrAgent; // 관리자 로그인 접속이력 브라우저 


    //GPIN관련 변수
    private String rauthVid;        //실명인증 개인식별번호(단방향 암호화)
    private String rauthDi;            //실명인증 중복가입확인정보(단방향 암호화)
    private String rauthBirth;        //실명인증 생년월일
    private String rauthSex;        //실명인증 성별
    private String rauthNi;            //실명인증 내/외국인 구분
    private String rauthDttm;        //실명인증 일자
    //

    //국고보조금 관련 변수
    private String naidCd;
    private String naidId;

    private String deptNm;
    private String deptFullnm;

    private String menuSiteCd;
    private String siteGubun;

    // 알림시간 추가위해 사용
    private String notiHhCd;
    private String notiStartHh;
    private String notiEndHh;
    private String usrWork;


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

    public String getSiteGubun() {
        return siteGubun;
    }

    public void setSiteGubun(String siteGubun) {
        this.siteGubun = siteGubun;
    }

    public String getMenuSiteCd() {
        return menuSiteCd;
    }

    public void setMenuSiteCd(String menuSiteCd) {
        this.menuSiteCd = menuSiteCd;
    }

    public String getAccokYn() {
        return accokYn;
    }

    public void setAccokYn(String accokYn) {
        this.accokYn = accokYn;
    }

    public String getHpYn() {
        return hpYn;
    }

    public void setHpYn(String hpYn) {
        this.hpYn = hpYn;
    }

    public String getRauthYn() {
        return rauthYn;
    }

    public void setRauthYn(String rauthYn) {
        this.rauthYn = rauthYn;
    }

    public String getReqPwYn() {
        return reqPwYn;
    }

    public void setReqPwYn(String reqPwYn) {
        this.reqPwYn = reqPwYn;
    }

    public String getPwDttm() {
        return pwDttm;
    }

    public void setPwDttm(String pwDttm) {
        this.pwDttm = pwDttm;
    }

    public String getUsrIp() {
        return usrIp;
    }

    public void setUsrIp(String usrIp) {
        this.usrIp = usrIp;
    }

    public String getUsrAgent() {
        return usrAgent;
    }

    public void setUsrAgent(String usrAgent) {
        this.usrAgent = usrAgent;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public String getUsrId() {
        return usrId;
    }

    public void setUsrId(String usrId) {
        this.usrId = usrId;
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

    public String getAccUsrId() {
        return accUsrId;
    }

    public void setAccUsrId(String accUsrId) {
        this.accUsrId = accUsrId;
    }

    public String getAccDttm() {
        return accDttm;
    }

    public void setAccDttm(String accDttm) {
        this.accDttm = accDttm;
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

    public int getUsrCd() {
        return usrCd;
    }

    //public void setUsrCd(String usrCd) {
    //this.usrCd = Integer.parseInt(usrCd);
    //}
    public void setUsrCd(int usrCd) {
        this.usrCd = usrCd;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
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

    public String getEmailDttm() {
        return emailDttm;
    }

    public void setEmailDttm(String emailDttm) {
        this.emailDttm = emailDttm;
    }

    public int getFailCnt() {
        return failCnt;
    }

    public void setFailCnt(int failCnt) {
        this.failCnt = failCnt;
    }

    public String getPwdCurr() {
        return pwdCurr;
    }

    public void setPwdCurr(String pwdCurr) {
        this.pwdCurr = pwdCurr;
    }

    public String getPwdNew1() {
        return pwdNew1;
    }

    public void setPwdNew1(String pwdNew1) {
        this.pwdNew1 = pwdNew1;
    }

    public String getPwdNew2() {
        return pwdNew2;
    }

    public void setPwdNew2(String pwdNew2) {
        this.pwdNew2 = pwdNew2;
    }

    public String getPkiDnVal() {
        return pkiDnVal;
    }

    public void setPkiDnVal(String pkiDnVal) {
        this.pkiDnVal = pkiDnVal;
    }

    public String getUsrPki() {
        return usrPki;
    }

    public void setUsrPki(String usrPki) {
        this.usrPki = usrPki;
    }

    public String getRauthVid() {
        return rauthVid;
    }

    public void setRauthVid(String rauthVid) {
        this.rauthVid = rauthVid;
    }

    public String getRauthDi() {
        return rauthDi;
    }

    public void setRauthDi(String rauthDi) {
        this.rauthDi = rauthDi;
    }

    public String getRauthBirth() {
        return rauthBirth;
    }

    public void setRauthBirth(String rauthBirth) {
        this.rauthBirth = rauthBirth;
    }

    public String getRauthSex() {
        return rauthSex;
    }

    public void setRauthSex(String rauthSex) {
        this.rauthSex = rauthSex;
    }

    public String getRauthNi() {
        return rauthNi;
    }

    public void setRauthNi(String rauthNi) {
        this.rauthNi = rauthNi;
    }

    public String getRauthDttm() {
        return rauthDttm;
    }

    public void setRauthDttm(String rauthDttm) {
        this.rauthDttm = rauthDttm;
    }

    public String getNaidCd() {
        return naidCd;
    }

    public void setNaidCd(String naidCd) {
        this.naidCd = naidCd;
    }

    public String getNaidId() {
        return naidId;
    }

    public void setNaidId(String naidId) {
        this.naidId = naidId;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getJobNm() {
        return jobNm;
    }

    public void setJobNm(String jobNm) {
        this.jobNm = jobNm;
    }

    public String getDeptFullnm() {
        return deptFullnm;
    }

    public void setDeptFullnm(String deptFullnm) {
        this.deptFullnm = deptFullnm;
    }

    public String getMenuParam() {
        return menuParam;
    }

    public void setMenuParam(String menuParam) {
        this.menuParam = menuParam;
    }

    public boolean isMenuTop() {
        return menuTop;
    }

    public void setMenuTop(boolean menuTop) {
        this.menuTop = menuTop;
    }
}

package egovframework.admin.user.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;


@SuppressWarnings("serial")
public class CommUsr extends CommVo implements Serializable{
	
	private int usrCd;
	private String usrNm;
	private String usrNmEng;
	private String usrEmail;
	private String usrEmailLast;
	private String emailYn;
	private String emailDttm;
	private String usrTel;
	private String usrHp;
	private String hpYn;
	private String hpDttm;
	private String usrWork;
	private String usrPki;
	private String pkiDttm;
	private String jobCd;
	private String jobNm;
	private String accIp;
	private String rauthYn;
	private String rauthVid;
	private String rauthDi;
	private String rauthBirth;
	private String rauthSex;
	private String rauthNi;
	private String rauthDttm;
	private String accYn;
	private String orgCd;
	private String accCd;
	private String usrId;
	private String usrPw;
	private String usrPwTemp; //초기화한 비밀번호(암호화x) 임시로 담아 sms로 전송한다.
	private String failCnt;
	private String reqPwYn;
	private String pwDttm;
	private String accokUsrId;
	private String accokYn;
	private String accokDttm;
	private String accokCnDttm;
	private String useYn;
	private String regId;
	private String regDttm;
	private String updId;
	private String updDttm;
	
	private String agreeYn; 
	private String agreeDttm;  

	private String orgNm;  
	private String deptNm;  
	private String naidCd;  
	private String naidId;  
	
	//sms서비스 
	private int smsSeq;
	private String sendMsg;
	private String rcvHp;

	//관리자정보 수정에서 사용
	private String usrEmailSplit1;
	private String usrEmailSplit2;
	private String usrTelSplit1;
	private String usrTelSplit2;
	private String usrTelSplit3;
	private String usrHpSplit1;
	private String usrHpSplit2;
	private String usrHpSplit3;
	private String usrPwChange;
	
	// 알림시간 추가위해 사용
	private String notiHhCd;
	private String notiStartHh;
	private String notiEndHh;
	
	
	
	//portalleft.jsp 에서 링크타기 위해 사용 
	private String leftCd;
	private String subCd;
	private String code;
	
	private String usrIp; // 관리자 로그인 접속이력 ip 
    private String usrAgent; // 관리자 로그인 접속이력 브라우저 
  
    private String orgCdNm; //tb_comm_usr에 org_cd컬럼에 해당하는 조직명을 가져온다. org_nm컬럼과는 다르다.  
    
    private String messageCheck;
	
	
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
	public String getOrgCdNm() {
		return orgCdNm;
	}
	public void setOrgCdNm(String orgCdNm) {
		this.orgCdNm = orgCdNm;
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
	public String getUsrPwChange() {
		return usrPwChange;
	}
	public void setUsrPwChange(String usrPwChange) {
		this.usrPwChange = usrPwChange;
	}
	public String getLeftCd() {
		return leftCd;
	}
	public void setLeftCd(String leftCd) {
		this.leftCd = leftCd;
	}
	public String getSubCd() {
		return subCd;
	}
	public void setSubCd(String subCd) {
		this.subCd = subCd;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getUsrEmailSplit1() {
		return usrEmailSplit1;
	}
	public void setUsrEmailSplit1(String usrEmailSplit1) {
		this.usrEmailSplit1 = usrEmailSplit1;
	}
	public String getUsrEmailSplit2() {
		return usrEmailSplit2;
	}
	public void setUsrEmailSplit2(String usrEmailSplit2) {
		this.usrEmailSplit2 = usrEmailSplit2;
	}
	public String getUsrTelSplit1() {
		return usrTelSplit1;
	}
	public void setUsrTelSplit1(String usrTelSplit1) {
		this.usrTelSplit1 = usrTelSplit1;
	}
	public String getUsrTelSplit2() {
		return usrTelSplit2;
	}
	public void setUsrTelSplit2(String usrTelSplit2) {
		this.usrTelSplit2 = usrTelSplit2;
	}
	public String getUsrTelSplit3() {
		return usrTelSplit3;
	}
	public void setUsrTelSplit3(String usrTelSplit3) {
		this.usrTelSplit3 = usrTelSplit3;
	}
	public String getUsrHpSplit1() {
		return usrHpSplit1;
	}
	public void setUsrHpSplit1(String usrHpSplit1) {
		this.usrHpSplit1 = usrHpSplit1;
	}
	public String getUsrHpSplit2() {
		return usrHpSplit2;
	}
	public void setUsrHpSplit2(String usrHpSplit2) {
		this.usrHpSplit2 = usrHpSplit2;
	}
	public String getUsrHpSplit3() {
		return usrHpSplit3;
	}
	public void setUsrHpSplit3(String usrHpSplit3) {
		this.usrHpSplit3 = usrHpSplit3;
	}
	public String getRcvHp() {
		return rcvHp;
	}
	public void setRcvHp(String rcvHp) {
		this.rcvHp = rcvHp;
	}
	public String getUsrPwTemp() {
		return usrPwTemp;
	}
	public void setUsrPwTemp(String usrPwTemp) {
		this.usrPwTemp = usrPwTemp;
	}
	public String getOrgNm() {
		return orgNm;
	}
	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
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
	public String getAgreeDttm() {
		return agreeDttm;
	}
	public void setAgreeDttm(String agreeDttm) {
		this.agreeDttm = agreeDttm;
	}
	public int getSmsSeq() {
		return smsSeq;
	}
	public void setSmsSeq(int smsSeq) {
		this.smsSeq = smsSeq;
	}
	public String getSendMsg() {
		return sendMsg;
	}
	public void setSendMsg(String sendMsg) {
		this.sendMsg = sendMsg;
	}
	public String getAgreeYn() {
		return agreeYn;
	}
	public void setAgreeYn(String agreeYn) {
		this.agreeYn = agreeYn;
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
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	public String getEmailDttm() {
		return emailDttm;
	}
	public void setEmailDttm(String emailDttm) {
		this.emailDttm = emailDttm;
	}
	public String getUsrTel() {
		return usrTel;
	}
	public void setUsrTel(String usrTel) {
		this.usrTel = usrTel;
	}
	public String getUsrHp() {
		return usrHp;
	}
	public void setUsrHp(String usrHp) {
		this.usrHp = usrHp;
	}
	public String getHpYn() {
		return hpYn;
	}
	public void setHpYn(String hpYn) {
		this.hpYn = hpYn;
	}
	public String getHpDttm() {
		return hpDttm;
	}
	public void setHpDttm(String hpDttm) {
		this.hpDttm = hpDttm;
	}
	public String getUsrWork() {
		return usrWork;
	}
	public void setUsrWork(String usrWork) {
		this.usrWork = usrWork;
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
	public String getJobCd() {
		return jobCd;
	}
	public void setJobCd(String jobCd) {
		this.jobCd = jobCd;
	}
	public String getAccIp() {
		return accIp;
	}
	public void setAccIp(String accIp) {
		this.accIp = accIp;
	}
	public String getRauthYn() {
		return rauthYn;
	}
	public void setRauthYn(String rauthYn) {
		this.rauthYn = rauthYn;
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
	public String getAccYn() {
		return accYn;
	}
	public void setAccYn(String accYn) {
		this.accYn = accYn;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	public String getAccCd() {
		return accCd;
	}
	public void setAccCd(String accCd) {
		this.accCd = accCd;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getUsrPw() {
		return usrPw;
	}
	public void setUsrPw(String usrPw) {
		this.usrPw = usrPw;
	}
	public String getFailCnt() {
		return failCnt;
	}
	public void setFailCnt(String failCnt) {
		this.failCnt = failCnt;
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
	public String getAccokUsrId() {
		return accokUsrId;
	}
	public void setAccokUsrId(String accokUsrId) {
		this.accokUsrId = accokUsrId;
	}
	public String getAccokYn() {
		return accokYn;
	}
	public void setAccokYn(String accokYn) {
		this.accokYn = accokYn;
	}
	public String getAccokDttm() {
		return accokDttm;
	}
	public void setAccokDttm(String accokDttm) {
		this.accokDttm = accokDttm;
	}
	public String getAccokCnDttm() {
		return accokCnDttm;
	}
	public void setAccokCnDttm(String accokCnDttm) {
		this.accokCnDttm = accokCnDttm;
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
	
	public String getUsrEmailLast() {
		return usrEmailLast;
	}
	public void setUsrEmailLast(String usrEmailLast) {
		this.usrEmailLast = usrEmailLast;
	}
	public String getMessageCheck() {
		return messageCheck;
	}
	public void setMessageCheck(String messageCheck) {
		this.messageCheck = messageCheck;
	}
	
	public String getJobNm() {
		return jobNm;
	}
	public void setJobNm(String jobNm) {
		this.jobNm = jobNm;
	}
	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
	
	
	
	
}

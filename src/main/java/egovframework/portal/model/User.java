package egovframework.portal.model;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;


/**
 * @since 2014.09.04
 * @author jyson
 *
 */
@SuppressWarnings("serial")
public class User extends CommVo implements Serializable{
	
	private int userCd;
	private String userId;
	private String userNm;
	private String nickNm;
	private String userPw;
	private String userPwTemp; //초기화한 비밀번호(암호화x) 임시로 담아 sms로 전송한다.
	private String reqPwYn;
	private String pwDttm;
	private String userEmail;
	private String userEmailLast;
	private String emailYn;
	private String emailDttm;
	private String userTel;
	private String userHp;
	private String hpYn;
	private String hpDttm;
	private String agreeYn;
	private String agreeDttm;
	private String areaCd;
	private String memberCd;
	//GPIN관련 변수
	private String rauthYn;
	private String rauthVid;		//실명인증 개인식별번호(단방향 암호화)
	private String rauthDi;			//실명인증 중복가입확인정보(단방향 암호화)
	private String rauthBirth;		//실명인증 생년월일
	private String rauthSex;		//실명인증 성별
	private String rauthNi;			//실명인증 내/외국인 구분
	private String rauthDttm;		//실명인증 일자
	//
	private String sysTag;
	private String regDttm;
	private String updDttm;

	private String agreeDttmYear;
	private String agreeDttmMm;
	private String agreeDttmDd;

	private String agreeDttmYearAfter; //동의날짜 기준 2년후 시간 저장.
	private String agreeDttmMmAfter;
	private String agreeDttmDdAfter;
	
	private String pwdCurr;
	private String pwdNew1;
	private String pwdNew2;
	
	private String pwConfirmStatus; //회원정보 수정, 회원탈퇴 할시 같은 controller를 사용한다.구분용.
	
	
	//회원정보 수정에서 split필요. 전화번호,이메일..
	private String userEmailSplit1;
	private String userEmailSplit2;
	private String userTelSplit1;
	private String userTelSplit2;
	private String userTelSplit3;
	private String userHpSplit1;
	private String userHpSplit2;
	private String userHpSplit3;
	
	private String sendMsg; // SMS로 메세지 보내는 내용.
	
	private int smsSeq; //seq값
	
	private String userPwChange; //비밀번호 변경했는지 유무결정하여 pw_dttm컬럼 업데이트 결정한다.
	
	private String rcvHp;
	
	 //portalleft.jsp 에서 링크타기 위해 사용 
	private String leftCd;
	private String subCd;	
	private String code;
	private String refUrl;
	
	private String userIp; //사용자 접속ip확인하기 위해 사용
	private String userAgent; //사용자 접속브라우저 확인
	
	private String messageCheck;
	
	private String deptCode;
	
	private String accIp;
	
	/** My데이터 *********************************************/
	private String no;				//게시물숫자
	private String tag;				//구분
	private String cateFullnm;		//분류
	private String infNm;			//재정데이터명
	private String loadNm;			//공표주기
	private String openDttm;		//최초 공갱리자
	private String infUrl;			//관련 데이터 링크 URL
	private String useYn;			//관리(사용여부)
	private String infId;			//공공데이터ID
	private String searchWd;		//검색어
	/********************************************************/
	
	public String getRefUrl() {
		return refUrl;
	}
	public void setRefUrl(String refUrl) {
		this.refUrl = refUrl;
	}
	public String getUserAgent() {
		return userAgent;
	}
	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
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
	public String getRcvHp() {
		return rcvHp;
	}
	public void setRcvHp(String rcvHp) {
		this.rcvHp = rcvHp;
	}
	public String getUserPwTemp() {
		return userPwTemp;
	}
	public void setUserPwTemp(String userPwTemp) {
		this.userPwTemp = userPwTemp;
	}
	public String getUserPwChange() {
		return userPwChange;
	}
	public void setUserPwChange(String userPwChange) {
		this.userPwChange = userPwChange;
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
	public String getUserEmailSplit1() {
		return userEmailSplit1;
	}
	public void setUserEmailSplit1(String userEmailSplit1) {
		this.userEmailSplit1 = userEmailSplit1;
	}
	public String getUserEmailSplit2() {
		return userEmailSplit2;
	}
	public void setUserEmailSplit2(String userEmailSplit2) {
		this.userEmailSplit2 = userEmailSplit2;
	}
	public String getUserTelSplit1() {
		return userTelSplit1;
	}
	public void setUserTelSplit1(String userTelSplit1) {
		this.userTelSplit1 = userTelSplit1;
	}
	public String getUserTelSplit2() {
		return userTelSplit2;
	}
	public void setUserTelSplit2(String userTelSplit2) {
		this.userTelSplit2 = userTelSplit2;
	}
	public String getUserTelSplit3() {
		return userTelSplit3;
	}
	public void setUserTelSplit3(String userTelSplit3) {
		this.userTelSplit3 = userTelSplit3;
	}
	public String getUserHpSplit1() {
		return userHpSplit1;
	}
	public void setUserHpSplit1(String userHpSplit1) {
		this.userHpSplit1 = userHpSplit1;
	}
	public String getUserHpSplit2() {
		return userHpSplit2;
	}
	public void setUserHpSplit2(String userHpSplit2) {
		this.userHpSplit2 = userHpSplit2;
	}
	public String getUserHpSplit3() {
		return userHpSplit3;
	}
	public void setUserHpSplit3(String userHpSplit3) {
		this.userHpSplit3 = userHpSplit3;
	}
	public String getAgreeDttmYearAfter() {
		return agreeDttmYearAfter;
	}
	public void setAgreeDttmYearAfter(String agreeDttmYearAfter) {
		this.agreeDttmYearAfter = agreeDttmYearAfter;
	}
	public String getAgreeDttmMmAfter() {
		return agreeDttmMmAfter;
	}
	public void setAgreeDttmMmAfter(String agreeDttmMmAfter) {
		this.agreeDttmMmAfter = agreeDttmMmAfter;
	}
	public String getAgreeDttmDdAfter() {
		return agreeDttmDdAfter;
	}
	public void setAgreeDttmDdAfter(String agreeDttmDdAfter) {
		this.agreeDttmDdAfter = agreeDttmDdAfter;
	}
	public String getPwConfirmStatus() {
		return pwConfirmStatus;
	}
	public void setPwConfirmStatus(String pwConfirmStatus) {
		this.pwConfirmStatus = pwConfirmStatus;
	}
	public int getUserCd() {
		return userCd;
	}
	public void setUserCd(int userCd) {
		this.userCd = userCd;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getNickNm() {
		return nickNm;
	}
	public void setNickNm(String nickNm) {
		this.nickNm = nickNm;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
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
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
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
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getUserHp() {
		return userHp;
	}
	public void setUserHp(String userHp) {
		this.userHp = userHp;
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
	public String getAgreeYn() {
		return agreeYn;
	}
	public void setAgreeYn(String agreeYn) {
		this.agreeYn = agreeYn;
	}
	public String getAgreeDttm() {
		return agreeDttm;
	}
	public void setAgreeDttm(String agreeDttm) {
		this.agreeDttm = agreeDttm;
	}
	public String getAreaCd() {
		return areaCd;
	}
	public void setAreaCd(String areaCd) {
		this.areaCd = areaCd;
	}
	public String getMemberCd() {
		return memberCd;
	}
	public void setMemberCd(String memberCd) {
		this.memberCd = memberCd;
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
	public String getSysTag() {
		return sysTag;
	}
	public void setSysTag(String sysTag) {
		this.sysTag = sysTag;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getUpdDttm() {
		return updDttm;
	}
	public void setUpdDttm(String updDttm) {
		this.updDttm = updDttm;
	}
	public String getAgreeDttmYear() {
		return agreeDttmYear;
	}
	public void setAgreeDttmYear(String agreeDttmYear) {
		this.agreeDttmYear = agreeDttmYear;
	}
	public String getAgreeDttmMm() {
		return agreeDttmMm;
	}
	public void setAgreeDttmMm(String agreeDttmMm) {
		this.agreeDttmMm = agreeDttmMm;
	}
	public String getAgreeDttmDd() {
		return agreeDttmDd;
	}
	public void setAgreeDttmDd(String agreeDttmDd) {
		this.agreeDttmDd = agreeDttmDd;
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
	public String getUserEmailLast() {
		return userEmailLast;
	}
	public void setUserEmailLast(String userEmailLast) {
		this.userEmailLast = userEmailLast;
	}
	
	public String getMessageCheck() {
		return messageCheck;
	}
	public void setMessageCheck(String messageCheck) {
		this.messageCheck = messageCheck;
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getCateFullnm() {
		return cateFullnm;
	}
	public void setCateFullnm(String cateFullnm) {
		this.cateFullnm = cateFullnm;
	}
	public String getInfNm() {
		return infNm;
	}
	public void setInfNm(String infNm) {
		this.infNm = infNm;
	}
	public String getLoadNm() {
		return loadNm;
	}
	public void setLoadNm(String loadNm) {
		this.loadNm = loadNm;
	}
	public String getOpenDttm() {
		return openDttm;
	}
	public void setOpenDttm(String openDttm) {
		this.openDttm = openDttm;
	}
	public String getInfUrl() {
		return infUrl;
	}
	public void setInfUrl(String infUrl) {
		this.infUrl = infUrl;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	public String getInfId() {
		return infId;
	}
	public void setInfId(String infId) {
		this.infId = infId;
	}
	
	public String getSearchWd() {
		return searchWd;
	}
	public void setSearchWd(String searchWd) {
		this.searchWd = searchWd;
	}
	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	
	public String getAccIp() {
		return accIp;
	}
	public void setAccIp(String accIp) {
		this.accIp = accIp;
	}
	
}

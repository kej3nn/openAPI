package egovframework.admin.user.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class UserVo extends CommVo implements Serializable{
	private int userCd;
	private String userId;
	private String userNm;
	private String userPw;
	private String reqPwYn;
	private String pwDttm;
	private String userEmail;
	private String emailYn;
	private String emailDttm;
	private String userTel;
	private String userHp;
	private String hpYn;
	private String hpDttm;
	private String agreeYn;
	private String agreeDttm;
	private String areaCd;
	private String areaNm;
	private String memberCd;
	private String memberNm;
	private String rauthYn;
	private String rauthVid;
	private String rauthDi;
	private String rauthBirth;
	private String rauthSex;
	private String rauthNi;
	private String rauthDttm;
	private String sysTag;
	private String regDttm;
	private String updDttm;
	
	private String pubDttmFrom;
	private String pubDttmTo;
	private String searchWd;
	private String searchWord;
	
	
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
	public String getAreaNm() {
		return areaNm;
	}
	public void setAreaNm(String areaNm) {
		this.areaNm = areaNm;
	}
	public String getMemberCd() {
		return memberCd;
	}
	public void setMemberCd(String memberCd) {
		this.memberCd = memberCd;
	}	
	public String getMemberNm() {
		return memberNm;
	}
	public void setMemberNm(String memberNm) {
		this.memberNm = memberNm;
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
	public String getPubDttmFrom() {
		return pubDttmFrom;
	}
	public void setPubDttmFrom(String pubDttmFrom) {
		this.pubDttmFrom = pubDttmFrom;
	}
	public String getPubDttmTo() {
		return pubDttmTo;
	}
	public void setPubDttmTo(String pubDttmTo) {
		this.pubDttmTo = pubDttmTo;
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
}

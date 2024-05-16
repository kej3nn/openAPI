package egovframework.admin.user.service;

import java.io.Serializable;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class UserKey extends CommVo implements Serializable{
	private String userId;
	private String userNm;
	private int userCd;
	private int keySeq;
	private String actKey;
	private String tActKey;
	private String keyState;
	private String useNm;
	private String useCont;
	private String pauseMsg;
	private String pauseDttm;
	private String limitCd;
	private String limitDttm;
	private String regDttm;
	private String updDttm;
	private String sysTag;
	private String pubDttmFrom;
	private String pubDttmTo;
	private String searchWd;
	private String searchWord;
	private String limitId;
	private String hiLimit;
	private String checked;
	private String limitAgo;
	private String limitYester;
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
	public int getUserCd() {
		return userCd;
	}
	public void setUserCd(int userCd) {
		this.userCd = userCd;
	}
	public int getKeySeq() {
		return keySeq;
	}
	public void setKeySeq(int keySeq) {
		this.keySeq = keySeq;
	}
	public String getActKey() {
		return actKey;
	}
	public void setActKey(String actKey) {
		this.actKey = actKey;
	}
	
	public String gettActKey() {
		return tActKey;
	}
	public void settActKey(String tActKey) {
		this.tActKey = tActKey;
	}
	public String getKeyState() {
		return keyState;
	}
	public void setKeyState(String keyState) {
		this.keyState = keyState;
	}
	public String getUseNm() {
		return useNm;
	}
	public void setUseNm(String useNm) {
		this.useNm = useNm;
	}
	public String getUseCont() {
		return useCont;
	}
	public void setUseCont(String useCont) {
		this.useCont = useCont;
	}
	public String getPauseMsg() {
		return pauseMsg;
	}
	public void setPauseMsg(String pauseMsg) {
		this.pauseMsg = pauseMsg;
	}
	public String getPauseDttm() {
		return pauseDttm;
	}
	public void setPauseDttm(String pauseDttm) {
		this.pauseDttm = pauseDttm;
	}
	public String getLimitCd() {
		return limitCd;
	}
	public void setLimitCd(String limitCd) {
		this.limitCd = limitCd;
	}
	public String getLimitDttm() {
		return limitDttm;
	}
	public void setLimitDttm(String limitDttm) {
		this.limitDttm = limitDttm;
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
	public String getSysTag() {
		return sysTag;
	}
	public void setSysTag(String sysTag) {
		this.sysTag = sysTag;
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
	public String getLimitId() {
		return limitId;
	}
	public void setLimitId(String limitId) {
		this.limitId = limitId;
	}
	public String getHiLimit() {
		return hiLimit;
	}
	public void setHiLimit(String hiLimit) {
		this.hiLimit = hiLimit;
	}
	public String getChecked() {
		return checked;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	public String getLimitAgo() {
		return limitAgo;
	}
	public void setLimitAgo(String limitAgo) {
		this.limitAgo = limitAgo;
	}
	public String getLimitYester() {
		return limitYester;
	}
	public void setLimitYester(String limitYester) {
		this.limitYester = limitYester;
	}
		
}

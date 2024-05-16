package egovframework.admin.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;

/**
 * 설문관리 데이터 처리 모델
 *
 * @author jyson
 * @since 2014.08.06
 */
@SuppressWarnings("serial")
public class Survey extends CommVo implements Serializable {


    private int surveyId;  //설문조사id
    private String surveyNm;  //설문조사 제목
    private String surveyPpose; //설문조사 목적
    private String langTag;   //설문조사언어
    private String ipDupYn;   //중복응답 여부
    private String startDttm; //시작일자
    private String endDttm;   //종료일자
    private String orgCd;      //담당부서
    private String usrCd;      //담당자
    private String useYn;     //사용여부
    private String searchWord; //검색어
    private String searchWd;   //검색선택
    private String surveyExp;  //설문조사 설명
    private String surveyDesc; //설문조사 요약/요지 ..타입이 CLOB
    private String user1Yn;    //응답자 기본정보 수집여부
    private String user2Yn;       //응답자 상세정보 수집여부
    private String loginYn;       //회원가입 필수
    private String orgNm;       //부서조직명
    private String usrNm;       //담당자명
    private String endYn;      //설문상태

    public String getSurveyDesc() {
        return surveyDesc;
    }

    public void setSurveyDesc(String surveyDesc) {
        this.surveyDesc = surveyDesc;
    }

    private int questSeq;
    private String dynamicCol;

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getLoginYn() {
        return loginYn;
    }

    public void setLoginYn(String loginYn) {
        this.loginYn = loginYn;
    }

    public String getSurveyPpose() {
        return surveyPpose;
    }

    public void setSurveyPpose(String surveyPpose) {
        this.surveyPpose = surveyPpose;
    }

    public String getSurveyExp() {
        return surveyExp;
    }

    public void setSurveyExp(String surveyExp) {
        this.surveyExp = surveyExp;
    }

    public String getUser1Yn() {
        return user1Yn;
    }

    public void setUser1Yn(String user1Yn) {
        this.user1Yn = user1Yn;
    }

    public String getUser2Yn() {
        return user2Yn;
    }

    public void setUser2Yn(String user2Yn) {
        this.user2Yn = user2Yn;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getSearchWd() {
        return searchWd;
    }

    public void setSearchWd(String searchWd) {
        this.searchWd = searchWd;
    }

    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public String getSurveyNm() {
        return surveyNm;
    }

    public void setSurveyNm(String surveyNm) {
        this.surveyNm = surveyNm;
    }

    public String getLangTag() {
        return langTag;
    }

    public void setLangTag(String langTag) {
        this.langTag = langTag;
    }

    public String getIpDupYn() {
        return ipDupYn;
    }

    public void setIpDupYn(String ipDupYn) {
        this.ipDupYn = ipDupYn;
    }

    public String getStartDttm() {
        return startDttm;
    }

    public void setStartDttm(String startDttm) {
        this.startDttm = startDttm;
    }

    public String getEndDttm() {
        return endDttm;
    }

    public void setEndDttm(String endDttm) {
        this.endDttm = endDttm;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getUsrCd() {
        return usrCd;
    }

    public void setUsrCd(String usrCd) {
        this.usrCd = usrCd;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    /**
     * 설문목록
     */
    public String getEndYn() {
        return endYn;
    }

    public void setEndYn(String endYn) {
        this.endYn = endYn;
    }

    public int getQuestSeq() {
        return questSeq;
    }

    public void setQuestSeq(int questSeq) {
        this.questSeq = questSeq;
    }

    public String getDynamicCol() {
        return dynamicCol;
    }

    public void setDynamicCol(String dynamicCol) {
        this.dynamicCol = dynamicCol;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }


}

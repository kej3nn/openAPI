package egovframework.admin.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;

/**
 * 설문결과 데이터 처리 모델
 *
 * @author jyson
 * @since 2014.08.08
 */

@SuppressWarnings("serial")
public class SurveyAns extends CommVo implements Serializable {

    //TB_SURVEY TABLE
    private String surveyId;    //설문조사id
    private String surveyNm;    //설문조사 제목
    private String surveyPpose; //설문조사 목적
    private String startDttm;   //시작일자
    private String endDttm;     //종료일자
    private String orgCd;        //담당부서
    private String orgNm;        //담당부서명


    //TB_COMM_CODE TABLE
    private String ditcNm;  //코드명
    private String ditcCd;  //코드
    private String ditcCnt; //코드별 인원수


    //설문조사 응답자 정보
    private int ansSeq;  //응답자 일련번호
    private int userCd;
    private String ansCd;
    private String ansNm;
    private String ansTel;
    private String ansEmail;
    private String ansSex;
    private String ansAgeCd;
    private String ansJobCd;
    private String ansIp;
    private String agreeYn;
    private String agreeDttm;
    private String regDttm;

    private String questSeq;
    private String dymanicCol;
    private String colId;
    private String colNm;
    private String grpExp;
    private String questNm;
    private String userId; //응답시 사용자 id로 user_cd찾음

    private String loginYn; //응답자 정보를 체크에따라 넣어주기위해서 사용
    private String user1Yn;
    private String user2Yn;

    private String questNo;
    private String examNm;
    private String examAns;

    public String getLoginYn() {
        return loginYn;
    }

    public void setLoginYn(String loginYn) {
        this.loginYn = loginYn;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getAnsSeq() {
        return ansSeq;
    }

    public void setAnsSeq(int ansSeq) {
        this.ansSeq = ansSeq;
    }

    public int getUserCd() {
        return userCd;
    }

    public void setUserCd(int userCd) {
        this.userCd = userCd;
    }

    public String getAnsCd() {
        return ansCd;
    }

    public void setAnsCd(String ansCd) {
        this.ansCd = ansCd;
    }

    public String getAnsNm() {
        return ansNm;
    }

    public void setAnsNm(String ansNm) {
        this.ansNm = ansNm;
    }

    public String getAnsTel() {
        return ansTel;
    }

    public void setAnsTel(String ansTel) {
        this.ansTel = ansTel;
    }

    public String getAnsEmail() {
        return ansEmail;
    }

    public void setAnsEmail(String ansEmail) {
        this.ansEmail = ansEmail;
    }

    public String getAnsSex() {
        return ansSex;
    }

    public void setAnsSex(String ansSex) {
        this.ansSex = ansSex;
    }

    public String getAnsAgeCd() {
        return ansAgeCd;
    }

    public void setAnsAgeCd(String ansAgeCd) {
        this.ansAgeCd = ansAgeCd;
    }

    public String getAnsJobCd() {
        return ansJobCd;
    }

    public void setAnsJobCd(String ansJobCd) {
        this.ansJobCd = ansJobCd;
    }

    public String getAnsIp() {
        return ansIp;
    }

    public void setAnsIp(String ansIp) {
        this.ansIp = ansIp;
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

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }

    public String getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(String surveyId) {
        this.surveyId = surveyId;
    }

    public String getSurveyNm() {
        return surveyNm;
    }

    public void setSurveyNm(String surveyNm) {
        this.surveyNm = surveyNm;
    }

    public String getSurveyPpose() {
        return surveyPpose;
    }

    public void setSurveyPpose(String surveyPpose) {
        this.surveyPpose = surveyPpose;
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

    public String getDitcNm() {
        return ditcNm;
    }

    public void setDitcNm(String ditcNm) {
        this.ditcNm = ditcNm;
    }

    public String getDitcCnt() {
        return ditcCnt;
    }

    public void setDitcCnt(String ditcCnt) {
        this.ditcCnt = ditcCnt;
    }

    public String getDitcCd() {
        return ditcCd;
    }

    public void setDitcCd(String ditcCd) {
        this.ditcCd = ditcCd;
    }

    public String getQuestSeq() {
        return questSeq;
    }

    public void setQuestSeq(String questSeq) {
        this.questSeq = questSeq;
    }

    public String getDymanicCol() {
        return dymanicCol;
    }

    public void setDymanicCol(String dymanicCol) {
        this.dymanicCol = dymanicCol;
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

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getGrpExp() {
        return grpExp;
    }

    public void setGrpExp(String grpExp) {
        this.grpExp = grpExp;
    }

    public String getQuestNm() {
        return questNm;
    }

    public void setQuestNm(String questNm) {
        this.questNm = questNm;
    }

    public String getQuestNo() {
        return questNo;
    }

    public void setQuestNo(String questNo) {
        this.questNo = questNo;
    }

    public String getExamNm() {
        return examNm;
    }

    public void setExamNm(String examNm) {
        this.examNm = examNm;
    }

    public String getExamAns() {
        return examAns;
    }

    public void setExamAns(String examAns) {
        this.examAns = examAns;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}

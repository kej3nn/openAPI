package egovframework.admin.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;

/**
 * @author jyson
 * @since 2014.08.19
 */
@SuppressWarnings("serial")
public class SurveyExam extends CommVo implements Serializable {

    private int surveyId;
    private int questSeq;
    private int examSeq;
    private String grpExp;
    private String examNm;
    private String examExp;
    private int examVal;
    private String etcYn;
    private int vOrder;
    private String useYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;


    //미리보기 팝업에서 사용
    private String questNo;
    //	private String itemCd;
    private String examCd;

    //tv_survey_item_cd 지문
    private String ditcCd;

    // tv_survey_item_cd
    private int num; //랭크순서 구하기위해 사용


    public String getExamCd() {
        return examCd;
    }


    public void setExamCd(String examCd) {
        this.examCd = examCd;
    }


    public int getNum() {
        return num;
    }


    public void setNum(int num) {
        this.num = num;
    }


    public String getDitcCd() {
        return ditcCd;
    }


    public void setDitcCd(String ditcCd) {
        this.ditcCd = ditcCd;
    }


    public String getQuestNo() {
        return questNo;
    }


    public void setQuestNo(String questNo) {
        this.questNo = questNo;
    }


    public int getSurveyId() {
        return surveyId;
    }


    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }


    public int getQuestSeq() {
        return questSeq;
    }


    public void setQuestSeq(int questSeq) {
        this.questSeq = questSeq;
    }


    public int getExamSeq() {
        return examSeq;
    }


    public void setExamSeq(int examSeq) {
        this.examSeq = examSeq;
    }


    public String getGrpExp() {
        return grpExp;
    }


    public void setGrpExp(String grpExp) {
        this.grpExp = grpExp;
    }


    public String getExamNm() {
        return examNm;
    }


    public void setExamNm(String examNm) {
        this.examNm = examNm;
    }


    public String getExamExp() {
        return examExp;
    }


    public void setExamExp(String examExp) {
        this.examExp = examExp;
    }


    public int getExamVal() {
        return examVal;
    }


    public void setExamVal(int examVal) {
        this.examVal = examVal;
    }


    public String getEtcYn() {
        return etcYn;
    }


    public void setEtcYn(String etcYn) {
        this.etcYn = etcYn;
    }


    public int getvOrder() {
        return vOrder;
    }


    public void setvOrder(int vOrder) {
        this.vOrder = vOrder;
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


    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}

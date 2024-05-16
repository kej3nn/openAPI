package egovframework.admin.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;


/**
 * 설문관리 문항
 *
 * @author jyson
 * @since 2014.08.14
 */

@SuppressWarnings("serial")
public class SurveyQuest extends CommVo implements Serializable {

    private int surveyId;  //설문조사id
    private int questSeq;  //문항고유번호
    private String questNo;
    private String grpExp;
    private String questNm;
    //	private String itemCd;
    private int maxDupCnt;
    private String useYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String UpdDttm;
    private String examCd; //itemCd -> examCd 컬럼명으로 변경됨.


    public String getExamCd() {
        return examCd;
    }

    public void setExamCd(String examCd) {
        this.examCd = examCd;
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
        return UpdDttm;
    }

    public void setUpdDttm(String updDttm) {
        UpdDttm = updDttm;
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

    public String getQuestNo() {
        return questNo;
    }

    public void setQuestNo(String questNo) {
        this.questNo = questNo;
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

    public int getMaxDupCnt() {
        return maxDupCnt;
    }

    public void setMaxDupCnt(int maxDupCnt) {
        this.maxDupCnt = maxDupCnt;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }


}

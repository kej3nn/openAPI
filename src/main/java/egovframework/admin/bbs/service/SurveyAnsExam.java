package egovframework.admin.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;


@SuppressWarnings("serial")
public class SurveyAnsExam extends CommVo implements Serializable {

    private int surveyId;  //설문조사id
    private int ansSeq;

    //private String arrItemSeq;

    //private String arrQuestSeq;
    private int ansVal; //응답점수 item_val - > ans_val
    private String examVal; //지문값 item_grade -> exam_val 컬럼변경
    private String regDttm;


    private String examAns; //text 200자 등   item_ans -> exam_ans
    private String examSeq;
    private String questSeq;

    //배열로 받아 split하기 위해.
    private String[] questSeqArr;
    private String[] examGradeArr;
    private String[] examSeqArr;
    private String[] examAnsArr;

    //분기문을 사용하기 위해 지문의 타입을 받는다.
//	private String questItemCd;
//	private String[] questItemCdArr;
    private String questExamCd;
    private String[] questExamCdArr;


    public String getExamVal() {
        return examVal;
    }

    public int getAnsVal() {
        return ansVal;
    }

    public void setAnsVal(int ansVal) {
        this.ansVal = ansVal;
    }

    public void setExamVal(String examVal) {
        this.examVal = examVal;
    }

    public String getQuestExamCd() {
        return questExamCd;
    }

    public void setQuestExamCd(String questExamCd) {
        this.questExamCd = questExamCd;
    }

    public String[] getQuestExamCdArr() {
        String[] ret = null;
        if (this.questExamCdArr != null) {
            ret = new String[this.questExamCdArr.length];
            for (int i = 0; i < this.questExamCdArr.length; i++) {
                ret[i] = this.questExamCdArr[i];
            }
        }
        return ret;
    }

    public void setQuestExamCdArr(String[] questExamCdArr) {
        this.questExamCdArr = new String[questExamCdArr.length];
        for (int i = 0; i < questExamCdArr.length; i++) {
            this.questExamCdArr[i] = questExamCdArr[i];
        }
    }

    public String[] getExamAnsArr() {
        String[] ret = null;
        if (this.examAnsArr != null) {
            ret = new String[this.examAnsArr.length];
            for (int i = 0; i < this.examAnsArr.length; i++) {
                ret[i] = this.examAnsArr[i];
            }
        }
        return ret;
    }

    public void setExamAnsArr(String[] examAnsArr) {
        this.examAnsArr = new String[examAnsArr.length];
        for (int i = 0; i < examAnsArr.length; i++) {
            this.examAnsArr[i] = examAnsArr[i];
        }
    }

    public String[] getExamSeqArr() {
        String[] ret = null;
        if (this.examSeqArr != null) {
            ret = new String[this.examSeqArr.length];
            for (int i = 0; i < this.examSeqArr.length; i++) {
                ret[i] = this.examSeqArr[i];
            }
        }
        return ret;
    }

    public void setExamSeqArr(String[] examSeqArr) {
        this.examSeqArr = new String[examSeqArr.length];
        for (int i = 0; i < examSeqArr.length; i++) {
            this.examSeqArr[i] = examSeqArr[i];
        }
    }

    public String[] getExamGradeArr() {
        String[] ret = null;
        if (this.examGradeArr != null) {
            ret = new String[this.examGradeArr.length];
            for (int i = 0; i < this.examGradeArr.length; i++) {
                ret[i] = this.examGradeArr[i];
            }
        }
        return ret;
    }

    public void setExamGradeArr(String[] examGradeArr) {
        this.examGradeArr = new String[examGradeArr.length];
        for (int i = 0; i < examGradeArr.length; i++) {
            this.examGradeArr[i] = examGradeArr[i];
        }
    }

    public String[] getQuestSeqArr() {
        String[] ret = null;
        if (this.questSeqArr != null) {
            ret = new String[this.questSeqArr.length];
            for (int i = 0; i < this.questSeqArr.length; i++) {
                ret[i] = this.questSeqArr[i];
            }
        }
        return ret;
    }

    public void setQuestSeqArr(String[] questSeqArr) {
        this.questSeqArr = new String[questSeqArr.length];
        for (int i = 0; i < questSeqArr.length; i++) {
            this.questSeqArr[i] = questSeqArr[i];
        }
    }

    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public int getAnsSeq() {
        return ansSeq;
    }

    public void setAnsSeq(int ansSeq) {
        this.ansSeq = ansSeq;
    }

    public String getQuestSeq() {
        return questSeq;
    }

    public void setQuestSeq(String questSeq) {
        this.questSeq = questSeq;
    }


    public String getExamAns() {
        return examAns;
    }

    public void setExamAns(String examAns) {
        this.examAns = examAns;
    }

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }


    public String getExamSeq() {
        return examSeq;
    }

    public void setExamSeq(String examSeq) {
        this.examSeq = examSeq;
    }


    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }


}

package egovframework.admin.bbs.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.bbs.service.SurveyExam;
import egovframework.admin.bbs.service.SurveyExamService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("SurveyExamService")
public class SurveyExamServiceImpl extends AbstractServiceImpl implements SurveyExamService {

    @Resource(name = "SurveyExamDAO")
    private SurveyExamDAO surveyExamDAO;


    /**
     * 설문조사 지문 저장/ 수정/ 삭제
     */
    @Override
    public int surveyExamSheetCUD(ArrayList<SurveyExam> list, String status, SurveyExam surveyExam) {
        int result = 0;

        try {
            if (WiseOpenConfig.STATUS_I.equals(status)) { //저장, 수정
                int surveyId = surveyExam.getSurveyId();
                int questSeq = surveyExam.getQuestSeq();
                for (SurveyExam surveyExam2 : list) {
                    surveyExam2.setSurveyId(surveyId);
                    surveyExam2.setQuestSeq(questSeq);
                    result = surveyExamDAO.insertSurveyExam(surveyExam2);
                }
            } else if (WiseOpenConfig.STATUS_D.equals(status)) { // 삭제
                for (SurveyExam surveyExam2 : list) {
                    result = surveyExamDAO.deleteSurveyExam(surveyExam2);
                }
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }


    /**
     * 지문 조회
     */
    @Override
    public List<SurveyExam> selectSurveyExamAll(SurveyExam surveyExam) {
        List<SurveyExam> result = new ArrayList<SurveyExam>();
        try {
            result = surveyExamDAO.selectSurveyExamAll(surveyExam);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }


    /**
     * 미리보기 팝업에서 지문 조회
     */
    @Override
    public List<SurveyExam> selectSurveyExamPop(SurveyExam surveyExam) {
        List<SurveyExam> result = new ArrayList<SurveyExam>();
        try {
            result = surveyExamDAO.selectSurveyExamPop(surveyExam);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    /**
     * Exam_cd 코드명 조회
     */
    @Override
    public List<SurveyExam> selectSurveyExamCdPop() {
        List<SurveyExam> result = new ArrayList<SurveyExam>();
        try {
            result = surveyExamDAO.selectSurveyExamCdPop();
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


}

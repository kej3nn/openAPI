package egovframework.admin.bbs.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.bbs.service.SurveyExam;
import egovframework.admin.bbs.service.SurveyQuest;
import egovframework.admin.bbs.service.SurveyQuestService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("SurveyQuestService")
public class SurveyQuestServiceImpl extends AbstractServiceImpl implements SurveyQuestService {

    @Resource(name = "SurveyQuestDAO")
    private SurveyQuestDAO surveyQuestDAO;

    @Resource(name = "SurveyExamDAO")
    private SurveyExamDAO surveyExamDAO;


    /**
     * 설문조사 문항 데이터 저장/ 수정/ 삭제 (단, 일부 문항유형의 경우 지문도 같이 INSERT된다.)
     */
    @Override
    public int surveyQuestSheetCUD(ArrayList<SurveyQuest> list, String status, SurveyQuest surveyQuest) {
        SurveyExam surveyExam;
        int result = 0;
        try {
            if (WiseOpenConfig.STATUS_I.equals(status)) { //저장, 수정
                int surveyId = surveyQuest.getSurveyId();
                for (SurveyQuest surveyQuest2 : list) {
                    surveyQuest2.setSurveyId(surveyId); //surveyId 저장
                    result = surveyQuestDAO.insertSurveyQuest(surveyQuest2);//문항 저장.INSERT

                    int questSeq = surveyQuestDAO.selectSurveyQuestSeq(surveyQuest2);
                    surveyQuest2.setQuestSeq(questSeq); //quest_seq 값을 생성하여 저장

                    //문항유형이 아래와 같다면 Exam지문에 insert 한다. 만족도 5 = sasf5
                    if ("SASF5".equals(surveyQuest2.getExamCd()) || "APPR5".equals(surveyQuest2.getExamCd()) || "IRST5".equals(surveyQuest2.getExamCd()) ||
                            "NEED5".equals(surveyQuest2.getExamCd()) || "MEAS5".equals(surveyQuest2.getExamCd()) || "MEAS10".equals(surveyQuest2.getExamCd())) {

                        surveyExam = new SurveyExam();
                        surveyExam.setSurveyId(surveyId); //필요한 pk값들만 넣어준다.
                        surveyExam.setQuestSeq(surveyQuest2.getQuestSeq());// quest_Seq값 받아온다.
                        surveyExam.setExamCd(surveyQuest2.getExamCd()); //tv_survey_Exam_Cd 에서 조회하기위한 조건들
                        result = surveyExamDAO.deleteSurveyExamAuto(surveyExam); //자동 등록하기전에 이전에 있던것 삭제한다.
                        result = surveyExamDAO.insertSurveyExamAuto(surveyExam); //자동으로 지문을 등록 해야한다.
                    } else { //자동으로 지문 생성 유형 -> 수 동으로 지문생성 변경되어 수정될때 이전 지문 삭제해야 한다.

                        surveyExam = new SurveyExam();
                        surveyExam.setSurveyId(surveyId); //필요한 pk값들만 넣어준다.
                        surveyExam.setQuestSeq(surveyQuest2.getQuestSeq());// quest_Seq값 받아온다.

                        if (surveyExamDAO.selectSurveyExamAutoCnt(surveyExam) > 0) {    //삭제 할 것이 있으면...(문항유형에서 입력할 Exam이 없는 것은 삭제하지 않는다.)
                            result = surveyExamDAO.deleteSurveyExamAuto(surveyExam); //이전에 있던것 삭제한다.
                        } else {
                            result = 1;
                        }

                    }
                }
            } else if (WiseOpenConfig.STATUS_D.equals(status)) { // 삭제
                for (SurveyQuest surveyQuest2 : list) {
                    result = surveyQuestDAO.deleteSurveyExam(surveyQuest2);
                    result = surveyQuestDAO.deleteSurveyQuest(surveyQuest2);
                }
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }


    /**
     * 설문문항 조회
     */
    @Override
    public List<SurveyQuest> selectSurveyQuestAll(SurveyQuest surveyQuest) {
        List<SurveyQuest> result = new ArrayList<SurveyQuest>();
        try {
            result = surveyQuestDAO.selectSurveyQuestAll(surveyQuest);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    /**
     * 미리보기 팝업창 문항출력
     */
    @Override
    public List<SurveyQuest> selectSurveyQuestPop(SurveyQuest surveyQuest) {
        List<SurveyQuest> result = new ArrayList<SurveyQuest>();
        try {
            result = surveyQuestDAO.selectSurveyQuestPop(surveyQuest);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }
}

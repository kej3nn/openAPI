package egovframework.admin.bbs.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.bbs.service.Survey;
import egovframework.admin.bbs.service.SurveyService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("SurveyService")
public class SurveyServiceImpl extends AbstractServiceImpl implements SurveyService {

    @Resource(name = "SurveyDao")
    private SurveyDao surveyDao;

    @Override
    public List<Survey> selectSurveyAll(Survey survey) {
        List<Survey> result = new ArrayList<Survey>();

        try {
            result = surveyDao.selectSurveyAll(survey);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }

    @Override
    public Survey surveyRetr(Survey survey) {
        Survey result = new Survey();

        try {
            result = surveyDao.surveyRetr(survey);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    /**
     * 설문조사 데이터 저장/ 수정/ 삭제
     */
    @Override
    public int saveSurveyCUD(Survey survey, String status) {
        int result = 0;

        try {
            if (WiseOpenConfig.STATUS_I.equals(status)) {
                int surveyId = surveyDao.getSurveyId();
                survey.setSurveyId(surveyId);
                result = surveyDao.insertSurvey(survey);
            } else if ((WiseOpenConfig.STATUS_U.equals(status))) {
                result = surveyDao.updateSurvey(survey);
            } else if ((WiseOpenConfig.STATUS_D.equals(status))) {
                result = surveyDao.deleteSurvey(survey); //상위인 survey가 삭제되면 하위인 문항,지문도 다 삭제가 되도록한다.
                if (surveyDao.selectSurveyQuestCnt(survey) > 0) { //설문만 존재하고 문항 또는 지문이 없으면 result가 0이 되기에 분기한다.
                    result = surveyDao.deleteSurveyQuest(survey);// 문항삭제
                    if (surveyDao.selectSurveyExamCnt(survey) > 0) {
                        result = surveyDao.deleteSurveyExam(survey); //지문삭제
                    }
                } else {
                    result = 1;
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 미리보기 팝업에 해당하는 설문의 pk값 전달받아 팝업에 뿌린다.
     */
    @Override
    public Survey selectSurveyPop(Survey survey) {
        Survey result = new Survey();

        try {
            result = surveyDao.selectSurveyPop(survey);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


}

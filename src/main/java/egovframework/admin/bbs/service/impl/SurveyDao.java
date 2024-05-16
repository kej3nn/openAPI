package egovframework.admin.bbs.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.bbs.service.Survey;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("SurveyDao")
public class SurveyDao extends EgovComAbstractDAO {


    /**
     * 설문관리 전체조회
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<Survey> selectSurveyAll(Survey survey) throws DataAccessException, Exception {
        return (List<Survey>) list("SurveyDao.selectSurveyAll", survey);
    }


    /**
     * 설문관리 단건 조회
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public Survey surveyRetr(Survey survey) throws DataAccessException, Exception {
        return (Survey) selectByPk("SurveyDao.surveyRetr", survey);
    }


    /**
     * 설문조사 등록
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertSurvey(Survey survey) throws DataAccessException, Exception {
        return (Integer) update("SurveyDao.insertSurvey", survey);
    }


    /**
     * surveyId 조회(최대값 +1 )
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int getSurveyId() throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("SurveyDao.getSurveyId");
    }


    /**
     * 설문조사 내용 수정
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateSurvey(Survey survey) throws DataAccessException, Exception {
        return (Integer) update("SurveyDao.updateSurvey", survey);
    }

    /**
     * 설문조사 삭제시 survey 테이블 내용 삭제
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteSurvey(Survey survey) throws DataAccessException, Exception {
        return (Integer) delete("SurveyDao.deleteSurvey", survey);
    }

    /**
     * 설문조사 삭제시 surveyQuest 테이블 내용 삭제
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteSurveyQuest(Survey survey) throws DataAccessException, Exception {
        return (Integer) delete("SurveyDao.deleteSurveyQuest", survey);
    }

    /**
     * 설문조사 삭제시 surveyExam 테이블 내용 삭제
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteSurveyExam(Survey survey) throws DataAccessException, Exception {
        return (Integer) delete("SurveyDao.deleteSurveyExam", survey);
    }


    /**
     * 해당하는 설문 미리보기 팝업에 뿌려줄 내용 조회한다.
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public Survey selectSurveyPop(Survey survey) throws DataAccessException, Exception {
        return (Survey) selectByPk("SurveyDao.selectSurveyPop", survey);
    }


    /**
     * 설문을 삭제 하면서 문항도 삭제하기위해 문항이 있는지 count한다.
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectSurveyQuestCnt(Survey survey) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("SurveyDao.selectSurveyQuestCnt", survey);
    }

    /**
     * 설문을 삭제 하면서 지문도 삭제하기위해 지문이 있는지 count한다.
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectSurveyExamCnt(Survey survey) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("SurveyDao.selectSurveyExamCnt", survey);
    }

}

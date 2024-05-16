package egovframework.admin.bbs.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.bbs.service.Survey;
import egovframework.admin.bbs.service.SurveyAns;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SurveyAnsDao")
public class SurveyAnsDao extends EgovComAbstractDAO {
    /**
     * 설문관리 전체조회
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<Survey> selectSurveyAnsAll(Survey survey) throws DataAccessException, Exception {
        return (List<Survey>) list("SurveyAnsDao.selectSurveyAnsAll", survey);
    }

    /**
     * 설문결과 리스트 조회
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public SurveyAns selectSurveyAnsList(Survey survey) throws DataAccessException, Exception {
        return (SurveyAns) selectByPk("SurveyAnsDao.selectSurveyAnsList", survey);
    }

    /**
     * 설문결과 인원 조회
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<SurveyAns> selectSurveyAnsCnt(Survey survey) throws DataAccessException, Exception {
        return (List<SurveyAns>) list("SurveyAnsDao.selectSurveyAnsCnt", survey);
    }

    /**
     * ip중복체크
     *
     * @param surveyAns
     * @return
     */
    public int selectSurveyAnsIpdup(SurveyAns surveyAns) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("SurveyAnsDao.selectSurveyAnsIpdup", surveyAns);
    }

    /**
     * 설문응답자 정보 등록
     *
     * @param surveyAns
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertSurveyAns(SurveyAns surveyAns) throws DataAccessException, Exception {
        return (Integer) update("SurveyAnsDao.insertSurveyAns", surveyAns);
    }

    /**
     * 설문결과 인원 조회
     *
     * @param surveyAns
     * @return
     * @throws DataAccessException, Exception
     */
    public int getSurveyAnsSeq(SurveyAns surveyAns) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("SurveyAnsDao.getSurveyAnsSeq", surveyAns);
    }

    /**
     * 설문 결과 문항 갯수 조회(리스트)
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public List<SurveyAns> selectSurveyQuestCnt(Survey survey) throws DataAccessException, Exception {
        return (List<SurveyAns>) list("SurveyAnsDao.selectSurveyQuestCnt", survey);
    }

    /**
     * 설문결과 항목의 X축 조회
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    public List<SurveyAns> selectSurveyAnsPersonGubun(Survey survey) throws DataAccessException, Exception {
        return (List<SurveyAns>) list("SurveyAnsDao.selectSurveyAnsPersonGubun", survey);
    }

    /**
     * 설문결과 팝업 항목 리스트 조회
     *
     * @param survey
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectSurveyAnsPopupListAll(Survey survey) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("SurveyAnsDao.selectSurveyAnsPopupListAll", survey);
    }

    /**
     * 설문에 응답자가 한명이라도 있다면 수정불가하도록 체크한다.
     *
     * @param surveyAns
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectSurveyAnsRegCheck(SurveyAns surveyAns) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("SurveyAnsDao.selectSurveyAnsRegCheck", surveyAns);
    }

    @SuppressWarnings("unchecked")
    public List<SurveyAns> surveyAnsListPopupExport(SurveyAns surveyAns) throws DataAccessException, Exception {
        return (List<SurveyAns>) list("SurveyAnsDao.surveyAnsListPopupExport", surveyAns);
    }

}

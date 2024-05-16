package egovframework.admin.bbs.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.bbs.service.SurveyExam;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("SurveyExamDAO")
public class SurveyExamDAO extends EgovComAbstractDAO {

    /**
     * 지문 등록, 수정
     *
     * @param surveyExam
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertSurveyExam(SurveyExam surveyExam) throws DataAccessException, Exception {
        return (Integer) update("SurveyExamDAO.insertSurveyExam", surveyExam);
    }

    /**
     * 지문 조회
     *
     * @param surveyExam
     * @return
     * @throws DataAccessException, Exception
     */
    public List<SurveyExam> selectSurveyExamAll(SurveyExam surveyExam) throws DataAccessException, Exception {
        return (List<SurveyExam>) list("SurveyExamDAO.selectSurveyExamAll", surveyExam);
    }

    /**
     * 지문 삭제
     *
     * @param surveyExam
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteSurveyExam(SurveyExam surveyExam) throws DataAccessException, Exception {
        return (Integer) update("SurveyExamDAO.deleteSurveyExam", surveyExam);
    }

    /**
     * 미리보기 팝업 지문조회하여 뿌려준다.
     *
     * @param surveyExam
     * @return
     * @throws DataAccessException, Exception
     */
    public List<SurveyExam> selectSurveyExamPop(SurveyExam surveyExam) throws DataAccessException, Exception {
        return (List<SurveyExam>) list("SurveyExamDAO.selectSurveyExamPop", surveyExam);
    }

    /**
     * 미리보기 팝업에서 Exam_cd사용
     *
     * @return
     * @throws DataAccessException, Exception
     */
    public List<SurveyExam> selectSurveyExamCdPop() throws DataAccessException, Exception {
        return (List<SurveyExam>) list("SurveyExamDAO.selectSurveyExamCdPop", null);
    }

    /**
     * quest 문항 저장,수정 할때 문항유형이 지문자동생성해야 할때 자동추가한다.
     *
     * @param surveyExam
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertSurveyExamAuto(SurveyExam surveyExam) throws DataAccessException, Exception {
        return (Integer) update("SurveyExamDAO.insertSurveyExamAuto", surveyExam);
    }

    /**
     * 문항유형 자동 저장 하기 위해 조회.
     *
     * @param surveyExam
     * @return
     * @throws DataAccessException, Exception
     */
    public SurveyExam selectTvSurveyExamCd(SurveyExam surveyExam) throws DataAccessException, Exception {
        return (SurveyExam) selectByPk("SurveyExamDAO.selectTvSurveyExamCd", surveyExam);
    }

    /**
     * 특정 문항유형으로 인해 자동으로 추가된 지문이 있다면 삭제한다.
     *
     * @param surveyExam
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteSurveyExamAuto(SurveyExam surveyExam) throws DataAccessException, Exception {
        return (Integer) delete("SurveyExamDAO.deleteSurveyExamAuto", surveyExam);
    }

    /**
     * 지문삭제전 지문이 있는지 count
     *
     * @param surveyExam
     * @return
     */
    public int selectSurveyExamAutoCnt(SurveyExam surveyExam) {
        return (Integer) getSqlMapClientTemplate().queryForObject("SurveyExamDAO.selectSurveyExamAutoCnt", surveyExam);
    }


}

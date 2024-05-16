package egovframework.admin.bbs.service.impl;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.bbs.service.SurveyAnsExam;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("SurveyAnsExamDao")
public class SurveyAnsExamDao extends EgovComAbstractDAO {

    public int insertSurveyAnsExam(SurveyAnsExam surveyAnsExam) throws DataAccessException, Exception {
        return (Integer) update("SurveyAnsExamDao.insertSurveyAnsExam", surveyAnsExam);
    }

}

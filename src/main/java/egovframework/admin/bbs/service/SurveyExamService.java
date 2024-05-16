package egovframework.admin.bbs.service;

import java.util.ArrayList;
import java.util.List;

public interface SurveyExamService {

    /**
     * 지문 추가, 수정, 삭제
     *
     * @param list
     * @param statusI
     * @param surveyExam
     * @return
     * @throws Exception
     */
    int surveyExamSheetCUD(ArrayList<SurveyExam> list, String status, SurveyExam surveyExam);

    List<SurveyExam> selectSurveyExamAll(SurveyExam surveyExam);

    List<SurveyExam> selectSurveyExamPop(SurveyExam surveyExam);

    List<SurveyExam> selectSurveyExamCdPop();

}

package egovframework.admin.bbs.service;

import java.util.List;

public interface SurveyService {


    /**
     * 설문관리 전체조회.
     *
     * @param survey
     * @return
     * @throws Exception
     */
    public List<Survey> selectSurveyAll(Survey survey);

    public Survey surveyRetr(Survey survey);


    /**
     * 데이터 저장/ 수정/ 삭제
     *
     * @param saveVO
     * @param status
     * @return
     * @throws Exception
     */
    public int saveSurveyCUD(Survey survey, String status);

    public Survey selectSurveyPop(Survey survey);


}

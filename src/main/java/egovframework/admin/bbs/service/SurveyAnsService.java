package egovframework.admin.bbs.service;

import java.util.List;
import java.util.Map;

public interface SurveyAnsService {

    /**
     * 설문관리 전체조회.
     *
     * @param survey
     * @return
     * @throws Exception
     */
    public List<Survey> surveyAnsService(Survey survey);

    public SurveyAns surveyAnsList(Survey survey);

    public List<SurveyAns> surveyAnsCnt(Survey survey);

    /**
     * ip중복체크
     *
     * @param surveyAns
     * @return
     */
    public int selectSurveyAnsIpdup(SurveyAns surveyAns);

    /**
     * 설문 팝업에서 등록
     *
     * @param surveyAns
     * @return
     * @throws Exception
     */
    public int saveSurveyAnsCUD(SurveyAns surveyAns);

    /**
     * AnsSeq 추출
     *
     * @param surveyAns
     * @return
     */
    public int getSurveyAnsSeq(SurveyAns surveyAns);

    /**
     * 설문 결과 문항 갯수 조회(리스트)
     *
     * @param survey
     * @return
     * @throws Exception
     */
    public List<SurveyAns> selectSurveyQuestCnt(Survey survey);

    public List<SurveyAns> selectSurveyAnsPopInfo(Survey survey);

    public Map<String, Object> surveyAnsListPopupListAllIbPaging(Survey survey);

    /**
     * 설문에 응답자가 한명이라도 있다면 수정불가하도록 체크한다.
     *
     * @param surveyAns
     * @return
     * @throws Exception
     */
    public int selectSurveyAnsRegCheck(SurveyAns surveyAns);


    public Map<String, Object> surveyAnsListPopupExport(SurveyAns surveyAns);
}

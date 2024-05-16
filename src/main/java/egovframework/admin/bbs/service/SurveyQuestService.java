package egovframework.admin.bbs.service;

import java.util.ArrayList;
import java.util.List;

public interface SurveyQuestService {


    /**
     * 문항 추가, 수정 ,삭제
     *
     * @param list
     * @param statusI
     * @param surveyQuest
     * @return
     * @throws Exception
     */
    int surveyQuestSheetCUD(ArrayList<SurveyQuest> list, String statusI, SurveyQuest surveyQuest);

    List<SurveyQuest> selectSurveyQuestAll(SurveyQuest surveyQuest);

    public List<SurveyQuest> selectSurveyQuestPop(SurveyQuest surveyQuest);

}

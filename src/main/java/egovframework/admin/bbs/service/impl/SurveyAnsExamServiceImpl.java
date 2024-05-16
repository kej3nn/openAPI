package egovframework.admin.bbs.service.impl;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.bbs.service.SurveyAns;
import egovframework.admin.bbs.service.SurveyAnsExam;
import egovframework.admin.bbs.service.SurveyAnsExamService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("SurveyAnsExamService")
public class SurveyAnsExamServiceImpl extends AbstractServiceImpl implements
        SurveyAnsExamService {

    @Resource(name = "SurveyAnsExamDao")
    private SurveyAnsExamDao surveyAnsExamDao;

    @Resource(name = "SurveyAnsDao")
    private SurveyAnsDao surveyAnsDao;


    @Override
    public int saveSurveyAnsExamCUD(SurveyAnsExam list, SurveyAns surveyAns) {
        int result = 0;
        try {
            if (surveyAnsDao.insertSurveyAns(surveyAns) > -1) {    //설문사용자 정보 등록
                if (list != null) {
                    for (int i = 0; i < list.getExamSeqArr().length; i++) {
                        if ("RADIO".equals(list.getQuestExamCdArr()[i])) { //type에 따라 따로 저장해야 배열초과오류 발생안함.

                            list.setExamSeq(list.getExamSeqArr()[i]); //split한 것을 set에 집어넣어 한row씩 insert한다.
                            list.setQuestSeq(list.getQuestSeqArr()[i]);
                            list.setExamVal(list.getExamGradeArr()[i]);
                            list.setExamAns(null);

                        } else if ("TEXT".equals(list.getQuestExamCdArr()[i]) || "CLOB".equals(list.getQuestExamCdArr()[i])) {
                            list.setExamSeq(list.getExamSeqArr()[i]); //split한 것을 set에 집어넣어 한row씩 insert한다.
                            list.setQuestSeq(list.getQuestSeqArr()[i]);
                            list.setExamVal(null); //배열에서 순서대로 꺼내기에 해당list에선 null을 준다. fake이다.
                            list.setExamAns(list.getExamAnsArr()[i]);
                        } else if ("RADIOmanual".equals(list.getQuestExamCdArr()[i])) {
                            list.setExamSeq(list.getExamSeqArr()[i]); //split한 것을 set에 집어넣어 한row씩 insert한다.
                            list.setQuestSeq(list.getQuestSeqArr()[i]);
                            list.setExamVal(list.getExamGradeArr()[i]);

                            if (list.getExamAnsArr()[i].equals("null")) { //examAns에 들어온 문자열이 null 이라면 null을 담아주고. 아니라면 들어온 문자를 담는다.
                                list.setExamAns(null);
                            } else {
                                list.setExamAns(list.getExamAnsArr()[i]);
                            }
                        } else if ("CHECK".equals(list.getQuestExamCdArr()[i])) { //check버튼을 통해 다중체크등
                            list.setExamSeq(list.getExamSeqArr()[i]); //split한 것을 set에 집어넣어 한row씩 insert한다.
                            list.setQuestSeq(list.getQuestSeqArr()[i]);
                            list.setExamVal(list.getExamGradeArr()[i]);

                            if (list.getExamAnsArr()[i].equals("null")) { //examAns에 들어온 문자열이 null 이라면 null을 담아주고. 아니라면 들어온 문자를 담는다.
                                list.setExamAns(null);
                            } else {
                                list.setExamAns(list.getExamAnsArr()[i]);
                            }
                        }
                        result = surveyAnsExamDao.insertSurveyAnsExam(list);
                    }
                }
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }


}

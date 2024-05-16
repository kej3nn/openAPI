package egovframework.admin.bbs.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsrAdmin;
import egovframework.admin.bbs.service.Survey;
import egovframework.admin.bbs.service.SurveyAns;
import egovframework.admin.bbs.service.SurveyAnsService;
import egovframework.admin.bbs.service.SurveyQuest;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("SurveyAnsService")
public class SurveyAnsServiceImpl extends AbstractServiceImpl implements SurveyAnsService {


    @Resource(name = "SurveyAnsDao")
    private SurveyAnsDao surveyAnsDao;

    /**
     * 설문결과 조회
     */
    @Override
    public List<Survey> surveyAnsService(Survey survey) {

        String suv_rep;
        String month;
        String day;
        //현재 날짜 가져오기
        Calendar cal = Calendar.getInstance();

        //월이 10보다 낮으면 앞에 0을 붙임
        if ((cal.get(Calendar.MONTH) + 1) < 10) {
            month = "0" + String.valueOf(cal.get(Calendar.MONTH) + 1);
        } else {
            month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        }
        //일이 10보다 낮으면 앞에 0을 붙임
        if ((cal.get(Calendar.DATE)) < 10) {
            day = "0" + String.valueOf(cal.get(Calendar.DATE));
        } else {
            day = String.valueOf(cal.get(Calendar.DATE));
        }
        //현재 날짜를 문자열로 만듬
        String now_rep = String.valueOf(cal.get(Calendar.YEAR)) + month + day;
        List<Survey> suv = new ArrayList<Survey>();
        try {
            suv = surveyAnsDao.selectSurveyAnsAll(survey);
            for (int i = 0; i < suv.size(); i++) {
                //" " 공백위치 가져오기
                int index = suv.get(i).getEndDttm().indexOf(" ");

                //가져온 공백위치의 문자열 가져와서 - 삭제
                suv_rep = suv.get(i).getEndDttm().substring(0, index).replaceAll("-", "");

                //현자 날짜와 종료일자 int형으로 변환해서 비교
                if (Integer.parseInt(now_rep) > Integer.parseInt(suv_rep)) {
                    suv.get(i).setEndYn("종료");
                } else {
                    suv.get(i).setEndYn("진행중");
                }
            }
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return suv;
    }

    /**
     * 설문결과 리스트 조회
     */
    @Override
    public SurveyAns surveyAnsList(Survey survey) {
        SurveyAns result = new SurveyAns();
        try {
            result = surveyAnsDao.selectSurveyAnsList(survey);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 설문결과 인원 조회
     */
    public List<SurveyAns> surveyAnsCnt(Survey survey) {
        List<SurveyAns> result = new ArrayList<SurveyAns>();
        try {
            result = surveyAnsDao.selectSurveyAnsCnt(survey);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    /**
     * 설문응답시 ip중복체크
     */
    @Override
    public int selectSurveyAnsIpdup(SurveyAns surveyAns) {
        int result = 0;
        try {
            result = surveyAnsDao.selectSurveyAnsIpdup(surveyAns);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }

    /**
     * 설문응답자 정보 등록
     */
    @Override
    public int saveSurveyAnsCUD(SurveyAns surveyAns) {
        int result = 0;
        try {
            result = surveyAnsDao.insertSurveyAns(surveyAns);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * AnsSeq추출
     */
    @Override
    public int getSurveyAnsSeq(SurveyAns surveyAns) {
        int result = 0;
        try {
            result = surveyAnsDao.getSurveyAnsSeq(surveyAns);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 설문 결과 문항 갯수 조회(리스트)
     */
    @Override
    public List<SurveyAns> selectSurveyQuestCnt(Survey survey) {
        List<SurveyAns> result = new ArrayList<SurveyAns>();

        try {
            result = surveyAnsDao.selectSurveyQuestCnt(survey);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 설문결과 항목의 X축 조회
     */
    @Override
    public List<SurveyAns> selectSurveyAnsPopInfo(Survey survey) {
        List<SurveyAns> result = new ArrayList<SurveyAns>();

        try {
            result = surveyAnsDao.selectSurveyAnsPersonGubun(survey);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 설문결과 팝업 항목 리스트 조회
     */
    @Override
    public Map<String, Object> surveyAnsListPopupListAllIbPaging(Survey survey) {
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            List<SurveyAns> info = surveyAnsDao.selectSurveyAnsPersonGubun(survey);
            survey.setDynamicCol(setSelectSurveyAnsPopInfo(info));

            List<LinkedHashMap<String, ?>> result = surveyAnsDao.selectSurveyAnsPopupListAll(survey);
            map.put("resultList", result);
            map.put("resultCnt", result.size());

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 설문결과 항목 리스트 조회시 select 절 생성
     *
     * @param obj
     * @return
     */
    private String setSelectSurveyAnsPopInfo(List<SurveyAns> obj) {
        if (obj.isEmpty()) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        int cnt = 0;
        sb.append("A.EXAM_NM ");
        //for ( SurveyAns surveyAns : obj ) {
        for (int i = 0; i < obj.size(); i++) {
            if (i != 0) {
                String cntString = ++cnt + "";
                cntString = UtilString.SQLInjectionFilter(cntString);
                sb.append("\n, SUM(CASE WHEN A.RNUM = " + cntString + " THEN ROUND(B.ANS_CNT / B.TOT_ANS_CNT *100, 1) ELSE 0 END) RATE" + cntString);
            }
        }
        return sb.toString();
    }

    /**
     * 설문에 응답자가 한명이라도 있다면 수정불가하도록 체크한다.
     */
    @Override
    public int selectSurveyAnsRegCheck(SurveyAns surveyAns) {
        int result = 0;
        try {
            result = surveyAnsDao.selectSurveyAnsRegCheck(surveyAns);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }

    @Override
    public Map<String, Object> surveyAnsListPopupExport(SurveyAns surveyAns) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<SurveyAns> result = surveyAnsDao.surveyAnsListPopupExport(surveyAns);
            map.put("resultList", result);
            map.put("resultCnt", String.valueOf(result.size()));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }
}

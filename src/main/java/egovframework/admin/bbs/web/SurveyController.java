package egovframework.admin.bbs.web;

/**
 * 설문조사 클래스
 *
 * @author jyson
 * @version 1.0
 * @see
 * @since 2014.08.07
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.basicinf.web.CommOrgController;
import egovframework.admin.bbs.service.Survey;
import egovframework.admin.bbs.service.SurveyAns;
import egovframework.admin.bbs.service.SurveyAnsExam;
import egovframework.admin.bbs.service.SurveyAnsExamService;
import egovframework.admin.bbs.service.SurveyAnsService;
import egovframework.admin.bbs.service.SurveyExam;
import egovframework.admin.bbs.service.SurveyExamService;
import egovframework.admin.bbs.service.SurveyQuest;
import egovframework.admin.bbs.service.SurveyQuestService;
import egovframework.admin.bbs.service.SurveyService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;


@Controller
public class SurveyController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommOrgController.class);

    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "SurveyService")
    private SurveyService surveyService;

    @Resource(name = "SurveyQuestService")
    private SurveyQuestService surveyQuestService;

    @Resource(name = "SurveyExamService")
    private SurveyExamService surveyExamService;

    @Resource(name = "SurveyAnsService")
    private SurveyAnsService surveyAnsService;

    @Resource(name = "SurveyAnsExamService")
    private SurveyAnsExamService surveyAnsExamService;

    static class SurveyExams extends HashMap<String, ArrayList<SurveyExam>> {
    }

    static class SurveyQuests extends HashMap<String, ArrayList<SurveyQuest>> {
    }

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Override
    public void afterPropertiesSet() {

    }

    /**
     * 공통코드를 조회 한다.
     *
     * @return
     * @throws Exception
     */
    @ModelAttribute("codeMap")
    public Map<String, Object> getcodeMap() {
        Map<String, Object> codeMap = new HashMap<String, Object>();
        try {
            codeMap.put("examCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("C1011"))); //문항유형
            codeMap.put("ansAge", commCodeListService.getCodeList("C1013")); //연령
            codeMap.put("ansJob", commCodeListService.getCodeList("C1014")); //직업
            codeMap.put("ansTel", commCodeListService.getCodeList("C1015")); //연락처
            codeMap.put("ansEmail", commCodeListService.getCodeList("C1009")); //이메일

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }

    /**
     * 설문관리목록 페이지
     */
    @RequestMapping("/admin/bbs/surveyManagementPage.do")
    public String surveyPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/bbs/surveyManagement";
    }

    /**
     * 설문관리목록을 전체 조회한다.
     */
    @RequestMapping("/admin/bbs/surveyListAll.do")
    @ResponseBody
    public IBSheetListVO<Survey> surveyListAll(@ModelAttribute("searchVO") Survey survey, ModelMap model) {
        List<Survey> list = surveyService.selectSurveyAll(survey);
        return new IBSheetListVO<Survey>(list, list.size());
    }

    /**
     * 설문관리 sheet클릭 단건 조회
     */
    @RequestMapping("/admin/bbs/surveyRetr.do")
    @ResponseBody
    public TABListVo<Survey> surveyRetr(@RequestBody Survey survey, ModelMap model) {
        //	model.addAttribute("surveyAnsCheck", "11232" );
        //surveyAnsService.selectSurveyAnsIpdup(surveyAns)
        return new TABListVo<Survey>(surveyService.surveyRetr(survey));
    }

    /**
     * 설문관리 등록 (단건 데이터 저장) insert
     */
    @RequestMapping("/admin/bbs/surveyReg.do")
    @ResponseBody
    public IBSResultVO<Survey> SurveyReg(@ModelAttribute Survey survey, ModelMap model) {
        int result = 0;
        result = surveyService.saveSurveyCUD(survey, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<Survey>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 설문관리 수정 (단건 데이터 수정) update
     */
    @RequestMapping("/admin/bbs/surveyUpd.do")
    @ResponseBody
    public IBSResultVO<Survey> surveyUpd(@ModelAttribute Survey survey, ModelMap model) {
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        int result = 0;
        result = surveyService.saveSurveyCUD(survey, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<Survey>(result, messagehelper.getUpdateMessage(result));
    }

    /**
     * 설문관리 삭제  delete
     */
    @RequestMapping("/admin/bbs/surveyDel.do")
    @ResponseBody
    public IBSResultVO<Survey> surveyDel(@ModelAttribute Survey survey, ModelMap model) {
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        int result = 0;
        result = surveyService.saveSurveyCUD(survey, WiseOpenConfig.STATUS_D);
        return new IBSResultVO<Survey>(result, messagehelper.getDeleteMessage(result));
    }

    /**
     * 설문 미리보기 팝업창
     */
    @RequestMapping("/admin/bbs/popup/surveyPop.do")
    public String surveyPop(HttpServletRequest request, ModelMap model, @ModelAttribute Survey survey, @ModelAttribute SurveyQuest surveyQuest, @ModelAttribute SurveyExam surveyExam, @ModelAttribute SurveyAns surveyAns) {

        // ip중복체크 클라이언트의 ip 찾는다.
        //단, 윈도우7 이상에서는 IPv6를 우선지원하기에 -> IPv4로 변경하기 위해
        //Run- Configurations 에서 arguments 제일 하단에 -Djava.net.preferIPv4Stack=true 붙여넣기 해주면 변경된다.
        String clientIp = request.getHeader("X_FORWARDED_ROR");
        if (null == clientIp || clientIp.isEmpty() || clientIp.equalsIgnoreCase("unknown")) {
            clientIp = request.getRemoteAddr();
            surveyAns.setAnsIp(clientIp); //지금 설문을 하려는 사용자의 ip를 획득한다.
        }

        model.addAttribute("Survey", surveyService.selectSurveyPop(survey)); // pk 넘겨준다.
        model.addAttribute("SurveyQuest", surveyQuestService.selectSurveyQuestPop(surveyQuest)); // pk 넘겨준다.
        model.addAttribute("SurveyQuestCnt", surveyQuestService.selectSurveyQuestPop(surveyQuest).size()); // 설문시 문항의 개수를 카운트한다.
        model.addAttribute("SurveyExam", surveyExamService.selectSurveyExamPop(surveyExam));  // pk 넘겨준다.
        model.addAttribute("SurveyExamCd", surveyExamService.selectSurveyExamCdPop()); //  Exam CD값 지문
        model.addAttribute("ClientIpDup", surveyAnsService.selectSurveyAnsIpdup(surveyAns)); //ip중복체크
        model.addAttribute("ClientIp", clientIp); //ip중복체크
        return "/admin/bbs/popup/surveypop";
    }

    /**
     * 설문에 응답자가 한명이라도 있다면 수정불가하도록 체크한다.
     *
     * @param survey
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/surveyAnsRegCheck.do")
    @ResponseBody
    public IBSResultVO<SurveyAns> surveyAnsRegCheck(@ModelAttribute SurveyAns surveyAns, ModelMap model) {
        int result = 0;
        result = surveyAnsService.selectSurveyAnsRegCheck(surveyAns);
        return new IBSResultVO<SurveyAns>(result, messagehelper.getSavaMessage(result));
    }


    /**
     * 설문 응답자 개인정보, 설문 정보 등록
     */
    @RequestMapping("/admin/bbs/surveyAnsExamPopReg.do")
    @ResponseBody
    public void surveyAnsExamPopReg(HttpSession session, @ModelAttribute("searchVO") SurveyAnsExam surveyAnsExam, ModelMap model, @ModelAttribute SurveyAns surveyAns, HttpServletResponse response) {
        int result = 0;
        try {
            PrintWriter writer = response.getWriter();
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        }
        String ansCd = "";
        String input = surveyAns.getAnsCd();
        Pattern pattern = Pattern.compile("[A-Z0-9].{0,10}");
        Matcher matcher;
        StringBuffer sb = new StringBuffer();

        //대문자, 숫자 , 10자내외로만 허용
        if (!input.isEmpty() && input.length() <= 10) { //단어수는 1~10자이상일때 실행
            for (int i = 0; i < input.length(); i++) {
                matcher = pattern.matcher(Character.toString(input.charAt(i)));
                if (matcher.matches()) { //true가 아니면 값을 넣어주지 않으면 ,, 값을 기본으로..
                    sb.append(input.charAt(i));
                } else {
                    sb.setLength(0); //버퍼 초기화
                    sb.trimToSize(); //배열메모리 최소화
                    break;
                }
            }
            ansCd = sb.toString();
        }
        surveyAns.setAnsCd(ansCd); //회원구분 설정


        int ansSeq = surveyAnsService.getSurveyAnsSeq(surveyAns); //AnsSeq 추출


        surveyAns.setAnsSeq(ansSeq); //ansSeq추출값 set
        if ("Y".equals(surveyAns.getLoginYn())) {
            surveyAns.setUserId((String) session.getAttribute("portalUserId")); //사용자 id (로그인시)
        }
        //saveSurveyAnsExamCUD impl 함수 내로 이동 => 한개의 transaction으로 변경..
        //result = surveyAnsService.saveSurveyAnsCUD(surveyAns); //설문사용자 정보 등록한다.

        String[] examSeq = StringUtils.defaultString(surveyAnsExam.getExamSeq()).split(" "); //ExamSeq
        surveyAnsExam.setExamSeqArr(examSeq);

        String[] questSeq = StringUtils.defaultString(surveyAnsExam.getQuestSeq()).split(" "); //questSeq
        surveyAnsExam.setQuestSeqArr(questSeq);

        String[] examVal = StringUtils.defaultString(surveyAnsExam.getExamVal()).split(" "); //ExamGrade
        surveyAnsExam.setExamGradeArr(examVal);

        String[] examAns = StringUtils.defaultString(surveyAnsExam.getExamAns()).split("12.34,56"); //ExamAns
        surveyAnsExam.setExamAnsArr(examAns);

        String[] questExamCd = StringUtils.defaultString(surveyAnsExam.getQuestExamCd()).split(" "); //questExamCd
        surveyAnsExam.setQuestExamCdArr(questExamCd);

        surveyAnsExam.setAnsSeq(ansSeq); //AnsSeq 추출값 set

        result = surveyAnsExamService.saveSurveyAnsExamCUD(surveyAnsExam, surveyAns); //설문 정보 등록

    }


    /**
     * 설문결과목록 페이지로 이동한다.
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/surveyAnsListPage.do")
    public String surveyAnsListPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/bbs/surveyAnsList";
    }

    /**
     * 설문결과목록을 전체 조회한다.
     *
     * @param survey
     * @param model
     * @return IBSheetListVO<Survey>
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/surveyAnsListAll.do")
    @ResponseBody
    public IBSheetListVO<Survey> surveyAnsListAll(@ModelAttribute("searchVO") Survey survey, ModelMap model) {
        List<Survey> list = surveyAnsService.surveyAnsService(survey);
        return new IBSheetListVO<Survey>(list, list.size());
    }

    /**
     * 리스트에서 선택한 설문결과정보를 조회한다
     *
     * @param survey
     * @param model
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/surveyAnsListPopup.do")
    public ModelAndView surveyAnsListPopup(Survey survey, ModelMap model) {
        ModelAndView modelAndView = new ModelAndView();

        int totalCnt = 0;
        List<SurveyAns> list = surveyAnsService.surveyAnsCnt(survey);
        for (int i = 0; i < list.size(); i++) {
            totalCnt += Integer.parseInt(list.get(i).getDitcCnt());
        }
        modelAndView.addObject("ansList", surveyAnsService.surveyAnsList(survey));
        modelAndView.addObject("cntList", list);
        modelAndView.addObject("totalCnt", totalCnt);
        modelAndView.addObject("questCnt", surveyAnsService.selectSurveyQuestCnt(survey));
        modelAndView.addObject("totalQuestCnt", surveyAnsService.selectSurveyQuestCnt(survey).size());
        modelAndView.addObject("head", surveyAnsService.selectSurveyAnsPopInfo(survey));
        modelAndView.setViewName("/admin/bbs/popup/surveyAnsListpopup");
        return modelAndView;
    }


    @RequestMapping("/admin/bbs/surveyAnsListPopupExport.do")
    @ResponseBody
    public IBSheetListVO<SurveyAns> surveyAnsListPopupExport(@ModelAttribute("searchVO") SurveyAns surveyAns, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = surveyAnsService.surveyAnsListPopupExport(surveyAns);
        @SuppressWarnings("unchecked")
        List<SurveyAns> result = (List<SurveyAns>) map.get("resultList");
        return new IBSheetListVO<SurveyAns>(result, Integer.parseInt((String) map.get("resultCnt")));
    }


    /**
     * 설문결과 팝업 항목을 조회한다.
     *
     * @param survey
     * @param mode
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/surveyAnsListPopupListAll.do")
    @ResponseBody
    public IBSheetListVO<LinkedHashMap<String, ?>> openInfColViewListAll(Survey survey, ModelMap mode) {
        //페이징 처리와 IbSheet 헤더 정렬은 반드시 *IbPaging 메소드명을 사용해야함(AOP 사용)
        Map<String, Object> map = surveyAnsService.surveyAnsListPopupListAllIbPaging(survey);
        @SuppressWarnings("unchecked")
        List<LinkedHashMap<String, ?>> result = (List<LinkedHashMap<String, ?>>) map.get("resultList");
        //int cnt = Integer.parseInt((String)map.get("resultCnt"));
        return new IBSheetListVO<LinkedHashMap<String, ?>>(result, result.size());
    }


    /**
     * 설문관리 항목 목록을 조회한다.
     */
    @RequestMapping("/admin/bbs/surveyQuestListAll.do")
    @ResponseBody
    public IBSheetListVO<SurveyQuest> surveyQuestListAll(@ModelAttribute("searchVO") SurveyQuest surveyQuest, ModelMap model) {
        List<SurveyQuest> list = surveyQuestService.selectSurveyQuestAll(surveyQuest);
        return new IBSheetListVO<SurveyQuest>(list, list.size());
    }

    /**
     * 설문 항목추가, 수정
     */
    @RequestMapping("/admin/bbs/surveyQuestAdd.do")
    @ResponseBody
    public IBSResultVO<SurveyQuest> surveyQuestAdd(@RequestBody SurveyQuests data, Locale locale, @ModelAttribute SurveyQuest surveyQuest) {
        ArrayList<SurveyQuest> list = data.get("data");
        int result = surveyQuestService.surveyQuestSheetCUD(list, WiseOpenConfig.STATUS_I, surveyQuest);
        return new IBSResultVO<SurveyQuest>(result, messagehelper.getSavaMessage(result));
    }


    /**
     * 설문 항목삭제
     */
    @RequestMapping("/admin/bbs/surveyQuestDelete.do")
    @ResponseBody
    public IBSResultVO<SurveyQuest> surveyQuestDelete(@RequestBody SurveyQuests data, Locale locale) {
        int result = 0;
        ArrayList<SurveyQuest> list = data.get("data");
        if (list != null) result = surveyQuestService.surveyQuestSheetCUD(list, WiseOpenConfig.STATUS_D, null);

        return new IBSResultVO<SurveyQuest>(result, messagehelper.getDeleteMessage(result));
    }

    /**
     * 설문관리 지문목록을 조회한다.
     */
    @RequestMapping("/admin/bbs/surveyExamListAll.do")
    @ResponseBody
    public IBSheetListVO<SurveyExam> surveyExamListAll(@ModelAttribute("searchVO") SurveyExam surveyExam, ModelMap model) {
        List<SurveyExam> list = surveyExamService.selectSurveyExamAll(surveyExam);
        return new IBSheetListVO<SurveyExam>(list, list.size());
    }

    /**
     * 지문추가
     */
    @RequestMapping("/admin/bbs/surveyExamAdd.do")
    @ResponseBody
    public IBSResultVO<SurveyExam> surveyExamAdd(@RequestBody SurveyExams data, Locale locale, @ModelAttribute("searchVO") SurveyExam surveyExam) {
        ArrayList<SurveyExam> list = data.get("data");
        int result = surveyExamService.surveyExamSheetCUD(list, WiseOpenConfig.STATUS_I, surveyExam);
        return new IBSResultVO<SurveyExam>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 지문삭제
     */
    @RequestMapping("/admin/bbs/surveyExamDelete.do")
    @ResponseBody
    public IBSResultVO<SurveyExam> surveyExamDelete(@RequestBody SurveyExams data, Locale locale) {
        int result = 0;
        ArrayList<SurveyExam> list = data.get("data");
        if (list != null) result = surveyExamService.surveyExamSheetCUD(list, WiseOpenConfig.STATUS_D, null);
        return new IBSResultVO<SurveyExam>(result, messagehelper.getDeleteMessage(result));
    }


}

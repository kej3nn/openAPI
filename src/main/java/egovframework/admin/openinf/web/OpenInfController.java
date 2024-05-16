package egovframework.admin.openinf.web;

/**
 * 사용자 페이지로 이동하는 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.basicinf.service.CommUsrService;
import egovframework.admin.bbs.service.BbsList;
import egovframework.admin.opendt.service.OpenCate;
import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.openinf.service.OpenInfService;
import egovframework.admin.openinf.service.OpenOrgUsrRel;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.WiseOpenConfig;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.code.service.CodeListService;
import egovframework.common.file.service.FileService;
import egovframework.common.file.service.FileVo;
import egovframework.common.grid.CommVo;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.MetaExceldownhelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;
import egovframework.common.util.UtilString;

@Controller
public class OpenInfController extends BaseController implements InitializingBean {

    protected static final Log logger = LogFactory
            .getLog(OpenInfController.class);

    static class openInf extends HashMap<String, ArrayList<OpenInf>> {
    }

    static class OpenOrgUsrRels extends
            HashMap<String, ArrayList<OpenOrgUsrRel>> {
    }

    @Resource(name = "CommUsrService")
    private CommUsrService commUsrService;

    // 공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "OpenInfService")
    private OpenInfService openInfService;

    // 공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

    @Autowired
    MetaExceldownhelper metaExceldownhelper;

    @Resource(name = "CommMenuService")
    private CommMenuService commMenuService;

    @Resource(name = "FileService")
    private FileService FileService;

    private ObjectMapper objectMapper = new ObjectMapper();

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
            codeMap.put("cclCdIbs", UtilJson.convertJsonString(commCodeListService
                    .getCodeListIBS("D1008")));
            codeMap.put("cateIdIbs", UtilJson.convertJsonString(commCodeListService
                    .getCodeListIBS("D1025")));// 분류정보 ibSheet
            codeMap.put("orgCdIbs", UtilJson.convertJsonString(commCodeListService
                    .getEntityCodeListIBS("ORG_CD")));
            codeMap.put("infStatsIbs", UtilJson
                    .convertJsonString(commCodeListService
                            .getEntityCodeListIBS("INF_STATS")));
            codeMap.put("pressStateIbs", UtilJson
                    .convertJsonString(commCodeListService
                            .getEntityCodeListIBS("PRSS_STATE")));
            codeMap.put("cateNm", commCodeListService.getEntityCodeList("CATE_NM"));// 분류정보
            codeMap.put("openCd", commCodeListService.getCodeList("D1001"));
            codeMap.put("causeCd", commCodeListService.getCodeList("D1002"));
            codeMap.put("cclCd", commCodeListService.getCodeList("D1008")); //이용허락조건
            codeMap.put("loadCd", commCodeListService.getCodeList("D1009"));
            codeMap.put("themeCd", commCodeListService.getCodeList("D1105"));
            codeMap.put("saCd", commCodeListService.getCodeList("D1106"));
            codeMap.put("jobCdIbs", UtilJson.convertJsonString(commCodeListService
                    .getCodeListIBS("C1003", true)));
            codeMap.put("prssAccCdIbs", UtilJson.convertJsonString(commCodeListService
                    .getCodeListIBS("D2003", true)));
            //2018.01.04 추가
            codeMap.put("fvtDataOrder", commCodeListService.getCodeList("C1018")); //추천 순위
            codeMap.put("infState", commCodeListService.getCodeList("D1007")); //개방상태
            codeMap.put("infSrv", commCodeListService.getCodeList("D1012")); //서비스유형

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return codeMap;
    }

    /**
     * 서비스 조회화면으로 이동한다.
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPage.do")
    public String openInfPage(ModelMap model) {
        // 페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        // Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openinf";
    }

    /**
     * 서비스를 전체 조회한다.
     *
     * @param openInf
     * @param model
     * @return IBSheetListVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfListAll.do")
    @ResponseBody
    public IBSheetListVO<OpenInf> openInfListAll(
            @ModelAttribute("searchVO") OpenInf openInf, ModelMap model) {

        // 페이징 처리와 IbSheet 헤더 정렬은 반드시 *IbPaging 메소드명을 사용해야함(AOP 사용)
        Map<String, Object> map = openInfService
                .selectOpenInfAllIbPaging(openInf);
        @SuppressWarnings("unchecked")
        List<OpenInf> result = (List<OpenInf>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInf>(result, cnt);
    }

    /**
     * 메타정보를 조회한다.
     *
     * @param openInf
     * @param model
     * @return TABListVo<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfListTab.do")
    @ResponseBody
    public TABListVo<OpenInf> openInfListTab(@RequestBody OpenInf openInf,
                                             ModelMap model) {
        logger.debug("test");
        return new TABListVo<OpenInf>(openInfService.selectOpenInf(openInf));
    }

    /**
     * 메타정보를 조회한다.
     *
     * @param openInf
     * @param model
     * @return TABListVo<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfList.do")
    @ResponseBody
    public Map<String, Object> openInfList(OpenInf openInf, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("DATA", openInfService.selectOpenInf(openInf));
        return map;
    }

    /**
     * 데이터셋 팝업 화면
     *
     * @param model
     * @return String
     */
    @RequestMapping("/admin/openinf/popup/openInfDs_pop.do")
    public String openDtSrcPop(ModelMap model) {
        return "/admin/openinf/popup/openinfds_pop";
    }

    /**
     * 데이터셋 팝업 화면 조회
     *
     * @param openInf
     * @param model
     * @return IBSheetListVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/popup/openInfDsList.do")
    @ResponseBody
    public IBSheetListVO<OpenInf> openDtSrcPopList(
            @ModelAttribute("searchVO") OpenInf openInf, ModelMap model) {
        // 페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openInfService
                .selectOpenInfDsListIbPaging(openInf);
        @SuppressWarnings("unchecked")
        List<OpenInf> result = (List<OpenInf>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInf>(result, cnt);
    }

    /**
     * 메타정보 미리보기
     *
     * @param openInf
     * @param model
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/popup/openInfViewPopUp.do")
    public ModelAndView openInfViewPopUp(OpenInf openInf, ModelMap model) {
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        String viewLang = openInf.getViewLang();
        map = openInfService.selectOpenInfViewPopUp(openInf);
        modelAndView.addObject("result", map.get("result"));
        modelAndView.setViewName("/admin/openinf/popup/openinfview");
        modelAndView.addObject("viewLang", viewLang);

        modelAndView.addObject("openInf", openInf);
        return modelAndView;
    }


    //특수문자 변환 (일단 미사용)
    public static String StringReplace(String str) {
        //String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
        //str =str.replaceAll(match, " ");
        return str;
    }

    /**
     * 메타정보 신규 저장
     *
     * @param saveVO
     * @param model
     * @return IBSResultVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfReg.do")
    @ResponseBody
    public IBSResultVO<OpenInf> regOpenInf(@RequestBody OpenOrgUsrRels data,
                                           @ModelAttribute OpenInf saveVO, ModelMap model, Locale locale,
                                           @RequestParam(value = "themeCd", required = false) List<String> themeCd,
                                           @RequestParam(value = "saCd", required = false) List<String> saCd) {
        saveVO.decodeURIEncoding();
        ArrayList<OpenOrgUsrRel> list = data.get("data");
        int result = 0;

        CommUsr loginVO = null;

        // 사용자 인증 및 사용자 권한정보 및 사용자코드 Set
        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            saveVO.setUsrId(loginVO.getUsrId());
            saveVO.setAccCd(loginVO.getAccCd());
        }

        if (themeCd != null) {
            String[] strArray = themeCd.toArray(new String[themeCd.size()]);
            saveVO.setThemeCd(strArray);
        }

        if (saCd != null) {
            String[] strArray2 = saCd.toArray(new String[saCd.size()]);
            saveVO.setSaCd(strArray2);
        }
        saveVO.setInfNm(StringReplace(saveVO.getInfNm())); //특수문자변환

        result = openInfService.openInfRegCUD(list, saveVO, WiseOpenConfig.STATUS_I);
        String resmsg;

        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        // return new IBSResultVO<OpenInf>(result,
        // messagehelper.getSavaMessage(result));
        return new IBSResultVO<OpenInf>(result, resmsg);
    }

    /**
     * 메타정보 수정
     *
     * @param request
     * @param model
     * @param themeCd
     * @param saCd
     * @return IBSResultVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfUpd.do")
    @ResponseBody
    public IBSResultVO<OpenInf> updateOpenInf(HttpServletRequest request,
                                              ModelMap model,
                                              @RequestParam(value = "themeCd", required = false) List<String> themeCd,
                                              @RequestParam(value = "saCd", required = false) List<String> saCd
    ) throws Exception {
        // saveVO.decodeURIEncoding();
        // ArrayList<OpenOrgUsrRel> list = data.get("data");
        OpenInf saveVO = new OpenInf();
        saveVO.setKorYn(request.getParameter("korYn"));
        saveVO.setEngYn(request.getParameter("engYn"));
        saveVO.setKorMobileYn(request.getParameter("korMobileYn"));

        if (!StringUtils.defaultString(request.getParameter("seq")).equals("")) {
            saveVO.setSeq(Integer.parseInt(request.getParameter("seq").trim()));
        }

        saveVO.setInfId(request.getParameter("infId"));
        saveVO.setInfNm(request.getParameter("infNm"));
        saveVO.setCateId(request.getParameter("cateId"));
        saveVO.setCateIdTop(request.getParameter("cateIdTop"));
        saveVO.setCateNm(request.getParameter("cateNm"));
        saveVO.setCclCd(request.getParameter("cclCd"));
        saveVO.setDtId(Integer.parseInt(request.getParameter("dtId")));
        saveVO.setDtNm(request.getParameter("dtNm"));
        saveVO.setDsId(request.getParameter("dsId"));
        saveVO.setOpenCd(request.getParameter("openCd"));
        saveVO.setLoadCd(request.getParameter("loadCd"));
        saveVO.setApiRes(request.getParameter("apiRes"));
        saveVO.setSgrpCd(request.getParameter("sgrpCd"));
        saveVO.setCauseInfo(request.getParameter("causeInfo"));
        saveVO.setInfTag(request.getParameter("infTag"));
        saveVO.setOpenDttm(request.getParameter("openDttm"));
        saveVO.setDataCondDttm(request.getParameter("dataCondDttm"));
        saveVO.setUseDeptNm(request.getParameter("useDeptNm"));
        saveVO.setAprvProcYn(request.getParameter("aprvProcYn"));
        saveVO.setInfExp(request.getParameter("infExp"));
        saveVO.setCateId2(request.getParameter("cateId2"));
        saveVO.setFvtDataOrder(request.getParameter("fvtDataOrder"));
        saveVO.setUseYn(request.getParameter("useYn"));
        saveVO.setInfState(request.getParameter("infState"));

        saveVO.decodeURIEncoding();


        if (themeCd != null) {
            String[] strArray = themeCd.toArray(new String[themeCd.size()]);
            saveVO.setThemeCd(strArray);
        }

        if (saCd != null) {
            String[] strArray2 = saCd.toArray(new String[saCd.size()]);
            saveVO.setSaCd(strArray2);
        }


        saveVO.setInfNm(StringReplace(saveVO.getInfNm())); //특수문자변환


        /*
         * Enumeration eNames = request.getParameterNames(); if
         * (eNames.hasMoreElements()) { String title = "Parameters"; Map entries
         * = new TreeMap(); while (eNames.hasMoreElements()) { String name =
         * (String) eNames.nextElement(); String[] values =
         * request.getParameterValues(name); if (values.length > 0) { String
         * value = values[0]; for (int i = 1; i < values.length; i++) { value +=
         * "," + values[i]; } System.out.println(name+" : "+value); } } }
         */
        ArrayList<OpenOrgUsrRel> list = new ArrayList<OpenOrgUsrRel>();

        JSONArray jsonArray = new JSONObject(
                request.getParameter("ibsSaveJson")).getJSONArray("data");
        for (int i = 0; i < jsonArray.length(); i++) {
            OpenOrgUsrRel obj = new OpenOrgUsrRel();
            JSONObject jsonObj = (JSONObject) jsonArray.get(i);
            obj.setDel(String.valueOf(jsonObj.getInt("del")));
            obj.setSeq(jsonObj.getInt("seq"));
            if (jsonObj.has("seqceNo") && !"".equals(jsonObj.get("seqceNo"))) {
                obj.setSeqceNo(jsonObj.getInt("seqceNo"));
            }
            obj.setOrgNm(jsonObj.getString("orgNm"));
            obj.setOrgCd(jsonObj.getString("orgCd"));
            obj.setUsrNm(jsonObj.getString("usrNm"));
            obj.setUsrCd(jsonObj.getString("usrCd"));
            obj.setRpstYn(jsonObj.getString("rpstYn"));
            obj.setPrssAccCd(jsonObj.getString("prssAccCd"));
            obj.setJobCd(jsonObj.getString("jobCd"));
            obj.setSrcViewYn(jsonObj.getString("srcViewYn"));
            obj.setUseYn(jsonObj.getString("useYn"));
            obj.setStatus(jsonObj.getString("status"));
            list.add(obj);
        }

        CommUsr loginVO = null;

        // 사용자 인증 및 사용자 권한정보 및 사용자코드 Set
        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            saveVO.setUsrId(loginVO.getUsrId());
            saveVO.setAccCd(loginVO.getAccCd());
        }

        int result = 0;
        result = openInfService.openInfRegCUD(list, saveVO, WiseOpenConfig.STATUS_U);
        String resmsg;


        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        // return new IBSResultVO<OpenInf>(result,
        // messagehelper.getSavaMessage(result));
        return new IBSResultVO<OpenInf>(result, resmsg);
    }

    /**
     * 메타정보 삭제
     *
     * @param saveVO
     * @param model
     * @return IBSResultVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfDel.do")
    @ResponseBody
    public IBSResultVO<OpenInf> deleteOpenInf(@RequestBody OpenOrgUsrRels data,
                                              @ModelAttribute OpenInf saveVO, ModelMap model) {
        saveVO.decodeURIEncoding();
        ArrayList<OpenOrgUsrRel> list = data.get("data");
        String resmsg;
        int result = 0;
        int resultPrss = openInfService.getPrssState(saveVO);
        int resultSrv = openInfService.getSrvCd(saveVO);

        // 사용자 인증 및 사용자 권한정보 및 사용자코드 Set
        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            CommUsr loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            saveVO.setUsrId(loginVO.getUsrId());
            saveVO.setAccCd(loginVO.getAccCd());
        }

        if (resultPrss > 0 || resultSrv > 0) {
            result = -1;
            resmsg = message.getMessage("ERR.INFCHK");
        } else {
            result = openInfService.openInfRegCUD(list, saveVO, WiseOpenConfig.STATUS_D);
            if (result > 0) {
                result = 0;
                resmsg = message.getMessage("MSG.DEL");
            } else if (result == -1) {
                result = -1;
                resmsg = "대상 공공데이터는 공개중이므로 삭제할 수 없습니다.";
            } else {
                result = -1;
                resmsg = "삭제에 실패하였습니다.";
            }
        }

        return new IBSResultVO<OpenInf>(result, resmsg);
    }

    /**
     * 불러오기 조회 화면
     *
     * @param model
     * @return String
     */
    @RequestMapping("/admin/openinf/popup/existOpenInfPop.do")
    public String existOpenInfPop(ModelMap model) {
        return "/admin/openinf/popup/existopeninf_pop";
    }

    /**
     * 불러오기
     *
     * @param openInf
     * @param model
     * @return IBSheetListVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/popup/existOpenInfPopList.do")
    @ResponseBody
    public IBSheetListVO<OpenInf> existOpenInfPopList(
            @ModelAttribute("searchVO") OpenInf openInf, ModelMap model) {
        // 페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openInfService
                .selectOpenInfAllIbPaging(openInf);
        @SuppressWarnings("unchecked")
        List<OpenInf> result = (List<OpenInf>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInf>(result, cnt);
    }

    /**
     * 불러오기 더블클릭 후 실행
     *
     * @param openInf
     * @param model
     * @return TABListVo<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/exist.do")
    @ResponseBody
    public TABListVo<OpenInf> existOpenInf(OpenInf openInf, ModelMap model) {
        return new TABListVo<OpenInf>(
                openInfService.selectExistOpenInfDtl(openInf));
    }

    /**
     * 메타다운로드
     *
     * @param openInf
     * @param mode
     * @param response
     * @param requset
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/metaDownload.do")
    public void fileDownload(OpenInf openInf, ModelMap mode,
                             HttpServletResponse response, HttpServletRequest requset) {
        Map<String, Object> map = openInfService
                .selectMetaDownIbPaging(openInf);
        @SuppressWarnings("unchecked")
        List<LinkedHashMap<String, ?>> result = (List<LinkedHashMap<String, ?>>) map
                .get("resultList");
        @SuppressWarnings("unchecked")
        List<String> head = (List<String>) map.get("head");
        String infNm = "공공데이터포털용";
        metaExceldownhelper.download(result, head, infNm, response, requset);

    }

    /**
     * 담당자일괄 변경 화면으로 이동
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPageModifyAllPage.do")
    public String openInfPageModifyAllPage(ModelMap model) {
        // 페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        // Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openinfmodifyall";
    }

    /**
     * 메타정보 일괄 수정
     *
     * @param data
     * @param locale
     * @param openInf
     * @return IBSResultVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfModifyAll.do")
    @ResponseBody
    public IBSResultVO<OpenInf> openInfModifyAll(@RequestBody openInf data,
                                                 Locale locale, @ModelAttribute OpenInf openInf) {
        int result = 0;
        ArrayList<OpenInf> list = data.get("data");
        result = openInfService.openInfModifyAllCUD(list,
                WiseOpenConfig.STATUS_U, openInf);
        return new IBSResultVO<OpenInf>(result,
                messagehelper.getSavaMessage(result));
    }

    /**
     * 변경내역 조회 화면으로 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openHisInfPage.do")
    public String openHisInfPage(ModelMap model) {
        // 페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        // Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openhisinf";
    }

    /**
     * 메타정보의 변경이력을 조회한다.
     *
     * @param openInf
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openHisInfOneList.do")
    @ResponseBody
    public IBSheetListVO<OpenInf> openHisInfOneList(
            @ModelAttribute("searchVO") OpenInf openInf, ModelMap model) {
        @SuppressWarnings("unchecked")
        Map<String, Object> map = openInfService
                .selectOpenHisInfOneList(openInf);
        List<OpenInf> result = (List<OpenInf>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInf>(result, cnt);
    }

    /**
     * 메타정보 변경이력의 상세팝업 화면으로 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openHisInfOneDetailPopUp.do")
    public ModelAndView openHisInfOneDetailPopUp(OpenInf openInf, ModelMap model) {
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        map = openInfService.openHisInfOneDetailPopUp(openInf);
        modelAndView.addObject("result", map.get("result"));
        modelAndView.addObject("openInf", openInf);
        modelAndView
                .setViewName("/admin/openinf/popup/openHisInfOneDetailPopUp");
        return modelAndView;
    }

    /**
     * 공공데이터 개방요청 화면
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openLogInfPrssAaPage.do")
    public String openInfPrssAaPage(ModelMap model) {
        // 페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        // Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openloginfprss";
    }

    /**
     * 메타정보의 개방이력을 조회한다.
     *
     * @param openInf
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openLogInfOneList.do")
    @ResponseBody
    public IBSheetListVO<OpenInf> openLogInfOneList(
            @ModelAttribute("searchVO") OpenInf openInf, ModelMap model) {
        Map<String, Object> map = openInfService.openLogInfOneList(openInf);
        @SuppressWarnings("unchecked")
        List<OpenInf> result = (List<OpenInf>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInf>(result, cnt);
    }

    /**
     * 서비스를 전체 조회한다.
     *
     * @param openOrgUsrRel
     * @param model
     * @return IBSheetListVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfOrgUsrList.do")
    @ResponseBody
    public IBSheetListVO<OpenOrgUsrRel> openInfOrgUsrList(
            @ModelAttribute("searchVO") OpenOrgUsrRel openOrgUsrRel,
            ModelMap model) {

        // 페이징 처리와 IbSheet 헤더 정렬은 반드시 *IbPaging 메소드명을 사용해야함(AOP 사용)
        Map<String, Object> map = openInfService
                .selectOpenInfOrgUsrListIbPaging(openOrgUsrRel);
        @SuppressWarnings("unchecked")
        List<OpenOrgUsrRel> result = (List<OpenOrgUsrRel>) map
                .get("resultList");
        //int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenOrgUsrRel>(result, (Integer) map.get("resultCnt"));
    }

    // ////////////////////////////////////////////// img 처리 컨트롤러
    // //////////////////////////////////////////////////////

    /**
     * 첨부파일 파일 저장
     *
     * @param fileVo
     * @param request
     * @param opencate
     * @param model
     * @param res
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opencate/saveBbsFile.do")
    @ResponseBody
    public void saveImgFile(FileVo fileVo, HttpServletRequest request,
                            OpenCate opencate, ModelMap model, HttpServletResponse res) {
        int i = 0;
        boolean successFileUpload = false;
        String rtnVal = "";
        /*
         * 파일 타입 체크시... 아래코드 주석 풀고 사용.. String[] type = {"hwp,ppt"}; //파일 허용타입
         * if(FileService.fileTypeCkeck(fileVo, type)){ //타입이 정상인지 체크
         * successFileUpload = FileService.fileUpload(fileVo,
         * openInfSrv.getMstSeq(),
         * EgovProperties.getProperty("Globals.ServiceFilePath"),
         * WiseOpenConfig.FILE_SERVICE); }else{ //리턴 에러메시지 뿌려야함 }
         */
        try {
            FileService.setFileCuData(fileVo);// 파일재정의(트랙잰션)
            logger.debug("========================before");
            successFileUpload = FileService.fileUpload(fileVo, i,
                    EgovProperties.getProperty("Globals.OpenCateFilePath"),
                    WiseOpenConfig.FILE_DATA_CATE);
            logger.debug("========================after," + successFileUpload);

            // UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
            // 반드시 new 연산자를 사용하여 vo를 넘겨야한다..
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            if (successFileUpload) {
                @SuppressWarnings("unchecked")
                List<OpenCate> list = (List<OpenCate>) UtilString
                        .setQueryStringData(request, new OpenCate(), fileVo);
                rtnVal = objectMapper.writeValueAsString(saveImgFileListCUD(
                        (ArrayList<?>) list, opencate, model, fileVo));
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<OpenCate>(
                        -2, messagehelper.getSavaMessage(-2))); // 저장실패
            }
            writer.println(rtnVal);
            writer.close(); // return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가
            // 생겨 변경..

        } catch (FileNotFoundException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 첨부파일 데이터 저장
     *
     * @param list
     * @param opencate
     * @param model
     * @param fileVo
     * @return
     * @throws Exception
     */
    private IBSResultVO<CommVo> saveImgFileListCUD(ArrayList<?> list,
                                                   OpenCate opencate, ModelMap model, FileVo fileVo) {
        logger.debug("saveImgFileListCUD");
        int result = openInfService.saveImgFileListCUD(opencate, list, fileVo);
        int fileSeq = 0;

        return new IBSResultVO<CommVo>(result,
                messagehelper.getSavaMessage(result), "File");
    }

    /**
     * 개발중....
     *
     * @param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opencate/bbsImgDetailView.do")
    @ResponseBody
    public Map<String, Object> cateImgDetailView(OpenCate opencate,
                                                 ModelMap model) {
        Map<String, Object> map = openInfService.cateImgDetailView(opencate);
        map.put("resultImg", map.get("resultImg"));
        // map.put("resultTopYn", map.get("resultTopYn"));
        return map;
    }

    /**
     * 파일 다운로드(포탈)
     *
     * @param downCd
     * @param fileSeq
     * @param seq
     * @return
     */
    @RequestMapping("/admin/opencate/fileDownload.do")
    public ModelAndView download(@RequestParam("downCd") String downCd,
                                 @RequestParam("fileSeq") int fileSeq,
                                 @RequestParam("seq") String seq) {
        // 게시판의 경우에는 C:/DATA/upload/bbs/ 이후에 bbsCd별로 folder가 따로 생성되기 때문에 중간에
        // bbsCd folder를 가져오기 위해 다운로드폴더명을 굳이 나눴음 - 발로 짠거 인정 ㅠㅠ - 황미리 with 정호성
        String downloadFolder = UtilString.getDownloadRootFolder(downCd, seq);

        List<HashMap<String, Object>> map = FileService.getFileNameByFileSeq(
                downCd, fileSeq, seq);
        String fileName = (String) map.get(0).get("viewFileNm"); // 사용자에게 보여줄
        // 파일명(출력파일명)
        String fileExtg = (String) map.get(0).get("fileExt");
        // 사용자에게 보여줄 확장자명(출력확장자)

        String saveFileNm = (String) map.get(0).get("saveFileNm");

        String folder = EgovWebUtil.folderPathReplaceAll(downloadFolder + File.separator); // 전체다운경로 및 파일
        ModelAndView mav = new ModelAndView();
        mav.addObject("fileName", fileName + "." + fileExtg);
        mav.addObject("file", new File(folder + EgovWebUtil.filePathReplaceAll(saveFileNm)));
        mav.setViewName("downloadView"); // viewResolver...
        return mav;
    }

    /**
     * 첨부이미지 완전 삭제 (개발중.....)
     *
     * @param opencate
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opencate/deleteImgDtl.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteImgDtl(@ModelAttribute OpenCate opencate) {
        int result = openInfService.deleteImgDtlCUD(opencate);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "Img");
    }

    /**
     * 개방 버튼 업데이트
     *
     * @param
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/updateInfState.do")
    public String updateInfState(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.

        Params params = getParams(request, true);
        debug("Request parameters: " + params);

        Object result = openInfService.updateInfState(params);

        debug("Processing results: " + result);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }


    /**
     * 내부직원용 공공데이터 메타관리 조회화면으로 이동한다.
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/stfOpenInfPage.do")
    public String stfOpenInfPage(ModelMap model) {
        // 페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        // Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/stfopeninf";
    }

    /**
     * 내부직원용 공공데이터 메타관리 조회(페이징 처리)
     */
    @RequestMapping("/admin/openinf/selectSftOpenInfListPaging.do")
    public String selectSftOpenInfListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfService.selectSftOpenInfListPaging(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 내부직원용 공공데이터 메타관리 상세 조회
     *
     * @param params
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/openinf/stfopeninfDtl.do")
    @ResponseBody
    public TABListVo<Record> stfopeninfDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
        return new TABListVo<Record>(openInfService.stfopeninfDtl(params));
    }

    /**
     * 내부직원용 공공데이터 메타관리 등록/수정
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/saveStfopeninf.do")
    public String saveStfopeninf(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        //데이터 처리 진행 코드(입력)
        params.set("Status", "U");
        Object result = openInfService.saveStfopeninf(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

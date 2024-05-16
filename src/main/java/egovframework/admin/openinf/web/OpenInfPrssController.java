package egovframework.admin.openinf.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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

import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.openinf.service.OpenInfPrssService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;

@Controller
public class OpenInfPrssController implements InitializingBean {
    protected static final Log logger = LogFactory.getLog(OpenInfController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "OpenInfPrssService")
    private OpenInfPrssService openInfPrssService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;


    @Resource(name = "CommMenuService")
    private CommMenuService commMenuService;

    public void afterPropertiesSet() {


    }

    /**
     * 공통코드를 조회 한다.
     *
     * @return Map<String, Object>
     * @throws Exception
     */
    @ModelAttribute("codeMap")
    public Map<String, Object> getcodeMap() {
        Map<String, Object> codeMap = new HashMap<String, Object>();
        try {
            codeMap.put("cateIdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1025")));//분류정보 ibSheet
            codeMap.put("orgCdIbs", UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("ORG_CD")));
            codeMap.put("infStateIbs", UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("INF_STATS")));
            codeMap.put("pressStateIbs", UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("PRSS_STATE")));
            codeMap.put("cateNm", commCodeListService.getEntityCodeList("CATE_NM"));//분류정보
            codeMap.put("openCd", commCodeListService.getCodeList("D1001"));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return codeMap;
    }

    /**
     * 공공데이터 개방요청 화면
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPrssAaPage.do")
    public String openInfPrssAaPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openinfprssaa";
    }

    /**
     * 공공데이터 개방승인 화면
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPrssAkPage.do")
    public String openInfPrssAkPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openinfprssak";
    }

    /**
     * 공공데이터 개방취소요청 화면
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPrssCaPage.do")
    public String openInfPrssCaPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openinfprssca";
    }

    /**
     * 공공데이터 개방취소승인 화면
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPrssCkPage.do")
    public String openInfPrssCkPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openinfprssck";
    }

    /**
     * 공공데이터 개방 화면 조회
     *
     * @param openInf
     * @param model
     * @return IBSheetListVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPrssListAll.do")
    @ResponseBody
    public IBSheetListVO<OpenInf> openInfPrssListAll(@ModelAttribute("searchVO") OpenInf openInf, ModelMap model) {
        //페이징 처리와 IbSheet 헤더 정렬은 반드시 *IbPaging 메소드명을 사용해야함(AOP 사용)
        Map<String, Object> map = openInfPrssService.selectOpenInfPrssListAllIbPaging(openInf);
        @SuppressWarnings("unchecked")
        List<OpenInf> result = (List<OpenInf>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInf>(result, cnt);
    }

    /**
     * 공공데이터 개방요청 단건 조회
     *
     * @param openInf
     * @param model
     * @return TABListVo<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPrssDtl.do")
    @ResponseBody
    public TABListVo<OpenInf> openInfPrssDtl(@RequestBody OpenInf openInf, ModelMap model) {
        return new TABListVo<OpenInf>(openInfPrssService.selectOpenInfPrssDtl(openInf));
    }

    /**
     * 공공데이터 개방요청 저장
     *
     * @param saveVO
     * @param model
     * @return IBSResultVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfPrssReg.do")
    @ResponseBody
    public IBSResultVO<OpenInf> openInfPrssReg(OpenInf openInf, ModelMap model) {
        int result = 0;
        result = openInfPrssService.openInfPrssRegCUD(openInf, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<OpenInf>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 공공데이터 요청기록 팝업 화면
     *
     * @param model
     * @return String
     */
    @RequestMapping("/admin/openinf/popup/openInfPrssLogPop.do")
    public String openInfPrssLogPop(ModelMap model, String infId) {
        model.addAttribute("infId", infId);
        return "/admin/openinf/popup/openinfprsslog_pop";
    }

    /**
     * 공공데이터 요청기록 팝업 화면 조회
     *
     * @param openInf
     * @param model
     * @return IBSheetListVO<OpenInf>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/popup/openInfPrssLogPopList.do")
    @ResponseBody
    public IBSheetListVO<OpenInf> openInfPrssLogPopList(@ModelAttribute("searchVO") OpenInf openInf, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openInfPrssService.selectOpenInfPrssLogIbPaging(openInf);
        @SuppressWarnings("unchecked")
        List<OpenInf> result = (List<OpenInf>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInf>(result, cnt);
    }

}

package egovframework.portal.openapi.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Messagehelper;
import egovframework.ggportal.bbs.service.PortalBbsListService;
import egovframework.portal.infs.service.PortalInfsListService;
import egovframework.portal.main.service.PortalMainService;
import egovframework.portal.openapi.service.PortalOpenApiService;


@Controller
public class PortalOpenApiController extends BaseController {

    protected static final Log logger = LogFactory.getLog(PortalOpenApiController.class);

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource(name = "portalOpenApiService")
    protected PortalOpenApiService portalOpenApiService;

    @Resource(name = "portalInfsListService")
    protected PortalInfsListService portalInfsListService;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    @Resource(name = "portalMainService")
    private PortalMainService portalMainService;

    /**
     * 공공데이터 서비스를 관리하는 서비스
     */
    /*
	@Resource(name="portalOpenInfSrvService")
    private PortalOpenInfSrvService portalOpenInfSrvService;*/

    /**
     * Open API 메인페이지
     */
    @RequestMapping("/portal/openapi/main.do")
    public String mainNew(HttpServletRequest request, Model model) {

        Params params = getParams(request, false);

        Params bbsParam = new Params();

        // 공지사항
        bbsParam.put("bbsCd", "NOTICEAPI");
        model.addAttribute("noticeList", portalMainService.searchBbsList(bbsParam));

        // FAQ
        bbsParam.put("bbsCd", "FAQAPI");
        model.addAttribute("faqList", portalMainService.searchBbsList(bbsParam));

        // Q&A
        bbsParam.put("bbsCd", "QNAAPI");
        model.addAttribute("qnaList", portalMainService.searchBbsList(bbsParam));

        // 주간인기순위
        model.addAttribute("popularWeeklyList", portalMainService.selectOpenApiWeeklyPopularList(new Params()));

        // 월간인기순위
        model.addAttribute("popularMonthlyList", portalMainService.selectOpenApiMonthlyPopularList(new Params()));

        return "/portal/openapi/openApiMain";
    }

    /**
     * Open API 소개 - 소개
     */
    @RequestMapping("/portal/openapi/openApiIntroPage.do")
    public String openApiIntroPage(HttpServletRequest request, Model model) {
        return "/portal/openapi/openApiIntro";
    }

    /**
     * Open API 소개 - 특징
     */
    @RequestMapping("/portal/openapi/openApiFeaturePage.do")
    public String openApiFeaturePage(HttpServletRequest request, Model model) {
        return "/portal/openapi/openApiFeature";
    }

    /**
     * Open API 서비스 목록
     */
    @RequestMapping("/portal/openapi/openApiListPage.do")
    public String openApiListPage(HttpServletRequest request, Model model) {
        return "/portal/openapi/openApiList";
    }

    /**
     * Open API 서비스 목록 - 사무처
     */
    @RequestMapping("/portal/openapi/openApiNaListPage.do")
    public String openApiNaListPage(HttpServletRequest request, Model model) {
        model.addAttribute("schOrg", portalInfsListService.selectCommOrgTop(new Params()));    // 기관

        Params params = getParams(request, false);
        portalInfsListService.keepSearchParam(params, model);
;

        return "/portal/openapi/openApiNaList";
    }

    /**
     * Open API 개발 가이드 - 사용방법
     */
    @RequestMapping("/portal/openapi/openApiDevPage.do")
    public String openApiDevPage(HttpServletRequest request, Model model) {
        return "/portal/openapi/openApiDev";
    }

    /**
     * Open API 개발 가이드 - 개발소스예제
     */
    @RequestMapping("/portal/openapi/openApiDevSrcPage.do")
    public String openApiDevSrcPage(HttpServletRequest request, Model model) {
        return "/portal/openapi/openApiDevSrc";
    }

    /**
     * Open API 개발 가이드 - 언어별 개발가이드
     */
    @RequestMapping("/portal/openapi/openApiDevLangPage.do")
    public String openApiDevLangPage(HttpServletRequest request, Model model) {
        return "/portal/openapi/openApiDevLang";
    }

    /**
     * 인증키 발급내역 - 발급내역
     */
    @RequestMapping("/portal/openapi/openApiActKeyPage.do")
    public String openApiActKeyPage(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
		/*model.addAttribute("tabIdx", params.getInt("tabIdx", 0));
		model.addAttribute("menuCd");*/

        model.addAttribute("tabIdx", 0);
        return "/portal/openapi/openApiActKey";
    }

    /**
     * 인증키 발급내역 - 이용내역
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/openapi/openApiActKeyUsePage.do")
    public String openApiActKeyUsePage(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        model.addAttribute("tabIdx", 3);
        return "/portal/openapi/openApiActKeyUseList";
    }

    /**
     * 인증키 발급내역 - 인증키 발급
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/openapi/openApiActKeyIssPage.do")
    public String openApiActKeyIssPage(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        model.addAttribute("tabIdx", 1);
        return "/portal/openapi/openApiActKeyIss";
    }

    /**
     * 인증키 발급내역 - OPEN API 테스트
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/openapi/openApiActKeyTestPage.do")
    public String openApiActKeyTestPage(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        model.addAttribute("tabIdx", 2);
        return "/portal/openapi/openApiActKeyTest";
    }


    /**
     * Open API 전체목록을 검색한다.
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/openapi/searchOpenApiList.do")
    public String searchOpenApiList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // Open API 전체목록을 검색한다.
        Object result = portalOpenApiService.searchOpenApiList(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * Open API 목록을 조회한다.(국회사무처)
     */
    @RequestMapping("/portal/openapi/selectInfsOpenApiListPaging.do")
    public String selectInfsOpenApiListPaging(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // Open API 전체목록을 검색한다.
        Object result = portalOpenApiService.selectInfsOpenApiListPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);
        
   // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * Open API 서비스를 조회하는 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/openapi/selectServicePage.do")
    public String selectServicePage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 서비스 메타정보를 조회한다.
        Record result = portalOpenApiService.selectOpenApiSrvMetaCUD(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "/portal/openapi/openApiDetail";
    }

    /**
     * Open API 통계코드 검색
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/openapi/openApiGuideCdPage.do")
    public String openApiGuideCdPage(HttpServletRequest request, Model model) {
        return "/portal/openapi/openApiGuideCd";
    }

    /**
     * 통계코드를 검색한다.
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/openapi/selectOpenApiItmCd.do")
    public String selectOpenApiItmCd(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 통계코드를 검색한다.
        Object result = portalOpenApiService.selectOpenApiItmCd(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 타 기관제공 Oepn API 목록 페이지 이동
     */
    @RequestMapping("/portal/openapi/openApiSupplyListPage.do")
    public String openApiSupplyListPage(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        portalInfsListService.keepSearchParam(params, model);
        params.set("grpCd", "A8016");
        model.addAttribute("apiTagCd", statsMgmtService.selectOption(params));    // API 구분
        return "/portal/openapi/openApiSupplyList";
    }

    /**
     * 타 기관제공 Oepn API 목록을 조회한다.
     */
    @RequestMapping("/portal/openapi/selectOpenApiSupplyListPaging.do")
    public String selectOpenApiSupplyListPaging(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // Open API 전체목록을 검색한다.
        Object result = portalOpenApiService.selectOpenApiSupplyListPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 타 기관제공 Oepn API 엑셀 다운로드
     */
    @RequestMapping("/portal/openapi/excelOpenApiSupplyList.do")
    public ModelAndView excelOpenApiSupplyList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        ModelAndView modelAndView = new ModelAndView();
        Object result = portalOpenApiService.selectOpenApiSupplyList(params);

        modelAndView.addObject("result", result);
        modelAndView.addObject("pageType", "SP");
        modelAndView.setViewName("/portal/openapi/excelOpenApi");

        return modelAndView;
    }


    /**
     * 참여형 플랫폼 메인페이지
     */
    @RequestMapping("/portal/gallery/galleryMainPage.do")
    public String galleryMainPage(HttpServletRequest request, Model model) {

        Params params = getParams(request, false);

        // 활용가이드
        model.addAttribute("guideList", (List<Record>) portalOpenApiService.selectGuideList(params));

        return "/portal/openapi/galleryMain";
    }

}
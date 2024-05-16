package egovframework.admin.expose.web;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.expose.service.AdminExposeInfoService;
import egovframework.admin.expose.service.AdminStatsPresentService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * 정보공개관리 > 통계/현황  클래스
 *
 * @author Softon
 * @version 1.0
 * @since 2019/08/12
 */
@Controller
public class AdminStatsPresentController extends BaseController {

    @Resource(name = "adminStatsPresentService")
    protected AdminStatsPresentService adminStatsPresentService;

    @Resource(name = "adminExposeInfoService")
    protected AdminExposeInfoService adminExposeInfoService;

    /**
     * 청구서 처리현황 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statAplDealPage.do")
    public String statAplDealPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statAplDeal";
    }

    /**
     * 청구서 처리현황  조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statAplDeal.do")
    public String statAplDeal(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statAplDeal(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }


    /**
     * 청구방법별 현황 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statAplTakMthPage.do")
    public String statAplTakMthPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statAplTakMth";
    }

    /**
     * 청구방법별 현황 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statAplTakMth.do")
    public String statAplTakMth(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statAplTakMth(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }


    /**
     * 공개방법별 현황 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statAplOpbFomPage.do")
    public String statAplOpbFomPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statAplOpbFom";
    }

    /**
     * 공개방법별 현황 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statAplOpbFom.do")
    public String statAplOpbFom(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statAplOpbFom(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 비공개(부분공개)사유별현황 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statClsdRsonPage.do")
    public String statClsdRsonPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statClsdRson";
    }

    /**
     * 비공개(부분공개)사유별현황 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statClsdRson.do")
    public String statClsdRson(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statClsdRson(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 이의신청서처리 현황 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statObjtnDealPage.do")
    public String statObjtnDealPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statObjtnDeal";
    }

    /**
     * 이의신청서처리 현황  조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statObjtnDeal.do")
    public String statObjtnDeal(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statObjtnDeal(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 처리현황 목록 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statAplResultPage.do")
    public String statAplResultPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statAplResult";
    }

    /**
     * 정보공개 처리현황 목록  조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statAplResult.do")
    public String statAplResult(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statAplResultPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 이의신청처리 현황 목록 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statObjtnDealRsltPage.do")
    public String statObjtnDealRsltPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statObjtnDealRslt";
    }

    /**
     * 이의신청처리 현황 목록  조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statObjtnDealRslt.do")
    public String statObjtnDealRslt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statObjtnDealRsltPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 결정통지서 기간별출력 목록 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/printAplDcsPage.do")
    public String printAplDcsPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/printAplDcs";
    }

    /**
     * 공개여부 결정기간별 현황 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/statAplDcsDtPage.do")
    public String statAplDcsDtPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/statAplDcsDt";
    }

    /**
     * 공개여부 결정기간별 현황  조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/statAplDcsDt.do")
    public String statAplDcsDt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.statAplDcsDt(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공개여부 결정기간별 현황(청구서 조회)
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/selectAplDcsdtList.do")
    public String selectAplDcsdtList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.selectAplDcsdtListPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개청구서 접근기록 목록 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/acsOpnzAplPage.do")
    public String acsOpnzAplPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        // 처리상태
        params.put("lclsCd", "D");
        model.addAttribute("prgStatCodeList", adminExposeInfoService.selectComCode(params));


        return "/admin/expose/acsOpnzAplList";
    }

    /**
     * 정보공개청구서 접근기록 목록  조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/acsOpnzAplList.do")
    public String acsOpnzAplList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminStatsPresentService.selectAcsOpnzAplListPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

}

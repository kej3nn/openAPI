package egovframework.admin.expose.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.expose.service.AdminExposeInfoService;
import egovframework.admin.expose.service.AdminOpenDecisionService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.helper.TABListVo;

/**
 * 정보공개관리 > 공개결정통보내역  클래스
 *
 * @author SoftOn
 * @version 1.0
 * @since 2019/08/12
 */
@Controller
public class AdminOpenDecisionController extends BaseController {

    @Resource(name = "adminExposeInfoService")
    protected AdminExposeInfoService adminExposeInfoService;

    @Resource(name = "adminOpenDecisionService")
    protected AdminOpenDecisionService adminOpenDecisionService;

    /**
     * 공개결정통보내역 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/searchOpnDcsPage.do")
    public String searchOpnDcsPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        //신청번호가 넘어오면 조회후 탭을 연다.
        model.addAttribute("openAplNo", params.get("aplNo"));

        // 처리기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        // 처리상태
        params.put("lclsCd", "D");
        model.addAttribute("prgStatCodeList", adminExposeInfoService.selectComCode(params));

        // 공개여부
        params.put("lclsCd", "A");
        model.addAttribute("lclsCodeList", adminExposeInfoService.selectComCode(params));

        return "/admin/expose/searchOpnDcs";
    }

    /**
     * 공개결정통보내역 페이지 이동 > 공개결정통보 상세탭 오픈
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/searchOpnDcsPage/{openAplNo}.do")
    public String searchOpnDcsPage(@PathVariable("openAplNo") String openAplNo, ModelMap model) {
        model.addAttribute("openAplNo", openAplNo);
        // 파라메터를 가져온다.
        Params params = new Params();

        debug("Request parameters: " + params);

        // 처리기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        // 처리상태
        params.put("lclsCd", "D");
        model.addAttribute("prgStatCodeList", adminExposeInfoService.selectComCode(params));

        // 공개여부
        params.put("lclsCd", "A");
        model.addAttribute("lclsCodeList", adminExposeInfoService.selectComCode(params));

        return "/admin/expose/searchOpnDcs";
    }

    /**
     * 공개결정통보내역  리스트 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/searchOpnDcs.do")
    public String searchOpnDcs(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("searchOpnDcs Request parameters: " + params);

        //관리구분 >  로그인 사용자 정보에서 session에 담아서 전달 할 필요가 있슴
        params.put("usr_div", "0");
        //처리기관 >  로그인 사용자 정보에서 session에 담아서 전달 할 필요가 있슴
        params.put("usr_instcd", null);

        debug("Request parameters: " + params);

        Object result = adminOpenDecisionService.searchOpnDcsPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공개결정통보내역
     *
     * @param paramMap
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/detailOpnDcs.do")
    @ResponseBody
    public TABListVo<Map<String, Object>> detailOpnDcs(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {

        String prgStatCd = paramMap.get("prgStatCd");

        Map<String, Object> map = new HashMap<String, Object>();
        if (prgStatCd.equals("03") || prgStatCd.equals("05")) { //정보공개접수 조회
            map = adminOpenDecisionService.writeOpnDcs(paramMap);
        } else { //상세 조회
            map = adminOpenDecisionService.detailOpnDcs(paramMap);
        }
        return new TABListVo<Map<String, Object>>(map.get("DATA"), map.get("DATA2"));
    }

    /**
     * 공개결정통보내역 데이터를 저장한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/saveOpnDcs.do")
    public String saveOpnDcs(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공개결정통보내역 데이터를 등록
        Object result = adminOpenDecisionService.saveOpnDcs(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공개결정통보내역 공개실시
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/openStartOpnDcs.do")
    public String openStartOpnDcs(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공개결정통보내역 공개실시
        Object result = adminOpenDecisionService.openStartOpnDcs(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 청구/이의신청  출력
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping(value = "/admin/expose/reportingPage/{printId}.do")
    public ModelAndView reportingPage(@PathVariable("printId") String printId, HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();


        //관리자 세션 검증
        //if((String) session.getAttribute("loginName") != null) {	//세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        if (params.getString("apl_no") != null && !params.get("mrdParam").equals("")) {
            params.put("aplNo", params.getString("apl_no"));
            params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
            params.put("apl_rno2", (String) session.getAttribute("loginRno2"));

            modelAndView.addObject("width", params.get("width"));
            modelAndView.addObject("height", params.get("height"));
            modelAndView.addObject("title", params.get("title"));
            modelAndView.addObject("mrdParam", params.get("mrdParam"));

            modelAndView.addObject("mrdPath", EgovProperties.getProperty("Globals." + printId));
        } else {
            String msg = "비정상적 접근입니다.";
            modelAndView.addObject("msg", msg);
        }

        modelAndView.setViewName("/soportal/expose/rdCommon");
        //}
        return modelAndView;
    }

    /**
     * 이전데이터로 팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/opnCancelPopup.do")
    public String opnCancelPopup(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Map<String, Object> opnAplDo = adminExposeInfoService.getInfoOpenApplyDetail(params);

        model.addAttribute("opnAplDo", opnAplDo);
        model.addAttribute("cType", params.get("cType"));

        return "/admin/expose/popup/opnCancelPopup";
    }

    /**
     * 이전데이터로 전환처리
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/cancelOpnProd.do")
    public String cancelOpnProd(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);


        debug("Request parameters: " + params);

        Object result = adminOpenDecisionService.cancelOpnProd(request, params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 부서정보 검색
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/infoOrgPop.do")
    public String infoOrgPop(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);


        debug("infoOrgPop Request parameters: " + params);

        addObject(model, params);

        return "/admin/expose/popup/infoOrgPopup";
    }

    /**
     * 부서정보 팝업 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/expose/popup/infoOrgPopList.do")
    public String infoOrgPopList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("infoOrgPopList Request parameters: " + params);

        Object result = adminExposeInfoService.infoOrgPopList(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

}

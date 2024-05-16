package egovframework.admin.expose.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.expose.service.AdminExposeInfoService;
import egovframework.admin.expose.service.AdminOpenObjectionService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.helper.TABListVo;

/**
 * 정보공개관리 > 이의신청관리  클래스
 *
 * @author SoftOn
 * @version 1.0
 * @since 2019/08/12
 */
@Controller
public class AdminOpenObjectionController extends BaseController {

    @Resource(name = "adminExposeInfoService")
    protected AdminExposeInfoService adminExposeInfoService;

    @Resource(name = "adminOpenObjectionService")
    protected AdminOpenObjectionService adminOpenObjectionService;

    /**
     * 오프라인 이의신청 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/searchOpnObjtnPage.do")
    public String searchOpnObjtnPage(ModelMap model) {
        // 파라메터를 가져온다.
        Params params = new Params();

        debug("Request parameters: " + params);

        return "/admin/expose/searchOpnObjtn";
    }

    /**
     * 오프라인 이의신청 가능내역 리스트 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/searchOpnObjtn.do")
    public String searchOpnObjtn(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        //관리구분 >  로그인 사용자 정보에서 session에 담아서 전달 할 필요가 있슴
        params.put("usr_div", "0");
        //처리기관 >  로그인 사용자 정보에서 session에 담아서 전달 할 필요가 있슴
        params.put("usr_instcd", null);

        debug("Request parameters: " + params);

        Object result = adminOpenObjectionService.searchOpnObjtnPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 오프라인 이의신청 작성 기본정보 호출
     *
     * @param paramMap
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/writeOpnObjtn.do")
    @ResponseBody
    public TABListVo<Map<String, Object>> writeOpnObjtn(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
        debug("writeOpnObjtn paramMap: " + paramMap);

        Map<String, Object> map = new HashMap<String, Object>();
        map = adminOpenObjectionService.writeOpnObjtn(paramMap);
        return new TABListVo<Map<String, Object>>(map.get("DATA"), map.get("DATA2"));
    }

    /**
     * 오프라인 이의신청 데이터를 저장한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/saveOpnObjtn.do")
    public String saveOpnObjtn(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = adminOpenObjectionService.saveOpnObjtn(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 이의신청내역 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/searchOpnObjtnProcPage.do")
    public String searchOpnObjtnProcPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 처리기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        return "/admin/expose/searchOpnObjtnProc";
    }

    /**
     * 이의신청내역 리스트 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/searchOpnObjtnProc.do")
    public String searchOpnObjtnProc(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        //관리구분 >  로그인 사용자 정보에서 session에 담아서 전달 할 필요가 있슴
        params.put("usr_div", "0");
        //처리기관 >  로그인 사용자 정보에서 session에 담아서 전달 할 필요가 있슴
        params.put("usr_instcd", null);

        debug("Request parameters: " + params);

        Object result = adminOpenObjectionService.searchOpnObjtnProcPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 이의신청내역
     *
     * @param paramMap
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/detailOpnObjtnProc.do")
    @ResponseBody
    public TABListVo<Map<String, Object>> detailOpnObjtnProc(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
        debug("detailOpnObjtnProc paramMap: " + paramMap);

        Map<String, Object> map = adminOpenObjectionService.detailOpnObjtnProc(paramMap);
        return new TABListVo<Map<String, Object>>(map.get("DATA"), map.get("DATA2"));
    }

    /**
     * 이의신청 데이터를 처리한다.(R:접수, C:취하)
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/comOpnObjtnProc.do")
    public String comOpnObjtnProc(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("comOpnObjtnProc Request parameters: " + params);

        Object result = adminOpenObjectionService.comOpnObjtnProc(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 이의신청 데이터를 처리한다.(S:저장) > 이의신청 결과등록
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/saveOpnObjtnProc.do")
    public String saveOpnObjtnProc(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("saveOpnObjtnProc Request parameters: " + params);

        Object result = adminOpenObjectionService.saveOpnObjtnProc(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 이의신청 결정기한연장  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/opnObjtnProdPopup.do")
    public String opnObjtnProdPopup(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        Map<String, Object> objtnDo = adminOpenObjectionService.searchObjtnDcsProd(params);

        model.addAttribute("objtnDo", objtnDo);

        return "/admin/expose/popup/opnObjtnProdPopup";
    }

    /**
     * 이의신청 결정기한연장
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/insertOpnObjtnProd.do")
    public String insertOpnObjtnProd(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);


        debug("Request parameters: " + params);

        Object result = adminOpenObjectionService.insertOpnObjtnProd(request, params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 이의신청 결과 공개실시
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/openStartOpnObjtn.do")
    public String openStartOpnObjtn(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공개결정통보내역 공개실시
        Object result = adminOpenObjectionService.openStartOpnObjtn(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

}

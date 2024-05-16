package egovframework.admin.nadata.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.nadata.service.NaCmpsService;
import egovframework.admin.nadata.service.NaDataSiteMapService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;

/**
 * 정보 카달로그를 관리하는 컨트롤러 클래스
 *
 * @author
 * @version 1.0
 * @since 2019/09/19
 */
@Controller
public class NaCmpsController extends BaseController {

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource(name = "naCmpsService")
    protected NaCmpsService naCmpsService;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    @Resource(name = "naDataSiteMapService")
    protected NaDataSiteMapService naDataSiteMapService;

    /**
     * 정보셋 관리 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/nadata/mgmt/naCmpsPage.do")
    public String naCmpsPage(ModelMap model) {

        Params params = new Params();

        params.set("grpCd", "A8011");
        model.addAttribute("srvInfoList", statsMgmtService.selectOption(params));    // 서비스정보

        params.set("grpCd", "A8010");
        model.addAttribute("srcSysList", statsMgmtService.selectOption(params));    // 원본시스템정보

        model.addAttribute("orgList", naDataSiteMapService.selectOrgList(params)); //기관정보

        return "/admin/nadata/mgmt/naCmps";
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @RequestMapping("/admin/nadata/mgmt/selectNaCmpsListPaging.do")
    public String selectNaCmpsListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = naCmpsService.selectNaCmpsListPaging(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 정보카탈로그 분류체계 팝업(검색용)으로 이동(iframe)
     */
    @RequestMapping("/admin/nadata/mgmt/popup/naSetCateSearchPop.do")
    public String naSetCateSearchPop(HttpServletRequest request, Model model) {
        return "/admin/nadata/mgmt/popup/naSetCateSearchPop";
    }

    /**
     * 정보카탈로그 분류체계 팝업으로 이동(iframe)
     */
    @RequestMapping("/admin/nadata/mgmt/popup/naSetCatePop.do")
    public String naSetCatePop(ModelMap model) {
        return "/admin/nadata/mgmt/popup/naSetCatePop";
    }

    /**
     * 정보카탈로그 ID 중복체크
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/nadata/mgmt/naCmpsDupChk.do")
    public String naCmpsDupChk(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naCmpsService.naCmpsDupChk(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 정보카탈로그 등록/수정
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/mgmt/saveNaCmps.do")
    public String saveNaCmps(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naCmpsService.saveNaCmps(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보카탈로그 상세 조회
     *
     * @param params
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/nadata/mgmt/naCmpsDtl.do")
    @ResponseBody
    public TABListVo<Record> naCmpsDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
        return new TABListVo<Record>(naCmpsService.naCmpsDtl(params));
    }

    /**
     * 정보카탈로그 썸네일 불러오기
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/nadata/mgmt/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = naCmpsService.selectNaCmpsThumbnail(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "imageView";
    }

    /**
     * 정보카탈로그 삭제
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/mgmt/deleteNaCmps.do")
    public String deleteNaCmps(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naCmpsService.deleteNaCmps(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보카탈로그 순서 저장
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/nadata/mgmt/saveNaCmpsOrder.do")
    public String saveNaCmpsOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = naCmpsService.saveNaCmpsOrder(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

}

package egovframework.admin.opendatamng.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.opendatamng.service.OpenDataMngService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 공공데이터관리  클래스
 *
 * @version 1.0
 * @since 2019/04/23
 */
@Controller
public class OpenDataMngController extends BaseController {

    @Resource(name = "openDataMngService")
    protected OpenDataMngService openDataMngService;

    /**
     * API 연계설정 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/opendata/openApiLinkageMngPage.do")
    public String openApiLinkageMngPage(ModelMap model) {

        return "/admin/opendatamng/openApiLinkageMng";
    }

    /**
     * API 연계설정 리스트 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendata/openApiLinkageMngList.do")
    @ResponseBody
    public IBSheetListVO<Map<String, Object>> openApiLinkageMngList(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        List<Map<String, Object>> list = openDataMngService.openApiLinkageMngListPaging(params);
        return new IBSheetListVO<Map<String, Object>>(list, list == null ? 0 : list.size());
    }

    /**
     * API 연계설정  상세 조회
     *
     * @param paramMap
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/opendata/openApiLinkageMngDtl.do")
    @ResponseBody
    public TABListVo<Map<String, Object>> openApiLinkageMngDtl(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
        Params params = getParams(request, true);
        return new TABListVo<Map<String, Object>>(openDataMngService.openApiLinkageMngDtl(paramMap));
    }

    /**
     * API 연계설정  저장 데이터셋 팝업으로 이동(iframe)
     */
    @RequestMapping("/admin/opendata/popup/openApiLinkDsPopup.do")
    public String openApiLinkDsPopup(HttpServletRequest request, Model model) {
        return "admin/opendatamng/popup/openApiLinkDsPopup";
    }

    /**
     * API 연계설정  저장 데이터셋 데이터 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/opendata/popup/selectOpenApiLinkDsPopup.do")
    @ResponseBody
    public IBSheetListVO<Map<String, Object>> selectOpenApiLinkDsPopup(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        List<Map<String, Object>> list = openDataMngService.selectOpenApiLinkDsPopup(params);
        return new IBSheetListVO<Map<String, Object>>(list, list == null ? 0 : list.size());
    }

    /**
     * API 연계설정  대상객체(통계데이터) 팝업으로 이동(iframe)
     */
    @RequestMapping("/admin/opendata/popup/openApiLinkObjSPopup.do")
    public String openApiLinkObjSPopup(HttpServletRequest request, Model model) {
        return "admin/opendatamng/popup/openApiLinkObjSPopup";
    }

    /**
     * API 연계설정  대상객체(통계데이터) 데이터 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/opendata/popup/selectOpenApiLinkObjSPopup.do")
    @ResponseBody
    public IBSheetListVO<Map<String, Object>> selectOpenApiLinkObjSPopup(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        List<Map<String, Object>> list = openDataMngService.selectOpenApiLinkObjSPopup(params);
        return new IBSheetListVO<Map<String, Object>>(list, list == null ? 0 : list.size());
    }

    /**
     * API 연계설정을 등록한다.
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendata/insertOpenApiLinkageMng.do")
    public String insertOpenApiLinkageMng(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);

        debug("Request parameters: " + params);

        Object result = openDataMngService.saveOpenApiLinkageMng(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * API 연계설정을 수정한다.
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendata/updateOpenApiLinkageMng.do")
    public String updateOpenApiLinkageMng(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);

        debug("Request parameters: " + params);

        Object result = openDataMngService.saveOpenApiLinkageMng(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * API 연계설정을 삭제한다.
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendata/deleteOpenApiLinkageMng.do")
    public String deleteOpenApiLinkageMng(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);

        debug("Request parameters: " + params);

        Object result = openDataMngService.saveOpenApiLinkageMng(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * API연계모니터링 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/opendata/openApiLinkageMonPage.do")
    public String openApiLinkageMonPage(ModelMap model) {
        Params params = new Params();
        params.set("grpCd", "D1109");
        model.addAttribute("jobTagCdList", openDataMngService.selectOption(params));

        return "/admin/opendatamng/openApiLinkageMon";
    }

    /**
     * API연계모니터링 리스트 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendata/openApiLinkageMonList.do")
    @ResponseBody
    public IBSheetListVO<Map<String, Object>> openApiLinkageMonList(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        List<Map<String, Object>> list = openDataMngService.openApiLinkageMonListPaging(params);
        return new IBSheetListVO<Map<String, Object>>(list, list == null ? 0 : list.size());
    }

}

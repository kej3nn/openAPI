package egovframework.admin.openapi.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.openapi.service.OpenApiMngService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;

/**
 * 제공 OPENAPI를 관리하는 컨트롤러 클래스
 *
 * @author
 * @version 1.0
 * @since 2020/09/10
 */
@Controller
public class OpenApiMngController extends BaseController {

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    @Resource(name = "openApiMngService")
    protected OpenApiMngService openApiMngService;

    /**
     * 제공 openapi 관리 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/openapi/openApiPage.do")
    public String openApiPage(ModelMap model) {

        Params params = new Params();

        params.set("grpCd", "A8016");
        model.addAttribute("apiGubunList", statsMgmtService.selectOption(params));    // API 구분코드

        model.addAttribute("orgList", openApiMngService.selectOrgList(params)); //기관정보

        return "/admin/openapi/openApiMng";
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @RequestMapping("/admin/openapi/selectOpenApiMngListPaging.do")
    public String selectOpenApiMngListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openApiMngService.selectOpenApiMngListPaging(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 제공 OPENAPI 등록/수정
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openapi/saveOpenApiMng.do")
    public String saveOpenApiMng(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = openApiMngService.saveOpenApiMng(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 제공 OPENAPI 상세 조회
     *
     * @param params
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/openapi/openApiMngDtl.do")
    @ResponseBody
    public TABListVo<Record> openApiMngDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
        return new TABListVo<Record>(openApiMngService.openApiMngDtl(params));
    }

    /**
     * 제공 OPENAPI 삭제
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openapi/deleteOpenApiMng.do")
    public String deleteOpenApiMng(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = openApiMngService.deleteOpenApiMng(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

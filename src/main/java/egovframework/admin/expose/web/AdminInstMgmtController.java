package egovframework.admin.expose.web;

/**
 * 기관관리를 위한 Controller
 *
 * @author JIS
 * @since 2019.08.27
 */


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.expose.service.AdminInstMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

@Controller
public class AdminInstMgmtController extends BaseController {

    @Resource(name = "AdminInstMgmtService")
    private AdminInstMgmtService instMgmtService;


    /**
     * 기관관리 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/instMgmtPage.do")
    public String instMgmtPage(ModelMap model) {
        return "/admin/expose/instMgmt";
    }

    /**
     * 조직정보 목록트리 조회.
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/expose/instMgmtListTree.do")
    public String instMgmtListTree(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = instMgmtService.instMgmtListTree(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        return "jsonView";
    }

    /**
     * 신규등록
     *
     * @param instMgmt
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/instMgmtReg.do")
    public String instMgmtReg(HttpServletRequest request, Model model) {
        //파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = instMgmtService.saveInstMgmt(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 조직정보 단건 조회
     *
     * @param instMgmt
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/instMgmtRetr.do")
    public String instMgmtRetv(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = instMgmtService.instMgmtRetr(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보 썸네일 불러오기
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/expose/selectInstMgmtThumbnail.do")
    public String selectInstMgmtThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = instMgmtService.selectInstMgmtThumbnail(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "imageView";
    }
}

package egovframework.admin.dev.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.dev.service.AdminDevService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.helper.Messagehelper;

@Controller
public class AdminDevController extends BaseController {

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource(name = "adminDevService")
    protected AdminDevService adminDevService;

    /**
     * 개발자 관리 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/dev/devMngPage.do")
    public String devMngPage(ModelMap model) {
        Params params = new Params();

        return "/admin/dev/devMng";
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @RequestMapping("/admin/dev/selectDevMngListPaging.do")
    public String selectDevMngListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = adminDevService.selectDevMngListPaging(params);
        addObject(model, result);

        return "jsonView";
    }

    /**
     * 메일, 카카오톡,sms 전송
     *
     * @param requeststatInputCmmtPop
     * @param model
     * @return
     */
    @RequestMapping("/admin/dev/insertDevReceive.do")
    public String insertDevReceive(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminDevService.insertDevReceive(params);

        debug("Processing results: " + result);

        addObject(model, result);    // 모델에 객체를 추가한다.

        return "jsonView";
    }

}

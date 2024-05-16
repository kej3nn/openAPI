package egovframework.admin.basicinf.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.basicinf.service.CommTermService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * 관리자 - 동의어 관리 컨트롤러 클래스
 *
 * @version 1.0
 * @author JHKIM
 * @since 2019/11/12
 */
@Controller
public class CommTermController extends BaseController {

    @Resource(name = "commTermService")
    private CommTermService commTermService;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    /**
     * 페이지로 이동한다.
     */
    @RequestMapping("/admin/basicinf/commTermPage.do")
    public String commTermPage(HttpServletRequest request, Model model) {
        Params params = new Params();
        params.set("grpCd", "C1017");
        model.addAttribute("termGubun", statsMgmtService.selectOption(params));        // 용어구분

        return "/admin/basicinf/commTerm";
    }

    /**
     * 데이터를 조회한다. - 페이징
     */
    @RequestMapping("/admin/basicinf/searchCommTerm.do")
    public String searchCommTerm(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = commTermService.searchCommTerm(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 데이터를 조회한다.
     */
    @RequestMapping("/admin/basicinf/selectCommTerm.do")
    public String selectCommTerm(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = commTermService.selectCommTerm(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 데이터를 저장한다. (CUD)
     */
    @RequestMapping("/admin/basicinf/saveCommTerm.do")
    public String saveCommTerm(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = commTermService.saveCommTerm(params);

        addObject(model, result);

        return "jsonView";
    }
}

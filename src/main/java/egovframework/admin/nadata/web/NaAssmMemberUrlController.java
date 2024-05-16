package egovframework.admin.nadata.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.basicinf.service.CommTermService;
import egovframework.admin.nadata.service.NaAssmMemberUrlService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 관리자 - 국회의원 URL 관리 컨트롤러 클래스
 *
 * @version 1.0
 * @author JHKIM
 * @since 2020/11/11
 */
@Controller
public class NaAssmMemberUrlController extends BaseController {

    @Resource(name = "naAssmMemberUrlService")
    private NaAssmMemberUrlService naAssmMemberUrlService;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    /**
     * 페이지로 이동한다.
     */
    @RequestMapping("/admin/nadata/assm/naAssmMemberUrlPage.do")
    public String naAssmMemberUrlPage(HttpServletRequest request, Model model) {
        Params params = new Params();
        params.set("grpCd", "C1017");
        model.addAttribute("termGubun", statsMgmtService.selectOption(params));        // 용어구분

        return "/admin/nadata/assm/naAssmMemberUrl";
    }

    /**
     * 데이터를 조회한다. - 페이징
     */
    @RequestMapping("/admin/nadata/assm/searchNaAssmMemberUrl.do")
    public String searchNaAssmMemberUrl(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object list = naAssmMemberUrlService.searchNaAssmMemberUrl(params);

        addObject(model, list);

        return "jsonView";
    }

    /**
     * 데이터를 저장한다. (CUD)
     */
    @RequestMapping("/admin/nadata/assm/saveNaAssmMemberUrl.do")
    public String saveNaAssmMemberUrl(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = naAssmMemberUrlService.saveNaAssmMemberUrl(params);

        addObject(model, result);

        return "jsonView";
    }
}

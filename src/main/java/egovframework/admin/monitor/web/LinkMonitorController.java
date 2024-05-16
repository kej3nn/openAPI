package egovframework.admin.monitor.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.monitor.service.LinkMonitorService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * JBO 모니터링 화면 컨트롤러 클래스
 *
 * @version 1.0
 * @author JSSON
 * @since 2019/10/01
 */
@Controller
public class LinkMonitorController extends BaseController {

    protected static final Log logger = LogFactory.getLog(LinkMonitorController.class);

    @Resource(name = "linkMonitorService")
    protected LinkMonitorService linkMonitorService;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    /**
     * 연계 모니터링 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */

    @RequestMapping(value = "/admin/monitor/linkMonitorPage.do")
    public String linkMonitorPage(ModelMap model) {
        Params params = new Params();

        params.set("grpCd", "C10124");
        model.addAttribute("jobTagCd", statsMgmtService.selectOption(params)); // 작업구분코드

        params.set("grpCd", "A10124");
        model.addAttribute("srcSysCd", statsMgmtService.selectOption(params)); // 작업구분코드


        return "/admin/monitor/linkMonitor";
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */

    @RequestMapping(value = "/admin/monitor/linkMonitorListPaging.do")
    public String linkMonitorListPaging(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = linkMonitorService.selectLinkMonitorListPaging(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }


}

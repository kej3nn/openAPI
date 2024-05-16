package egovframework.admin.monitor.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.monitor.service.CycleInputMonitorService;
import egovframework.admin.monitor.service.OpenInputMonitorService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * JBO 모니터링 화면 컨트롤러 클래스
 *
 * @author JSSON
 * @version 1.0
 * @since 2019/10/01
 */
@Controller
public class CycleInputMonitorController extends BaseController {

    protected static final Log logger = LogFactory.getLog(CycleInputMonitorController.class);

    @Resource(name = "cycleInputMonitorService")
    protected CycleInputMonitorService cycleInputMonitorService;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    /**
     * 연계 모니터링 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */

    @RequestMapping(value = "/admin/monitor/cycleInputMonitorPage.do")
    public String cycleInputMonitorPage(ModelMap model) {
        Params params = new Params();
        params.set("grpCd", "D1009");
        model.addAttribute("loadCdList", cycleInputMonitorService.selectOption(params));        //입력주기

        return "/admin/monitor/cycleInputMonitor";
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */

    @RequestMapping(value = "/admin/monitor/cycleInputMonitorListPaging.do")
    public String cycleInputMonitorListPaging(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = cycleInputMonitorService.selectCycleInputMonitorListPaging(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }

    /**
     * 차트 조회
     */

    @RequestMapping(value = "/admin/monitor/cycleInputMonitorChart.do")
    public String cycleInputMonitorChart(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = cycleInputMonitorService.cycleInputMonitorChart(params);


        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }


}

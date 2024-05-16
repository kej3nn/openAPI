package egovframework.admin.monitor.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.monitor.service.StatInputMonitorService;
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
public class StatInputMonitorController extends BaseController {

    protected static final Log logger = LogFactory.getLog(StatInputMonitorController.class);

    @Resource(name = "statInputMonitorService")
    protected StatInputMonitorService statInputMonitorService;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    /**
     * 연계 모니터링 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */

    @RequestMapping(value = "/admin/monitor/statInputMonitorPage.do")
    public String statInputMonitorPage(ModelMap model) {
        Params params = new Params();


        return "/admin/monitor/statInputMonitor";
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */

    @RequestMapping(value = "/admin/monitor/statInputMonitorListPaging.do")
    public String statInputMonitorListPaging(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = statInputMonitorService.selectStatInputMonitorListPaging(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }

    /**
     * 차트 조회
     */

    @RequestMapping(value = "/admin/monitor/statInputMonitorChart.do")
    public String statInputMonitorChart(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = statInputMonitorService.statInputMonitorChart(params);


        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }

    /**
     * 담당부서별 차트 조회
     * @throws Exception 
     * @throws DataAccessException 
     */

    @RequestMapping(value = "/admin/stat/selectOpenInputMonitorstatblList.do")
    public String selectOpenInputMonitorstatblList(HttpServletRequest request, Model model) throws DataAccessException, Exception {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = statInputMonitorService.selectOpenInputMonitorstatblList(params);


        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }
    
    /**
     * 담당부서별 차트 조회
     * @throws Exception 
     * @throws DataAccessException 
     */

    @RequestMapping(value = "/admin/stat/selectOpenInputMonitorwrtOrgList.do")
    public String selectOpenInputMonitorDsList(HttpServletRequest request, Model model) throws DataAccessException, Exception {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = statInputMonitorService.selectOpenInputMonitorwrtOrgList(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }

}

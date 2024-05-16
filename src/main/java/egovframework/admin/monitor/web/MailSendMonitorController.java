package egovframework.admin.monitor.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.monitor.service.MailSendMonitorService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * 메일전송 모니터링 화면 컨트롤러 클래스
 *
 * @version 1.0
 * @author JHKIM
 * @since 2021/03/31
 */
@Controller
public class MailSendMonitorController extends BaseController {

    protected static final Log logger = LogFactory.getLog(MailSendMonitorController.class);

    @Resource(name = "mailSendMonitorService")
    protected MailSendMonitorService mailSendMonitorService;

    /**
     * 메일전송 모니터링 화면으로 이동한다.
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/monitor/mailSendMonitorPage.do")
    public String mailSendMonitorPage(ModelMap model) {

        return "/admin/monitor/mailSendMonitor";
    }

    /**
     * 메일전송 모니터링 페이징 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/monitor/mailSendMonListPaging.do")
    public String mailSendMonList(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = mailSendMonitorService.selectMailMonitorListPaging(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";
    }

    /**
     * 메세지를 재전송 한다.
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/monitor/insertMailReSend.do")
    public String insertMailReSend(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        log.info(params);
        Object result = mailSendMonitorService.insertMailReSend(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";
    }
}

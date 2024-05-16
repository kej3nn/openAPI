package egovframework.portal.mailing.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.mailing.service.PortalMailingService;
import egovframework.portal.main.service.PortalMainService;

/**
 * 메일링 컨트롤러 클래스
 * 
 * @author SBCHOI
 * @version 1.0 2019/11/25
 */
@Controller
public class PortalMailingController extends BaseController {
	@Resource(name="portalMailingService")
	private PortalMailingService portalMailingService;
	
	@Resource(name="portalMainService")
	private PortalMainService portalMainService;
	
	@RequestMapping("/portal/mailing/mailingPage.do")
    public String mainPage(HttpServletRequest request, Model model) {
		
		Params params = new Params();
		
		// 국회는 지금
		model.addAttribute("nowList", portalMainService.selectAssmNowList(params));
		
		// 국회문화 행사
		model.addAttribute("cultureList", portalMailingService.selectCultureList(params)); 
		
		// 날짜 조회
		model.addAttribute("weekList", portalMailingService.selectWeekDateList(params)); 
		
        return "/portal/mailing/mailing";
    }
	
	/**
	 * 인기공개정보 조회
	 */
	@RequestMapping("/portal/mailing/selectPplrInfoRank.do")
    public String selectPplrInfoRank(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMailingService.selectPplrInfoRank(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 국회 주간일정 조회
	 */
	@RequestMapping("/portal/mailing/selectNaScheduleList.do")
    public String selectNaScheduleList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMailingService.selectNaScheduleList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
}

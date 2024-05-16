package egovframework.portal.bpm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.bpm.service.BpmDateService;

/**
 * 의정활동별 공개 - 날짜별 의정활동 공개 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Controller
public class BpmDateController extends BaseController {
	
	@Resource(name="bpmDateService")
	private BpmDateService bpmDateService;

	@RequestMapping("/portal/bpm/date/dateMstPage.do")
	public String dateMstPage(HttpServletRequest request, Model model) {
		return "/portal/bpm/date/dateMst";
	}
	
	/**
	 * 날짜별 의정활동 조회
	 */
	@RequestMapping("/portal/bpm/date/searchDate.do")
	public String searchDate(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmDateService.searchDate(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	/**
	 * 캘린더 데이터 조회(월단위로)
	 */
	@RequestMapping("/portal/bpm/date/searchDateCalendar.do")
	public String searchDateCalendar(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmDateService.searchDateCalendar(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
}

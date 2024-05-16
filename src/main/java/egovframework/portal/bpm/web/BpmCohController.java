package egovframework.portal.bpm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.bpm.service.BpmCohService;

/**
 * 의정활동별 공개 - 인사청문회 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Controller
public class BpmCohController extends BaseController {

	@Resource(name="bpmCohService")
	private BpmCohService bpmCohService;
	
	@RequestMapping("/portal/bpm/coh/cohMstPage.do")
	public String cohMstPage(HttpServletRequest request, Model model) {
		return "/portal/bpm/coh/cohMst";
	}
	
	/**
	 * 인사청문회 조회
	 */
	@RequestMapping("/portal/bpm/coh/searchCoh.do")
	public String searchCoh(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCohService.searchCoh(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
}

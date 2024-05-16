package egovframework.portal.bpm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmLawmService;
import egovframework.portal.assm.service.AssmMemberService;
import egovframework.portal.bpm.service.BpmPrcService;

/**
 * 의정활동별 공개 - 본회의 안건처리 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Controller
public class BpmPrcController extends BaseController {

	@Resource(name="bpmPrcService")
	private BpmPrcService bpmPrcService;
	
	@Resource(name="AssmLawmService")
	private AssmLawmService assmLawmService;
	
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	@RequestMapping("/portal/bpm/prc/prcMstPage.do")
	public String prcMstPage(HttpServletRequest request, Model model) {
		
		// UNIT_CD 입력
//		assmMemberService.selectAssmMaxUnit(model, "");
				
		Params codeParams = new Params();
		
		// 의안처리결과
		codeParams.put("gCmCd", "RESULT");
		model.addAttribute("codeProcResult", assmLawmService.searchAssmLawmCommCd(codeParams));	
		
		
		return "/portal/bpm/prc/prcMst";
	}
	
	/**
	 * 본회의 일정 조회
	 */
	@RequestMapping("/portal/bpm/prc/searchPrcDate.do")
	public String searchPrcDate(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmPrcService.searchPrcDate(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 본회의 안건처리 - 법률안, 기타 데이터 조회
	 */
	@RequestMapping("/portal/bpm/prc/searchPrcItmPrcLaw.do")
	public String searchPrcItmPrcLaw(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmPrcService.searchPrcItmPrcLaw(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 본회의 안건처리 - 예산안, 결산 데이터 조회
	 */
	@RequestMapping("/portal/bpm/prc/searchPrcItmPrcBdg.do")
	public String searchPrcItmPrcBdg(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmPrcService.searchPrcItmPrcBdg(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 본회의 회의록 조회
	 */
	@RequestMapping("/portal/bpm/prc/searchPrcPrcd.do")
	public String searchPrcPrcd(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmPrcService.searchPrcPrcd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
}

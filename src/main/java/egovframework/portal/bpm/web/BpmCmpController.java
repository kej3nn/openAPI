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
import egovframework.portal.bpm.service.BpmCmpService;

/**
 * 의정활동별 공개 - 위원회 구성/계류법안 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Controller
public class BpmCmpController extends BaseController {

	@Resource(name="AssmLawmService")
	private AssmLawmService assmLawmService;
	
	@Resource(name="bpmCmpService")
	private BpmCmpService bpmCmpService;
	
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	@RequestMapping("/portal/bpm/cmp/cmpMstPage.do")
	public String cmpMstPage(HttpServletRequest request, Model model) {
		// UNIT_CD 입력
//		assmMemberService.selectAssmMaxUnit(model, "");
		
		Params codeParam = new Params();
		
		// 위원회 종류(코드)
		//model.addAttribute("cmtDivCdList", bpmCmpService.selectCmpDivCdList(codeParam));
		
		// 위원회명(코드)
		//model.addAttribute("committeeCdList", bpmCmpService.selectCommitteeCdList(codeParam));
		
		// 당명 리스트 조회(교섭단체, 비교섭단체 구분)
		model.addAttribute("polyGroupList", bpmCmpService.selectPolyGroupList(codeParam));
		
		return "/portal/bpm/cmp/cmpMst";
	}
	
	/**
	 * 위원회 현황 조회
	 */
	@RequestMapping("/portal/bpm/cmp/searchCmpCond.do")
	public String searchCmpCond(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCmpService.searchCmpCond(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 위원회 위원명단 조회
	 */
	@RequestMapping("/portal/bpm/cmp/searchCmpList.do")
	public String searchCmpList(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCmpService.searchCmpList(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 위원회 일정 조회
	 */
	@RequestMapping("/portal/bpm/cmp/searchCmpDate.do")
	public String searchCmpDate(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCmpService.searchCmpDate(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 계류의안 조회
	 */
	@RequestMapping("/portal/bpm/cmp/searchCmpMoob.do")
	public String searchCmpMoob(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCmpService.searchCmpMoob(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 공통코드 조회(의안구분)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/bpm/cmp/searchCmpMoobCommCd.do")
	public String searchCmpMoobCommCd(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCmpService.searchCmpMoobCommCd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 자료실 조회
	 */
	@RequestMapping("/portal/bpm/cmp/searchCmpRefR.do")
	public String searchCmpRefR(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCmpService.searchCmpRefR(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 회의록 조회
	 */
	@RequestMapping("/portal/bpm/cmp/searchCmpReport.do")
	public String searchCmpReport(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmCmpService.searchCmpReport(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
}

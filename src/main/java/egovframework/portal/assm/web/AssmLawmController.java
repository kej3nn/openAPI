package egovframework.portal.assm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmLawmService;
import egovframework.portal.assm.service.AssmMemberService;

/**
 * 국회의원 입법활동 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Controller("AssmLawmController")
public class AssmLawmController extends BaseController {

	/**
	 * 국회의원 입법활동 서비스
	 */
	@Resource(name="AssmLawmService")
	private AssmLawmService assmLawmService;
	
	/**
	 * 국회의원 서비스
	 */
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	/**
	 * 국회의원 공통코드 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/lawm/searchAssmLawmCommCd.do")
	public String searchAssmLawmCommCd(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchAssmLawmCommCd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 국회의원 입법활동 페이지 이동
	 */
	@RequestMapping("/portal/assm/lawm/assmLawmPage.do")
	public String assmLawmPage(HttpServletRequest request, Model model) {
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
		
		return "/portal/assm/lawm/assmLawm";
	}
	
	/**
	 * 대표발의 법률안 조회
	 */
	@RequestMapping("/portal/assm/lawm/searchLawmDegtMotnLgsb.do")
	public String lawmDegtMotnLgsbPagePaging(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchLawmDegtMotnLgsb(params);
        
        addObject(model, result);
        
        return "jsonView";
	}

	/**
	 * 공동발의 법률안 조회 
	 */
	@RequestMapping("/portal/assm/lawm/searchLawmClboMotnLgsb.do")
	public String searchLawmClboMotnLgsb(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchLawmClboMotnLgsb(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표결현황 조회 
	 */
	@RequestMapping("/portal/assm/lawm/searchLawmVoteCond.do")
	public String searchLawmVoteCond(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchLawmVoteCond(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표결현황 카운트 조회
	 */
	@RequestMapping("/portal/assm/lawm/selectLawmVoteCondResultCnt.do")
	public String selectLawmVoteCondResultCnt(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.selectLawmVoteCondResultCnt(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * TreeMap Chart 데이터 조회 (대표발의 법률안)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/lawm/searchDegtMotnLgsbTreeMap.do")
	public String searchDegtMotnLgsbTreeMap(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmLawmService.searchDegtMotnLgsbTreeMap(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Column Chart 데이터 조회(대표발의법률안)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/lawm/searchDegtMotnLgsbColumn.do")
	public String searchDegtMotnLgsbColumn(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmLawmService.searchDegtMotnLgsbColumn(params); 
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * TreeMap Chart 데이터 조회 (공동발의 법률안)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/lawm/searchLawmClboMotnLgsbTreeMap.do")
	public String searchLawmClboMotnLgsbTreeMap(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmLawmService.searchLawmClboMotnLgsbTreeMap(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Column Chart 데이터 조회(공동발의 법률안)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/lawm/searchLawmClboMotnLgsbColumn.do")
	public String searchLawmClboMotnLgsbColumn(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmLawmService.searchLawmClboMotnLgsbColumn(params); 
    	addObject(model, result);
		return "jsonView";
	}

	/**
	 * 상임위 활동 조회
	 */
	@RequestMapping("/portal/assm/lawm/searchLawmSdcmAct.do")
	public String searchLawmSdcmAct(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchLawmSdcmAct(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 연구단체 조회
	 */
	@RequestMapping("/portal/assm/lawm/searchLawmRschOrg.do")
	public String searchLawmRschOrg(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchLawmRschOrg(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 청원 조회
	 */
	@RequestMapping("/portal/assm/lawm/searchCombLawmPttnReport.do")
	public String searchCombLawmPttnReport(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchCombLawmPttnReport(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 청원 조회
	 */
	@RequestMapping("/portal/assm/lawm/searchCombLawmVideoMnts.do")
	public String searchCombLawmVideoMnts(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmLawmService.searchCombLawmVideoMnts(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
}

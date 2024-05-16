package egovframework.portal.assm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmPdtaService;
import egovframework.portal.assm.service.AssmMemberService;

/**
 * 국회의원 정책자료&보고서 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Controller("AssmPdtaController")
public class AssmPdtaController extends BaseController {
	
	/**
	 * GUBUN_NAMES.put("PA", "");			// 전체
	 * GUBUN_NAMES.put("PS", "POLCS");		// 정책세미나
	 * GUBUN_NAMES.put("PR", "POLCD");		// 정책자료실
	 * GUBUN_NAMES.put("PP", "ASEMR");		// 의정보고서
	 * GUBUN_NAMES.put("PV", "RESHR");		// 연구용역 결과보고서
	 * GUBUN_NAMES.put("PO", "OREPORT");	// 연구단체 활동보고서
	 * GUBUN_NAMES.put("PL", "DISCCS");		// 지역현안 입법지원 토론회 개최내역
	 * GUBUN_NAMES.put("PB", "ABOOK");		// 의원저서
	 */

	/**
	 * 국회의원 정책자료&보고서 서비스
	 */
	@Resource(name="AssmPdtaService")
	private AssmPdtaService assmPdtaService;
	
	/**
	 * 국회의원 서비스
	 */
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	/**
	 * 정책자료&보고서 페이지 이동
	 */
	@RequestMapping("/portal/assm/pdta/assmPdtaPage.do")
	public String assmPdtaPage(HttpServletRequest request, Model model) {
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
				
		return "/portal/assm/pdta/assmPdta";
	}
	
	/**
	 * 정책자료&보고서 전체 조회
	 */
	@RequestMapping("/portal/assm/noti/searchAssmPdta.do")
	public String lawmDegtMotnLgsbPagePaging(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 정책세미나 조회
	 */
	@RequestMapping("/portal/assm/pdta/searchPdtaPlcySmn.do")
	public String searchPdtaPlcySmn(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PS"));
		
		Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 정책자료실 조회
	 */
	@RequestMapping("/portal/assm/pdta/searchPdtaPlcyRefRoom.do")
	public String searchPdtaPlcyRefRoom(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PR"));
		
		Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 의정보고서 조회
	 */
	@RequestMapping("/portal/assm/pdta/searchPdtaPltcReport.do")
	public String searchPdtaPltcReport(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PP"));
		
		Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 연구용역 결과보고서 조회
	 */
	@RequestMapping("/portal/assm/pdta/searchPdtaRschSrvReport.do")
	public String searchPdtaRschSrvReport(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PV"));
		
        Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	

	/**
	 * 연구단체 활동보고서
	 */
	@RequestMapping("/portal/assm/pdta/searchPdtaRschOrgReport.do")
	public String searchPdtaRschOrgReport(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PO"));
		
        Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 지역현안 입법지원 토론회 개최내역 조회
	 */
	@RequestMapping("/portal/assm/pdta/searchPdtaLcosLawSupport.do")
	public String searchPdtaLcosLawSupport(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PL"));
		
        Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 의원저서 조회
	 */
	@RequestMapping("/portal/assm/pdta/searchAssmPdtaAmr.do")
	public String searchAssmPdtaAmr(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PB"));
		
        Object result = assmPdtaService.searchAssmPdta(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
}

package egovframework.portal.assm.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmMemberService;
import egovframework.portal.assm.service.AssmSchdService;

/**
 * 국회의원 일정 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Controller("AssmSchdController")
public class AssmSchdController extends BaseController {
	
	/**
	 * 국회의원 일정 서비스
	 */
	@Resource(name="AssmSchdService")
	private AssmSchdService assmSchdService;
	
	/**
	 * 국회의원 서비스
	 */
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	/**
	 * 의원일정 페이지 이동
	 */
	@RequestMapping("/portal/assm/schd/assmSchdPage.do")
	public String assmSchdPage(HttpServletRequest request, Model model) {
		
		// 현재 년월을 구한다.(캘린더에서 사용)
		Calendar cal = Calendar.getInstance();
		model.addAttribute("currentYear", cal.get(cal.YEAR));
		model.addAttribute("currentMonth", cal.get(cal.MONTH)+1);
		
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
		
		return "/portal/assm/schd/assmSchd";
	}
	
	/**
	 * 전체 의원일정 조회
	 */
	@RequestMapping("/portal/assm/schd/searchAssmSchd.do")
	public String lawmDegtMotnLgsbPagePaging(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.put("gubun", params.getString("radioGubun"));
		
        Object result = assmSchdService.searchAssmSchd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 본회의 의원일정 조회
	 */
	@RequestMapping("/portal/assm/schd/searchAssmSchdRgls.do")
	public String searchAssmSchdRgls(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("gubun", AssmMemberController.GUBUN_NAMES.get("SR"));
		
        Object result = assmSchdService.searchAssmSchd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 위원회 의원일정 조회
	 */
	@RequestMapping("/portal/assm/schd/searchAssmSchdCmte.do")
	public String searchAssmSchdCmte(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("gubun", AssmMemberController.GUBUN_NAMES.get("SC"));
		
        Object result = assmSchdService.searchAssmSchd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 세미나일정 조회
	 */
	@RequestMapping("/portal/assm/schd/searchAssmSchdSmn.do")
	public String searchAssmSchdSmn(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
		params.set("gubun", AssmMemberController.GUBUN_NAMES.get("SS"));
		
        Object result = assmSchdService.searchAssmSchd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
}

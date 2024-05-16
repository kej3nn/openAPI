package egovframework.portal.assm.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.portal.assm.service.AssmMemberSchService;
import egovframework.portal.assm.service.AssmMemberService;

/**
 * 국회의원 검색 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Controller("AssmMemberSchController")
public class AssmMemberSchController extends BaseController {

	@Resource(name="AssmMemberSchService")
	private AssmMemberSchService assmMemberSchService;
	
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	/**
	 * 의원검색 페이지 이동
	 */
	@RequestMapping("/portal/assm/search/memberSchPage.do")
	public String memberSchPage(HttpServletRequest request, Model model) {
		
		// 국회 현재 회차 조회
		assmMemberService.setModelInCurrentAssmMemberUnit(model);
		
		// 국회의원 재적수
		model.addAttribute("allCnt", assmMemberSchService.searchAssmMemberAllCnt());
		
		Params CommCdParam = new Params(); 
		
		// 정당
		CommCdParam.put("listNo", 101);
		model.addAttribute("polyList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 위원회
		CommCdParam.put("listNo", 206);
		model.addAttribute("cmitList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 지역
		CommCdParam.put("listNo", 204);
		model.addAttribute("origList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 성별
		CommCdParam.put("listNo", 203);
		model.addAttribute("sexGbnList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 연령
		CommCdParam.put("listNo", 207);
		model.addAttribute("ageList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 당선횟수
		CommCdParam.put("listNo", 105);
		model.addAttribute("reeleGbnList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 당선방법
		CommCdParam.put("listNo", 102);
		model.addAttribute("electGbnList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		return "/portal/assm/search/memberSch";
	}
	
	/**
	 * 역대 국회의원검색 페이지 이동
	 */
	@RequestMapping("/portal/assm/search/memberHistSchPage.do")
	public String memberHistSchPage(HttpServletRequest request, Model model) {
		Params CommCdParam = new Params(); 
		
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		CommCdParam.put("ditcCd", "SPUNIT");
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(CommCdParam));
		
		// 국회의원 재적수
//		model.addAttribute("allCnt", assmMemberSchService.searchAssmHistMemberAllCnt());
		
		// 성별
		CommCdParam.put("listNo", 203);
		model.addAttribute("sexGbnList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 연령
		CommCdParam.put("listNo", 207);
		model.addAttribute("ageList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 당선횟수
		CommCdParam.put("listNo", 105);
		model.addAttribute("reeleGbnList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		// 당선방법
		CommCdParam.put("listNo", 102);
		model.addAttribute("electGbnList", assmMemberSchService.searchAssmMembCommCd(CommCdParam));
		
		return "/portal/assm/search/memberHistSch";
	}
	
	/**
	 * 공통코드 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/search/searchAssmMembCommCd.do")
	public String searchAssmMembCommCd(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmMemberSchService.searchAssmMembCommCd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	/**
	 * 국회의원 검색 페이징 처리
	 */
	@RequestMapping("/portal/assm/search/searchAssmMemberSch.do")
	public String searchAssmMemberSchPaging(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmMemberSchService.searchAssmMemberSchPaging(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 대수에 맞는 국회의원 회차의 재적수를 구한다
	 */
	@RequestMapping("/portal/assm/search/searchAssmHistMemberAllCnt.do")
	public String searchAssmHistMemberAllCnt(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object list = assmMemberSchService.searchAssmHistMemberAllCnt(params);
        
        addObject(model, list);
        
        return "jsonView";
	}
	
	/**
	 * 우편번호 선거구 매핑정보
	 */
	@RequestMapping("/portal/assm/search/searchAssmNaElectCd.do")
	public String searchAssmNaElectCd(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmMemberSchService.searchAssmNaElectCd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
}

package egovframework.portal.assm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmMemberService;
/**
 * 국회의원 레프트 통합조회 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Controller(value="AssmCombController")
public class AssmCombController extends BaseController {
	
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	/**
	 * 국회의원 의정활동 통합조회 페이지 이동
	 */
	@RequestMapping("/portal/assm/comb/combLawmPage.do")
	public String memberLawmCombPage(@RequestParam(value="monaCd", required=true) String monaCd,
			@RequestParam(value="unitCd", required=false, defaultValue="") String unitCd,
			HttpServletRequest request, Model model) {
		
		// 국회의원 각종 코드관련 정보를 로드한다.
		Params assmMemberParams = new Params();
		assmMemberParams.put("monaCd", monaCd);
		assmMemberParams.put("unitCd", unitCd);
		assmMemberService.loadAssmMemberCode(model, assmMemberParams);
		
		// 국회의원 정보를 조회한다.
		model.addAttribute("meta", assmMemberService.selectAssmMemberDtl(assmMemberParams));
		
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
		
		return "/portal/assm/comb/combLawm";
	}
	
	/**
	 * 정책자료/보고서 통합조회 페이지 이동 
	 */
	@RequestMapping("/portal/assm/comb/combPdtaPage.do")
	public String memberPdtaCombPage(@RequestParam(value="monaCd", required=true) String monaCd, 
			@RequestParam(value="unitCd", required=false, defaultValue="") String unitCd,
			HttpServletRequest request, Model model) {
		
		// 국회의원 각종 코드관련 정보를 로드한다.
		Params assmMemberParams = new Params();
		assmMemberParams.put("monaCd", monaCd);
		assmMemberParams.put("unitCd", unitCd);
		assmMemberService.loadAssmMemberCode(model, assmMemberParams);
		
		// 국회의원 정보를 조회한다.
		model.addAttribute("meta", assmMemberService.selectAssmMemberDtl(assmMemberParams));
		
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
		
		return "/portal/assm/comb/combPdta";
	}
	
	/**
	 * 의원일정 통합조회 페이지 이동
	 */
	@RequestMapping("/portal/assm/comb/combSchdPage.do")
	public String memberScheduleCombPage(@RequestParam(value="monaCd", required=true) String monaCd, 
			@RequestParam(value="unitCd", required=false, defaultValue="") String unitCd,
			HttpServletRequest request, Model model) {
		
		// 국회의원 각종 코드관련 정보를 로드한다.
		Params assmMemberParams = new Params();
		assmMemberParams.put("monaCd", monaCd);
		assmMemberParams.put("unitCd", unitCd);
		assmMemberService.loadAssmMemberCode(model, assmMemberParams);
		
		// 국회의원 정보를 조회한다.
		model.addAttribute("meta", assmMemberService.selectAssmMemberDtl(assmMemberParams));
		
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
		
		return "/portal/assm/comb/combSchd";
	}
	
	/**
	 * 알림 통합조회 페이지 이동
	 */
	@RequestMapping("/portal/assm/comb/combNotiPage.do")
	public String memberNotiCombPage(@RequestParam(value="monaCd", required=true) String monaCd, 
			@RequestParam(value="unitCd", required=false, defaultValue="") String unitCd,
			HttpServletRequest request, Model model) {
		
		// 국회의원 각종 코드관련 정보를 로드한다.
		Params assmMemberParams = new Params();
		assmMemberParams.put("monaCd", monaCd);
		assmMemberParams.put("unitCd", unitCd);
		assmMemberService.loadAssmMemberCode(model, assmMemberParams);
		
		// 국회의원 정보를 조회한다.
		model.addAttribute("meta", assmMemberService.selectAssmMemberDtl(assmMemberParams));
		
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
		
		return "/portal/assm/comb/combNoti";
	}
}

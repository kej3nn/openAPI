package egovframework.portal.assm.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmMemberService;

/**
 * 국회의원 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Controller("AssmMemberController")
public class AssmMemberController extends BaseController {
	
	/**
	 * 구분코드 맵
	 */
	public static final Map<String, String> GUBUN_NAMES = new HashMap<String, String>();
	static {
		// 의정활동
		GUBUN_NAMES.put("AD", "");		// 메인-대표발의 법률안		
		GUBUN_NAMES.put("AC", "");		// 메인-공동발의 법률안
		GUBUN_NAMES.put("AR", "");		// 본회의 표결정보 
		GUBUN_NAMES.put("AD_2", "");	// 대표발의 법률안(메인화면과 틀이 달라서 추가함		
		GUBUN_NAMES.put("AC_2", "");	// 공동발의 법률안
		GUBUN_NAMES.put("AS", "");		// 상임위 활동
		GUBUN_NAMES.put("AV", "");		// 영상회의록
		GUBUN_NAMES.put("AP", "");		// 청원현황
		GUBUN_NAMES.put("AO", "");		// 연구단체
		
		// 의원일정
		GUBUN_NAMES.put("SA", "");			// 전체
		GUBUN_NAMES.put("SR", "ASSEM");		// 본회의 의사일정 
		GUBUN_NAMES.put("SC", "CMMTT");		// 위원회 의사일정
		GUBUN_NAMES.put("SS", "SEMNA");		// 세미나 일정
		
		// 의원알림
		GUBUN_NAMES.put("NA", "");			// 전체
		GUBUN_NAMES.put("NR", "6");			// 의원실 채용
		GUBUN_NAMES.put("NI", "P");			// 기자회견
		GUBUN_NAMES.put("NT", "SEMNA");		// 트위터
		
		// 정책자료&보고서
		GUBUN_NAMES.put("PA", "");			// 전체
		GUBUN_NAMES.put("PS", "POLCS");		// 정책세미나
		GUBUN_NAMES.put("PR", "POLCD");		// 정책자료실
		GUBUN_NAMES.put("PP", "ASEMR");		// 의정보고서
		GUBUN_NAMES.put("PV", "RESHR");		// 연구용역 결과보고서
		GUBUN_NAMES.put("PO", "OREPORT");	// 연구단체 활동보고서
		GUBUN_NAMES.put("PL", "DISCCS");	// 지역현안 입법지원 토론회 개최내역
		GUBUN_NAMES.put("PB", "ABOOK");		// 의원저서
		
		GUBUN_NAMES.put("MA", "");		// 의원검색
	}
	
	/**
	 * 구분코드 맵 설명(엑셀 다운로드시 파일명으로 사용)
	 */
	public static final Map<String, String> GUBUN_NAMES_TXT = new HashMap<String, String>();
	static {
		// 의정활동
		GUBUN_NAMES_TXT.put("AD", "대표발의 법률안");		
		GUBUN_NAMES_TXT.put("AC", "공동발의 법률안");
		GUBUN_NAMES_TXT.put("AR", "본회의 표결정보"); 
		GUBUN_NAMES_TXT.put("AD_2", "대표발의 법률안");		
		GUBUN_NAMES_TXT.put("AC_2", "공동발의 법률안");
		GUBUN_NAMES_TXT.put("AS", "상임위 활동");
		GUBUN_NAMES_TXT.put("AV", "영상회의록");
		GUBUN_NAMES_TXT.put("AP", "청원현황");
		GUBUN_NAMES_TXT.put("AO", "연구단체");
		
		// 의원일정
		GUBUN_NAMES_TXT.put("SA", "전체");
		GUBUN_NAMES_TXT.put("SR", "본회의 의사일정 "); 
		GUBUN_NAMES_TXT.put("SC", "위원회 의사일정");
		GUBUN_NAMES_TXT.put("SS", "세미나 일정");
		
		// 의원알림
		GUBUN_NAMES_TXT.put("NA", "전체");
		GUBUN_NAMES_TXT.put("NR", "의원실 채용");
		GUBUN_NAMES_TXT.put("NI", "기자회견");
		GUBUN_NAMES_TXT.put("NT", "트위터");
		
		// 정책자료&보고서
		GUBUN_NAMES_TXT.put("PA", "전체");
		GUBUN_NAMES_TXT.put("PS", "정책세미나");
		GUBUN_NAMES_TXT.put("PR", "정책자료실");
		GUBUN_NAMES_TXT.put("PP", "의정보고서");
		GUBUN_NAMES_TXT.put("PV", "연구용역 연구보고서");
		GUBUN_NAMES_TXT.put("PO", "연구단체 활동보고서");
		GUBUN_NAMES_TXT.put("PL", "지역현안 입법지원 토론회 개최내역");
		GUBUN_NAMES_TXT.put("PB", "의원저서");
		
		GUBUN_NAMES_TXT.put("MA", "의원검색");
	}

	/**
	 * 국회의원 서비스
	 */
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	/**
	 * 국회 관련 공통코드 조회
	 */
	@RequestMapping("/portal/assm/searchAssmCommCd.do")
	public String searchAssmCommCd(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmMemberService.searchAssmCommCd(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 의원메인 페이지 이동
	 */
	@RequestMapping("/portal/assm/memberPage.do")
	public String memberPage(@RequestParam(value="monaCd", required=true) String monaCd,
			@RequestParam(value="unitCd", required=false, defaultValue="") String unitCd,
			HttpServletRequest request, Model model) {
		
		// 국회의원 각종 코드관련 정보를 로드한다.
		Params assmMemberParams = new Params();
		assmMemberParams.put("monaCd", monaCd);
		assmMemberParams.put("unitCd", unitCd);
		assmMemberService.loadAssmMemberCode(model, assmMemberParams);
		
		// 국회의원 정보를 조회한다.
		model.addAttribute("meta", assmMemberService.selectAssmMemberDtl(assmMemberParams));
		return "/portal/assm/member";
	}
	
	/**
	 * 국회의원 URL 코드로 개인 상세페이지로 바로가기
	 * @param openNaId
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/21stMembers/{openNaId}")
	public String docInfDirectPage(@PathVariable(value="openNaId") String openNaId, HttpServletRequest request, Model model) {
		
		if ( StringUtils.isEmpty(openNaId) ) {
			return "forward:/portal/error";
		}

		return "redirect:/21stMembers/" + openNaId;
	}
	
	/**
	 * 인적정보 페이지 이동
	 */
	@RequestMapping("/portal/assm/memberInfoPage.do")
	public String memberInfoPage(@RequestParam(value="monaCd", required=true) String monaCd, 
			@RequestParam(value="unitCd", required=false, defaultValue="") String unitCd,
			HttpServletRequest request, Model model) {
		
		// 국회의원 각종 코드관련 정보를 로드한다.
		Params assmMemberParams = new Params();
		assmMemberParams.put("monaCd", monaCd);
		assmMemberParams.put("unitCd", unitCd);
		assmMemberService.loadAssmMemberCode(model, assmMemberParams);
		
		// 국회의원 정보를 조회한다.
		model.addAttribute("meta", assmMemberService.selectAssmMemberDtl(assmMemberParams));
		
		// 국회의원, 약력, 학력, 위원회 경력 조회
		model.addAttribute("info", assmMemberService.selectAssmMemberInfo(assmMemberParams));
		
		// 국회의원 선거이력
		model.addAttribute("electedInfo", assmMemberService.selectElectedInfo(assmMemberParams));
		
		return "/portal/assm/memberInfo";
	}
	
	/**
	 * 국회의원 인적정보 조회
	 */
	@RequestMapping("/portal/assm/selectAssmMemberInfo.do")
	public String selectAssmMemberInfo(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = assmMemberService.selectAssmMemberInfo(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 엑셀 다운로드
	 */
	@RequestMapping("/portal/assm/downExcel.do")
	public void downExcel(HttpServletResponse response, HttpServletRequest request) {
		Params params = getParams(request, false);
	
		assmMemberService.downloadExcel(request, response, params);
	}
	
	/**
	 * 의원정보 엑셀 다운로드
	 */
	@RequestMapping("/portal/assm/downExcelMembInfo.do")
	public void downExcelMembInfo(HttpServletResponse response, HttpServletRequest request) {
		Params params = getParams(request, false);
		
		assmMemberService.downExcelMembInfo(request, response, params);
	}
	
	/**
	 * 국회의원 URL 코드로 개인 상세페이지로 바로가기
	 * @param openNaId
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/21stMembers/{openNaId:.+}")
	public String domainDirectPage(@PathVariable(value="openNaId") String openNaId, HttpServletRequest request, Model model) {
		
		if ( StringUtils.isEmpty(openNaId) ) {
			return "forward:/portal/error";
		}
		
		Params params = new Params();
		params.put("openNaId", openNaId);
		
		// 메뉴정보를 로그에 담는다.
		params.put("sysTag", "K");
		params.put("menuId", 319); //국회의원 페이지 319
		// 로그인 되어있을경우
		HttpSession session = getSession();
        params.put("userCd", session.getAttribute(SessionAttribute.USER_CD));
        params.put("userIp",StringUtils.defaultIfEmpty(request.getRemoteAddr(), ""));
        params.put("menuUrl", "/21stMembers");
        params.put("menuParam", openNaId);

        assmMemberService.insertLogMenu(params);
		
		// openNaId 코드로 MONA_CD 조회
		String monaCd = assmMemberService.selectAssmMemberUrlByMonaCd(params);
		if ( StringUtils.isEmpty(monaCd) ) {
			monaCd = assmMemberService.selectAssmMemberUrlByMonaCdChkEngnm(params);				
			if ( StringUtils.isEmpty(monaCd) ) {
				params.put("unitCd", "100021");
				monaCd = assmMemberService.selectAssmMemberUrlByMonaCd(params);
				if(StringUtils.isNotEmpty(monaCd) ) {
					model.addAttribute("monaCd", monaCd);
					return "/portal/assm/memberHisDomain";
				}
				monaCd = assmMemberService.selectAssmMemberUrlByMonaCdChkEngnm(params);	
				if(StringUtils.isNotEmpty(monaCd) ) {
					model.addAttribute("monaCd", monaCd);
					return "/portal/assm/memberHisDomain";
				}
				return "forward:/portal/error";
			}
		}
		
		model.addAttribute("monaCd", monaCd);
		return "/portal/assm/memberDomain";
		//return "redirect:/portal/assm/memberPage.do?monaCd=" + monaCd;
	}
	
	/**
	 * 20대 국회의원 URL 코드로 개인 상세페이지로 바로가기
	 * @param openNaId
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/20stMembers/{openNaId:.+}")
	public String domain20HisDirectPage(@PathVariable(value="openNaId") String openNaId, HttpServletRequest request, Model model) {
		
		if ( StringUtils.isEmpty(openNaId) ) {
			return "forward:/portal/error";
		}
		
		Params params = new Params();
		params.put("openNaId", openNaId);
		
		// 메뉴정보를 로그에 담는다.
		params.put("sysTag", "K");
		params.put("menuId", 319); //국회의원 페이지 319
		// 로그인 되어있을경우
		HttpSession session = getSession();
        params.put("userCd", session.getAttribute(SessionAttribute.USER_CD));
        params.put("userIp",StringUtils.defaultIfEmpty(request.getRemoteAddr(), ""));
        params.put("menuUrl", "/20stMembers");
        params.put("menuParam", openNaId);

        assmMemberService.insertLogMenu(params);
        params.put("unitCd", "100020");
		// openNaId 코드로 MONA_CD 조회
		String monaCd = assmMemberService.selectAssmMemberUrlByMonaCd(params);
		if ( StringUtils.isEmpty(monaCd) ) {
			monaCd = assmMemberService.selectAssmMemberUrlByMonaCdChkEngnm(params);				
			if ( StringUtils.isEmpty(monaCd) ) {
				return "forward:/portal/error";
			}
		}
		
		model.addAttribute("monaCd", monaCd);
		model.addAttribute("unitCd", "100020");
		
		return "/portal/assm/memberHisDomain";
	}
	/**
	 * 19대 국회의원 URL 코드로 개인 상세페이지로 바로가기
	 * @param openNaId
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/19stMembers/{openNaId:.+}")
	public String domain19HisDirectPage(@PathVariable(value="openNaId") String openNaId, HttpServletRequest request, Model model) {
		
		if ( StringUtils.isEmpty(openNaId) ) {
			return "forward:/portal/error";
		}
		
		Params params = new Params();
		params.put("openNaId", openNaId);
		
		// 메뉴정보를 로그에 담는다.
		params.put("sysTag", "K");
		params.put("menuId", 319); //국회의원 페이지 319
		// 로그인 되어있을경우
		HttpSession session = getSession();
        params.put("userCd", session.getAttribute(SessionAttribute.USER_CD));
        params.put("userIp",StringUtils.defaultIfEmpty(request.getRemoteAddr(), ""));
        params.put("menuUrl", "/19stMembers");
        params.put("menuParam", openNaId);

        assmMemberService.insertLogMenu(params);
        params.put("unitCd", "100019");
		// openNaId 코드로 MONA_CD 조회
		String monaCd = assmMemberService.selectAssmMemberUrlByMonaCd(params);
		if ( StringUtils.isEmpty(monaCd) ) {
			monaCd = assmMemberService.selectAssmMemberUrlByMonaCdChkEngnm(params);				
			if ( StringUtils.isEmpty(monaCd) ) {
				return "forward:/portal/error";
			}
		}
		
		model.addAttribute("monaCd", monaCd);
		model.addAttribute("unitCd", "100019");
		
		return "/portal/assm/memberHisDomain";
	}
	
	/**
	 * 18대 국회의원 URL 코드로 개인 상세페이지로 바로가기
	 * @param openNaId
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/18stMembers/{openNaId:.+}")
	public String domain18HisDirectPage(@PathVariable(value="openNaId") String openNaId, HttpServletRequest request, Model model) {
		
		if ( StringUtils.isEmpty(openNaId) ) {
			return "forward:/portal/error";
		}
		
		Params params = new Params();
		params.put("openNaId", openNaId);
		
		// 메뉴정보를 로그에 담는다.
		params.put("sysTag", "K");
		params.put("menuId", 319); //국회의원 페이지 319
		// 로그인 되어있을경우
		HttpSession session = getSession();
        params.put("userCd", session.getAttribute(SessionAttribute.USER_CD));
        params.put("userIp",StringUtils.defaultIfEmpty(request.getRemoteAddr(), ""));
        params.put("menuUrl", "/18stMembers");
        params.put("menuParam", openNaId);

        assmMemberService.insertLogMenu(params);
        params.put("unitCd", "100018");
		// openNaId 코드로 MONA_CD 조회
		String monaCd = assmMemberService.selectAssmMemberUrlByMonaCd(params);
		if ( StringUtils.isEmpty(monaCd) ) {
			monaCd = assmMemberService.selectAssmMemberUrlByMonaCdChkEngnm(params);				
			if ( StringUtils.isEmpty(monaCd) ) {
				return "forward:/portal/error";
			}
		}
		
		model.addAttribute("monaCd", monaCd);
		model.addAttribute("unitCd", "100018");
		
		return "/portal/assm/memberHisDomain";
	}
}

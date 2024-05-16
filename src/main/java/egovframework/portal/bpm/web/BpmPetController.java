package egovframework.portal.bpm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmMemberService;
import egovframework.portal.bpm.service.BpmPetService;

/**
 * 의정활동별 공개 - 청원 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Controller
public class BpmPetController extends BaseController {

	@Resource(name="bpmPetService")
	private BpmPetService bpmPetService;
	
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	@RequestMapping("/portal/bpm/pet/petMstPage.do")
	public String petMstPage(HttpServletRequest request, Model model) {
		
		// UNIT_CD 입력
//		assmMemberService.selectAssmMaxUnit(model, "");
		
		return "/portal/bpm/pet/petMst";
	}
	
	/**
	 * 국회의원 청원 조회
	 */
	@RequestMapping("/portal/bpm/pet/searchPetAssmMemb.do")
	public String searchPetAssmMemb(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmPetService.searchPetAssmMemb(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 국민동의 청원 조회
	 */
	@RequestMapping("/portal/bpm/pet/searchPetAprvNa.do")
	public String searchPetAprvNa(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
        
        Object result = bpmPetService.searchPetAprvNa(params);
        
        addObject(model, result);
        
        return "jsonView";
	}
}

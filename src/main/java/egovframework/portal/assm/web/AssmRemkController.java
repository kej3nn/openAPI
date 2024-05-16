package egovframework.portal.assm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmRemkService;
import egovframework.portal.assm.service.AssmMemberService;

/**
 * 국회의원 발언 컨트롤러 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Controller("AssmRemkController")
public class AssmRemkController extends BaseController {

	/**
	 * 국회의원 발언 서비스
	 */
	@Resource(name="AssmRemkService")
	private AssmRemkService AssmRemkService;
	
	/**
	 * 국회의원 서비스
	 */
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	/**
	 * 국회발언 페이지 이동
	 */
	@RequestMapping("/portal/assm/remk/assmRemkPage.do")
	public String memberRemkPage(HttpServletRequest request, Model model) {
		// 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
		model.addAttribute("assmHistUnitCodeList", assmMemberService.selectAssmHistUnitCodeList(null));
				
		return "/portal/assm/remk/assmRemk";
	}
}

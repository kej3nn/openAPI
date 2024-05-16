package egovframework.portal.main.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.main.service.PortalMainPopupService;

/**
 * 포털 메인팝업 화면 컨트롤러 클래스
 * 
 * @author CSB
 * @version 1.0 2021/01/05
 */
@Controller
public class PortalMainPopupController extends BaseController {
	
	@Resource(name="portalMainPopupService")
	private PortalMainPopupService portalMainPopupService;
	
	/**
	 * 옥에 티를 찾아라 팝업
	 */
	@RequestMapping("/portal/main/mainOkteePop.do")
    public String mainOkteePop(HttpServletRequest request, Model model) {
        return "/portal/popup/mainOkteePop";
    }	
	
	/**
	 * 퀴즈이벤트 팝업
	 */
	@RequestMapping("/portal/main/mainQuizEventPop.do")
    public String mainQuizEventPop(HttpServletRequest request, Model model) {
        return "/portal/popup/mainQuizEventPop";
    }	
	
	/**
	 * 퀴즈이벤트 등록 팝업
	 */
	@RequestMapping("/portal/main/mainQuizEventRegPage.do")
    public String mainQuizEventRegPage(HttpServletRequest request, Model model) {
        return "/portal/popup/mainQuizEventRegPop";
    }
	
	/**
     * 퀴즈이벤트 내용을 등록한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/main/mainQuizEventInsert.do")
    public String mainQuizEventInsert(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request);
        
        debug("Request parameters: " + params);
        
        // 내용을 등록한다.
        Object result = portalMainPopupService.mainQuizEventInsert(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
	 * 국회홈페이지 선호도 조사 팝업( 임시 )
	 */
	@RequestMapping("/portal/main/dsgPrefPop.do")
    public String dsgPrefPopPage(HttpServletRequest request, Model model) {
        return "/portal/popup/dsgPrefPop";
    }
	
	@RequestMapping("/portal/main/dsgPrefSamplePop01.do")
	public String dsgPrefSamplePop01(HttpServletRequest request, Model model) {
		
		return "/portal/popup/dsgPrefSample01";
	}
	@RequestMapping("/portal/main/dsgPrefSamplePop02.do")
	public String dsgPrefSamplePop02(HttpServletRequest request, Model model) {
		
		return "/portal/popup/dsgPrefSample02";
	}
	@RequestMapping("/portal/main/dsgPrefSamplePop03.do")
	public String dsgPrefSamplePop03(HttpServletRequest request, Model model) {
		
		return "/portal/popup/dsgPrefSample03";
	}
}

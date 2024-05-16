package egovframework.ggportal.user.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import WiseAccess.SSO;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.helper.SSOHelper;
import egovframework.common.util.UtilString;
import egovframework.ggportal.user.service.PortalUserService;

/**
 * 사용자 정보를 관리하는 컨트롤러 클래스이다.
 * 
 * @author jhkim
 * @version 1.0 2019/12/01
 */
@Controller("ggportalUserController")
public class PortalUserController extends BaseController {
	
	/* 로그인 페이지 관련 전역변수 */
	public static final String MAIN_PAGE = "/portal/mainPage.do";
	public static final String LOGIN_PAGE = "/portal/user/loginPage.do";
	public static final String LOGIN_PROC_PAGE = "/portal/user/loginProc.do";
	public static final String LOGOUT_PAGE = "/portal/user/logout.do";
	
	/* 로그인 세션 관련 전역변수 */
	public static final String PORTAL_SESSION_NAME = "nasna_session_nm";
	public static final String PORTAL_SESSION_VALUE = "nasna_session_val";
	
    /**
     * 사용자 정보를 관리하는 서비스
     */
    @Resource(name="ggportalUserService")
    private PortalUserService portalUserService;
    
    
    /* [ SSO 로그인 시작] ***********************************************************************************************************************************************/
    
    /**
     * SSO 로그인 페이지 이동(실제 로직은 login2.jsp 파일에서 처리)
     */
    @RequestMapping(value="/portal/user/loginPage.do")
    public ModelAndView loginPage2(HttpServletRequest request, HttpServletResponse response) {
    	ModelAndView mv = new ModelAndView("/portal/login2");
    	
    	return mv;
    }
    
    /**
     * SSO 토큰 검증 후 실제 로그인 처리
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/portal/user/loginSSOProc.do")
    public String loginSSOProc(HttpServletRequest request, HttpServletResponse response) {
    	Params params = getParams(request, false);
    	
    	String redirectUrl = "/error/error.jsp";
    	
    	if ( EgovUserDetailsHelper.isAuthenticatedPortal() ) {
    		return "redirect:" + MAIN_PAGE;
    	}
    	
		int result = -1;
		
		// SSO 토큰값
		String sToken = SSOHelper.getSSOToken(request);
		log.info("WWWWW TOKEN VALUE = "+ sToken);
		
		// SSO 성공
		if ( sToken != null && sToken.length() > 0) {
			
			// SSO 초기화
			SSO sso = SSOHelper.initSSO();
			
			// SSO 토큰 검증
			boolean isVerify = SSOHelper.isVerify(sso, sToken, request.getRemoteAddr());
			
			log.info("WWWWW IS VERIFY = "+ isVerify);
			log.info("WWWWW RemoteAddr = "+ request.getRemoteAddr());
			
			// 토큰값이 정상인경우
			if( isVerify ) {
				String sUid = sso.getValueUserID();
				log.info("WWWWW UID = "+ sUid);
				params.set("memberId", sUid);
				
				// 유저 조회 및 세션 처리
				result = portalUserService.checkUserSSOLoginProcCUD(request, params);
				
    		}
			
			if ( result > 0 ) {
				redirectUrl = StringUtils.defaultString(request.getParameter("returnUrl"), MAIN_PAGE);
			}
		}
		
		return "redirect:" + redirectUrl;
    	
    }
    
    /**
     * 로그아웃 
     */
    @RequestMapping(value="/portal/user/logout.do")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
    	
    	if ( EgovUserDetailsHelper.isAuthenticatedPortal() ) {
    		getSession(false).invalidate();
    	}
    	
    	StringBuffer sbMemberLogoutUrl = new StringBuffer(EgovProperties.getProperty("url.member.main"));
    	sbMemberLogoutUrl.append("/login/logout.do");
    	
    	StringBuffer sbUrl = new StringBuffer(sbMemberLogoutUrl.toString());
    	sbUrl.append("?returnUrl=");
    	sbUrl.append(EgovProperties.getProperty("url.open.main"));
    	sbUrl.append(MAIN_PAGE);
    	
    	return "redirect:" + sbUrl.toString();
    }
    
    /* [ SSO 로그인 종료] ***********************************************************************************************************************************************/
    
    
    
    /* [ 일반로그인 시작] ***********************************************************************************************************************************************/
    // ============== loginPage.do -> login2Page.do로 변경
    // ============== logout.do -> logout2.do로 변경
    /**
     * 로그인 페이지 이동
     */
    @RequestMapping(value="/portal/user/login2Page.do")
    public ModelAndView loginPage(HttpServletRequest request, HttpServletResponse response) {
    	ModelAndView mv = new ModelAndView("/portal/login");
    	
    	Params params = getParams(request, false);
    	
    	return mv;
    }

    
    /**
     * 로그아웃
     */
    @RequestMapping(value="/portal/user/logout2.do")
    public String logout2(HttpServletRequest request, HttpServletResponse response) {
    	
    	if ( EgovUserDetailsHelper.isAuthenticatedPortal() ) {
    		getSession(false).invalidate();
    	}
    	return "redirect:" + MAIN_PAGE;
    }
    
    
    /**
     * 로그인 진행 로직
     */
    @RequestMapping(value="/portal/user/loginProc.do", method=RequestMethod.POST)
    public ModelAndView loginProc(HttpServletRequest request, HttpServletResponse response) {
    	ModelAndView mv = new ModelAndView();
    	String errMsg = "";
    	String viewName = "";
    	
    	try {
    		
    		Params params = getParams(request, false);
    		
    		int result = portalUserService.checkUserLoginProcCUD(request, params);
    		
    		if ( result > 0 ) {
    			viewName = "redirect:" + MAIN_PAGE;
    		}
    		else {
    			
    			if ( result == -90 ) {
    				errMsg = "아이디/패스워드를 입력해 주세요";
    			}
    			else if ( result == -80 ) {
    				errMsg = "아이디/패스워드를 확인해 주세요";
    			}
    			else {
    				errMsg = "로그인 도중 오류가 발생하였습니다.";
    			}
    			
    			viewName = "forward:" + PortalUserController.LOGIN_PAGE;
    		}
    		
    		if ( StringUtils.isNotBlank(errMsg) )	mv.addObject("errMsg", errMsg);	
    		mv.setViewName(viewName);
        	
    	} catch(Exception e) {
    		EgovWebUtil.exLogging(e);
    		mv.setViewName("forward:" + PortalUserController.LOGIN_PAGE);
    		return mv;
    	}
    	return mv;
    }
    
    /**
     * SSO 로그인 진행 로직
     */
    @RequestMapping(value="/portal/user/ssoLoginProc.do", method=RequestMethod.POST)
    public ModelAndView ssoLoginProc(HttpServletRequest request, HttpServletResponse response) {
    	ModelAndView mv = new ModelAndView();
    	
    	try {
    		Params params = getParams(request, false);
    		
    		int result = portalUserService.checkSSOUserLoginProcCUD(params);
    		
    		if ( result > 0 ) {
    			mv.setViewName("redirect:" + MAIN_PAGE);
    		}
    		else if ( result == -90 ) {
    			mv.addObject("errMsg", "회원정보가 존재하지 않습니다.");
    			mv.setViewName("forward:/portal/user/redirect.do");
    		}
    		else if ( result == -80 ) {
    			mv.addObject("errMsg", "비정상 연동 입니다.");
    			mv.setViewName("forward:/portal/user/redirect.do");
    		}
    		else if ( result == -81 ) {
    			mv.addObject("errMsg", "유효한 식별키가 아님");
    			mv.setViewName("forward:/portal/user/redirect.do");
    		}
    		else if ( result == -82 ) {
    			mv.addObject("errMsg", "비정상 접근입니다.");
    			mv.setViewName("forward:/portal/user/redirect.do");
    		}
    		else {
    			mv.addObject("errMsg", "처리도중 오류가 발생하였습니다.");
    			mv.setViewName("forward:/portal/user/redirect.do");
//    			mv.setViewName("redirect: /error500");
    		}
        	
    	} catch(Exception e) {
    		EgovWebUtil.exLogging(e);
    		mv.addObject("errMsg", "처리도중 오류가 발생하였습니다.");
    		mv.setViewName("redirect: /error500");
    		return mv;
    	}
    	return mv;
    }
    
    @RequestMapping("/portal/user/redirect.do")
    public String redirect(HttpServletRequest request, Model model) {
    	
        return "ggportal/user/sso/redirect";
    }
    
    
    /* [로그인 종료] ***********************************************************************************************************************************************/
    
    
    @RequestMapping("/portal/user/notAccess.do")
    public String accessDenined(Model model) {
    	return "/ggportal/user/accessDenined";
    }
    
}
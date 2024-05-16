package egovframework.portal.view.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.common.base.controller.BaseController;

/**
 * 포털 뷰 컨트롤러 클래스이다.
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/09/03
 */
@Controller("PortalViewController")
public class PortalViewController extends BaseController {
	
	/**
     * 사이트맵을 조회하는 화면으로 이동한다.
     */
    @RequestMapping("/portal/view/sitemapPage.do")
    public String sitemapPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/view/sitemap";
    }
    
    /**
     * Open API 사이트맵을 조회하는 화면으로 이동한다.
     */
    @RequestMapping("/portal/view/openSitemapPage.do")
    public String openSitemapPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/view/openSitemap";
    }
    
	/**
	 * 포털 서비스 소개 
	 */
	@RequestMapping("/portal/intro/serviceIntroPage.do")
	public String serviceIntroPage(HttpServletRequest request, Model model) {
		return "portal/view/serviceIntro";
	}
	
	/**
	 * 포털 서비스 이용안내
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/intro/useServiceIntroPage.do")
	public String useIntroPage(HttpServletRequest request, Model model) {
		return "portal/view/useServiceIntro";
	}
	
	/**
     * 개인정보처리방침을 조회하는 화면으로 이동한다.
     */
    @RequestMapping("/portal/policy/privatePolicyPage.do")
    public String privatePolicyPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/view/privatePolicy";
    }
    
    /**
     * 이메일무단수집거부를 조회하는 화면으로 이동한다.
     */
    @RequestMapping("/portal/policy/emailPolicyPage.do")
    public String emailPolicyPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/view/emailPolicy";
    }
    
    /**
     * 서비스이용약관을 조회하는 화면으로 이동한다.
     */
    @RequestMapping("/portal/policy/userAgreementPage.do")
    public String userAgreementPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/view/userAgreement";
    }
    
    /**
     * OPENAPI 이용약관을 조회하는 화면으로 이동한다.
     */
    @RequestMapping("/portal/policy/openUserAgreementPage.do")
    public String openApiUserAgreementPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/view/openUserAgreement";
    }
    
    /**
     * 저작권처리방침을 조회하는 화면으로 이동한다.
     */
    @RequestMapping("/portal/policy/copyRightPage.do")
    public String copyRightPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/view/copyRight";
    }
}

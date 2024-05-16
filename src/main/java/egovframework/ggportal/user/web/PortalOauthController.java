/*
 * @(#)PortalOauthController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;
import egovframework.ggportal.user.service.PortalOauthService;

/**
 * 사용자 인증을 처리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalOauthController")
public class PortalOauthController extends BaseController {
    /**
     * 사용자 인증을 처리하는 서비스
     */
    @Resource(name="ggportalOauthService")
    private PortalOauthService portalOauthService;
    
    /* 
     * (non-Javadoc)
     * @see egovframework.common.base.controller.BaseController#addPathParameter(egovframework.common.base.model.Params, javax.servlet.http.HttpServletRequest)
     */
    protected void addPathParameter(Params params, HttpServletRequest request) {
        String context = request.getContextPath();
        String uri     = request.getRequestURI();
        
        // 컨텍스트 경로가 루트가 아닌 경우
        if (!"".equals(context)) {
            uri = uri.substring(context.length());
        }
        
        String[] path = uri.split("/");
        
        if (path.length == 6) {
            params.put("providerName", path[4]);
        }
    }
    
    /**
     * 인증을 요청하는 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/user/oauth/authorizePage.do")
    public String authorizePage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 제공자를 가져온다.
        Object result = portalOauthService.providers(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "ggportal/user/oauth/authorize";
    }
    
    /**
     * 인증을 요청한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/user/oauth/{provider}/authorize.do")
    public String authorize(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 인증을 요청한다.
        Result result = portalOauthService.authorize(params);
        
        debug("Processing results: " + result);
        
        // 뷰이름을 반환한다.
        return "redirect:" + result.getMessages().getMessage("authEndpoint");
    }
    
    /**
     * 리다이렉트를 처리한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/user/oauth/{provider}/redirect.do")
    public String redirect(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 리다이렉트를 처리한다.
        Object result = portalOauthService.redirectCUD(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "ggportal/user/oauth/redirect";
    }
    
    /**
     * 사용자를 등록하는 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/user/oauth/registerPage.do")
    public String registerPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "ggportal/user/oauth/register";
    }
    
    /**
     * 사용자를 등록한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/user/oauth/register.do")
    public String register(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 사용자를 등록한다.
        Result result = portalOauthService.registerCUD(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 로그아웃을 처리한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/user/oauth/logout.do")
    public String logout(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 로그아웃을 처리한다.
        Result result = portalOauthService.logout(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "redirect:/";
    }
}
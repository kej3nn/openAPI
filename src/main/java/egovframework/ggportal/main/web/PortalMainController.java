/*
 * @(#)PortalMainController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.main.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenDsService;
import egovframework.ggportal.main.service.PortalHomeMngService;

/**
 * 메인 화면 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("gmportalMainController")
public class PortalMainController extends BaseController {
	
    /**
     * 홈페이지 설정을 관리하는 서비스
     */
    @Resource(name="gmportalHomeMngService")
    private PortalHomeMngService portalHomeMngService;
    
    /**
     * 공공데이터 데이터셋을 관리하는 서비스
     */
    @Resource(name="ggportalOpenDsService")
    private PortalOpenDsService portalOpenDsService;
    
    /**
     * 메인 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    /*@RequestMapping("/portal/mainPage.do")
    public String mainPage(HttpServletRequest request, Model model) {
    	//리턴시킬 jsp 파일
    	String rtnUrl = "";
    	
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 홈페이지 설정을 조회한다.
        Object result = portalHomeMngService.selectSettings(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        rtnUrl = "ggportal/main/main";
        
        // 뷰이름을 반환한다.
        return rtnUrl;
    }*/
    
    @RequestMapping("/portal/stat/searchOpenDsCate.do")
    public String searchOpenDsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 카테고리를 검색한다.
        Object result = portalOpenDsService.searchOpenDsCate(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 배너를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/banner.do")
    public String banner(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 홈페이지 설정을 조회한다.
        Object result = portalHomeMngService.selectHomeMng(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
    
    /**
     * 설정을 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/settings.do")
    public String settings(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 홈페이지 설정을 검색한다.
        Object result = portalHomeMngService.searchHomeMng(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 메인 새창 팝업
     */
    @RequestMapping("/portal/popupPage.do")
    public String popupPage(HttpServletRequest request, Model model) {
        return "/ggportal/main/mainPop";
    }
}